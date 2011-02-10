From: Vampire <Vampire@Masters-of-Disaster.de>
Subject: Bug in "git diff-files"
Date: Thu, 10 Feb 2011 18:56:07 +0100
Message-ID: <4D5426B7.9010007@Masters-of-Disaster.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 10 18:56:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnakh-000668-1y
	for gcvg-git-2@lo.gmane.org; Thu, 10 Feb 2011 18:56:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756686Ab1BJR4O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 10 Feb 2011 12:56:14 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55788 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756615Ab1BJR4L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Feb 2011 12:56:11 -0500
Received: by fxm20 with SMTP id 20so1730101fxm.19
        for <git@vger.kernel.org>; Thu, 10 Feb 2011 09:56:10 -0800 (PST)
Received: by 10.223.103.8 with SMTP id i8mr1563121fao.47.1297360570376;
        Thu, 10 Feb 2011 09:56:10 -0800 (PST)
Received: from [10.10.10.151] (pD9E42B12.dip.t-dialin.net [217.228.43.18])
        by mx.google.com with ESMTPS id j12sm169864fax.9.2011.02.10.09.56.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Feb 2011 09:56:09 -0800 (PST)
User-Agent: Thunderbird 2.0.0.24 (X11/20101027)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166489>

Hi,

I found a bug in git diff-files.
git diff-files with a --diff-filter and --quiet given behaves bad.
I have a diff-filter of U and one file M and one U.
But diff-lib.c:105-107 in commit 1a9fe45 stops as soon as HAS_CHANGES i=
s=20
true.
In my case it found the M file and stops searching as --quiet is given.
But then when applying the diff-filter, this M instance is filtered out=
=20
and thus 0 is returned instead of 1 which is returned with --exit-code=20
and without --quiet.

Regards
Bj=F6rn Kautler
