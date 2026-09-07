Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA04A44C673
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 09:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788773446; cv=pass; b=iyAGvCvCMVsD643t7w1hLEVDGsR6XorR6BH5LTyG22C61mjBfyK8HOLo1Ajpp1xg2TGL/UHCFWDZUoHFM6cRMRXIx7kWq41jTEhbB5AJY7XQNkHBS1mWUX8AWBzPl0TtUI9hVRne/sk3rXSEP2O4n96obTSK5lN3ivio2GnDR4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788773446; c=relaxed/simple;
	bh=H37t44PM/gCeHRfOmFtghWOrIvDU5DDzqoDf3zqTx7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=N9ORMLN/23eFetbe52YxxAldkI2iibVOwAKOGGvdKop7RIRivw1SFcOHZe5U5D6dSgsA4UCD7grleSrhIjMAZEQsSUJyt4fELcdwYPuCrO5NDnfuYdGmXPngOwQ57GSUZikNYq065x9oKORxIIWdHESZvdG485KouW/hRI3YVWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Dqk2CJmw; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dqk2CJmw"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-5306706e89dso309441cf.1
        for <git@vger.kernel.org>; Mon, 07 Sep 2026 02:30:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788773443; cv=none;
        d=google.com; s=arc-20260327;
        b=RAQ76KhhWVXsaYONa3W6dxckoEYq56koIcrcWZCLBYI/dMkqxL6VpnxjTlHP6C57XV
         zUffYbXaitltzwGHW7AiEPgIKkrkGUEj6bncCOjtQZ9aGfCMLWutdXFJyS6N9mtjVat5
         CpBftgtU48RwG6hz5iiaTk0TFmKSrl7Z9sZWHC1yNhRjR/fytNTLa6rqhH6MpmwGy6jH
         oPusmfBDS3kwD2BzN5CCYc7ezgLCDXVxIa8NFAHVP9J3lUVwx6uaS7VMiMntGCL1IiS1
         bObVVBOOg6kE+7Ol9O2L4jmiXgIWG9hFcDQtlZjzksTpfW99s/fpbDKh7NhaOxSWEtkd
         HAJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Joo3KFvFG3FFpMifQ3cnM0RgHPTGyfnVfoaMSZ+twR0=;
        fh=4vLwwOu76q/8OHz7mGPUoW5x5SU161IohxSqhF88pRA=;
        b=KwuA87EQ1hsuwhG+MsqFuF2iUOzNMzmil41UdSxTrBX0WoCT0ZlG4wAZeoqlrWOeLR
         0sO8CIX+PXfJ0/icjXQXPsqEmFhnUPlrTEezIPaUdDaJPAt1SkUH7r+k6ynjkx9UMLce
         jIrNxFef87Oh8IkN+FNctzGOxloEXbvkGGKBB/lVsd30Lm9oGCoLUxVColLYCzs/o+y6
         uYfAefWEFAdb4gdx9//nf5xvfGKIvQHdxt8HZ6tnYHBiw5ez4aeeHexYXu8zgNPjCPJT
         hkmX2Vi/VsCYW4iv+dklFl4Q/HhJQkIHNWvgt7IQmrR2WAghiHpoidfnKF5TGVpy3bWY
         aykQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788773443; x=1789378243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Joo3KFvFG3FFpMifQ3cnM0RgHPTGyfnVfoaMSZ+twR0=;
        b=Dqk2CJmwu3WZTpqmnA9ZpSvM9l8lfTCs9XhdO+p7V0zwYOGIG669yVSfhaF0wgDsRt
         +PKt2hhhdhH/frKBScO8PuF9hgLp92+jGsPdN0P0junEME1JBh+zsS1gVulSfU3ScOlB
         q5irg1ILYqStmx0MjWsT1RroFVtQp5y/bREjxFqtDhoKvd8WMtbkALRF1tdDSM3xU3jk
         HLovolKGyPiQTE14FUX72Cv52neVCnugXKoa7TANz+IEHeQIRmwPjuKNiKCMisscKrTW
         dfkT4lkDv7ziTpgBY2wyrAaMZh/G2excFo75C+HBFR0GYKnS+4qREESVSk7ebZqHC4Sd
         fB8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788773443; x=1789378243;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Joo3KFvFG3FFpMifQ3cnM0RgHPTGyfnVfoaMSZ+twR0=;
        b=ECB78HZ0I0dKGOb+VnkAuy7GlMcB6UJGhq8kExqJF98YxhZ0V6va7o0J+3vXICNiat
         VoEAwE43vD2/wrhBHiX7XLASU74PS8rHSvNDsWLWMByyKGjN02BItcH9p98XgeQX6h1P
         2cJQzGm7k+gXYWIcLdeByyS8gJuUxi0dQyLF6b6o/7gnDIuUSNTOyd50ILNQIwcnmttG
         6xj5H7Eukhgr70RdqNkmHQiUFTERvSJWzHL43d4+EMvz71WqYCF/S5sXDsD4QOyHRSef
         ZLRvhDDY4ju/Irvt1NRUbiOVUqIFDBiXO92TEni88aYeitqNK4qvfTY/iIcogQjLW5+q
         2dTA==
