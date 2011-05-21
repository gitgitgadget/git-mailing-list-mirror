From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/4] streaming filter: ident filter and filter cascading
Date: Sun, 22 May 2011 00:08:46 +0200
Message-ID: <4DD837EE.3010608@lsrfire.ath.cx>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com> <1305961127-26540-5-git-send-email-gitster@pobox.com> <4DD82931.6000101@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sun May 22 00:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNuMK-0000ur-IR
	for gcvg-git-2@lo.gmane.org; Sun, 22 May 2011 00:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757270Ab1EUWJI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 18:09:08 -0400
Received: from india601.server4you.de ([85.25.151.105]:42837 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754389Ab1EUWJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 18:09:07 -0400
Received: from [192.168.2.106] (p579BE3D8.dip.t-dialin.net [87.155.227.216])
	by india601.server4you.de (Postfix) with ESMTPSA id 586842F8086;
	Sun, 22 May 2011 00:09:06 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <4DD82931.6000101@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174177>

Am 21.05.2011 23:05, schrieb Ren=E9 Scharfe:
>> +		if (ident->state < sizeof(head) &&
>=20
> 		// minus one because otherwise we'd compare the
> 		// terminating NUL as well even though we're not
> 		// actually looking for a NUL
> 		if (ident->state < sizeof(head) - 1 &&

Possibly, but that doesn't matter, as the right number of characters is
remembered and the second test below is not passed if we sailed past th=
e
NUL.  Sorry for the noise.

>=20
>> +		    head[ident->state] =3D=3D ch) {
>> +			ident->state++;
>> +			continue;
>> +		}
>> +
>> +		if (ident->state)
>> +			strbuf_add(&ident->left, head, ident->state);
>> +		if (ident->state =3D=3D sizeof(head) - 1) {
