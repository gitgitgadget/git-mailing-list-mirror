From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/4] push: add 'prune' option
Date: Thu, 23 Feb 2012 03:09:00 +0200
Message-ID: <CAMP44s1s_NeXeUpxDR0cLoLGjSaf-0E_62MzAxeiHS=-6c045A@mail.gmail.com>
References: <1329950621-21165-1-git-send-email-felipe.contreras@gmail.com>
	<1329950621-21165-5-git-send-email-felipe.contreras@gmail.com>
	<7v1upm8jnq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 23 02:09:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0NBH-00049x-HO
	for gcvg-git-2@plane.gmane.org; Thu, 23 Feb 2012 02:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117Ab2BWBJF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Feb 2012 20:09:05 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:47748 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753413Ab2BWBJE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Feb 2012 20:09:04 -0500
Received: by lagu2 with SMTP id u2so791897lag.19
        for <git@vger.kernel.org>; Wed, 22 Feb 2012 17:09:01 -0800 (PST)
Received-SPF: pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.125.20 as permitted sender) client-ip=10.152.125.20;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of felipe.contreras@gmail.com designates 10.152.125.20 as permitted sender) smtp.mail=felipe.contreras@gmail.com; dkim=pass header.i=felipe.contreras@gmail.com
Received: from mr.google.com ([10.152.125.20])
        by 10.152.125.20 with SMTP id mm20mr24432332lab.6.1329959341022 (num_hops = 1);
        Wed, 22 Feb 2012 17:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=NNLGWoOQ/MqShYGUcg4ExauO6J+QNmDD4ig/irbDGU8=;
        b=a9Mk5zfTErs5EzjUP7n+dwUGPYbt3/JtgOKo9DVhXlr42TV7+BXi6ANy4eNN/7spKW
         aqtXO6v9yfG7qdhN6KGFDeLLPhSMzem8HvDDrCqZWdpgA9w0RRRextX1LtUI9oeF7My5
         9+cO9vG2g6cB+SrBU9OhXJ1Cij1sARQyL+A4I=
Received: by 10.152.125.20 with SMTP id mm20mr20518565lab.6.1329959340892;
 Wed, 22 Feb 2012 17:09:00 -0800 (PST)
Received: by 10.112.41.73 with HTTP; Wed, 22 Feb 2012 17:09:00 -0800 (PST)
In-Reply-To: <7v1upm8jnq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191319>

On Thu, Feb 23, 2012 at 2:42 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +--prune::
>> + =C2=A0 =C2=A0 Remove remote branches that don't have a local count=
erpart. For example
>> + =C2=A0 =C2=A0 a remote branch `tmp` will be removed if a local bra=
nch with the same
>> + =C2=A0 =C2=A0 name doesn't exist any more. This also respects refs=
pecs, e.g.
>> + =C2=A0 =C2=A0 `refs/heads/*:refs/tmp/*` would make sure that remot=
e `refs/tmp/foo`
>> + =C2=A0 =C2=A0 will be removed if `refs/heads/foo` doesn't exist.
>
> I do not think it adds much useful information to mention `tmp` only =
once
> over what is already said by the first sentence. =C2=A0Also, the firs=
t sentence
> of the example does not make it clear that it is assuming a same-for-=
same
> mapping.

Sure, the first sentence doesn't make it clear, but it would be a
valid and obvious assumption. The second sentence makes it clear, and
the name `tmp` immediately evokes a branch that will probably be
removed.

> Coming up with a precise technical description is easy, but it is har=
d to
> explain to the end user in easy terms, and I commend you for attempti=
ng to
> add an example in a short single sentence, though.
>
> Perhaps spelling out the underlying assumption the example makes is t=
he
> best we could do here without going too technical.
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0... For example, if you are pushing all yo=
ur local branches to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0update the local branches of the remote,

Yeah, but that's 'git push --all', and that's not the common
operation--'git push' is. So that's what I presumed the reader would
assume, and it really doesn't make a difference as to what will
follow:

>        `tmp` branch will be
> =C2=A0 =C2=A0 =C2=A0 =C2=A0removed from the remote if you removed you=
r `tmp` branch locally.

This reuses the name `tmp`, which seems to be your objective, but it
doesn't explain _why_ it would remove `tmp`; is it because `tmp` is
the upstream branch, or is it because it has the same name?

> =C2=A0 =C2=A0 =C2=A0 =C2=A0If you are pushing all your local branches=
 on your laptop to a
> =C2=A0 =C2=A0 =C2=A0 =C2=A0repository on your desktop machine under `=
refs/remotes/laptop/`
> =C2=A0 =C2=A0 =C2=A0 =C2=A0hierarchy to back them up, `refs/remotes/l=
aptop/tmp` is removed
> =C2=A0 =C2=A0 =C2=A0 =C2=A0from the remote if you no longer have the =
branch `tmp` on your
> =C2=A0 =C2=A0 =C2=A0 =C2=A0laptop.

Unfortunately, I as a reader have trouble understanding this. More
specifically I have trouble understanding where `refs/remotes/laptop/`
is coming from, and what it is meaning. I have always pictured
`refs/remotes` as something that 'git fetch' updates, and always from
the relevant repository. While eventually I could understand what this
thing is doing, it took me more than one read, and I had to read
slowly, and even then it seems completely non-standard to me.

I think a synthetic example, like `refs/heads/*:refs/tmp/*`, is much
easier to understand because it doesn't mess up with any established
refs, and also has the advantage that it shows the relevant refspec,
which is useful for people that are not familiar with refspecs, and in
fact, people could try it out without messing with their current refs.

>> diff --git a/remote.h b/remote.h
>> index b395598..341142c 100644
>> --- a/remote.h
>> +++ b/remote.h
>> @@ -145,7 +145,8 @@ int branch_merge_matches(struct branch *, int n,=
 const char *);
>> =C2=A0enum match_refs_flags {
>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_NONE =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
 0,
>> =C2=A0 =C2=A0 =C2=A0 MATCH_REFS_ALL =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
=3D (1 << 0),
>> - =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1)
>> + =C2=A0 =C2=A0 MATCH_REFS_MIRROR =C2=A0 =C2=A0 =C2=A0 =3D (1 << 1),
>> + =C2=A0 =C2=A0 MATCH_REFS_PRUNE =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D (1 <=
< 2),
>> =C2=A0};
>
> Lose the ',' at the end, for the same reason why deleted line did not=
 have
> one.

And why is that? Isn't git c99? That comma would only ensure that the
next patch that touches this would be two lines instead of one.

Cheers.

--=20
=46elipe Contreras
