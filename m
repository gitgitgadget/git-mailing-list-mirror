From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/6] Add infrastructure to write revisions in fast-export 
	format
Date: Mon, 7 Jun 2010 14:35:30 +0200
Message-ID: <AANLkTilqFNqGj8rq3fHZld6ddkHLp_usQSQKgQqeAt0X@mail.gmail.com>
References: <1275658871-1473-1-git-send-email-artagnon@gmail.com> 
	<1275658871-1473-6-git-send-email-artagnon@gmail.com> <20100604190222.GB21295@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Michael Barr <david.barr@cordelta.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 07 14:36:14 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLbYo-00007a-8G
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 14:36:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750834Ab0FGMfy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jun 2010 08:35:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:39128 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab0FGMfw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jun 2010 08:35:52 -0400
Received: by vws5 with SMTP id 5so3416690vws.19
        for <git@vger.kernel.org>; Mon, 07 Jun 2010 05:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=18jReI/jP5ZwU9WyhQuaL9mHV0PlswAYCKu2PPjY9qk=;
        b=yDe3Yv33J10V5EKX2AGBGoNh3mO3fp/YTcN8nt9nytmMUCK5NegTuOYkqr0U+g/oFP
         HpNfBEv8J6ii+ngvR9v8HcCrXIbuBtlt0skn0fp5cuzAOnJifZZ6Bsm0di9NspYSUIDT
         J4nK3FWaccG0JzfVJJXC6dXgSwkr7ELIOYR8Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=FH09dM8TGnf9Z30oS21PFcaPTITqurSQTvOrz0Kxh1/Raj4GIIxd4p8Ss4QW+/qxC0
         mSIFUixUqybMVHaabrIzoEFXssvJ1146RXbi5RkMiIzsDppeQdCjeGQpGB/w40r8Vspo
         KvIgYgEpWQFHfVu+p7IYaolGFN/0vkdO7kgkc=
Received: by 10.224.72.15 with SMTP id k15mr8797514qaj.356.1275914151259; Mon, 
	07 Jun 2010 05:35:51 -0700 (PDT)
Received: by 10.229.182.85 with HTTP; Mon, 7 Jun 2010 05:35:30 -0700 (PDT)
In-Reply-To: <20100604190222.GB21295@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148590>

Hi Jonathan,

Jonathan Nieder wrote:
> The big downside is that as David mentioned it does not scale well wi=
th
> the size of the directory and number of expansions. =C2=A0But a patch=
 is in
> the pipeline to fix that. =C2=A0I do not think it should hold the ser=
ies up.

Right. The `dirents` branch is now merged.

> Style: would probably be clearer to write:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0while (~(name =3D *path++)) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dirent =3D rep=
o_dirent_by_name(dir, name);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!dirent ||=
 !repo_dirent_is_dir(dirent))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0break;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dir =3D repo_d=
ir_from_dirent(dirent);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> i.e., fewer unnecessary braces, and dealing with the exceptional case=
s
> separately from the normal case.

This was (probably unintentionally) re-factored by David when merging
in his `dirents` branch.

> As before, I wonder about the error cases. =C2=A0Might it make sense =
to
> report the error if someone tries to copy a nonexistent directory
> from a previous revision?


> Function is too long for my taste (I realize this is a matter of
> taste). =C2=A0The innermost blocks would make sense as functions in t=
heir
> own right.

This came up in your previous review- I tried to split it up into more
functions, but due to the number of local variables, it turned out to
be a mess and I had to revert. Would you like to try re-factoring it?

> My 80-column terminal is suffering. =C2=A0Why not use the common
> pattern?

Re-factored (again, probably unintentionally) by David during the merge=
=2E

> These limits are not checked; is the caller supposed to check them
> itself? =C2=A0Does svn obey them?

I asked David too, and as far as we know, these limits are pretty
arbitrary. They're no enforced by SVN or any specific filesystem. We
can discuss about having less arbitrary limits and checking it in
svndump.c (while parsing the dump).

-- Ram
