From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 10/10] clean: support cleaning sparse checkout with -S
Date: Tue, 16 Nov 2010 09:53:47 +0700
Message-ID: <AANLkTimrm2ArRn9Ym271iFEv2bstPPD0WPuP0=Majf0K@mail.gmail.com>
References: <1289817410-32470-1-git-send-email-pclouds@gmail.com>
 <1289817410-32470-11-git-send-email-pclouds@gmail.com> <20101115213059.GJ16385@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 16 03:54:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIBgV-00010e-7W
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 03:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759206Ab0KPCyJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Nov 2010 21:54:09 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:53278 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754636Ab0KPCyI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Nov 2010 21:54:08 -0500
Received: by wwa36 with SMTP id 36so237924wwa.1
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 18:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=Iisloic2GuFUmf4Xi9SjNFiSXrVIue4mECu+XVcxfyk=;
        b=JISgEBAHEBekytkCn+YKhP/zitvNGL+EqAK0oN+hHxrY51K5kB/THjMs+o+r67riWF
         XXPNeDmznN3pZi1Ou3L70lV7EDI0yb29bp9RN0AAIk6+A+/6IQyTIuMocklREcp3ngo6
         hpbY0zZ7hwhrChOOPV+yEOKE6GGi8DRSV+wmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=aZEeIr1QgOR4wGfcnjRScZpOv/vyfOwN/IfZ7tLoMePS6M1zzzWTwur8TAVGLdBWaC
         YDQInU8aAxSGnx7MCscwwbuhsMxQoZqI5H5MWYVS/g2fZ9jaDjqK33BoYyV9dvBhcMvN
         PoTrERi670sOTGSH2UD9Yq/lvAlGls9VoFX78=
Received: by 10.216.166.68 with SMTP id f46mr7526057wel.26.1289876047255; Mon,
 15 Nov 2010 18:54:07 -0800 (PST)
Received: by 10.216.172.199 with HTTP; Mon, 15 Nov 2010 18:53:47 -0800 (PST)
In-Reply-To: <20101115213059.GJ16385@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161535>

2010/11/16 Jonathan Nieder <jrnieder@gmail.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0Files
>> that match the index exactly will be cleaned without "-f".
>
> Hmm, that's new. =C2=A0Seems fine, though; a person using -S would be
> forwarned.

It's safe, which is why I let it do that without '-f'. One can always
checkout those entries again (provided that they know what entries to
checkout).

How do you want them to be warned?

>> --- a/Documentation/git-clean.txt
>> +++ b/Documentation/git-clean.txt
>> @@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working =
tree
>> =C2=A0SYNOPSIS
>> =C2=A0--------
>> =C2=A0[verse]
>> -'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path=
>...
>> +'git clean' [-d] [-f] [-n] [-q] [-e <pattern>] [-x | -X | -S] [--] =
<path>...
>
> So -S and -x don't combine?

No. Technical difficulties. Wait, nothing prevents me from doing that.
Yes combination is possible.

>>
>> =C2=A0DESCRIPTION
>> =C2=A0-----------
>> @@ -61,6 +61,10 @@ OPTIONS
>> =C2=A0 =C2=A0 =C2=A0 Remove only files ignored by git. =C2=A0This ma=
y be useful to rebuild
>> =C2=A0 =C2=A0 =C2=A0 everything from scratch, but keep manually crea=
ted files.
>>
>> +-S::
>> + =C2=A0 =C2=A0 Remove files tracked by git but are outside of spars=
e checkout.
>> + =C2=A0 =C2=A0 Files that match the index exactly will be removed e=
ven when
>> + =C2=A0 =C2=A0 '-f' is not given and clean.requireForce is no.
>
> Does "no" mean "yes" here?

Probably, need to look at the that config variable again :(
--=20
Duy
