Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBF632F760
	for <git@vger.kernel.org>; Mon,  1 Sep 2025 20:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756759726; cv=none; b=Ukk7x41uvE2WnAXxSA+a3dr0Cq+OeyL+a2T61CIE29KcIJ3PQZE1ihrJWLJmxSQPt0a56Z3F0lkvenkGBwCYhmcKDS+YrMt/HIuMlf2XJq96YPS62wmlPBMZcos7l8NUBnLCkKN19pNlw0jcy78isjRXCvoSYzWg6He6oE5hzZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756759726; c=relaxed/simple;
	bh=OCvGc3qATc5+p+XkEM6DIT8wYWQXrzLXPiPadkuW/2g=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Tgzr92Q2N52xc8FuB7KVeaFc2ibBcs9BqvQ0E/mfPQbyLlKXzb7A9MqN2ZIXiZiIPXGCc8yA+DmxJ7Sv16SIp33tt+I2JhYRCQ+S2bL1RQmwsKo1jwViWmlFLudvohlPNDbdI3lm/+li3FdkctcR+p/qO5IfQx0qGKtp+65tEbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io; spf=pass smtp.mailfrom=alchemists.io; dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b=PA4sQqvv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cPiGTXu3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alchemists.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alchemists.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alchemists.io header.i=@alchemists.io header.b="PA4sQqvv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cPiGTXu3"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 105B97A02AC;
	Mon,  1 Sep 2025 16:48:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Mon, 01 Sep 2025 16:48:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alchemists.io;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1756759721; x=1756846121; bh=gcsEoltDMjd1iuOc7jIIpKnstCHCUSxc
	q48Vov0S0oc=; b=PA4sQqvv0alXu8lBWqc93WuB2QLH1Oa6QHKKmujJre4mJs5d
	gyRmaQIHHEHN6TcIzZRJjfHgyH0FAve+po4QrfWqqay9Nd/e9vUQXPP2HTUXoHn9
	ep43fw0zuvkktWR1Ot1JLlukfckG3s7cBNu58zFaPAO1hZ6T4UWLV0B3HDiqUsuG
	eNFlgUj3jhEYzpARpvczLm+j3cfalZvqmH0yMzZUFVqeASo8iuTYMEHQ0Q+S2oCy
	CMPIaPKhanmUU5gaSK1cOEbJ+YRwZ1RAxB8Cw/e2BlHTvRzMKLg/5ihOWBB48sTs
	kvRU2AQq66iZtzdZ5PwdPR652rvdjlasRV52DQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756759721; x=
	1756846121; bh=gcsEoltDMjd1iuOc7jIIpKnstCHCUSxcq48Vov0S0oc=; b=c
	PiGTXu3M7AMl0w/Qyi2/z8FrhPrP3zkRMJcmON4BFnfusdEooh85JVoEkQ1FH2qy
	SZGlkCnGcv0Bn3RZNO/LZaRPr3dFX8UyqqOh2pLgiclzC//CIR2VwBGc8hkCZsIv
	CxdOGeQQ5GYvM1D5JPXMOBiThSSBDcFkzPumdIv4Y/K48qvmgbBiNwmfv3augTbO
	3oQpBbap8D7XZnxu9BMPIsW4Uc+6lTAM/V8g/v/krMYHaOQj98Xt8vXbQsdmeUSN
	XqNYgYvGpZEnUtbJBLRi+dfJxjcMhZUra1RDpj0PSo291T0KiAgWAQTIpWA8iGPr
	WDMlQWxJjOmi7Jhw6RsLA==
X-ME-Sender: <xms:qQa2aBza--6NaIWy1-LtRan7YUJjUaJNQGoIlDUT9gyOtO7u7YPXUA>
    <xme:qQa2aIKBYsuVAMAP_UboDo8B42ajT4aEwDWj-3mtZP-8vbTnvG3-nOSzOOwxMOES0
    -UqTdGb8IMWEWIh>
