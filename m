From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/41] Add and use error_errno() and warning_errno()
Date: Sun, 1 May 2016 18:21:24 +0700
Message-ID: <20160501112124.GA8748@lanh>
References: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 13:21:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awpRO-0001Iy-HJ
	for gcvg-git-2@plane.gmane.org; Sun, 01 May 2016 13:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbcEALVb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 May 2016 07:21:31 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33004 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752261AbcEALVa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2016 07:21:30 -0400
Received: by mail-pf0-f196.google.com with SMTP id e190so18861211pfe.0
        for <git@vger.kernel.org>; Sun, 01 May 2016 04:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KXrrjYJ5VBMRjHlfZtbPKVryHMGas0vxAdJBbhsUz3A=;
        b=eCABbiBANdR54ssQrcalYcau93qHZVj7vTV258l9/GWlMRPazWJfISuVY+MCFGxwWu
         GxiKD6fQnURtc7/BH0KBzbR7aqPvOEFUmw0WxMqUNEu7U7n9MFTSCG88zki+1dwwWcm1
         wMf9hUOiBmbLr9WFWEIcIcDiWgHgdmof8h9iSx3xHpIfdpDb6efKvqYR9x+fgSSy+26b
         4vqsR5FbVj5DeCzubKWh/PO3BftxY47iFAbEP7BS2eRMpoeZbr+J0AAS4w7t2ZVNhF5o
         oUO7IWqDAsIPYRb55JRj4P8l29+bueW5xaJWEN5++sxg4nci1Vc8H1t7M5sbB6aKtbXB
         6XAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KXrrjYJ5VBMRjHlfZtbPKVryHMGas0vxAdJBbhsUz3A=;
        b=ijfQAwWzpL7WUGAZ4WXQJHedJTIy2ovN7501Yl0Gvo7RJ+GYVQvU4qrPc7A1DP1tmC
         oZo0cGGw15Za48lUa1zJR7iNHImf0mwQ9SYk12SZVuLqftRXABYEjyLO6JyCWgQ1Bu8V
         mKn+BjvzvEsQskxUzhTVDrCQzBfUNlFPukSQAuLLpTPEBzN9UQghMtw9JBTsAdBV1vnn
         qcOCnqlrhUk6ixwPQyergA97ThNZz6L/ceh1AQswSQFNQri3M+2iiSTu0RjIbKlvEPVW
         7ICjUiXPHfpyVqgIVPPeEeoVJiz1rtEXHQg+saiBUVFzTfvEyicU0Vq2u29ttrABA07B
         7rzQ==
X-Gm-Message-State: AOPr4FUQY41w/O1IqZ2cZf/Phc1kq99CQI03yAKJWqqmWL0LP2MXx83DiRzjCsHUXAJPzA==
X-Received: by 10.98.80.78 with SMTP id e75mr43767875pfb.147.1462101689492;
        Sun, 01 May 2016 04:21:29 -0700 (PDT)
Received: from lanh ([115.72.42.9])
        by smtp.gmail.com with ESMTPSA id yl5sm37378002pac.38.2016.05.01.04.21.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 May 2016 04:21:27 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Sun, 01 May 2016 18:21:24 +0700
Content-Disposition: inline
In-Reply-To: <1462101297-8610-1-git-send-email-pclouds@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293192>

On Sun, May 01, 2016 at 06:14:16PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
> This is a spinoff from my worktree-move topic. This series adds
> die_errno() companions, error_errno() and warning_errno(), and use th=
em
> where applicable to reduce the amount of typing (in future).

I had this patch in the series but excluded it before sending because
there is something wrong about it.

The patch shows two code blocks that follow the same pattern:
closesocket() then print an error with strerror(). The second block
suggests that closesocket() can change errno. But if that's true, the
first block should do the same.

Which is right? Fix the first block to save errno, or drop the saving
in the second block?

diff --git a/compat/mingw.c b/compat/mingw.c
index 0413d5c..b6de02c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1555,8 +1555,7 @@ int mingw_socket(int domain, int type, int protoc=
ol)
 	/* convert into a file descriptor */
 	if ((sockfd =3D _open_osfhandle(s, O_RDWR|O_BINARY)) < 0) {
 		closesocket(s);
-		return error("unable to make a socket file descriptor: %s",
-			strerror(errno));
+		return error_errno("unable to make a socket file descriptor");
 	}
 	return sockfd;
 }
@@ -1606,10 +1605,8 @@ int mingw_accept(int sockfd1, struct sockaddr *s=
a, socklen_t *sz)
=20
 	/* convert into a file descriptor */
 	if ((sockfd2 =3D _open_osfhandle(s2, O_RDWR|O_BINARY)) < 0) {
-		int err =3D errno;
 		closesocket(s2);
-		return error("unable to make a socket file descriptor: %s",
-			strerror(err));
+		return error_errno("unable to make a socket file descriptor");
 	}
 	return sockfd2;
 }
--=20
2.8.0.rc0.210.gd302cd2
