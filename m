From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] setup_revisions(): do not access outside argv
Date: Wed, 20 May 2009 18:23:27 +1000
Message-ID: <fcaeb9bf0905200123r3649a7e5vc40ece402379e701@mail.gmail.com>
References: <1242806900-3499-1-git-send-email-pclouds@gmail.com> 
	<4A13BC3C.5070000@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 20 10:23:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6h5h-0002wI-AC
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 10:23:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbZETIXt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 04:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZETIXr
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 04:23:47 -0400
Received: from yw-out-2324.google.com ([74.125.46.30]:22636 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbZETIXq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 04:23:46 -0400
Received: by yw-out-2324.google.com with SMTP id 5so202825ywb.1
        for <git@vger.kernel.org>; Wed, 20 May 2009 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=zookS5Rcz/g1CP6vM5nNRXsGa+bSn+Ttmp5CmRkKBxg=;
        b=pbDZcEfhaiLJYpjW/HukPbZExLNoJxahIGRgk+e0rgJtv0KsxPpJnSiCJepAdoR9+K
         z1Z0W1cui1KjqSRkGpd148Yz8gPbcC/JHbmfjlra8wFf8K/JueHk/1NHEHfHqlAcY2u3
         yznEK9kRIVMbkMP/+ltzmFtnyMT8uRSNwkcnM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=h0MEpu/YS9UsuVIhUgNa8Sr8IYGF0DcPBqCeAt9rFj0eY3SWrEuAv9+LUHUb2w/tNj
         O8eAtbOJw6QY4sEXrAmp3kGWUT3/thnMuGj7EDkDO8dyKP7i+OK3Vr/91W+kp3f/U4Pd
         qSFNDOq6na39DYiCqgvJbZw8UD2KpwDiiDKdw=
Received: by 10.100.202.8 with SMTP id z8mr1994200anf.151.1242807827080; Wed, 
	20 May 2009 01:23:47 -0700 (PDT)
In-Reply-To: <4A13BC3C.5070000@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119589>

2009/5/20 Johannes Sixt <j.sixt@viscovery.net>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> =C2=A0revision.c | =C2=A0 =C2=A04 ++--
>> =C2=A01 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/revision.c b/revision.c
>> index 18b7ebb..be1e307 100644
>> --- a/revision.c
>> +++ b/revision.c
>> @@ -1241,9 +1241,9 @@ int setup_revisions(int argc, const char **arg=
v, struct rev_info *revs, const ch
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(arg, "--=
"))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 continue;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argv[i] =3D NULL;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc =3D i;
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (argv[i + 1])
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (i + 1 < argc && argv=
[i + 1])
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 revs->prune_data =3D get_pathspec(revs->prefix, argv + i + 1);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 argc =3D i;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 seen_dashdash =3D 1=
;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 break;
>> =C2=A0 =C2=A0 =C2=A0 }
>
> Why is this necessary? I'd expect that argv arrays have NULL at the e=
nd.

I have no idea. I hit this "bug" in my builtin-rebase.c and had that
question too. But I grepped through and saw that
at least verify_bundle() does not terminate argv with NULL. So I
assume that setup_revisions() does not expect NULL at the end.
--=20
Duy
