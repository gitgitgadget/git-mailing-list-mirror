Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C125014AD24
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732099648; cv=none; b=Z/4XioYQw2dC7nv32oG61bUCg236bE1T+1o6uD5PEVQrlDjHENNih/Ff637qkuscIT9j6DWf3F97c5IR1sLe8SiNG4LnrTb+OrJ9tbAsqoYx0l8OGs0P9Cb4i+4GSHc9nRiUb/G8cYvakQQXnRe/FnCeM6MrsBDMuO0/buLAU0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732099648; c=relaxed/simple;
	bh=dXcyUHgNp4nJcZ8v3TMS4zcmEMVcUtfXZRBMRmDBX78=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=MN/Q+Rwo6OLkt6tOeQGmbhu161FQ04Kk/i8d4rDmeT+vPPzA+bJDIzBjYL2wk5W5cORNEE9zDoeNZdf4Xjts6Cbjzyfq1JsPisaezVkAs2AC9Jn9idq5C1c6GzywoHPPNYbPe7jGynw5MJrS5mrfy4KU6ld4w86iRWs8s5ptbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=TZshXzlu; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="TZshXzlu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=tWo+4dRs+iZdmEg/mXSBDzqd+gqZXfnkmuI57BdMHCk=;
 b=TZshXzluqL2NLk6v7vcbhGPLthZcO1cR7QHKhyojIPc/baffKi05jSJ3RXLrr3YdG+siyMelEGCa
   gINyUynOT3tvPeFXMWSuAU3Yq95+rzKJkHxD7kkOMUWwxxbBLYB6nrp81ucoLyUzHLEM0O8Hvi8z
   XxPV5FD29EAyy8UQUaWT2t4FGxnA0ixyeBSUhpH4h9exbUJPovab97Y+5s89dqyrdKN1EsUKSECN
   tCiZGYctfd8Iu95kAI+1PaUQfhplVfUJGeEvWtMJjpGkowNXsdi4Tlgj8mgrOjNxzJSX/sNuipQ2
   IlLdC4+Y2oXE394fIj2P3P9TtU+u80m9VUlgiw==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241024 64bit (built Oct 24
 2024))
 with ESMTPS id <0SN8008AVWMXSC60@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 20 Nov 2024 10:47:21 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 20 Nov 2024 11:45:34 +0100
Message-id: <D5QY1HE55OLC.1RI15N4DC2O9A@ferdinandy.com>
Subject: Re: [PATCH v13 8/9] fetch: set remote/HEAD if it does not exist
Cc: <git@vger.kernel.org>, <phillip.wood@dunelm.org.uk>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>, <karthik.188@gmail.com>,
 "Taylor Blau" <me@ttaylorr.com>, "Patrick Steinhardt" <ps@pks.im>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20241023153736.257733-1-bence@ferdinandy.com>
 <20241118151755.756265-1-bence@ferdinandy.com>
 <20241118151755.756265-9-bence@ferdinandy.com> <xmqq5xojgbfl.fsf@gitster.g>
 <D5Q4AYZ9WSPP.3KOENYK0R7XB5@ferdinandy.com> <xmqqed36btxm.fsf@gitster.g>
In-reply-to: <xmqqed36btxm.fsf@gitster.g>
Reporting-Meta:
 AAHJelShxOEEmJ8wRy5BeYrGlOcsaUCws0etVablNpLEaT68QjSHDrE4tclwSh61
 PGaEDX4rH5tguJhJ8Qfu8kmIYrbJ+aoJJbZOvjlyN5pAvMlik3+dZunIbAUttx6o
 WvlXvtX3JaqQN2ac3NIOGT/5amKl0Jmy+kzoywxvPilTeEF1kl7QPBys4auyTAmA
 e9/xQ0aP1XjHFfqOHP3ogE4ocKvJuEIgqz2beK7Knz78Ywf19UxCVdg4qXx/2K2S
 wXaI648TD0aki4YIuFHQ1X5ffXiQe7wOfuI5E/Qn8z23Wg4nLwEwn6N6+0ufSY+3
 aqV2eKU3rXy0sB2AGf5a1pIKxJ2x/46VbfpYFE9zosClxuFkqrwUTj05FVjolY14
 d/x/dQI1MwkqhbVZ4jnGlsQOLLTPv/h7rY/R/10WHAOl0O3GcG2OYwCd/l+YW0Hz
 Fgdnp9Q7YRljvvSEzJ5FT3ECcTMNWjFhhWF+FzgVQ+nHSJi5dbR2+QcF


