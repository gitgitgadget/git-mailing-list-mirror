From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 19:32:41 +0700
Message-ID: <CACsJy8BuUn4htSR6jAJfbueOshE6-YVV5dZGSWTGXbkuA0HO=A@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com> <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 06 13:33:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXuD0-0002HE-Vk
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 13:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346Ab1LFMdO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Dec 2011 07:33:14 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42129 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933327Ab1LFMdN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Dec 2011 07:33:13 -0500
Received: by eaak14 with SMTP id k14so5038475eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 04:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WSHP0/xZ+QMQTPWjfaHyYLMUAIfWcz+ydmmV6w+fep4=;
        b=cPhiH9EnQHewaRidF9B4fBknE5fqYW2EsMmEjqzb/B/LpabgNyaxkeEsyWc4DHt56L
         NELMyOZTHupc1acXlG+Qxeq4hI1JwCzb+ZpNOHOQFUFJbb0JXNhaLpVPVgQQQi8XB2qe
         77KSFeqjzi1a3OQZXjxACin/hGxXKQWGoIPEg=
Received: by 10.213.108.138 with SMTP id f10mr2321247ebp.84.1323174792266;
 Tue, 06 Dec 2011 04:33:12 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 04:32:41 -0800 (PST)
In-Reply-To: <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186345>

2011/12/6 Erik Faye-Lund <kusmabite@gmail.com>:
> 2011/12/5 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.co=
m>:
>> Too deep delta chains can cause stack overflow in get_base_data(). S=
et
>> a hard limit so that index-pack does not run out of stack. Also stop
>> people from producing such a long delta chains using "pack-object
>> --depth=3D<too large>"
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0I used to make very long delta chains and triggered this in in=
dex-pack.
>> =C2=A0I did not care reporting because it's my fault anyway. Think a=
gain,
>> =C2=A0index-pack is called at server side and a malicious client can
>> =C2=A0trigger this. This patch does not improve the situation much, =
but at
>> =C2=A0least we won't get sigsegv at server side.
>>
>
> Wouldn't it make more sense to make the limit a config option rather
> than a hard-coded value of 128 (which seems arbitrary to me)? After
> all, different platforms have different stack-limitations...

Then it'd make more sense to make a compile time config based on
platform. We could have a config option that can override the default,
but I really don't see the point of making long delta chains.
--=20
Duy
