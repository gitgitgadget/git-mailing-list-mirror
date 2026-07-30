Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A008384223
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434534; cv=none; b=FnMilTEmFYjYKNbMmkK2RrvKxpYBqDWqQb5Sz2QTOi4xC4KvyAhOPkdut8nxXOea+aMYmN9RtqII1IshcZ2F91HVUUl9Up6JtIANmcUKWJen+vx/Fbr/I3MNL11+Iq6WBydb/RQzewezXdEjpAoSy01xkBlrC7fXzc4c//NT6dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434534; c=relaxed/simple;
	bh=1yeaXi7b212rIH99vpEcxy/ATB9DUPNlrCEkYiSYa+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iABk9V8cNhZbAJ18Fd7O0IHy59unqDhtrqXxHvlljyzJEjMHacnAOrGsBE5Z+ju55HgnERf4ROW9Twa6W0mvhHBBABVndz8vyd/0mz777AEMuckB7Va8vJJSQ1BLRmm45d5D/yC4Z10F/Aa7yaTwuZCg1AdSD+94NbQD7gm3tIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EyMqIjBg; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EyMqIjBg"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-caf707e3a70so834946a12.1
        for <git@vger.kernel.org>; Thu, 30 Jul 2026 11:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785434533; x=1786039333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9JDb/w86TnjwnrMiYIvr/SEyG26Tk5WVu/sETNj5bfg=;
        b=EyMqIjBgJwDVdofY7CHRpe4Id87yCSYp3w789atsj8sH+sELPI4bCEtyPPXHOtM9Fi
         TEhmLte8EBjYn2w+JFdQvoJg9LXZ2ddf0cnGIoHPrycfKyf7WhH3fLnL/1V3gZKs944d
         Ee67Oz1o64PAhzFtg4Z4dQfxBfSP/Q/tEsSjoln65ASqbPFQD1/X7hw+vlFloy6gJDQR
         cWetpMGvyXk5zlLuuW6CsdPuB8aO+jKc0rKlCJamPUSDt1oQHxnGFKFNEFvCLT7FstT+
         n5vKu4eunI0ORVa2IhNUozI/jOgg2PwBwyYs8JcbabETdUgHXHWyrrUUYMkB/9/g0IuB
         3cOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785434533; x=1786039333;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9JDb/w86TnjwnrMiYIvr/SEyG26Tk5WVu/sETNj5bfg=;
        b=SrFtMJesyAoITQo5WywoVKSAUWflbWYtxHs4tQOfxqZK7VnBOX5kWT6jRT5nYOZsI+
         ggXGOMkPLg2zoRSHtj4z6JBIVlKjpoYfLr6DrHtYI0njFO8B2QrUPAWD5pTxOgI7V9Ak
         9ZJNyMna1LJGWwEGxBZb2obIGG8/0o5YEyuhhXz6ZkHA4GRVHsB128FXfUMPnjE6lhUv
         ihbr7vtcTH1RluF54hTCn+1NuMxaICBTymj7Xp5tUcGYRvuk5lGmd0W8KsiK5uU8Rpes
         BANd22SqWOBLe5na9dPIgZ+Yxs5tKtJj+rSQMP830/8Q6HRy3u7SHHQJLwFo5Sh+AE1y
         Fz8g==
X-Gm-Message-State: AOJu0YzFdAShJH9F4325Jiq+bGgThtK0FDsckn1HlfIluspumNIYfgA6
	LcNsFJa5+IKK5pUbEFdej8ZvF4QhDLaLRFXrF/PwFPhH02j/VhDdVpwyNCrRWg==
X-Gm-Gg: AR+sD13mXpz3JAkeBJhaa4igkeDDLFbVfP8ltO71GE4TfK2MUeAI+Z15s6c7ZbtHjqS
	bN7aS7NleIKqMhGtcxTAqNhcmJtsE2lcko8AqnL1MRmCgP7vXC0TaLp1aY9h2R+PWsVPHnJD8DP
	D5rDluM9DKQHQluJ9hmZ85KeGyOeaqVhXZd6kByt15ug3fm39kLMIF1TZID1ngN10qHzEHuBguj
	LlCGlQggZNvII563vfjmAwXxSkgWb65tyJ1chvuo7BpwfCJEVCtz4/ZdE71CTyyZRWPBYWygvVq
	wUNRKWesaLayRWcahVOokW8DswJVLx5odBdX2KmJVAkguFAJkvzrbALFmTkRL5lbpxQZQmHidpc
	efqQPuYskJ18TGfmf5td/5TI11rTbVP5VOfWVjyJjYO1K/lgPD4PRz7YJe/PKANOzUV7fj34fAE
	Q29EBUPbvqGZMoLDKIL77c5RXULqsEsn0TUmyeCUlMWByp2eYVVpsMy24lzr+hW7u/eM9JjZKGg
	PnTdAXPwQlyfzxgYg4MAgbg
X-Received: by 2002:a05:6a21:710b:b0:3c4:2cd3:f0bb with SMTP id adf61e73a8af0-3c90d7de41amr1351088637.10.1785434532545;
        Thu, 30 Jul 2026 11:02:12 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c54:6cc1:c882:4eb8:575b:54a7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm21939913eec.6.2026.07.30.11.02.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 30 Jul 2026 11:02:12 -0700 (PDT)
From: Shlok Kulshreshtha <diy2903@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t: use commit_body to extract commit message bodies
Date: Thu, 30 Jul 2026 23:32:07 +0530
Message-ID: <20260730180207.83197-1-diy2903@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqpl05o5n7.fsf@gitster.g>
References: <20260727095656.75496-3-diy2903@gmail.com> <xmqqpl05o5n7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Junio C Hamano <gitster@pobox.com> writes:

> I would not claim to have checked all of these changes, but I did
> spot check a handful and they all looked reasonable.
>
> Shall we mark the topic for 'next'?

Yes, please.

To save you reading all 66 hunks: 63 of them are the same local swap,
where the rev and the output file are unchanged and only the spelling
differs.

	-git cat-file commit HEAD | sed -e "1,/^\$/d" >actual
	+commit_body HEAD >actual

Each one can be confirmed by looking at the hunk alone.

The three hunks that are worth actual attention are:

* t7509-commit-authorship.sh, the hunk at author_header().  This one
  deletes the file's local message_body() helper rather than
  substituting anything; its call sites become commit_body elsewhere in
  the file.

* t7600-merge.sh, "merge --no-ff --edit".  The test grepped the raw
  commit object for a phrase and then stripped the header for the
  comparison.  The phrase is in the body rather than the header, so the
  grep now runs against the already-stripped body and both steps share
  one commit_body call.

* t3900-i18n-commit.sh, in test_commit_autosquash_multi_encoding().
  The stripped body was piped into "iconv".  Piping commit_body into
  "iconv" would reintroduce the exit-code hole,
  so the body is written to a file and "iconv"
  reads the file.

Everything else in the patch is the swap above.