X-Forwarded-Encrypted: i=1; AKwUvBxogPBUrvBTc5zuEFXlzWHaKH04QAljo01gvs80ICjkII9fbURlqK/KXH3Cn80D81Z2ncI=@vger.kernel.org
X-Gm-Message-State: AFuF++mg+GudD4ayGQw3hLBKyW9V0n5vkGfo+EJmKg7Bex792hfx3dYu
	CNl8hN+nC238gswuxPXappLz17/4TO63/FgxxLSAEcqB1soEwmtbnvsenOsBlhJteixANhSu67A
	5JI92u2xgaxwlCQIsVHuDu8cxTUtA0Xk7ZTJ7UNJv
X-Gm-Gg: AYBFou38PtJH+UWIxVlmFczN6PXprtvwpz7diOrYdEbqVYXAR84QFj6v6iIkui4LXsW
	f7xnYEuOeh1fjxg2tCXFobtdXYfCM6A06qBazxnf9qAtGMEEdqwgZ78iFg2K1Ojqr3a6qNtfmhy
	zIaLCceim0TwtTJ9QHbW1DIby5NNkW9937+H9RG/WNNMIX20QESs15f0Ue86V26KGFGIyMzReUN
	27eYkWiSJa8Aj+fcbLoajpgDZYw6c+fN3Y3C26B9END2wyetE9bVedmo8SepyqI/Sx85VLD1vIT
	eeaRvxNwYHtkHZmRJ7rAtV1yEy7Vw5+iLFi/Ehwt+WBUHGnXcNH0E0DfnheV03PWT+/5aOsnO34
	=
X-Received: by 2002:ac8:5a56:0:b0:530:5ed7:50f0 with SMTP id
 d75a77b69052e-53084da738dmr8671371cf.13.1788773442792; Mon, 07 Sep 2026
 02:30:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqmrtu50av.fsf@gitster.g> <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
In-Reply-To: <ap2tjx0z7kiFjDM9@fruit.crustytoothpaste.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Mon, 7 Sep 2026 11:30:31 +0200
X-Gm-Features: AcwNN1UP9WMrF9XtAER-N7ZrVTRUA3tPw5yW4cCcEHSLteACBHjH1yu-DcdBVIA
Message-ID: <CAJoAoZkfNDBVt6RJg4rGAfB1SLp3O0Nh+_w6Ge5oebj67KJXrQ@mail.gmail.com>
Subject: Re: What will come after Git 2.56?
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 8:19=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2026-09-06 at 07:03:20, Junio C Hamano wrote:
> > http://tinyurl.com/gitcal tells us that the current development
> > cycle for Git 2.56 will conclude around the end of this month.  As
> > our typical development cycle lasts between 8 and 12 weeks, we will
> > have exactly one more cycle after that before the end of the year.
> >
> > Now, the question is what that release should be called.  A few
> > thoughts.
> >
> >  (1) Git 3.0: it is tempting to conclude the year with a big
> >      version bump.  Splash!
> >
> >  (2) Git 2.99: by leaving no more room until 3.0, we will
> >      conclude the year with a version that is still in the 2.X
> >      series, but will hopefully force us to seriously prepare for
> >      a big version bump with the first release of the year 2027.
> >
> >  (3) Git 2.98 (or 2.97): we admit that we are not ready for even
> >      (2) and chicken out, leaving us breathing room for a few
> >      more preparatory releases before the big one.
> >
> >  (4) Git 2.57: doing business as usual.
> >
> > Needless to say, this is not a popularity contest, nor is it even a
> > democracy.  Regardless, we should review what we have in the
> > 'BreakingChanges' document and ask ourselves how ready we are.
>
> There are a few remaining things I think we should consider in regards
> to this:
>
> * forge support for SHA-256 on the remaining major forges (I have an
>   update to provide about this at Git Merge);

Looking forward to it; support missing from GitHub is probably the
thing that leaves me the most concerned about landing 3.0. On the one
hand, the Git project is of course independent from GitHub, but on the
other hand, pragmatically speaking, the majority of our users still
host there, and it will be potentially quite confusing for people
creating a new repo and trying to push.

However if there isn't a solid commitment on timeline from GitHub then
it's less appealing to wait - it seemed like a lot of the work that
was happening in 2026 was because of the looming pressure of 3.0
coming out in the fall.

> * any updates on libgit2 and its support for SHA-256 and reftable; and
> * the lowercase-only object IDs series, which I will be sending out a
>   re-roll for today or tomorrow and which is a breaking change that we
>   may want to soak for a release or two.
>
> I think anyone else who is not already extremely far along on SHA-256
> (and reftable, for software working with local repositories) is likely
> not worth considering.  JGit and Gitoxide were both informed that
> SHA-256 was coming in Git 3.0 at least a year ago, for instance.  (I
> know because I did the informing.)

I believe GitOxide received some initial support this year and I'm
expecting for that work to continue over the next handful of months,
FWIW.

As an aside - Google cares about landing it in GitOxide because jj
also needs it to support SHA-256... but even with GitOxide support
there is still some work to happen in jj itself to make it work. We
are working on it but it's not ready still, fwiw.

>
> Similarly, I am not aware of anyone who is seriously undertaking Rust
> support for platforms that do not already support it, so I don't think
> that should be a blocker, either.
>
> So my gut reaction would be that maybe 3 is the best choice.  2.97 might
> be nice, or we could be more careful and go with 2.95 and then skip
> ahead to 3.0 whenever we're ready.

For what it's worth, for our Google distribution I think we would
disable SHA-256 for new repos via system config until we have GitHub
support (and honestly probably JGit support), anyway. So that makes me
want to say "meh, I don't care, why not release 3.0"... but not
everyone has the luxury of distributing the system config to a whole
swath of people like we do.

> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
