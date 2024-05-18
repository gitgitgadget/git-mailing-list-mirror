Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68ABC2C8
	for <git@vger.kernel.org>; Sat, 18 May 2024 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716061089; cv=none; b=NdbHDkTDh1wYoy3augvnc+La4k9xIyTtbHPkDR2nWcBiyyixEVuVgyq0e1/MfqZ0qUBLOT0g6518PeDvmTr0TlrzmGlyS2y1WK4RuQoVZqxcDLTSa4AJonBZOVPawiZBBLG//iEY25rttku95zmd03m4i78OqOXuzXC/PGst/Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716061089; c=relaxed/simple;
	bh=hL4z2emY7gAFnUWugN6AGXmle3mrVuGIVrESRPIDCH0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gp6nMuxBg8XLKA9tlrpYBw3bHrS8Z+mo4V/6pv96g8kt95AAa5QmFChw98KpyAu1tlDWVLsdrKsomUGrh4LrHlWoFPYzLXu8mu9bHXydPAhsLmUDdtMxVHLipa/yLCT6m5JfYkGpnZDO2HclnNSs4wf8Pw+ddy4gtIXUPsKFzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=VhsQ8Mvw; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="VhsQ8Mvw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716061073; x=1716665873;
	i=johannes.schindelin@gmx.de;
	bh=b4KfJWKpEa1L4wJYC1sAyDk4iP2pnbJgkx7RmfhTKLY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=VhsQ8MvwMMvxgAX90oJ2ajpsQ8/aiKZwJkeFxFlhvzuYJgMFPZxtMNP39EQD8Zav
	 GIU7rsYlDRjVHpRnXaxciwQhLIQE2TLQNbSGSfWI3LRdat0lmTHJ+GMRgtjFQEgMY
	 2tCk9eOWAIjg8JtUR3Pdu+fVxDa+S0Vlum/hkkOHzQa2RR9/SIp+0cFf+V5iGQHEJ
	 Bf6Y/LLhRAx8YxAlZHnEgyafWhfpCD4lRO8L5xwPKtZ4qij9qwsgSWhBJW0FNbLYa
	 jf05eSbhD63AXgw5Xk7ZnyKfm43u2eE/VTOBciw6FaoSexobKmWRlWqKdhZ0SEmfx
	 ordMNy7fKguYAsdiRg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.77]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N63VY-1sbHT63fcu-016RKd; Sat, 18
 May 2024 21:37:52 +0200
