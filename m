From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Documentation doesn't build anymore on old asciidoc due to i18n series
Date: Sat, 28 May 2011 13:40:22 +0200
Message-ID: <BANLkTikjfyxAzLu2e5aJFVhgKq8UBiJAQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 28 13:40:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQHsb-0006AW-1h
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 13:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914Ab1E1LkY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 07:40:24 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:64666 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab1E1LkX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 07:40:23 -0400
Received: by fxm17 with SMTP id 17so1752258fxm.19
        for <git@vger.kernel.org>; Sat, 28 May 2011 04:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=dBoDqSXMDq7m93024Sv42NuqJNmMvPzArj1JRY1ee7w=;
        b=g6JuzR0qrBkoE66g7rTf1ygGeEA89InVeI70p0p3LoB7xvbQWC9OJKqUGjtUMJ+5Pw
         YuvXWn4PuDSUV8OLXDs6btXxdh4gTevC5LN13s7m1lAHCeBdX4U78HRCouqh7lD6Du6i
         kl+7XUhCOrCdvF7cW3sYmfcCLcLCZ64SnfFac=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=wWirKK7DhTym/MEQCu4CzEhN8t8JySCxuBmNUYga5CYVHroQ0xz32uIs4deSw85tSW
         QWnrVt5Sp6NO94LdrRWaVkTpFG8ARQte/cEoGmkGoXVWJYgQkcMaMDQEdKMn+7t8lJ/Y
         m3ryfkK3YsKPydLPPxFd3QT2qVWtiXYIBbc4k=
Received: by 10.223.55.201 with SMTP id v9mr738398fag.76.1306582822363; Sat,
 28 May 2011 04:40:22 -0700 (PDT)
Received: by 10.223.117.72 with HTTP; Sat, 28 May 2011 04:40:22 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174659>

I can submit a patch for this later, just thought I'd note it and
solicit feedback on the best solution to this.

On my Debian box with asciidoc 8.6.4 Git builds just fine from master.

But on a Centos 5.5 box with asciidoc 8.2.5 I get:

    rm -f git-sh-i18n--envsubst.html+ git-sh-i18n--envsubst.html && \
            asciidoc -b xhtml11 -d manpage -f asciidoc.conf \
                     -a asciidoc7compatible -a no-inline-literal -a
git-asciidoc-no-roff -agit_version=1.7.5.3.367.ga9930 -o
git-sh-i18n--envsubst.html+ git-sh-i18n--envsubst.txt && \
            mv git-sh-i18n--envsubst.html+ git-sh-i18n--envsubst.html
    ERROR: git-sh-i18n--envsubst.txt: line 9: second section must be
named SYNOPSIS
    make[1]: *** [git-sh-i18n--envsubst.html] Error 1

The solution is obvious: just add a SYNOPSIS section for
consistency. I'll do that later, unless we want to provide some option
(which old asciidoc may or may not support) to not have a SYNOPSIS
there, which we arguably can just omit for purely internal tooling
like this.

I'll submit patches soon for adding a SYNOPSIS unless we want to go
that route.
