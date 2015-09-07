From: Renato Botelho <garga@FreeBSD.org>
Subject: Conditionally define vars to improve portability
Date: Mon, 7 Sep 2015 14:51:42 -0300
Message-ID: <81961DE1-FA30-4E55-8818-9FCA3BC59B81@FreeBSD.org>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 19:52:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZZ0aL-0004Ge-O2
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 19:52:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753019AbbIGRvt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Sep 2015 13:51:49 -0400
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36225 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752740AbbIGRvs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Sep 2015 13:51:48 -0400
Received: by qgx61 with SMTP id 61so66161604qgx.3
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 10:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:content-type:content-transfer-encoding:subject
         :message-id:date:to:mime-version;
        bh=PquPpijrkGt9M7ygy49JBlwR2kR+rbaVjiy2mu0bCI4=;
        b=hyn1ZqiXvizPiqxUUvuWHu2sDWdZz+VznKB9ysejs9GDfjL6+fEmjHLuaGzOIRsoiC
         3WtlyIo2Uut7gk3jHyOqXrL/a5rRj/sU7cZRunuJN2nllvxni+fq/zcseR0yDM/dNc3V
         D/T1k2sJwvuufNzY3JxDvgYzhR4yqOWK1Zq4FVg2ZgQKOUnoONXBfOOxNSrSHKKJ62jN
         qnx3PQTYDRt3ARDh/pRhUPCotXKOVw1qrbH0j7IE6o3wc480oe/xCJi+JTLiHK67Lv63
         j5USfBAcpmWcDV7Ad8Y71h/iW1r1BB85dIZ/zoLJqg4cuhryNKqHsFF8mfaoDi13fwl2
         K0KA==
X-Received: by 10.140.133.69 with SMTP id 66mr30305551qhf.12.1441648307613;
        Mon, 07 Sep 2015 10:51:47 -0700 (PDT)
Received: from mbp.home (179-125-137-171.desktop.com.br. [179.125.137.171])
        by smtp.gmail.com with ESMTPSA id e131sm266994qhc.10.2015.09.07.10.51.46
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 07 Sep 2015 10:51:46 -0700 (PDT)
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277471>

Default variables used to build are set using =3D on Makefile, (e.g. CC=
, INSTALL, CFLAGS, =E2=80=A6). GNU make overwrite these values if it=E2=
=80=99s passed as an argument (make CC=3Dclang) and it works as expecte=
d.

Default method of passing arguments for make operations on FreeBSD port=
s tree is using environment variables instead of make arguments, then w=
e have CC set on env before call gmake. Today these values are ignored =
by git Makefile, and we ended up patching Makefile replacing =3D by ?=3D=
 on variable assignments [1].

Before I write a patch and submit I would like to check if it would be =
an acceptable change of if it=E2=80=99s something you won=E2=80=99t acc=
ept for any reason.

Regards

[1] https://svnweb.freebsd.org/ports/head/devel/git/files/patch-Makefil=
e?revision=3D396048&view=3Dmarkup#l7
--
Renato Botelho
