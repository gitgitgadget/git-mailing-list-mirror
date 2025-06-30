Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7216F79D2
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751309600; cv=none; b=R/JqVfPVkEakt/5+IuhTeNlElk9Tr/jsl3PzPDLv6QMpjh5VY1eoi8EfG92Nyod/1IWHBLQBCV3Ovke36d2LJZ5O8oJsmed32VVUJ/lczKxVMlAJLFZ2F2LBXqerBOv6+lt0tuwb3LE7kuFfvHfAdN16ft+CNrP2gzrGmea7MHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751309600; c=relaxed/simple;
	bh=gZhewVTy9+3F0B8m4Uwgmt48JvFR3PoupR+tiWPED1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BFSYBjHU2BKxQtD0B/K06im/MyMiTWKBGKNFqJE5nJL9s/6UuZ5RPrcV1Z1oC065vLGsaGuYckdl1dDfPCx6wnqqjWbicpchKVPQ3kLj8qfTl7aQxNxe0T6iR+zWTlH95g0o3kiEwjvgbqN8NeWAE9t0UCyHj4HvRPCzH9zufUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hbiRiMyb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbiRiMyb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-748f54dfa5fso4245002b3a.2
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 11:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751309598; x=1751914398; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OA0OjAhaBBNhrgW6s7wSxFSnXQ5hdjQMtXsUEDhjPSs=;
        b=hbiRiMyb2zOezMomkrYTqfzE2EivAs9hWz/bN1PLeAaJTPfukgYwDT/fuXuWYZXjAh
         jbWaiIDVPcspleACkgkPNxYBHBFlAzjM2Dnn6xD86US4H3rd+ExO+kYQxS7r61BeJ4Y6
         gxAxE1jVrRtXhqoP5crnx3aq3dZA8x46kWAfL8UP6EryweNMK+8LzdefhPIXIkeSX0+w
         Zq+tVZffe7O2NNGW6Dy6EN9paVCmJagNRt80+1PiOV+XB0m10DWxQYWvTPgakMEr61Lz
         3m1pPKWNhJ+ExaR4K9ZAnqxdKiLxr/txLvNd+zTZEzSFzOQIn23hY/eFXVFmj3N92FQs
         qm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751309598; x=1751914398;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OA0OjAhaBBNhrgW6s7wSxFSnXQ5hdjQMtXsUEDhjPSs=;
        b=lRX9Y/Z4Aj1ka3UBGNrWaC43aHhV83rSXpGIpYR4WLf8z+SeYWlNHyL3pisq4en8zM
         rulbAxiTiX1vuDvYmZr+XDYsJoVWqyJuMVxrcVwpHPbPxL+d6vp+okXfJbwhix0Lpnyl
         jGzH3uYr8RLckngtxpaouiHT4kBmR9oWZB2sJzELOIl6VNtxkXEAI0QeBgu6mO5cIjz6
         KIIlg25AmcMkQRuPAmtmQDEObFezC+/AY20Nuy1bXU22sRHlrJy2pxXJPgVvXAxTSDKu
         6aAZbvT7Kd881b6LXKiTGuIEwz9/pRkJX/3xHR4h9DyG87bZPaA1f3J7/m/am4oEeoJY
         BEJA==
X-Gm-Message-State: AOJu0Yyzf0B4/+qFnQT9xAe5SDCdmhHCnJQpPSG0y/P7JHLyN+lWmjWr
	W5vcxdIMk2Jn+eKmMm3VndNqilwaYFMWSJGMu0vi67NgbghxS8ndGaRM
X-Gm-Gg: ASbGncs2k4MCGhC3D7k/Z9KT3NMpDsYjD9cQaNb+plUYOoqdXklQGtStNh8E+JaOrOx
	gI9EHAy64pJK7M8PBuBQWFjN/Z1/vHN/LI7i38m4Z/Skc9qgxbELy5OYAVFFXHDoNls5aPp1gnd
	kdNGCYHM7gZpIQFAdmn0cnwOqEkOP/Oy8tAzHLTFYAaZ0iHJnKuZQRsthzYVJzu5w5IQhkWzIPa
	HMDztmVAb1utD6VlbWrZekowkkJl+qlAV0iuAcwxpiVQGrJ/2/HnrMhwu6k5IDlLjQ4C48dKJyH
	grakOScZeLe3cOWukllfnWb2d/cmNb4dlaq6jgqyoZ66BeXtlB0svo6c+qMzG06uYILSLe5qAOp
	7E/ySrK45qoRLiC+HgzfYXE/onvk=
X-Google-Smtp-Source: AGHT+IHMAGQ4wv5eZ0/ma980EEJpc62qt2mBTf/hk7jFqHHwunabcBVqBSoVwJBElGfE3boU2IeC6g==
X-Received: by 2002:a05:6a00:91e2:b0:740:a85b:7554 with SMTP id d2e1a72fcca58-74af6e66243mr17651983b3a.2.1751309597679;
        Mon, 30 Jun 2025 11:53:17 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af541e664sm9304789b3a.68.2025.06.30.11.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 11:53:17 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: "Raymond E. Pasco" <ray@ameretat.dev>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] apply: only write intents to add for new files
In-Reply-To: <20250628225819.1294068-5-ray@ameretat.dev> (Raymond E. Pasco's
	message of "Sat, 28 Jun 2025 18:52:05 -0400")
References: <20250628225819.1294068-2-ray@ameretat.dev>
	<20250628225819.1294068-5-ray@ameretat.dev>
Date: Mon, 30 Jun 2025 11:53:16 -0700
Message-ID: <xmqq7c0t12oz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Raymond E. Pasco" <ray@ameretat.dev> writes:

> In the "update only the worktree" mode, the index should not be touched
> except to record intents to add when --intent-to-add is on. Because
> having --intent-to-add on sets update_index, to indicate that we are
> touching the index, we can't rely only on that flag to decide whether to
> write an index entry.

Does that let us inspect state->ita_only alone and conclude that
state->update_index is set, though?  IOW ...

>  	if (patch->conflicted_threeway)
>  		return add_conflicted_stages_file(state, patch);
> -	else if (state->update_index)
> +	else if (state->check_index || (state->ita_only && patch->is_new > 0))

... I would have expected the new code to check not just ita_only but
check ita_only only when update_index is in effect.


>  		return add_index_file(state, path, mode, buf, size);
>  	return 0;
>  }
