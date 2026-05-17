Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E258BE9
	for <git@vger.kernel.org>; Sun, 17 May 2026 11:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017286; cv=none; b=pRqkIH6vDElQnPU+5GlmmJPgGj0jV4Lq7jaAZDqLXYiRdsYNjRUlL+gAeEI6NydkZujEYv9xYlkIU7OJQSldXs2C2oiOE5HJ6y7bAGSjy34I6N/kg9ODhwzkAFRdmuky4Qrl1C4TnHdHhlrGDVFYPlufopWwAhVLTfSmYNZnFio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017286; c=relaxed/simple;
	bh=M83PMf/ASKvUrmGINyXimeEGU4fQ8WGKzn3y7n0EOWw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QiVo1gMDrnA/PRp3aaq5YG9iNYT2/O0/Uv5KNz2mFVKGl+Qv3XVQRYHDobWBPLVkk7f9yirFGTnPOoUuFZOyfBeKlDnFIoWvgDZE9m6ytl6e/kfJamUNOqeMgQjz94yzOVAoXszvaLPpqQGRqihdPjRreu+lz7iHuOb3eUPMIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=AilJIMnG; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="AilJIMnG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779017276; x=1779622076;
	i=johannes.schindelin@gmx.de;
	bh=bcZryiFLSAGnMKbOyH960Ti/Uo7dWZXR21IJZwe3TD8=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AilJIMnGL7MEeLROe49tmI0vitlvi2nFTRxe8qUnLQWo662F9shI+dU8wml0lh29
	 rjGvkoHndYiz7u0F/ytGN8ELpPgwXdcPmKcW+c9rOnqPm2YAJEKudyL01uSl7/F+t
	 zkxN1VHUgXjWXLYS9Y/ylpXbLrSqf/hxHSXnsvugL5fEJj8qbvh2eAcUVh+lHm6As
	 /TdvhSyKezgxieuLo2G3a3P/AWrrckZUgdT9GKswGFSSuytn4neJSUdmPwj5cwE7N
	 6zPR5eBGI4bS47yyYW+NU9o3fz16ULpz3TIUTBBE/BfzksMm7s1++3/BV7b7On3Vi
	 aftJOBZeReu2hXcdgw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1x39Ca2tz2-00kljq; Sun, 17
 May 2026 13:27:56 +0200
Date: Sun, 17 May 2026 13:27:55 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: =?UTF-8?Q?J=C3=B6rg_Thalheim?= <joerg@thalheim.io>, 
    Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
In-Reply-To: <agGo9Prt8Hs2gbic@pks.im>
Message-ID: <409d05a5-235b-6b19-5a33-a4e613dd447c@gmx.de>
References: <20260403100135.3901610-1-joerg@thalheim.io> <adYvSZeN0ZVqwRhi@pks.im> <xmqqcxz2vfpa.fsf@gitster.g> <91335804a092b09757331cac72092a3835020b3a@thalheim.io> <agGo9Prt8Hs2gbic@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1600604462-1779017276=:15795"
X-Provags-ID: V03:K1:Pl8qrAG53wbl5QTDEluo8I0FK3sAy8V1Bv+zNa/sJbdQl4h4H1E
 iBHiDtM7aMzvSPCpAK/FeihPjTgk1YxlUUu4n8rWuCoC7Hg6LdCN8S1YaytEPrdny6cqHB9
 LJr8kXWmzQVVHmnUvYzfk9qOeF1V9uYeoRlY0h9osp4Q49Y03SiwyUbINs4m+YVidYji7aE
 4TmWBdwf8chbjPK3r6tww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:yheROftNGQU=;aQ2STxRc8XkMNPwnZmuVd9D+vRW
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1600604462-1779017276=:15795
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Patrick & J=C3=B6rg,

On Mon, 11 May 2026, Patrick Steinhardt wrote:

> On Mon, May 11, 2026 at 09:06:00AM +0000, J=C3=B6rg Thalheim wrote:
> > May 11, 2026 at 4:32 AM, "Junio C Hamano" <gitster@pobox.com
> > mailto:gitster@pobox.com?to=3D%22Junio%20C%20Hamano%22%20%3Cgitster%40=
pobox.com%3E
> > > wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > > > > This bites in practice when running `git worktree add -b` concur=
rently
> > > > >  against the same repository. Each invocation makes several writ=
es to
> > > > >  ".git/config" to set up branch tracking, and tooling that creat=
es
> > > > >  worktrees in parallel sees intermittent failures. Worse, `git w=
orktree
> > > > >  add` does not propagate the failed config write to its exit cod=
e: the
> > > > >  worktree is created and the command exits 0, but tracking
> > > > >  configuration is silently dropped.
> > > > >=20
> > > >  This very much sounds like a bug that is worth fixing independent=
ly.
> > > >=20
> > > > >=20
> > > > > The lock is held only for the duration of rewriting a small file=
, so
> > > > >  retrying for 100 ms papers over any realistic contention while =
still
> > > > >  failing fast if a stale lock has been left behind by a crashed
> > > > >  process. This mirrors what we already do for individual referen=
ce
> > > > >  locks (4ff0f01cb7 (refs: retry acquiring reference locks for 10=
0ms,
> > > > >  2017-08-21)).
> > > > >=20
> > > >  Famous last words :) Experience tells me that any timeout value t=
hat
> > > >  isn't excessive will eventually be hit in some production system.=
 Which