X-ME-Received: <xmr:qQa2aIRxtUPGNnb59gaJ_S4Yt5VdF_Ae_FGX1JKPQQtz7B4MTzlkxUGuU7TSGVGNEReo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpegtggfuhfgjffevgffkfhfvofesthhqmh
    dthhdtjeenucfhrhhomhepuehrohhokhgvucfmuhhhlhhmrghnnhcuoegsrhhoohhkvges
    rghltghhvghmihhsthhsrdhioheqnecuggftrfgrthhtvghrnhepgeejvdeuvdetieelte
    euhfehieekkeefgfdvhfelgeegteehueelfeegledvieevnecuffhomhgrihhnpehgihht
    hhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegsrhhoohhkvgesrghltghhvghmihhsthhsrdhiohdpnhgspghrtghpthhtohep
    fedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrsh
    htvgdrnhgvth
X-ME-Proxy: <xmx:qQa2aAr3wGP3rM2qHmI2TwcU62smOb018b35RrPZNHa6MtgUqOok4w>
    <xmx:qQa2aNrrgqOcetmocu7kipM-IwVlbrqPQqwVGpbU68uv10N00nDoVQ>
    <xmx:qQa2aKNVhiV86wYu_YTes4lQ3qEs2EYwFh35eDQ8adiQm9gkdKLRHg>
    <xmx:qQa2aGz2htCk-hNEFiRMyTrOGPSN2_5Ip6DkX_PcSmX7FFZA_0pXqQ>
    <xmx:qQa2aBRdlW1bM--9_HFBo3P3wMTcvMXB0XLWNkzxA4ABY3zWhtTmNuls>
Feedback-ID: i78e840cc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 16:48:40 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Git Stash Synchronization - Best Workflow?
From: Brooke Kuhlmann <brooke@alchemists.io>
In-Reply-To: <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
Date: Mon, 1 Sep 2025 14:48:29 -0600
Cc: git@vger.kernel.org,
 "brian m . carlson" <sandals@crustytoothpaste.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <CE34C4BA-1ED4-458C-A31F-3DDB61ECCAAF@alchemists.io>
References: <7B1CCA36-23F1-410D-84ED-6E965989EA8B@alchemists.io>
 <5dee5f49-eeb6-49e2-8bca-6ae6a1d6be5d@gmail.com>
To: phillip.wood@dunelm.org.uk
X-Mailer: Apple Mail (2.3826.700.81)

Hey Phillip, thanks!

I applied what you've suggested and still was only able to make push and =
popping my stash with `git push --force` work. Actually, `git push =
--force-with-lease` does work but I get this error still:

To https://github.com/bkuhlmann/test
 ! [rejected]                  refs/stashes/bkuhlmann -> =
refs/stashes/bkuhlmann (remote ref updated since checkout)
error: failed to push some refs to 'https://github.com/bkuhlmann/test'

Despite that error showing up -- and the fact that I've applied your =
changes -- the stash DOES get updated properly both locally and via the =
remote. That didn't happen before.

Good callout on the use of `--force-if-includes`. I didn't mention that =
I have this enabled earlier because I always forget I have it configured =
via my global configuration as:

[push]
  useForceIfIncludes =3D true

...but I did update my global configuration, per your suggestion, as =
follows:

[core]
  logAllrefUpdates =3D always

