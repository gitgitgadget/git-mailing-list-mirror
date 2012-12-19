From: David Michael <fedora.dm0@gmail.com>
Subject: [RFC] test: Old shells and physical paths
Date: Wed, 19 Dec 2012 18:22:03 -0500
Message-ID: <CAEvUa7=sOPF9xwfGuBXv0CBZhT+79+8z3tm9ar_cz3q--kfqRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 20 00:48:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlTNV-00023J-AQ
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 00:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384Ab2LSXs2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 18:48:28 -0500
Received: from mail-vb0-f47.google.com ([209.85.212.47]:54743 "EHLO
	mail-vb0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751062Ab2LSXs1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 18:48:27 -0500
X-Greylist: delayed 1583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 19 Dec 2012 18:48:27 EST
Received: by mail-vb0-f47.google.com with SMTP id e21so2988690vbm.6
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 15:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=s3e8PsrGTBgZzyt/Ja/peFr6mrRwK/AuYUU9QUs5ukA=;
        b=wD5SHStrJ0iZsOhlUZQWGFNnbjUGub8SUUyZoVJPNl9fxOV2PjHbgh7yXJ2qZ9n1nM
         9+fZIiMqgL5u62ax9M9ryzBItiSO/Ov895PJIPjRpuoh9ZVzkdsLllclvJtq8HxRXLCO
         ef/9c37N5w6TBMrSrl/woSulkZfJCGLLLraDF8ewZbmIQ9G2075obp95upBX/pYWZ/Sl
         J0B4Mn07/InebFoyaBKzOFhrWkdqRlQhDfLr9/QusFLYB4pey/AsedFxj5IZmbeTVK0U
         fc7Qsdy/L+lcnmCbztMkYveJOL0dHNhGQy+m8pwiwuskld0FB0Bi/NRhBWklWQiikUMW
         gAVg==
Received: by 10.52.98.36 with SMTP id ef4mr9898364vdb.104.1355959324171; Wed,
 19 Dec 2012 15:22:04 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Wed, 19 Dec 2012 15:22:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211864>

Hi,

In working on a port, I have to tolerate an ancient shell.  The "cd"
and "pwd" commands don't understand the "-P" flag for physical paths,
as some tests use.  The biggest offender is "cd -P" causing a failure
in t/test-lib.sh (since 1bd9c64), which is sourced by every test
script.

This shell does understand the difference between physical and logical
paths, but the only way to choose which is with a shell option.  The
shell option is named "logical" which is not portable; GNU bash uses
the opposite, "physical".

Does anyone have any suggestions for how to handle this?

Would it be acceptable to instead force the platform's shell option
(if it exists) to always use physical paths for the tests and drop the
"-P" flags?

If not, is it worth maintaining compatibility wrappers for this one
obscure platform?

Thanks.

David
