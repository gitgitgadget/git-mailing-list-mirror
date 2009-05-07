From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 4/4] t4200: avoid passing a non-newline terminated file to 
	sed
Date: Thu, 7 May 2009 11:49:08 +1000
Message-ID: <fcaeb9bf0905061849v1dd50d8fk36e6804824a59032@mail.gmail.com>
References: <-ElxRhvpfY_jx1Ps8nJ42rHdrKbR03T1y96WpGK19gM@cipher.nrlssc.navy.mil> 
	<IHOAO7NDkb8K9nkprnkd2cQW6duDZ3aYmQzpqboBi5HibQoO83nGG2Z4562gIb22HVW3ho6Z250@cipher.nrlssc.navy.mil> 
	<IHOAO7NDkb8K9nkprnkd2TGjPUHc5N7wdnoXRYKelDZEem1S0tynQeYlVheR46_5TDmYxS1O9i4@cipher.nrlssc.navy.mil> 
	<IHOAO7NDkb8K9nkprnkd2QibZp-GnWBSpcJ8fxO9NTUsmXbuv4_2x5S6YNLzUogav4gLkrx9ClI@cipher.nrlssc.navy.mil> 
	<IHOAO7NDkb8K9nkprnkd2ZsdySdVG_ssYL84wqJwNHZYBqMWRKBIa_Ni6jJRHumlZvrQcXOEMhQ@cipher.nrlssc.navy.mil> 
	<IHOAO7NDkb8K9nkprnkd2ep5vFgQr-bAuDGJW-OdtSbS6WmpSHl041GRSXpP3OcDP4_PsYKsQDU@cipher.nrlssc.navy.mil> 
	<7vhbzyukyi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 07 03:49:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1sjw-0003Bp-Uf
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 03:49:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758336AbZEGBt3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 21:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758160AbZEGBt3
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 21:49:29 -0400
Received: from an-out-0708.google.com ([209.85.132.244]:42672 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755600AbZEGBt2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 21:49:28 -0400
Received: by an-out-0708.google.com with SMTP id d40so1325106and.1
        for <git@vger.kernel.org>; Wed, 06 May 2009 18:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=1g4XdaqXRCG95NkGu5Jwh/kJ6GsUHnsGyAFV/AGfpt0=;
        b=htvbtOqFLKb5aEkzieKhk9WO0dOmgaf7MTOYOgzvxzeqHSXc/3vNKC1iEwzPNZC25k
         6mAKjZwb0p4QiMww2P0IgqRmIAAQaGTdL4lq7J1v04c9koFK5uH5/OVG2Nu4iGks+PE7
         5H23JldzD/9gg2kK0Zh5QaIQROT/4VpVFPMbE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=L9nlH79N5q/SlaI0wWzsxuiIxB5L66WwMzfmhBGlzW6VNEa2sT0k7PLou00AbebSwi
         OY5bsEFUt8Bano/pzv/e7E7aSDtrrmv2tknacdbCri94AOACPqLh1DKKWKDCjkF1a4Bc
         l4ExJId01u56b7glvjivVCoytYaUOQe/WrphA=
Received: by 10.100.227.18 with SMTP id z18mr4208333ang.67.1241660968134; Wed, 
	06 May 2009 18:49:28 -0700 (PDT)
In-Reply-To: <7vhbzyukyi.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118419>

On Thu, May 7, 2009 at 4:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Brandon Casey <casey@nrlssc.navy.mil> writes:
>
>> Some versions of sed exit non-zero if the file they are supplied is =
not
>> newline terminated. =C2=A0Solaris's /usr/xpg4/bin/sed is one such se=
d. =C2=A0So
>> rework this test to avoid doing so.
>
> I think up to your 3/4 is reasonable, but this is not enough for POSI=
X
> conformance (it is Ok if it is just aiming to fix "Solaris quirk"). =C2=
=A0POSIX
> sed is only required to work on text files, but .git/MERGE_RR is not =
a
> text file (it is a sequence of NUL terminated records).
>
> I think something like this may work better. =C2=A0Can somebody test?
>
>> - =C2=A0 =C2=A0 sha1=3D$(sed -e "s/ =C2=A0 =C2=A0 =C2=A0 .*//" .git/=
MERGE_RR) &&
>> + =C2=A0 =C2=A0 sha1=3D$({ cat .git/MERGE_RR; echo; } | sed -e "s/ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0.*//") &&
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0sha1=3D$(tr "\\000" "\\012" <./git/MERGE_R=
R | sed -e "s/ =C2=A0.*//") &&
>

I would replace it again, according to e85fe4d8.
--=20
Duy
