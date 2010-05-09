From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/2] Makefile: let header dependency checker override
 COMPUTE_HEADER_DEPENDENCIES
Date: Sat, 8 May 2010 23:00:10 -0500
Message-ID: <20100509040010.GB8198@progeny.tock>
References: <20100509035536.GA8118@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 09 05:59:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAxfe-00027l-7f
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 05:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496Ab0EID7J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 May 2010 23:59:09 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:49287 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab0EID7G (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 23:59:06 -0400
Received: by qyk13 with SMTP id 13so4098741qyk.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 20:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=LkRvCAA6bs0UWLi5qxsqgrukm3ry/5BJ42ZzCxvxGkE=;
        b=KDLxtLLjzPy//zp6F5FJNdJL4qwfnALHzkcUlynKN2FqPzSukzBa+E7DrqjoncLXsp
         yhySM7MH3GqsH429I5XWHAgr+LjcqFy4MekyN84jZcLYbbtkhSeDnvy0PTMLS2O8FwwQ
         exdeD2j0ybswnjpwrMv2C0qjSKu1aT5cR23A8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=bB+ZOMaOjQlhqaGfI41NWesEs/Kci8cMTFT8Txn21ECiPoLfwm4m+oziR/3/K+FboY
         EIvsz1gzX1/wgjecTfHEpYhvfQcqtU4NBOpKZcgYrcuarFVO7oLwc5KTXI0F/VxAjRGZ
         7JdRKZeLB0g9H0mWLqnVlXxmBcdMUbzKxRg1Q=
Received: by 10.229.187.71 with SMTP id cv7mr1669052qcb.81.1273377545831;
        Sat, 08 May 2010 20:59:05 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x34sm2730081qce.3.2010.05.08.20.59.04
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 20:59:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100509035536.GA8118@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146702>

This way, if you have =E2=80=9CCOMPUTE_HEADER_DEPENDENCIES =3D YesPleas=
e=E2=80=9D in your
config.mak, you can still =E2=80=9Cmake CHECK_HEADER_DEPENDENCIES=3DYes=
=E2=80=9D to check
the makefile after a successful build.

This change does not affect the result of the command
=E2=80=9Cmake CHECK_HEADER_DEPENDENCIES=3DYes COMPUTE_HEADER_DEPENDENCI=
ES=3DYes=E2=80=9D.
That will still die with an error message:

	cannot compute header dependencies outside a normal build

The message is appropriate because still true.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Makefile b/Makefile
index 567b859..0025b98 100644
--- a/Makefile
+++ b/Makefile
@@ -1063,6 +1063,7 @@ endif
 -include config.mak
=20
 ifdef CHECK_HEADER_DEPENDENCIES
+COMPUTE_HEADER_DEPENDENCIES =3D
 USE_COMPUTED_HEADER_DEPENDENCIES =3D
 endif
=20
--=20
1.7.1
