From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC 0/2] post-receive-email: declaring and consistently using
 one output encoding
Date: Thu, 8 Mar 2012 05:51:19 -0600
Message-ID: <20120308115119.GA2604@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Gerrit Pape <pape@smarden.org>, Alexey Shumkin <zapped@mail.ru>,
	Johannes Sixt <j6t@kdbg.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jon Jensen <jon@endpoint.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 08 12:51:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5bsb-0007Jh-ED
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 12:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756957Ab2CHLv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 06:51:29 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:58137 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab2CHLv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 06:51:28 -0500
Received: by yhmm54 with SMTP id m54so114211yhm.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 03:51:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=rzfi45/C/8wi0RwlpwThwW/prcUfgN3XQYeUOrr/qb8=;
        b=IJlQi+gDN5OthvPMEVQOcY+7XWA4dBztXZ879MDZmCIDSGudkj9al5ZJIfHJqsOoH1
         vzho9NcK3N3kuUWr5aPRx62VTi1Xnoea+If4rIXGdpWBjUU4PDji3ODL+0OvnjuZZZ4m
         i1CYQgRINiyzJeNSD7zJ1IYeExJg+bHf4xrMkX8vEQiNbB+JMe5VNMPqfWO831n7SQQV
         idbckUDLgxVCiGNFPIQHjeGAVPTYV7YIW06aJHK8QkAJuVrtpVKQ2qX/bal8UqhKm7Yf
         eAjdRWz25AkgcEty32VDQvjGpiTCy8Op03JRTvA4XlwM+3cXKYcM+cf9ewOlXmJqv+Rg
         BY7A==
Received: by 10.60.9.102 with SMTP id y6mr2598037oea.46.1331207487454;
        Thu, 08 Mar 2012 03:51:27 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d9sm2286423obq.0.2012.03.08.03.51.26
        (version=SSLv3 cipher=OTHER);
        Thu, 08 Mar 2012 03:51:27 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192573>

Hi,

These patches revisit the bug described at [1], where the sample
post-receive script annoys receiving MUAs by not declaring what
encoding it uses.  Worse, sometimes the mails have a mixture of
encodings.

These patches standardize on UTF-8, but that is only for the sake of
simplicity.  A patch on top to make the choice of encoding
customizable would probably not be too complicated, if someone is
interested.

Patches are targetted at 1.7.11 unless there is overwhelming
interest in them landing sooner.  Thanks to Alexander Gerasiov
<gq@cs.msu.su> for the writing a patch long ago to get this
started[1].

Thoughts?

Gerrit Pape (1):
  bug#506445: hooks/post-receive-email: set encoding to utf-8

Jonathan Nieder (1):
  post-receive-email: defend against non-utf8 [i18n] logoutputencoding
    setting

 contrib/hooks/post-receive-email |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

[1] http://thread.gmane.org/gmane.comp.version-control.git/181737/focus=181755
[2] http://bugs.debian.org/506445