[remote "origin"]
  fetch =3D refs/stashes/*:refs/remote/origin/stashes/*

With the above enabled, my reflog ended up showing this (using my "test" =
repository):

9305680c9afb (HEAD -> main, tag: 0.0.0, origin/main, origin/HEAD) =
HEAD@{6 minutes ago}: reset: moving to HEAD
9305680c9afb (HEAD -> main, tag: 0.0.0, origin/main, origin/HEAD) =
HEAD@{7 minutes ago}: reset: moving to HEAD
9305680c9afb (HEAD -> main, tag: 0.0.0, origin/main, origin/HEAD) =
HEAD@{8 minutes ago}: reset: moving to HEAD

I'm only seeing "reset: moving to HEAD" in my reflog when performing the =
push on my stash (in case that helps).

Yeah, having the documentation reflect this would be nice in terms of =
informing folks that you should enable what I've shown above. Ensuring =
any change to the stash would also update the reflog would be helpful =
too so folks can be implicit instead of explicit.


> You can use --force-with-lease=3Drefs/stashes/$USER:$expect where =
$expect is the value of refs/stashes/$USER when you last pushed. The =
problem is that there is no easy way to find that as by default =
refs/stashes/$USER does not have a reflog and there is no remote =
tracking ref set up for it either. If you add a fetch refspec like
>=20
>    refs/stashes/*:refs/remote/origin/stashes/*
>=20
> (note "remote" rather than "remotes" to avoid clashing with the =
default refspec for branches) then refs/remote/origin/stashes/$USER =
should be updated when you push to or pull from refs/stashes/* and I =
think a bare --force-with-lease will work. In general --force-with-lease =
without explicitly specifying $expect is not that safe as it will =
happily overwrite the remote ref if you fetch and do not incorporate the =
remote changes into your local changes before pushing. Using =
--force-if-includes is safer if you don't want to give $expect =
explicitly. That requires a reflog for the local ref though which you =
can enable by setting core.logAllrefUpdates=3Dalways. We should perhaps =
change the export code to create a reflog for the ref we're exporting =
the stashes to and maybe expand the documentation to mention setting up =
a fetch refspec.





> On Sep 1, 2025, at 4:10=E2=80=AFAM, Phillip Wood =
<phillip.wood123@gmail.com> wrote:
>=20
> Hi Brooke
>=20
> [I've cc'd brian to see what he thinks about setting up a reflog by =
default when exporting stashes]
>=20
> On 01/09/2025 00:25, Brooke Kuhlmann wrote:
>> Hello.
>> When using Git 2.51.0, what is the correct way to safely export
> > your stash and then keep that stash up-to-date? Here's an example
> > workflow:>
>> touch demo.txt
>> git stash push --include-untracked --message "Demo"
>> git stash export --to-ref "refs/stashes/$USER"
>> git push origin "refs/stashes/$USER"
>> git stash pop stash@{0}
>> git push origin "refs/stashes/$USER"
>=20
> This push doesn't do anything because refs/stashes/$USER is unchanged =
since the last push
>=20
>> git stash push --include-untracked --message "Demo II"
>> git stash export --to-ref "refs/stashes/$USER"
>> git push origin "refs/stashes/$USER"
>=20
> This push fails because you've popped and then pushed a stash since =
the last export so refs/stashes/$USER on the remote cannot fast-forward
>> Notice, in the middle, I pop the stash only to rename it. Upon
> > pushing these changes back up, I get the following error:>
>> To https://github.com/bkuhlmann/test
>>  ! [rejected]                  refs/stashes/bkuhlmann -> =
refs/stashes/bkuhlmann (non-fast-forward)
>> error: failed to push some refs to =
'https://github.com/bkuhlmann/test'
>> hint: Updates were rejected because a pushed branch tip is behind its =
remote
>> hint: counterpart. If you want to integrate the remote changes, use =
'git pull'
>> hint: before pushing again.
>> hint: See the 'Note about fast-forwards' in 'git push --help' for =
details.
>> The work around is to use `git push --force` when pushing updates.
> > I'd like to use `git push --force-with-lease` but that doesn't work.
> You can use --force-with-lease=3Drefs/stashes/$USER:$expect where =
$expect is the value of refs/stashes/$USER when you last pushed. The =
problem is that there is no easy way to find that as by default =
refs/stashes/$USER does not have a reflog and there is no remote =
tracking ref set up for it either. If you add a fetch refspec like
>=20
>    refs/stashes/*:refs/remote/origin/stashes/*
>=20
> (note "remote" rather than "remotes" to avoid clashing with the =
default refspec for branches) then refs/remote/origin/stashes/$USER =
should be updated when you push to or pull from refs/stashes/* and I =
think a bare --force-with-lease will work. In general --force-with-lease =
without explicitly specifying $expect is not that safe as it will =
happily overwrite the remote ref if you fetch and do not incorporate the =
remote changes into your local changes before pushing. Using =
--force-if-includes is safer if you don't want to give $expect =
explicitly. That requires a reflog for the local ref though which you =
can enable by setting core.logAllrefUpdates=3Dalways. We should perhaps =
change the export code to create a reflog for the ref we're exporting =
the stashes to and maybe expand the documentation to mention setting up =
a fetch refspec.
>=20
> Thanks
>=20
> Phillip
>=20
>> I realize that force pushing over your remote stash makes a lot more =
sense since you typically never share a stash with folks but was =
thinking it would be nice to ensure you don't accidentally override your =
remote stash when working on different machine when you forgot to import =
first. Basically, wanting to protect myself from myself. :)
>> Is force push the only way to handle this use case or is there a =
better approach? Thanks!
>=20

