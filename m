From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2] tests: rename test to work around GNU gettext bug
Date: Mon, 19 Jul 2010 20:28:11 +0000
Message-ID: <1279571291-5555-1-git-send-email-avarab@gmail.com>
References: <1279570409-5293-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 22:28:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oawx4-0001CC-2g
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:28:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966699Ab0GSU2d convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 16:28:33 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63463 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966638Ab0GSU2c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 16:28:32 -0400
Received: by eya25 with SMTP id 25so1073963eya.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 13:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=C2PtiFJvok24VAis1Liexf+lldJHbkRF2EEUNr6bSH8=;
        b=DDr9wvV1va7uNdhRlcmRqJZDltq+oDQXoziebI2efKF2xp3oMFNA6CpwYQMcIQeA7X
         8gze7RhS6Do7ZZ96HgPxVZqSpWZ702wndUvW4oPezSCnwO7kAj+h6Oh8d9TK+vZdTg37
         JhluGzQKzo2BSJ/SWUVuFXugiplTfhocjgYts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=c+jnDQg7PtKotYz/6oCr8kA8wlryOCKOgTtryThrA21r32WE9pWibPscdU+rvts9qi
         7AGDcceLLF1YB/b0u9ODfo2skxOkIZNLTucno8muKygQN734A4XC5J4bsXfWRzrTkmdm
         5X5gvASUxBW1riF67pEYdIruA4QFx1yViOqCo=
Received: by 10.213.28.194 with SMTP id n2mr3571226ebc.10.1279571310735;
        Mon, 19 Jul 2010 13:28:30 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-233-160.pools.arcor-ip.net [88.67.233.160])
        by mx.google.com with ESMTPS id a48sm50260292eei.6.2010.07.19.13.28.29
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 13:28:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.125.g94e09.dirty
In-Reply-To: <1279570409-5293-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151275>

Rename t0200-gettext.sh to t0200-gettext-basic.sh. Versions of GNU
gettext before v0.15 (released in 2006) fail to run the test because
of an old bug in gettext.sh.

To conform with the FHS gettext.sh prints a help message when it's
invoked directly. To do this it checks if $0 is "gettext.sh". This
check was broken before v0.15, it was checking for *\gettext.sh (to
support Windows), but now correctly checks for *\\gettext.sh.

t0200-gettext.sh matched the former broken check, so on systems with
an old GNU gettext (like RHEL 5.4) the test simply printed:

    ./t0200-gettext.sh
    GNU gettext shell script function library version 0.14.6
    Usage: . gettext.sh
    FATAL: Unexpected exit with code 1

Which is just the gettext.sh help output:

    $ gettext.sh
    GNU gettext shell script function library version 0.17
    Usage: . gettext.sh

Change the test name to t0200-gettext-basic.sh to work around that.

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

Thomas Rast noted a typo in the commit message offlist. This fixes
that.

 t/{t0200-gettext.sh =3D> t0200-gettext-basic.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t0200-gettext.sh =3D> t0200-gettext-basic.sh} (100%)

diff --git a/t/t0200-gettext.sh b/t/t0200-gettext-basic.sh
similarity index 100%
rename from t/t0200-gettext.sh
rename to t/t0200-gettext-basic.sh
--=20
1.7.2.rc3.125.g94e09.dirty
