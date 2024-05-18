Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4353B39852
	for <git@vger.kernel.org>; Sat, 18 May 2024 20:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716062814; cv=none; b=bqCGXC75D+Tvp/h/+ErQ+78htOMblbQJUj1U+QRoak6gq+1NNTFJKSoXvFWVMKr1UHXTAgtn07UknMKkeHZQOwhwDjr/gpXyB9hl09yAO1RV7WUqZHfTJNmdu2KZcnq9ML8v2glrw/iK09rf3Lhz+kW9delRnAIDTA0nbNasLHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716062814; c=relaxed/simple;
	bh=9B0FulhThwVl+Z8AsXI091YHNQa83BQ8rZY6xk/kTV4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=trBzjMMFYkOngMaq0Y3RJxort/jgbeYjxFGNTpnJ2sZ+iJ6dRskOjm9S3qF8Zj1nbkpYZNSL9ruyqYVHV1IgeHY0pX2EP9aMABm7YOwmNCf9Q/1OyOX/s+jvf/nxNnADSY38vScLtY8Dk9SO4r2eP42jmPC+D7HXt6KT6DoEBKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=ZHxjrT/H; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="ZHxjrT/H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716062797; x=1716667597;
	i=johannes.schindelin@gmx.de;
	bh=y6Fqwx61h3oV3h1G1Fl7ckLtKj1tiui5dKVL35XYBx0=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZHxjrT/HZFSsyRi8Cps+cP9IZ3ZC+/UNAhSKuDYCHQX01O8lq7bJGGBgPUposMHa
	 gs1G3eE5Y42jrr4Q99sLoTydLduMbt1Kae2A3Y4+O3GB445LrxsdLUqze2gQOsrhK
	 vbnHvD8+UyA5IXsnKT78L85KwucDa1mi2cD/pWTuFsr4lLBfaAn0qL/HTmm9yVOin
	 p+PTOIWY3PPJoOa/dnTHXEPfWi2RijhFCc5lY0Mo4OewuAOYyk1xurCE/O1fCu1or
	 aQCp4NpGNihKiuBOJLXA6FrY7xv40Ers6OEeec2YRYonatmXO5XuDtTVtkh6sHhKx
	 BCfJ5KuTbPHWIcO5cQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsIv-1sRbha2wWl-00tyaW; Sat, 18
 May 2024 22:06:37 +0200
Date: Sat, 18 May 2024 22:06:36 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <20240518194724.GB1573807@coredump.intra.peff.net>
Message-ID: <86d57213-e3b2-c985-6d69-71568c66fc9c@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com> <20240518181432.GA1570600@coredump.intra.peff.net>
 <c201bbe3-b404-feed-fcef-8333f72068dc@gmx.de> <20240518194724.GB1573807@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RBc5wUgOkvGd9WqoGT2HPWoGEVrE5pakk0384gyRN1XloC5otpz
 6AJoF2dLMIMJO90kL8xEEkKQSSZMqYGD9Aw13/0CFiZaDd1I0BhCwf4uxqNizaSwItEaHEv
 0n/ExGomJSvBoADs+aloaCEd4ov8SKAHSG4vjtWB8m/O0ORD45unK7G3qr50YKezPu1GKAq
 ihHKd8xQYmrJTSPLCU52w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:SSvI+WGBw5w=;E8BE+y/9EYPnligMnSlAXlS5WkR
 wwAR4aVeJnW0YxllEk5rnJNIouoYZ1hYbP70QDvq3KdV7T0Qjj3D86W4ypAMBtmxAAD1KjgFw
 6z9Yg5CWu61WyC5++OC6/mgE7nxdLPZ9YErJ7JCawXF9gtGqXUX+tEbswbJme9W1Xp8fF9zJ7
 ZXrftEICH3k/evBcaXy+zcSQYz5EXW9zKtXvsSg6go2s77WyTGdczHsSHpStwdJiX3LiNmMQU
 zYOk4NxPEufogUkZGyLb7TijKmefzUScYwrmJP9GJy5gdb2T3JWgp7oSBxV75ZsteB7svv7nS
 aUt1Po4co97pyZeIJ3HBYIZllkbkpVvl7rEU36OzRR8X+dU4/nQmYJMP+WIBPVByHgRVY4qRo
 JGWUFpbAMnXqw8La0AaEcgR1QMQj1bGTuPM5SF65zhXzihDxmpG8YaqNbHQo9EXkvm2W1FA7s
 gnWzWYKWEnrccRUwos/wmf/xuPgoGFOLM5JtUYIERixbhMvK4SscFG5mprDophmTp7ig3vZUr
 o57V3gYTwP6BeG9aqa1aktSKFszpadRKkiHPuRvLfXbqSrbwlCysYDFUXxkV6L07JlAd57/Wx
 hsQR5rfFJXLEc6UAVOnHtXVfEEM1bGwD4DqaAp1Q7v/vh+rCxukoxYerLELSEo2TWHH37mvOp
 VDOUy/oLlRb6JocCi3hI1zt3Q6KRHOvnmZJPN/J08OMbltTG5V71XCY51RZCZJvsXWhMZWbNL
 e8jEkT4T4KFfEIRq3fdKbSvMfHZkQhzb9yhVpWM335tu3cXD2pwuFUhkT5qtNAm6Z+cZ/8gPF
 x2b2LC1vNj6dnQ0E2I/jtpwZuvV4rAtx7qEPbQZkqdrtc=
