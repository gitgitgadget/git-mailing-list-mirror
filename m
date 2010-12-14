From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 09/19] tree-diff.c: reserve space in "base" for pathname concatenation
Date: Tue, 14 Dec 2010 12:00:11 +0700
Message-ID: <AANLkTi=5QgkBd434=Z7MCA_ZNZCXVyXJYh_fd1A+B2ue@mail.gmail.com>
References: <1292233616-27692-1-git-send-email-pclouds@gmail.com>
 <1292233616-27692-10-git-send-email-pclouds@gmail.com> <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 14 06:00:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSN0K-0003sY-4A
	for gcvg-git-2@lo.gmane.org; Tue, 14 Dec 2010 06:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803Ab0LNFAn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 00:00:43 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:56549 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712Ab0LNFAm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 00:00:42 -0500
Received: by wyb28 with SMTP id 28so175025wyb.19
        for <git@vger.kernel.org>; Mon, 13 Dec 2010 21:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=S20b1rhpUioLkWPyi92ZKCfECs//l9BTatQMFLiuhrU=;
        b=B8oWr7g0rAIyw4ky4vUu7Ov1Uv8Ajqeg4C3SvjTb1GcNHCcLnQOhdhFp6AnbwAvqZW
         L16A/nsbXE/crjvZyeoe4JoRodc2GkKN9YRq+x5/tZ6tGEapULodTP6DsVg1cncobxrE
         mM4/PW/jhRE42fAqbQJRW5R4RP1Q6OKTL19mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z4eeLOSPBNVu6mFQydTWFX+q5trhBK5eNKoU3dpifdTVHj/a1FZM7wR2TliAi5uZqX
         MEheIf/zsosVOx3A8eXOXGa2cc/JBOXtzGXJueI2DBYD5qln0oPLNHONfPWustga82DO
         8cBcgjWBHJ4qDcBA0KNoJEX39+c1uq9gUTjFQ=
Received: by 10.216.59.143 with SMTP id s15mr2703390wec.49.1292302841109; Mon,
 13 Dec 2010 21:00:41 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Mon, 13 Dec 2010 21:00:11 -0800 (PST)
In-Reply-To: <7vlj3t35ol.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163624>

2010/12/14 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy =C2=A0<pclouds@gmail.com> w=
rites:
>
>> This patch make sure that "base" parameter is writable. The callees
>> are free to modify it as long as base remains the same before
>> entering and after leaving the callee.
>>
>> This avoids quite a bit of malloc and memcpy().
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>
> I like what I see in this patch in general, but there is nothing that
> guarantees that you are "reserving" enough space. =C2=A0Doesn't the b=
uffer
> overflow with deep enough trees?

All paths should not exceed PATH_MAX, right? That's my assumption. If
it's wrong, then, well.. we need another way.
--=20
Duy
