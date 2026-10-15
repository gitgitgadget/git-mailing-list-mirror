Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07A146A66
	for <git@vger.kernel.org>; Thu, 15 Oct 2026 00:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023584; cv=none; b=JtNfNnzO44DFfhA/JrbVrF3mSXXvG6xz2/7o6NqQAINuOxz/9Zq84G4x3YK0fwnD3Y/r85udqKxTHutm0o1e6WuIPv2vq3l5OMNeAU6g4Bma0bWqDSYKOsaJosHZ6Hz6uMx9t5vQNNl/JutiDagX0If00l5xxi5J4slVTI/dfGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023584; c=relaxed/simple;
	bh=Wrz3/r0L5AiZ/0Cc4iMDWbFGxwRFiGkpoiJCTAZiCXw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIcDcaQb6XtbIcrfkURG1sG4Os3E+/ffdTJ9T956acQY5fgUN/+J7DfpTnZz5aLOBx9zyf3/pBt52cMfw6jcWSBeA4bxDnIrksv2LM8TM5VrPHvKUBEy+4NQv73ODApnJ99MB6xUc0Z6fKV0uqC49qV46YFEbtcA32wnsX21/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fpNuA1G3; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpNuA1G3"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-170135e43c7so2240545c88.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 17:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792023582; x=1792628382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Wrz3/r0L5AiZ/0Cc4iMDWbFGxwRFiGkpoiJCTAZiCXw=;
        b=fpNuA1G3YZ88OEVuDzkmxuV4UD8P680eoJGS6zUTvk9yJcY4KjjZbtdUvN6BOt36H/
         o87kb7GoY93rgIu6Mgwx2f0P8iADyzPP4n/trbIcmEwMPQl56WRR9V4Flz77bD/owATx
         o7Ou8VR8z+HBWPBrO9uC10Vo2JJq/xaQ+0FeJhZ0BgWpIEk2S1wKk9NcCuz10K/koxEC
         /X9XBjJTuG6XvQWIBTXKB7Zyp+adeVqEvH+E9RDdPVtrRSmyQMSIcdd5aPp5sBXBTN89
         oS6fD0zP1QhbtKjAPP3Fb2DczZfyWSGJ6rTnU6LtHysqq8OvVx8zkhthwEU6EaiggBaH
         2YkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792023582; x=1792628382;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wrz3/r0L5AiZ/0Cc4iMDWbFGxwRFiGkpoiJCTAZiCXw=;
        b=vM0cpXyJNc7AEjS4P2G8itn2gExrtzI+TIS0zuQOdINBJuuHsPrOphzK8M4Bsp2LEx
         ehvKji1RJL7Y/y9t6XS/iFx8mdXY2Tckv3HAZiWRHES1Zafk/UED4QgKDfKqZ7Vfm1tT
         uLGmOKxnxz37KPH53uTqHMW3kSSfFZ0sEBkMP4UH3ut5Qtiox+2MyX6mCfr5A29DA3G2
         CM2hMdSj/OhYKh8puvhuF3XhxTGZbjQa4c8ZNSj1vJXbjHNvg8fnPqjn9/pLd40HEtKZ
         eCcMPba/XbVNpK3D4ffl06oLZP/lAh9t/koZICDZszpX0yWhqcY2Jj4RkW/tNrk9tjQU
         ux9A==
X-Gm-Message-State: AFq9FYIOikeXYUR3V4mOhmhrMGzy6Oenu+ErV6OmiYrW4l/VlY/aKnRm
	MtwgsTHeP0H1XU6VAM9XQcKIxqiA/SwjBze4yss56deHF/+z+Q2jE66v
X-Gm-Gg: AYBFou2HFDVLedLgX8W5V1t5FDm2tECzcqc6ARSqbD0K5e03pDku6LMVPViJ2Sk+WMB
	0xjJrme2niC3lEPK4szg+/sFq+1jpANBRYWpoGAbjo2BwOj7zVQ7cMZnMmjE7spOUgwh0WtIdl9
	wvcge7CQAt+USNPQI/Msj/6cdlxpR/A20Lvxh12WezgdSO8viAZ7TB+z1RzM3Xc/xBAuQd/vP3J
	AxdTpkpENgPtANBQ5F8qfxB2NXWARFqqK64RsbeDhLY/73aE6I/OYBbelMZ31D3OpsJCoQve/TG
	FiCh+eoy9KBUzycr+Ge1L5v3vxR2Aj6wXd+luFcrrek2kuFu1crmji1Ud/RsAadmvcuROcisk/E
	QAHzLb+M0KvNqgojjM5OxQpXNcI8qBdjIazm6Gui2wXOic91ellrPFxnX6abBqSZsr1+cApYF3l
	Q2tWJD+wM7eCgjDv4PsZBsA8Vip8caHbauy6CJ09BMFZ6VnbgYCWrBhHe6HL+GscGIj958RD5Kn
	ovSNHnwbIkO0sy0x1954KYPhQ7jGFUAbdT5ORIYhLpUeBIXMGRcu8JKU38f1v9joARVtrxNRTjB
X-Received: by 2002:a05:7022:5f07:b0:168:6ad8:e8ae with SMTP id a92af1059eb24-16a6187f492mr22566579c88.11.1792023582302;
        Wed, 14 Oct 2026 17:19:42 -0700 (PDT)
Received: from quark-fedora-PF5F60VQ (162-199-88-188.lightspeed.sntcca.sbcglobal.net. [162.199.88.188])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a442956asm64288057c88.16.2026.10.14.17.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 17:19:41 -0700 (PDT)
From: Jun Wu <quark.zju@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	Jun Wu <quark@meta.com>
Subject: Re: [PATCH 2/2] commit: lock index before reading
Date: Wed, 14 Oct 2026 17:19:37 -0700
Message-ID: <20261015001938.2092523-1-quark.zju@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014100432.GB1344504@coredump.intra.peff.net>
References: <20261013172315.2997446-1-quark.zju@gmail.com> <20261013172315.2997446-3-quark.zju@gmail.com> <20261014100432.GB1344504@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Peff,

On Wed, 14 Oct 2026 06:04:32 -0400, Jeff King wrote:
> I do think your patch fixes the problem. But we probably want to discuss
> that in the commit message as a motivation (and likewise, discuss the
> fact that we may be holding the lock for longer).

Will do in v2: describe the race as motivation, and mention the longer hold
trade-off.

I'd like to note 'commit' is just one command with the read/lock order issue.
There are many others, like: reset, rebase, stash, am, merge, etc.
Some are easy to fix, some seem tricky (e.g. merge).

Do you think that I should fix all order issues before adding the timeout?

Note Patch 1 alone does not hurt - if a command has the read/lock order issue
and is therefore racy, then the timeout feature is automatically disabled
(by the 'initialized' check) so the racy command behaves exactly the same as
before, not worse.

My plan is to add the timeout support first, then incrementally fix order
issues, starting from the easy/more common ones (e.g. commit).

> There's probably some kind of hybrid world where we optimistically read
> without the lock, then take the lock, and then check (cheaply-ish) that
> the index didn't change since what we read. But I don't think we do that
> in this code path.

For reference, 'status' is such an example, although its write is optional.
'add -i' could be another example - it avoids locking when waiting for user
input, although it lacks the "didn't change" check right now.

-Jun
