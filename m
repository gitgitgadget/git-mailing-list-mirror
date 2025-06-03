Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9A210E5
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 02:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748916079; cv=none; b=AOkhC/UthXam2NrmeblOiCtQrq64Pt9A2RxAmtEEcSo2ZaKkrTTG5GRC5m/SEsYZ9kI46vZik5x1b0hQPG8cbwc0xNdAeGfYYIE56hsyX7859tmi26m/wxBhvx8efAfk8giheRpts3/HXGSZ+iN+t2COZm3HwiCh0aAXm2qk9ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748916079; c=relaxed/simple;
	bh=8VetJ6yW/RH0NWFAbrL59VYGPFRmhsCchrbLG4C/QSk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=JVBhzlu5oS4qvTI5z/bWWAyBXFB4U3ckt7ktc4ZJefMmIe7dseDKV5L0YNIJWTsl1uV17joMIxQLzOWGBRbZQP3m6fTVXdb3PoWKdmMbP7Ra65ZqamxjQ+np+ERwTo82ce5ezOp80Q/9ZDbnz0i9+xdDvMKZUkJiPRlbX6M6U1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIe5VY2g; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIe5VY2g"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a4f71831abso3606631f8f.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 19:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748916076; x=1749520876; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PRhVm51TgB1WroCZWGA6tKyMja6q1KYrWFNZOX0mr60=;
        b=FIe5VY2gmDOqY+A1reqty73pvn8MMISlYfnwpPTogdRnpKU0m7fvMmpjPqwZlehVVE
         8Q/krgf8GdJOyn4jqLLadwpVW+jADcxNjQHInRyGESWPtUZwbujlP3XM7pYID8rcumVr
         NSZgpilgUJjvvLb13GdDiDfyduB7YhQqPJE1wR1cM5QJyVyVhftH22TWh9+6p82hjmCL
         6niFKm534laiDd1VfIYb6NxBCYEujyj2GXsZ7EKNzubvFt0TIQIN9mJkSSxkuGxLY+jT
         Z1jwfQw1JRsYEX1CXU+FJDqX2tHIPzVkU+oGc5rM1TODw161kgyPstN6Q7DYqiMPyLz9
         OHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748916076; x=1749520876;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRhVm51TgB1WroCZWGA6tKyMja6q1KYrWFNZOX0mr60=;
        b=c5WkwEs+bfiaJW8+BVf6fR3i/cniA5VLfpNsbNtVTjnH81z+q/iI8T3XYKi1G3LdzV
         aXhh/5sQnBemxN/KNqbEQeBAGqBlXHLKTWymKm4+7/dZ38pVnxuWnEHA8dflaQlC3Y3w
         /WoS8HKTXNOEz2/yjPlYx7Y1xhsdaBRZPwdThJOxWGNIs9yR9ayIH3VT8O6oc2ypWxt9
         Qu9scxPT4RICNjcI0oNN7SUt9P6n2EXDWW4rQpWYuvkuiDo8lesbSnXRCLpWn+zUaEwm
         E6eufm7cJCngTU+yWa0McXZU6Y1lmq+mU1/pom9QvHcpY1fq69YjIVYhnkw0We5B9xiw
         6M0g==
X-Gm-Message-State: AOJu0Yw3ZSfelClWw3RSFdUnwy+wBiKG+M3OabUlcHSdF1I6quMaz+Zm
	Sde5SrTsGQktBRCqZ5MllUkFj9uc/LJs57T4+HTgcwudY0G4BuOVIOWhl7ifNA==
X-Gm-Gg: ASbGncvCpkXxjyvYmiTO+Om46UQN/X4zEYXRf625KWj+bYY6HEgEd2fkFiutriaOZy1
	DSAV2o/GMfCFojbO0RthE860VUEy+lBJ9oTqM5l1wRl9fnS/d5gI2r3aSkXhLNVSgrboII4r67I
	lO/gtKIP/i5C7ATcCan9hVQbpb1wzyAliUq+LbCzeWJLCYIr2h8NfKUubxXDuj4PKqew9tjOF20
	lTMQYfzs0A9ZWRLDWtpvnMovse7U+06Ha6kewSELvM8iw/r3ICq1mNzLewFjZX7cu4kGDQiVMub
	D2dmifvmB65eDGojwwazyTTMyEdTsKKLfuSdzWjDrSIbOtah9v34
X-Google-Smtp-Source: AGHT+IH8kulqGKRFKaIvYLygofbNCq8jBxkrP09rEPQm6SDQ5Z8hwXu7Yu80dsvnywtoo/Xn7D5w5Q==
X-Received: by 2002:a05:6000:2583:b0:399:6dd9:9f40 with SMTP id ffacd0b85a97d-3a4f89a4791mr11902433f8f.9.1748916075503;
        Mon, 02 Jun 2025 19:01:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c82csm16700881f8f.30.2025.06.02.19.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 19:01:15 -0700 (PDT)
Message-Id: <pull.1964.v4.git.git.1748916074.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
References: <pull.1964.v3.git.git.1748569955.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 03 Jun 2025 02:01:12 +0000
Subject: [PATCH v4 0/2] sequencer: replace error() with BUG() in update_squash_messages()
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

Lidong Yan (2):
  sequencer: replace error() with BUG() in update_squash_messages()
  BUG(): remove leading underscore of the format string

 builtin/mktag.c     | 2 +-
 builtin/worktree.c  | 2 +-
 pack-bitmap-write.c | 2 +-
 sequencer.c         | 6 ++++--
 4 files changed, 7 insertions(+), 5 deletions(-)


base-commit: fcfe60668e05ffde2610bfef9045797618c145ac
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1964%2Fbrandb97%2Ffix-sequencer-leak-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1964/brandb97/fix-sequencer-leak-v4
Pull-Request: https://github.com/git/git/pull/1964

Range-diff vs v3:

 1:  b812f973d18 ! 1:  f2d2cfd6a87 sequencer: replace error() with BUG() in update_squash_messages()
     @@ Commit message
      
          In sequencer.c, caller only pass TODO_SQUASH or TODO_FIXUP to
          update_squash_messages(), any other command passed in should be
     -    considered as BUG. Thus I think `return error('unknown command')`
     -    should be replaced as `BUG('unknown command')`.
     +    considered as BUG. Replace `return error('unknown command')`
     +    with `BUG('not a FIXUP or SQUASH')`.
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      
     @@ sequencer.c: static int update_squash_messages(struct repository *r,
       	const char *encoding = get_commit_output_encoding();
       
      +	if (!is_fixup(command))
     -+		BUG("unknown command: %d", command);
     ++		BUG("not a FIXUP or SQUASH %d", command);
      +
       	if (ctx->current_fixup_count > 0) {
       		struct strbuf header = STRBUF_INIT;
 2:  e1f84c111f6 ! 2:  9d69c19273b BUG(): remove leading underscore of the format string
     @@ Commit message
          BUG(): remove leading underscore of the format string
      
          BUG() is not end-user facing but programmer facing, and we do not
     -    use _("...") in them. I searched all `BUG(_` pattern and replace
     -    them with `BUG(`
     +    use _("...") in them. Replace all `BUG(_("..."))` with `BUG("...")`
      
          Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
      

-- 
gitgitgadget