On Wed Nov 20, 2024 at 02:00, Junio C Hamano <gitster@pobox.com> wrote:
> "Bence Ferdinandy" <bence@ferdinandy.com> writes:
>
>> Your suggestion seems to be the original tri-state configuration that ca=
me up
>> in one of the original discussions. It was recently requested again for =
fetch
>> to just do this automatically
>> (https://lore.kernel.org/git/CAAHKNRGv19rhnqCkJMpE2FomNQBHvSS36aC=3Dfh0U=
wO+9-6RRfA@mail.gmail.com),
>> so at least some people would like to have this fully automated.
>
> And that is *not* the only option, and I am trying to help others
> by preventing unconditional warning messages from annoying them.
>
>> On the other hand: considering your points in the linked very early disc=
ussion,
>> maybe "warn" would be a better default?
>
> Those who want to stick to their manual choice would have to do an
> explicit set-head once, whether the default is "true" or "warn", so
> their inconvenience would not affect the choice of the default.
>
> I think "warn" is a good default _only_ for folks who want to verify
> and then expect they will follow what the upstream does 99% of the
> time.  For them, when they do not want to switch to what the
> upstream says (which is the rest 1%), there is no good way to
> squelch the warning other than dropping the configuration, but then
> they will lose the ability to notice further flips at the remote
> after that, which may turn out to be a problem.
>
> Instead of "true", "warn", and "false", we might need "if it is set
> to _this_ value, do not warn and keep the current setting" to help
> those who cautiously only allow the remote affect what they use
> after inspecting, but expect that the choice made by the remote will
> not be outrageous most of the time for them.
>
> If we want to solve this completely for them, that is.  I dunno.

I initially thought you meant a fourth setting here, but what you are
suggesting here is that in case the user has "remote.origin.followremotehea=
d
=3D never" set even in case of "init && remote add && fetch" HEAD should no=
t be
created, which is a bit different, because originally we discussed only not
changing after the initial creation. This makes a lot of sense.

>
> Those who want to blindly follow what the upstream says 100% of the
> time will have to switch to "true" just once manually, if the
> default were "warn", but once may be one time too many for them.
>
> And that is why I said "clone" (and "fetch" setting a non-existing
> HEAD automatically) may want to default to "true".

Fair point again.

>
>> Fair point.
>>
>> This series has a tendency for growing in complication in each iteration=
 :)
>
> Anytime somebody gets swayed by an opinion to add unconditional
> warning or unconditional futzing without considering that such a
> move may annoy some users that are different from the opinion giver,
> we need to make sure there are escape hatches.  Under the assumption
> that most projects only flip HEAD very rarely, and considering the
> fact that we have lived with manual setting with set-head and
> nothing else, we could drop the automatic setting by "fetch"
> altogether to reduce the scope of the series without losing much
> *and* more importantly without harming existing users.

Don't get me wrong, I'd like to do the right thing here, and appreciate tha=
t my
perspective is rather limited. I was just reflecting on the fact that the f=
irst
"working" version of the series was only two patches. Writing this is fun a=
nd
educational for me.

>
> I think we could make it a multi-step transition in order to keep
> changes to "git fetch" we make in each step smaller, which may go
> like so:

That being said, if it's possible to graduate a part of the series when it'=
s
ready and where it makes sense to split, that would be welcome. As you writ=
e
below the first such place would be remote set-head --auto. Not that that i=
s
ready yet, I need to fix the mistake you spotted, update a commit message, =
and
add a test-coverage. But in that case I might send a v14 with just these
updates and work on getting the fetch settings in parallel for a v15.
Technically I would just need to build the series off next for a while, rig=
ht?

>
>  1) Let "git fetch" create missing remotes/$name/HEAD.  No other
>     changes.

So this is a bit simpler version of what we have now (as long as it doesn't
bother for example you, that there is a state which will create HEAD withou=
t
being able to disable it :)) Should this even print anything? Probably not,
clone also doesn't tell you that the HEAD was set.

>
>  2) Introduce a remote.$name.followRemoteHEAD that can say "the last
>     branch we observed that they point at is 'main'".  Set it when
>     we clone, When "git fetch" notices that the remote flipped its
>     HEAD to a different value, warn and update (which would give us
>     the "warn only once, do not annoy users by constantly warning").
>     The user can delete the configuration to squelch "git fetch" (in
>     other words, the repository does not remember the last setting,
>     so we refrain from warning "it has changed since the last time").
>     No other changes.
>
>  3) Allow remote.$name.followRemoteHEAD to be set to
>
>     3-a) "always", which would squelch the warning and causes "git
>     fetch" to always repoint the local remotes/$name/HEAD to
>     whatever the remote says,

But this should print similar messages as remote set-head --auto when there=
 is
an actual change done, right? And should probably respect --quiet?

>
>     3-b) "warn", which would cause "git fetch" to warn when the
>     remote's HEAD is different from local remotes/$name/HEAD,

This should also respect --quite I assume.

>
>     3-c) "never", which would cause "git fetch" to even omit the
>     "copy if it does not exist" we add in 1) to help those who
>     deliberately want to keep remotes/$name/HEAD missing (to force
>     themselves to be more explicit, saying things like "git checkout
>     -b topic origin/maint" and "git rebase origin/master", but never
>     "git checkout --detach origin").

I think skipping 2 and jumping straight to the final configuration would be
easier, no need to wrap one's head around a configuration state that will
essentially never really exist and most of the extra complexity (at least f=
rom
my perspective) comes from having to have a configuration at all.=20

Thanks,
Bence

