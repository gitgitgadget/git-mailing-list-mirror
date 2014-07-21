From: Jean-Francois Bouchard <jfbouchard@accedian.com>
Subject: Git + mod_auth_kerb
Date: Mon, 21 Jul 2014 17:06:50 -0400
Message-ID: <CAPYmS35cgcEOfKvT17tULYyxL5GgXBavkD6anhV6yJtdoXVE9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 23:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9KnS-0007V7-W2
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 23:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754132AbaGUVGx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 17:06:53 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:54792 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753754AbaGUVGv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 17:06:51 -0400
Received: by mail-yk0-f178.google.com with SMTP id 142so4326449ykq.23
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 14:06:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=khphWRQWtxb2JNYI0rr8rwYeThUMGcHhXE9ey0tIv1E=;
        b=eiLVCdu+KAvHDvpeHBf9tlKog2c44LwB4kayRBQVEfJ3CY1sKHN4EDDjYcq9B7re5b
         JktpauZrITqs7q8RGQEiMRLNGi/rUoBNpjWy8qU6XHXxkE/YdRZGje7Jtx3GKurQLHoe
         X8kKMdLVSd9W/yMGdj2cV59BRhWVRabzF20jf9vT8BdAg0dCM4d0K24AqTMsogUy58ng
         pMC7+z48HSvviQJcBQRDG5EElfPAyXBv/c9qYNaoJvTtwthNluKKWATY9iBr1IHeiq4n
         /QWLHCrciJTR54rVTHf73EEz98gmhy7sCLhjcahrvilNY/mbW/sMexwhsON4iYwQH2N7
         MkmQ==
X-Gm-Message-State: ALoCoQmeJNvYXAhA1xMqMaD8RTA1BNP+yhFJ41G+TScHY50Byd6zQTTp0Gd2z83RLNCp6k0dlx5NcGU2asr+JjvNOMvrGq7/CdxerLxPG8yDyYC0RI3tFLE=
X-Received: by 10.236.112.167 with SMTP id y27mr43338764yhg.60.1405976810862;
 Mon, 21 Jul 2014 14:06:50 -0700 (PDT)
Received: by 10.170.196.150 with HTTP; Mon, 21 Jul 2014 14:06:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253995>

Hello,

We are currently working on a single sign on setup for our git install.=
 We are
using git 2.0.2 (ubuntu) plus apache/2.2.22 mod_auth_kerb on the
server side. Here some scenario we are trying to accomplish :

-Without Kerberos ticket stored.
Git ask for username/password.
Result =3D Authentication failed

-Kerberos ticket in store and BAD password :
Git ask for username/password.
Result =3D Authentication failed

-Kerberos ticket in Store entering good password :
Git ask for username/password.
Result =3D Authentication failed on some host, other works

-Kerberos ticket in Store and embedding the username in the URI (aka
https://username@repo)
Git don't ask for anything or ask for password
Result =3D Works on some host, other request the password. (Will fail i=
f
the kerberos ticket not in store)

This is a very strange behaviour. It seems to be cause by the way
libcurl and git interact and the way the authentication goes
(Negociate first, then basic auth). I have tried to use the helper to
store invalid authentication information. With not much success.



Any idea ?

Thanks,

JF

--=20


Avis de confidentialit=C3=A9

Les informations contenues dans le pr=C3=A9sent message et dans toute p=
i=C3=A8ce qui=20
lui est jointe sont confidentielles et peuvent =C3=AAtre prot=C3=A9g=C3=
=A9es par le secret=20
professionnel. Ces informations sont =C3=A0 l=E2=80=99usage exclusif de=
 son ou de ses=20
destinataires. Si vous recevez ce message par erreur, veuillez s=E2=80=99=
il vous=20
plait communiquer imm=C3=A9diatement avec l=E2=80=99exp=C3=A9diteur et =
en d=C3=A9truire tout=20
exemplaire. De plus, il vous est strictement interdit de le divulguer, =
de=20
le distribuer ou de le reproduire sans l=E2=80=99autorisation de l=E2=80=
=99exp=C3=A9diteur.=20
Merci.

Confidentiality notice

This e-mail message and any attachment hereto contain confidential=20
information which may be privileged and which is intended for the exclu=
sive=20
use of its addressee(s). If you receive this message in error, please=20
inform sender immediately and destroy any copy thereof. Furthermore, an=
y=20
disclosure, distribution or copying of this message and/or any attachme=
nt=20
hereto without the consent of the sender is strictly prohibited. Thank =
you.