Date: Sat, 18 May 2024 21:37:50 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Jeff King <peff@peff.net>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] hook(clone protections): add escape hatch
In-Reply-To: <xmqqmsonne6m.fsf@gitster.g>
Message-ID: <6ad4cc61-f434-3ea4-8f54-728e6ad6b045@gmx.de>
References: <pull.1732.git.1715987756.gitgitgadget@gmail.com> <pull.1732.v2.git.1716028366.gitgitgadget@gmail.com> <b841db8392ebd924d1893829a7e5e22240f1e9cf.1716028366.git.gitgitgadget@gmail.com> <20240518181432.GA1570600@coredump.intra.peff.net>
 <xmqqmsonne6m.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IfmLmP/qPYpXezcQsIg14iGbD9NF3R1z4Vm4xyMeDvaO1Lxvm/a
 xivqpGVKVOSmO9lWCTFfrepOxCQP2nyZQH+5TDx99T+Xvwoc9xJMtzJgkjdi5mtwelqL+/o
 7VY+HdV1sZI94TGrL8IC1fhNOhaeex2r8TbuirMrtaCAi4Itzoy0h1Ufe2fKmXZClrifHw2
 iqaaWCuDsQrvR5zkhkr4g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:KRsvUdyxgos=;OjoqhsWCeBulY+m7XPpaAkIIDhw
 M61kP4GoF23fNiiBFugcQGpTbu2sbH3JZ2reuxmfBR3nV7y2E9hDW3guB9e5vB2s/NS8/xXpZ
 bXS8N9s0w94Eg59C8oTypUr+hBXPrMC488/5JzP23sUXPY7cvzYTn1YA47OLWl4NiixHL4l0k
 tox5Wyr+TTeCMSZKQo1Xb1oOtwJG0Lj7LYRZTLK8rNdkAeO8p0RoaM6LTy7zIXIiBjB8FYXlk
 3EicHYSOb4IaRZ/vJRM1Bp060lm0X6zsGwZbxCxYMVweZv/69usW6CVzUlw/oofsaWUOHLW1m
 7tVgwCLuFpHo5o1EW1j7usTwqM0pO5zutUlxC/quEFRmi2sfFfdYDJ3qMx9ecbV9bhmroir3y
 IYgbKnrmxNMNZpNM/351CblM6mmPeulGFnvkkJA6/yJ+QQLVW1HPdQcEEsGMX8trgSsT4tHtF
 qGPV527vxNxNlfNMAdhwhUYaASwFj7pjHqTqWOGRrM6LZH5sGCQSITOjrcrpCHWuF1XZFznxr
 lFpQfOJKgyq73b647gfEWu4jcwzOrpFuyLS9rwRaiNt20JuahBFOIXlFAS5qGmWg42sTY4OaH
 XeYZvJh6Qtqs1nOawwpYF+qjpWMxSMdvBtH+hdAY2oSJ/ECDJADWxaa4q6saXyvKA3LPBOKkL
 fflqAYfLKX1N6p6rsrN1ACxMBVuirzZOLP4LvrQaagQKqdcj21v8/qE6MIPfkxijV99XAVvvl
 RPt0Kun+2PUBpDTKkrG9p3byKaBftX/BrQ6AznImuQuhlXaeVoZEGDe22Foaa/rBhb1iXwkAb
 sMD47haGdbhkWHfXUmbbUMzQvzjMV6sogM5sLaVX844ig=
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sat, 18 May 2024, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > In either case, we're considering config to be a trusted source of
> > truth, so I think the security properties are the same. But for the
> > system here, a user updating a hook needs to do multiple steps:
> >
> >   - compute the sha256 of the hook (for which we provide no tooling
> >     support, though hopefully it is obvious how to use other tools)
> >
> >   - add the config for the sha256
> >
> >   - install the new hook into $GIT_DIR/hooks
>
> I am not sure why any of the above is needed.
>
> Hmph.
>
> I was somehow (because that is how "git config --help" explains
> "safe.hook.*") led to believe that this "safety" was only about "git
> clone would prefer not to run ANY hook before it finishes operation
> and gives back the control to the end user, but historically it ran
> any enabled hooks in the resulting repository that was freshly
> created by it---so let's at least make sure the contents of the
> hooks are known-to-be-good ones when 'git clone' runs the hooks".
> Most importantly, once "git clone" gives control back to the end
> user and the end user had a chance to inspect the resulting
> repository, the files in $GIT_DIR/hooks can be updated and the hooks
> will run without incurring any cost of checking.
>
> Isn't that what happens?
>
> Looking at the control flow, hook.c:find_hook() is the one that
> calls the function is_hook_safe_during_clone() to reject "unsafe"
> ones (and allow the white-listed ones), but I do not know offhand
> how the code limits the rejection only during clone.  So perhaps
> this set of patches need further work to restrict the checks only to
> "while we are cloning" case?

The logic in `find_hook()` reads like this:

        if (!git_hooks_path && git_env_bool("GIT_CLONE_PROTECTION_ACTIVE",=
 0) &&
            !is_hook_safe_during_clone(name, path.buf, sha256))
                die(_("active `%s` hook found during `git clone`:\n\t%s\n"
                      "For security reasons, this is disallowed by default=
.\n"
                      "If this is intentional and the hook is safe to run,=
 "
                      "please run the following command and try again:\n\n=
"
                      "  git config --global --add safe.hook.sha256 %s"),
                    name, path.buf, sha256);

The `!git_hooks_path` accounts for the fact that users can choose to set
the `core.hooksPath` in their global configs, in which case `git clone`
_should_ expect hooks to be present that do not originate from Git's
templates.

The `GIT_CLONE_PROTECTION_ACTIVE` check is the one that limits the
rejection to only happen during a clone: This environment variable is set
in `git clone` (carefully passing 0 as `overwrite` parameter to `setenv()`
to allow users to override this protection).

The reason why it has to be done via an environment variable is that `git
clone` can spawn many processes that all need to respect this protection,
most notably when a recursive clone calls `git submodule--helper update`.

Ciao,
Johannes
