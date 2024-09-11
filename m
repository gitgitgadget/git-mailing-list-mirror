Received: from aib29agh126.zrh1.oracleemaildelivery.com (aib29agh126.zrh1.oracleemaildelivery.com [192.29.178.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA8192B87
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 12:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057179; cv=none; b=UtjwLRyAx3U7UpRIpMErTI2iRA80X9ckMUjrJjg+8KY3datGLydiIGiVDjdQJAmauqDC3fy7EvJuwmqgUWcMcTOanl92EKF0IrxFs5vMFGRg7pCbeQ6J6QdSquR12ymBsKM5tgpG4gLoMshqIJjRTcbL8vEwKlQHVbkH+tfBYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057179; c=relaxed/simple;
	bh=jsNkDIuZ560f8brjgkrxY1tBvWwCRAs+NZMLHwd+qkQ=;
	h=MIME-version:Content-type:Date:Message-id:To:From:Subject:Cc:
	 References:In-reply-to; b=u9w7U90PUZO3So5uYPPmvQHwmJhvwGQ1sqbu4sb/Vn5tfFn7hJkSCULxkt0RziVnHqPO/J3g45aJGGu5b7tfFToC+uf3kSVX6wWHpmnQ7gOdQzZwmS6wvIdXl4MNu7J6G4J01cT7VAo5FLAaVl+cGn7nLLj3z5jhpei0dLm3N6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=VTjkCdAk; arc=none smtp.client-ip=192.29.178.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="VTjkCdAk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=LB+I9wJmbCkO4ttao3xZ8+kAMoWFk9hPjbiSCfvj6WY=;
 b=VTjkCdAkfxmUR44pYIFkNsM0T2KVhFtHvBzi4J0y2irVf+Hiwbf7Ddy/emZV4Gf06kglNae842fm
   UlofBzfFxcocR4PkmmXBjAm0bGhaEhntsxQEoKnQaWSR/z9nvcvN/P29VvbWQWfTNoxgy+NrUAmm
   DlUlAvQH2s6bgSYPtCdlWTYh74suxvkR+zknLq7kZohneA4m7bZ0rw/c4Z+BG+YdRdaSMtTYwAd6
   xPLFNiZ3EVrhnxfFf/fu/W1vLoOM5q5k0qnzgJeyE1f8tNpuhvdUPZYonm4PlR3cEqLI1Mnr0Faw
   Q0pq7gt55f5aZfQor9FYzLv4U7a7ns0lXwoubQ==
Received: by omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJN005K1E04D4B0@omta-ad1-fd3-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Sep 2024 12:14:28 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 14:13:05 +0200
Message-id: <D43G2CGX2N7L.ZRETD4HLIH0E@ferdinandy.com>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
Subject: Re: [RFC PATCH v2 1/2] fetch: set-head with --set-head option
Cc: <git@vger.kernel.org>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <20240910203835.2288291-1-bence@ferdinandy.com>
 <20240910203835.2288291-2-bence@ferdinandy.com> <xmqqseu7cfsl.fsf@gitster.g>
In-reply-to: <xmqqseu7cfsl.fsf@gitster.g>
Reporting-Meta:
 AAGAL7LB+LPsTE/01ylhfMlrgpU5acpodPSM1r7dKMpnT9o+/Qix9AsYE5Xh0m2e
 +8ESnMhdJHLT26NIN7lUVGh18twSzQVgXqs5mKp0hJgSjlnksc/1z2FrgTuV+3zX
 5iMz1CTTGCgoXGn69mnq4G/1WTzLu7958MNNMFXuWvpSicbzzvhTvIPwu9Da3Tig
 kNnwzJzxJjwyIxCcfwV8MeHccJ2CElEv/uoo9OuqPx2sQPuXGBVZZkhynmM1LWwI
 1l+aftfUhq8SNvL39xPPGlVOxNo9Wspw66OKIStGjHf7/RXeB5359+YuIuqqMMne
 aRkK6yMdx1H3rCU/HZ+Sy0cpTMFmh5avJmERfp9+m+eI/uaWMSkejIxGuxn5WTho
 lBEO0yGDCo4E17G/zZg58sJu6FgL2I8B3bVojv3IQTfkwKX+z/MzLp1XxQunkjjw
 U4vxu7L5E2FKmZkdVBJesYhBoiSunAUVcgU8fxEJbL6e/b2QaAEnDEI=

Hey Junio,

thanks for the very speedy feedback!

On Wed Sep 11, 2024 at 00:19, Junio C Hamano <gitster@pobox.com> wrote:

[snip]

>
> Ideally, because every "git fetch" you do will automatically learn
> what their HEAD of the day points at, even without "--set-head", it
> may be nice to let the user know when their HEAD changed, so that
> the user can inspect the situation and decide.

That would actually make sense, we could print a message saying HEAD has
changed and I guess helpfully print the exact set-head command they would n=
eed
to manually update should they wish to do so.

>
> If "fetch $repo", when it notices that refs/remotes/$repo/HEAD is
> missing, always unconditionally stores where their HEAD points at
> in refs/remotes/$repo/HEAD, and did nothing else, wouldn't that be
> sufficient?

>
> The users have "remote set-head" to do this when needed.  What is
> the true motivation that "fetch" (which presumably happens a lot
> more often) needs to be involved in this process?  The *only* upside
> I can see with "fetch --set-head" to blindly follow every switch of
> HEAD on the remote end is that you can keep up with the remote that
> flips its HEAD very often, but is that really a realistic need?  If
> we reject such a use case as invalid, I suspect that the end-user
> experience would be simplified quite a lot.  Imagine that we teach
> "git fetch $repo" to notice refs/remotes/$repo/HEAD is missing, and
> create it from the remote HEAD information automatically.  And we do
> NOTHING ELSE.  What would the end-user experience look like?
>
>  * Usually, you start with "git clone" and 'origin' will know which
>    branch 'origin/HEAD' points at.
>
>  * You may run "git remote add -f $repo $URL" to add one.  Because
>    this runs "git fetch $repo", the previous addition to the "git
>    fetch" will make sure refs/remotes/$repo/HEAD would be there.
>
>  * You may run "git remote add $repo $URL" to add one, and then
>    separately "git fetch $repo" yourself.  The end result would be
>    the same; refs/remotes/$repo/HEAD will be there.

I'm convinced :) It also does drop a lot of complexity. So there will be no
extra flag for fetch, rather:

- if the remote HEAD does not exist, we create it

- if it does exist, but has changed we print a message saying it was change=
d from X to Y and print the required command to update to this

- no configuration needed

The only place I can imagine this not being sufficient is in a CI/CD proces=
s
that is fetching into a cached repo needs to be updated, but then those peo=
ple
can just always run remote set-head -a.

>
> Having said all that, the implementation here ...
>
> > +static int run_set_head(const char *name)
> > +{
> > +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> > +	strvec_push(&cmd.args, "remote");
> > +	strvec_push(&cmd.args, "set-head");
> > +	strvec_push(&cmd.args, "--auto");
> > +	strvec_push(&cmd.args, name);
> > +	cmd.git_cmd =3D 1;
> > +	return run_command(&cmd);
> > +}
>
> ... does look quite straight-forward.

Unfortunately, as Jeff has pointed out in the other thread, this implementa=
tion
requires the user to authenticate twice ... Now, we could still rely on
set-head to actually do the writing, since if you explicitly give it what t=
o
set to it will not do a network query, but considering all of the above,
I think it would make more sense not to do this, rather just bring in the
required logic here. This would also allow for the second patch to be a bit
more explicit on what did or did not happen during a remote set-head.

>
> > +static int fetch_multiple(struct string_list *list, int max_children, =
int set_head,
> > +			const struct fetch_config *config)
> >  {
> >  	int i, result =3D 0;
> >  	struct strvec argv =3D STRVEC_INIT;
> > @@ -2014,6 +2025,8 @@ static int fetch_multiple(struct string_list *lis=
t, int max_children,
> >  				error(_("could not fetch %s"), name);
> >  				result =3D 1;
> >  			}
> > +			if (set_head && run_set_head(name))
> > +				result =3D 1;
>
> This looked a bit questionable---I expected that we'd run the
> subfetches with "--set-head" option, but this makes us do the
> set-head step ourselves after the subfetches are done.  What are
> pros-and-cons considered to reach the decision to do it this way?

Just noobish oversight, I figured out how to do it in the subfetch, but wit=
h
the above there will be no need for this anyway I guess.

I'll send a v2 soonish.

Best,
Bence
