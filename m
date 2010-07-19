From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] tests: rename test to work around GNU gettext bug
Date: Mon, 19 Jul 2010 20:13:29 +0000
Message-ID: <1279570409-5293-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 22:13:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oawih-0002Hf-QP
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 22:13:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966660Ab0GSUNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Jul 2010 16:13:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42618 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966644Ab0GSUNl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 16:13:41 -0400
Received: by ewy23 with SMTP id 23so1433761ewy.19
        for <git@vger.kernel.org>; Mon, 19 Jul 2010 13:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=DtVF/1IM2C7L+q9iqTOwoBYKhTGZstdCr9n6GA0j5oM=;
        b=q6Dr6hWKO3dB98QtuTeiW4YjimZnUbeIC4W6wIZvsWCcNpmlp9fHWzQP2wHD9WUcrd
         ignMCO5n/kuM1B9d+XRFMjXuukdGAxjMoeVI5nKhFevCfMahU0gMtt9k5hAw2lnDlJoK
         vs7GXGFMyIh1T3SQ0ROcmbgroj847WmaR4OBM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=smcVxrWo5gIVc14BEGqtxThUlq/CAyyG3MjUTBZEaujr4Tu9elzxCiBCO1fyuScrc0
         waqvHw52JfmPfjYoxvG1O/xLSU1JXYN2j0Q6RWsJjGy4syx+qhM6up2Of/CVRz78nyC/
         AYIjiOlm4ZCMj3/KbbxynFRHwfCWym1IW36X0=
Received: by 10.213.114.67 with SMTP id d3mr1168567ebq.77.1279570419721;
        Mon, 19 Jul 2010 13:13:39 -0700 (PDT)
Received: from localhost.localdomain (dslb-088-067-233-160.pools.arcor-ip.net [88.67.233.160])
        by mx.google.com with ESMTPS id a48sm50227505eei.0.2010.07.19.13.13.38
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 19 Jul 2010 13:13:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.rc3.125.g94e09.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151273>

Rename t0200-gettext.sh to t0200-gettext-basic.sh. Versions of GNU
gettext before v0.15 (released in 2006) fail to run the test because
of an old bug in gettext.sh.

To conform with the FHS gettext.sh prints a help message when it's
invoked directly. To do this it checks if $0 is "gettext.sh". This
check was broken before v0.15, it was checking for *\gettext.sh (to
support Windows), but now correctly checks for *\\gettext.sh.

t0200-gettext-basic.sh matched the former broken check, so on systems
with an old GNU gettext (like RHEL 5.4) the test simply printed:

    ./t0200-gettext.sh
    GNU gettext shell script function library version 0.14.6
    Usage: . gettext.sh
    FATAL: Unexpected exit with code 1

Which is just the gettext.sh help output:

    $ gettext.sh
    GNU gettext shell script function library version 0.17
    Usage: . gettext.sh

Change the test name to t0200-gettext-basic.sh to work around the
issue.

Reported-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This patch is against pu. It requires the gettext series already
there.

 t/{t0200-gettext.sh =3D> t0200-gettext-basic.sh} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename t/{t0200-gettext.sh =3D> t0200-gettext-basic.sh} (100%)

diff --git a/t/t0200-gettext.sh b/t/t0200-gettext-basic.sh
similarity index 100%
rename from t/t0200-gettext.sh
rename to t/t0200-gettext-basic.sh
--=20
1.7.2.rc3.125.g94e09.dirty