> > > >  raises the question whether we want to make the timeout configura=
ble,
> > > >  similar to "core.filesRefLockTimeout" and "core.packedRefsTimeout=
".
> > > >  ...
> > > >  Honestly though, I'm not really sure what to make with this. We c=
ould
> > > >  of course also add some validation that the configuration we want=
 to set
> > > >  hasn't been modified meanwhile. But that would now lead to a situ=
ation
> > > >  where we have to update every single caller in our tree to make u=
se of
> > > >  the new mechanism, which would be a bunch of work.
> > > >=20
> > > >  And adding the timeout doesn't really change the status quo, eith=
er. We
> > > >  already have the case that we'll happily overwrite changes made b=
y
> > > >  concurrent processes. The only thing that changes is that we make=
 it
> > > >  more likely for concurrent changes to succeed.
> > > >=20
> > > We haven't heard any response to these points raised in the message
> > > I am responding to. Should I still keep the patch in my tree,
> > > hoping that a responses may come some day? I am tempted to discard
> > > the topic as it has been quite a while since we last looked at it.
> >=20
> > I am not really sure what you want me to do here.
>=20
> In general, the idea here is to engage in a discussion that can
> ultimately lead to one of two outcomes:
>=20
>   - The discussion surfaces an area the author hasn't thought about, so
>     the patch is adapted accordingly.
>=20
>   - The discussion shows that the author already did think about the
>     issue, but hasn't documented the assumptions. In this case, it
>     should be the commit message that gets adapted.

For what it's worth, I meant to chime in earlier, but obligations kept
preventing me from setting aside the time to do so. Well, better late than
never.

> > I don't see how git can have this value configurable, given it's about
> > reading the configuration itself. Is the user supposed via command
> > line?
>=20
> This is a fair point indeed. But if it's not possible to change via the
> configuration itself, then the next-best thing might be to introduce an
> environment variable that allows configuring it.

Well, given that the config is read first before it's written, it is
totally possible to configure a timeout via the config, and I have some
real-world proof that this works as intended (see below).

> The other aspect that wasn't discussed in the commit message is how
> concurrent writes are handled, both when they are non-conflicting
> (updating different keys) and when they are conflicting (updating the
> same key). After spending some more time in the code I think it's
> ultimately nothing we have to worry about too much, as we only start
> reading the configuration after we've locked it.

Correct. I had performed this analysis myself when writing a similar patch
to fix problems in Scalar's Functional Test suite, which wants to register
_many_ Scalar repositories with ~/.gitconfig concurrently. The current
iteration of the patch can be found here:

https://github.com/microsoft/git/commit/a1c2d97cb61bc3697086d1749de848586d=
f2ec54

It does include the config setting, leaving the default as "off" (but I
missed the separate code path to rename sections, which has _independent_
code that also wants to lock the config file, which your patch did not
miss). The subsequent child commit

https://github.com/microsoft/git/commit/5d365c1f332b8d2214ae9c44970d6370ed=
9caffc

configures it to 150ms in Scalar repositories only. This is notably larger
than the 100ms you suggested, and it is rooted in the fact that NTFS I/O
characteristics are unfortunately in need of a wider margin. In other
words, the optimal value depends on the operating system (and the CPU
load, as Junio had pointed out).

For the record, feel free to adopt whatever you want from my patches for
your next iteration (but also feel free to ignore all of it).

> So in the semantically non-conflicting case there isn't really much of a
> race, because things already work as expected. But in the semantically
> conflicting case it's a bit different, as the latter writer will
> overwrite the result of the former one. In theory it would be possible
> to detect such conflicts by:
>=20
>   - Reading the configuration file.
>=20
>   - Taking the lock.
>=20
>   - Rereading the configuration to check for conflicts.
>=20
> But even that is racy as the first writer might have succeeded before we
> read the configuration the first time. So I'm not sure whether we can do
> anything about that in the first place, as the race basically exists in
> the outer loop controlled by the caller.
>=20
> So there probably isn't much we can do about that, and unless I missed
> something I think your timeout is sensible. But ideally, such nuances
> would be discussed as part of the commit message so that reviewers and
> future readers are made aware of them.

I agree. Complex cases like this would require a sort of transactional
support to be added to `git config`, and that would in and of itself open
a can of worms I'm not sure we should open unless there is a concrete use
case that bites enough real-world scenarios to require acting upon.

Ciao,
Johannes

--8323328-1600604462-1779017276=:15795--
