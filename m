Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA733FF1DD
	for <git@vger.kernel.org>; Fri, 15 May 2026 15:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860095; cv=none; b=ul4nE0olwGQ/Bbyv1e//TIM9FrNoLgLp5zyIElRuA5w15y5GMSFoPb77Vmwn9WNHKooqX0XAa7zGGmln1pC3l6CJF0025xNBM5UMK1xDYoScvQ6y+8a6cG7p77riTGX8A3CecPVuANX0/tXPakjB5/FtrpB2hDPJXBgUQFFyYus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860095; c=relaxed/simple;
	bh=psdfOwZ5HYXkS9D8jxE/0kYDSTJXcPplcZ7pI5h7Xd8=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=SfpI0EPD3geZ6kLzNFNNCJup59oIwqd7WBJgdudt2seobuRfAjW/G163hCoj/9ZoImMMi64gLbyCy0PtLBcRJ7xI1bqmJBokutee0+ojo1HrMtU/9lNPYk45LoH602+SmlKMXhmB3ALPBxT4U9oS+WWNNoHrNs/AWms7/Xa/N/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUuXvJx3; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUuXvJx3"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c2cd216c9so11360707d50.3
        for <git@vger.kernel.org>; Fri, 15 May 2026 08:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778860093; x=1779464893; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7IOMCsL3nzya/PDmaLqp9qQFrPY+w8UsCqgXBiQ3uuQ=;
        b=UUuXvJx30/PXNPyAWr+AKTfFbq16KmAuOpuPNr0/4KJLhF2ocWOBrYd58epShSc2XI
         NEf0F+mTqWd6+/i2kbFsHVP2R+uCwrNErZOjJ9qIDyt12YK+dxM/5vBsEOzhk1rTsEZo
         kXiWNTXn5ZZFsEM/H/kPgqYp1G4j3w+y9sWksxr14fd5Z9HFjF0I3f4yauH9ke3aie8E
         Wj89BbMLb8ynPJnbU2PNllSgXkDRcJagijFfe7lh0PRRtKwesccZFyT62EMlfyGoftdp
         UI4/gz5SDTl8SfhrgG5ecBsXgQ4J6QWFAfmzvB2nh9OBDh62eI3ZKoSvC73lgydfcIgj
         dm1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778860093; x=1779464893;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7IOMCsL3nzya/PDmaLqp9qQFrPY+w8UsCqgXBiQ3uuQ=;
        b=F9rIM1bqD6TUqD3mSi1AVRjTH9bdHudyOUPdFnzr0MUY7AV6M+w00Xzkw16wNww5gV
         /Ecgw8vgC9dptYVLGyCQqJBuOsKgtNYF8SPCwIHxxUzkPewboq9go0698ez5N7sHCxdf
         HFxh5pfVZAtpgkj0B8l5t9XP7O492lDohss/JdJex7l5j9DnhwOIEZtUdkk6iaAnkupJ
         YQ28gL/o2zgKqLyIX4AZ+HDuGxh2nqi67bNeNDd9VHzNy9FTJLVGo4b3n+eQyO5/Ak2v
         Lo5C+2QqlJThJSSSg9+PjuXI8a5Gj+OxhIJduU/RfcYLVf47k4kTecXvFt2t2jl1FzRn
         076g==
X-Gm-Message-State: AOJu0Yw6ZrERAKhK6odV27V2jrVagk7xVSRPuf9AWLwTKEyNtuWr288Y
	uz6OP3jHYIpjKWbden4aZAh+mGckwZupV2A9VffTvmCcQZRQbeHv4wvEZbJnqQ==
X-Gm-Gg: Acq92OFvS8vD0RgYYq4OLPSqDs97DmIubxwC3CJF3HJZdj/fMchJS4EBgLEOZTDimeM
	hhlGaWoq5YU/JIJUVYbshr/TGL7BH4fvBJp3a/NNTnwL2wuUHXprkzkS/QuS3JsQh6w/t/DPvmX
	d5nx1pOBMnuT9S7FgbForEfYeCwAa00IoRax4kc1TsdgsCRC0WpzQoWVJmN8tVJvKvuR8QSqKQX
	g6scl26Ol7WzKMfD3MU3+CzpGne8kTGVOKenndW/FMSCUYjv2uPyX8eEWIlap2EnYbOuafwH756
	2KuMQ4YHlUzTc4nJTbBgzhru6pP7Gn10N0C+jP+Z1vV9rCWbPlOXhTC3B0XT/hmCeXRoUbM8UCB
	9m58zBlulUUxM1CPgoGti5eBRfvTeqgTCCxEIHxwfjTv6j6om7flRzMA9abNuEin69Rca1wCfmu
	aRcuW/SYNmsnpF4aS3rPBU7j8=
X-Received: by 2002:a05:690c:1e:b0:7b4:4a3c:b6a1 with SMTP id 00721157ae682-7c957129210mr56057337b3.0.1778860093245;
        Fri, 15 May 2026 08:48:13 -0700 (PDT)
Received: from [127.0.0.1] ([20.59.242.4])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7c8cd49b283sm21265227b3.6.2026.05.15.08.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 08:48:12 -0700 (PDT)
Message-Id: <pull.2304.git.git.1778860091.gitgitgadget@gmail.com>
From: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 May 2026 15:48:08 +0000
Subject: [PATCH 0/3] Some more "Raw output format" doc improvements
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Philippe Blain <levraiphilippeblain@gmail.com>

Here are some small improvements to the "Raw output format" documentation
that I noticed while working on another topic.

Philippe Blain (3):
  diff-format.adoc: remove mention of diff-tree specific output
  diff-format.adoc: 'git diff-files' prints two lines for unmerged files
  diff-format.adoc: mode and hash are 0* for unmerged paths from index
    only

 Documentation/diff-format.adoc | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2304%2Fphil-blain%2Fdiff-raw-format-doc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2304/phil-blain/diff-raw-format-doc-v1
Pull-Request: https://github.com/git/git/pull/2304
-- 
gitgitgadget
