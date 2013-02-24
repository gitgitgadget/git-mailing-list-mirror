From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH] Improve QNX support in GIT
Date: Sun, 24 Feb 2013 16:12:27 +0200
Message-ID: <CAHXAxrO_AeLoHw6TaVkDZsS=J6Ro+qEuMs4rbyCoFuHAGT+6vg@mail.gmail.com>
References: <CAHXAxrMRxKKiEarSQ0fCLt6-zyS=52B+kmZMLDf8SQAGzGbjjQ@mail.gmail.com>
	<CAHXAxrMgJf2C3dAe1O2DW5qFYFnCDhbQNmpnvK4ZOduJnqwQWg@mail.gmail.com>
	<7vvc9i5cbw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 15:12:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9cJx-0000iA-Nd
	for gcvg-git-2@plane.gmane.org; Sun, 24 Feb 2013 15:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755109Ab3BXOM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Feb 2013 09:12:28 -0500
Received: from mail-qa0-f41.google.com ([209.85.216.41]:52007 "EHLO
	mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754869Ab3BXOM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2013 09:12:28 -0500
Received: by mail-qa0-f41.google.com with SMTP id bs12so1147173qab.0
        for <git@vger.kernel.org>; Sun, 24 Feb 2013 06:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:content-type;
        bh=7zviGoKvnlPNfY2Ro62VQN3cs0Fh/9hO8Tdyr9ftDbY=;
        b=lcp9uW/1YdItPw68guyxNYjDiIA6F8pQyLZ9SgrNcm/jghcP1ZYxRvtfi8EPNFYcPT
         DUqznyhZ+bA+sksvTHv4PcT8+DMzGsbBVVMYQoda8PGbUZ+5oZCe+nOS9BiP6aVt3Z/Q
         fOX9RQ3mWmNQObwGxoqfbVgbc5wW5YQCCUFxpq8KgxhSOHt+jxGAUhtziVFB25cbulwq
         hJnlgaO9WijouZxDBkZVDSdXYGTvWAP8HhjPp0lPzYH85CgrlwF071v+Tqe5B4F+VBrN
         U3/3YKTPJxCvPmwyym6RfLCfFNtZHO/0JJl7T037Mdp51jd0bL6AbBrvQPaVG6j8sa14
         3Zdg==
X-Received: by 10.224.27.136 with SMTP id i8mr6903843qac.63.1361715147095;
 Sun, 24 Feb 2013 06:12:27 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Sun, 24 Feb 2013 06:12:27 -0800 (PST)
In-Reply-To: <7vvc9i5cbw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216988>

>>> 2) Rename fnmatch.h to fnmatch_gnu.h and fnmatch.c to fnmatch_gnu.c to
>>> avoid inclusion of system fnmatch.h header in case if -I/usr/include
>>> path is specified before -Icompat/fnmatch. Which is common situation.
> As to the substance, I am fairly negative about the approach this
> patch takes, especially the rationale it uses for #2 above.  It goes
> directly against the spirit of having compat/ directory in the first
> place to have -I/usr/include _before_ -Icompat/anything and that,
> not the names of header files in compat/ directory, is the root
> cause of the problem you are seeing, I think.

It is quite common to pass CPPFLAGS/CFLAGS/CXXFLAGS before configure
script to make a custom build. For example, I have specific set of
headers which belong to another version of libc, so I pass directory
where these headers are located right before configure script:

CFLAGS="-I/usr/qnxVVV/include" LDFLAGS="-I/usr/qnxVVV/lib" ./configure
--prefix=/usr

About this you can read by typing ./configure --help. This approach
works for every autoconf-based project, except for GIT due to headers
collision. I do not know anything about "spirit of compat/ directory",
but if it interferes with the normal build process, it means something
is wrong. But it is up to you.

Thanks.
