From: Stephan Hugel <urschrei@gmail.com>
Subject: Re: [PATCH] tag,verify-tag: do not trip over rfc1991 signatures
Date: Tue, 5 Oct 2010 21:51:51 +0100
Message-ID: <AANLkTimg+=WW-mcB6RzORjDCV9rpLbc0NJhhg7Wd=0vp@mail.gmail.com>
References: <4CAB46C0.9000807@drmicha.warpmail.net>
	<5cea498f34522d603a1561bfe69e2f92caa39ced.1286293083.git.git@drmicha.warpmail.net>
	<7vr5g45qqx.fsf@alter.siamese.dyndns.org>
	<4CAB8DBB.3030706@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 05 22:52:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3EUR-0000qe-4j
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 22:51:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756298Ab0JEUvy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 16:51:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48377 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755854Ab0JEUvx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 16:51:53 -0400
Received: by wwj40 with SMTP id 40so6178710wwj.1
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 13:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aqm3XJfb28SHqqsjgrhiFcfyv8N5lZSqVQ/PTw7DzUs=;
        b=vGTbYS9GTXc3FBjs0CedZ5v5opB47VnF08KiTapI/3YJPa1VbxOT0v/iHROtQo37rW
         KVT8yQmI0Ww0KHn00w6Xk03G9SqHVAa3qixpaAPYLVg1cBOK3Jrh3hX2kNsmhuoCehvi
         hu8Xtj++FnY7XvnTk5213MTkW5M5mab+ZF6PU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SYvIHVbuJKuOCb6BUCWh+INBlRcK1U2D7vj3zbu+GLPVA938878/KALXoCSv5oUba5
         EFNNSpx/sPWq6BrluG/D66PVnZD4rWYcmxDzojNRftqk4kvMQTntzw7wMJe3oWUxiwWA
         FR05/7Q6Zf0bFU8LvYW5FlxMJ4FRwuNQjRsWY=
Received: by 10.216.154.133 with SMTP id h5mr9689276wek.93.1286311912007; Tue,
 05 Oct 2010 13:51:52 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Tue, 5 Oct 2010 13:51:51 -0700 (PDT)
In-Reply-To: <4CAB8DBB.3030706@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158245>

On 5 October 2010 21:42, Michael J Gruber <git@drmicha.warpmail.net> wr=
ote:
> Junio C Hamano venit, vidit, dixit 05.10.2010 22:28:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> Currently, git expects "-----BEGIN PGP SIGNATURE-----" at the begin=
ning of a
>>> signature. But gpg uses "MESSAGE" instead of "SIGNATURE" when used =
with
>>> the "rfc1991" option. This leads to git's faling to verify it's own
>>> signed tags.
>>>
>>> Be more lenient and take "-----BEGIN PGP " as the indicator.
>>
>> Thanks, but it bothers me that the patch is a bit inconsistently len=
ient.
>>
>> How many variants of PGP implementations are there? =C2=A0For exampl=
e, I'd ask
>> these without doing my own research because I am lazy:
>>
>> =C2=A01. Does everybody place five dashes at the beginning (IOW, is =
there an
>> =C2=A0 =C2=A0 odd variant that puts four or six)?
>>
>> =C2=A02. Does everybody follow the dashes immediately with "BEGIN" (=
IOW, is
>> =C2=A0 =C2=A0 there an odd variant that puts a SP between them)?
>>
>> =C2=A03. Does everybody spell "BEGIN PGP " the same way, in all uppe=
rcase?
>>
>> =C2=A04. Does everybody place five dashes at the end (IOW, is there =
an odd
>> =C2=A0 =C2=A0 variant that puts four or six)?
>>
>> =C2=A05. Does everybody follow the "BEGIN PGP SOMETHING" immediately=
 with
>> =C2=A0 =C2=A0 dashes without SP?
>>
>> Your patch seem to answer <yes, yes, yes, no, no> to the above quest=
ion.
>
> On 4,5, my patch only implies that I (suggest we) don't care.
>
>> I'd find it saner if the patched code at least checked that the line=
 ends
>> with 5 dashes.
>
> Alternatively, we can just say we support gnupg/openpg but not pgp 2.=
0,
> and running gpg with pgp 2.0 options is discouraged even by gpg's man=
 page.
>
> The main issue here is that we create a detached signature (rather th=
an
> a clear text signature) but then lump it together with the content (t=
he
> tag object sans sig). The boundary mark between the two is not
> controlled by us but by gpg (and its options).
>
> In order to verify the sig, *we* have to split the lump again but we
> don't really know the boundary mark. It's insane by design. We should
> have used a non-volatile boundary mark.
>
> I'll check whether we can somehow feed the whole lump to gpg and make=
 it
> recognize the attached-detached signature. That way we'd be as
> compatible as gpg.
>
> Michael
>
5 dashes + BEGIN [other stuff] and
5 dashes + END
was part of RFC1991:
http://tools.ietf.org/html/rfc1991#section-2.4.1

Which was obsoleted by RFC4880 :
http://tools.ietf.org/html/rfc4880#section-6.2
5 dashes + BEGIN [some different stuff]
5 dashes + END

Aside from the above considerations, 5 dashes + BEGIN
would appear to conform to both the old and the current spec. Since
the current implementation of GnuPG only offers the rfc1991
compatibility options, complying with both covers all (i.e. both)
possibilties, no?
--=20

steph
