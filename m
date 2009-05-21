From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Thu, 21 May 2009 12:41:54 +1000
Message-ID: <fcaeb9bf0905201941u2480e102jd1925593e288b608@mail.gmail.com>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> 
	<4A13BC3C.5070000@viscovery.net> <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com> 
	<7v7i0btdwu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 21 04:42:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6yEg-0000ha-8j
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 04:42:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbZEUCmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 22:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbZEUCmN
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 22:42:13 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:14496 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753596AbZEUCmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 22:42:13 -0400
Received: by an-out-0708.google.com with SMTP id d40so1931286and.1
        for <git@vger.kernel.org>; Wed, 20 May 2009 19:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=fLUCA6R2v42githmHWZwyu1jwq42jQv9UWS9z3Si5dA=;
        b=sgOBJqzg7Gz8+HfxW36RpvsjtYVRdG92FtHjqnvweE6rENKcNqYDc/S5rH2mgyNXgc
         iVAt8xKQ7Or5OnWlul6whj9lDMFH5ancoxbVeMqhny/x6ybvvvXpdmCPEm6ZhCzjhrE/
         sbB7GDrVHopuiygKVY0rbWf/5qRI++wN5ZkqY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=KQxGNs/fWoWf4sJuM4icO2gfw5nMDKzvNy724WqDKn/ZIXuP4qm1sOW48j9Az6VYjQ
         qHG1uVYX3uLyawwTlrBepl+htgqO8kv7GA1qkhoMJghzg26ga3zn2p8otDQ0kIJwrXdI
         ZNkjUQbrMWUQ75bfc7l3LHYfumGu2FhwfoKss=
Received: by 10.100.213.13 with SMTP id l13mr3938648ang.110.1242873734083; 
	Wed, 20 May 2009 19:42:14 -0700 (PDT)
In-Reply-To: <7v7i0btdwu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119648>

On Thu, May 21, 2009 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> 2009/5/20 Johannes Sixt <j.sixt@viscovery.net>:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@=
gmail.com>
>>>> ---
>>>> =C2=A0revision.c | =C2=A0 =C2=A04 ++--
>>>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/revision.c b/revision.c
>>>> index 18b7ebb..be1e307 100644
>>>> --- a/revision.c
>>>> +++ b/revision.c
>>>> @@ -1241,9 +1241,9 @@ int setup_revisions(int argc, const char **a=
rgv, struct rev_info *revs, const ch
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(arg, "=
--"))
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[i] =3D NULL;
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc =3D i;
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (argv[i + 1])
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i + 1 < argc && ar=
gv[i + 1])
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 revs->prune_data =3D get_pathspec(revs->prefix, argv + i + 1=
);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc =3D i;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seen_dashdash =3D=
 1;
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>>>> =C2=A0 =C2=A0 =C2=A0 }
>>>
>>> Why is this necessary? I'd expect that argv arrays have NULL at the=
 end.
>>
>> I have no idea. I hit this "bug" in my builtin-rebase.c and had that
>> question too. But I grepped through and saw that
>> at least verify_bundle() does not terminate argv with NULL. So I
>> assume that setup_revisions() does not expect NULL at the end.
>
> If a function takes (int ac, char **av), then people should be able t=
o
> depend on the usual convention of
>
> =C2=A0(1) for any i < ac, av[i] is not NULL; and
> =C2=A0(2) av[ac] is NULL.
>
> With your patch, a broken caller's wish is simply discarded and nobod=
y
> will notice. =C2=A0Without your patch, at least you will know that th=
e caller
> passed an inconsistent pair of ac and av to this function by seeing a
> coalmine canary segfault.

OK. I will send another patch for verify_bundle() then :-) just to
make sure no one goes down the same way.
--=20
Duy