Content-Transfer-Encoding: quoted-printable

Hi Jeff,

On Sat, 18 May 2024, Jeff King wrote:

> On Sat, May 18, 2024 at 09:32:07PM +0200, Johannes Schindelin wrote:
>
> > > Implied here is that I also think config-based hooks have a lot of
> > > _other_ advantages, and so would be worth pursuing anyway, and this
> > > extra safety would come along for free. I won't enumerate those
> > > advantages here, but we that can be a separate discussion if need
> > > be.
> >
> > One disadvantage of config-based hooks is that it is quite hard to
> > verify the provenance of the settings: Was it the user who added it,
> > was it a program the user called, or was it exploiting a vulnerability
> > whereby the config was written inadvertently?
>
> But isn't that true of the safe.hook.sha256 value, too?

No, because `safe.hook.sha256` (like `safe.directory` and
`safe.bareRepository`) is only respected in "protected" configs, i.e.
system-wide, user-wide and command-line config. Any such settings in the
repository-local config are ignored.

> If I can attack .git/config, then I can set it to match the attack hook
> (not to mention the zillion other config options which execute arbitrary
> code).
>
> If we really want to harden .git against attacks which can overwrite
> files in it, then I think the long-term path may be something like:
>
>   - add support for specifying hooks via config. Leave .git/hooks for
>     compatibility.
>
>   - introduce a config option to disable .git/hooks support. Respect it
>     only outside of .git/config. Default to false to start for backwards
>     compatibility. Eventually flip it to true by default.
>
> And then perhaps something similar for in-repo config (add an option to
> disable in-repo config except for repos marked as safe).
>
> > > And of course that feature doesn't yet exist, and is a much larger o=
ne.
> > > But besides un-breaking current LFS, I'm not sure that we need to ru=
sh
> > > out a more generic version of the feature.
> >
> > Exactly. We need to unbreak Git LFS-enabled clones and release v2.45.2
> > before I even have the head space to think more about config-based hoo=
ks.
>
> To be clear, I'm not proposing doing nothing. I'm proposing un-breaking
> LFS either by rolling back the defense-in-depth or adding hard-coded
> hashes, neither of which introduces a user-visible feature that must be
> supported. And then proceed with new features in the regular cycle.
>
> The hard-coded hashes are obviously a ticking time bomb until lfs
> updates again (and they don't help any as-yet-unknown program which does
> the same thing). So I'd suggest just rolling back the feature entirely
> in the meantime.

Rolling back the defense-in-depth would be a mistake: We do see (seemingly
on a yearly cadence) reports of vulnerabilities in Git that often raise to
critical severity by exploiting the hooks feature (typically in
conjunction with submodules). There is no reason to believe that this
steady trickle will stop any time soon. The defense-in-depth we introduced
would stop at least that escalation path that turns those vulnerabilities
into critical attack vectors putting users at risk.

Even worse: If we removed these protections without any replacement, now
we basically told hackers where to look for nice, exploitable bugs,
publicly.

For what it's worth, I was originally also in favor of the pretty surgical
addition of the hard-coded hashes specifically to unbreak Git LFS-enabled
clones. You must have seen my proposal that I sent to the Git security
mailing list.

However, brian suggested that Git LFS may not be the only 3rd-party
application that is affected by the clone protections. I have my doubts
that other applications use a similar route, it strikes me as quite hacky
to install a hook while running a `smudge` filter, yet I do admit that
there is a possibility. Which is why we introduced the `safe.hooks.sha256`
settings.

This strikes a good balance between unbreaking Git LFS and still
benefitting from the defense-in-depth that helps fend off future critical
vulnerabilities.

If we did not have such a balanced way to address the Git LFS breakage, I
would totally agree with you that we would need to consider rolling back
the defense-in-depth. Happily, we don't have to.

Ciao,
Johannes

P.S.: For what it's worth, the pattern we see in Git LFS is relatively
hard to replicate. `git clone` does not offer any easy and convenient way
to install hooks during the operation other than via templates (which,
unlike Git LFS-enabled clones, is _not_ broken in v2.45.1). Of course,
users could start a clone and then manually copy a `post-checkout` hook
into `.git/hooks/` _while the clone is still running_. I kind of doubt
that that's common practice we need to support, though.
