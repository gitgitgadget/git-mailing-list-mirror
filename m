Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C472B126C03
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 04:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770525922; cv=none; b=CqlQsA475hrxgdQT1bp1AnYO2ff+ItfLN9z7etEIalpgV1vfallPIgeaSErz/ZF3mAOwiRJTaZUKDMPXZrCpb8sDdyhfX/vk+BX9mCXwWU3LRqBu0p14WNejKypMp5G5Q7MeNa9FEAfe3EUlfKgggGohL8sKk0+OiSKYuOFA//o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770525922; c=relaxed/simple;
	bh=TFrIkMDqdBWFN5MEeazlV9h7sOOnyICukQ/L2yxWRck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzsqDkMFalSWL7bBzQPr0PN6MHvZix91gOWofJR3Zhoz6XUGz4hldFzIZzHi2Hc9pc0YSdKcu2hzveqUAxiOIYq7cbZCh9UVQ7GnILEQ2n51cSE6L1UAL+VxQnXuPt8GjSjBKUu79u1T9o82h2rC2SwopvWJ7we6oSHqoxpMjBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrkQZLFR; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrkQZLFR"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2a79998d35aso25482695ad.0
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 20:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770525922; x=1771130722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ykX/LOR3CB0adHLO32s2BpE0gk0dybL1zSVBj00zq4=;
        b=LrkQZLFRrkgwHnWt0B17B3y8xpw+RGyEs2Ox3HCrvwdfn0xR57Mok15a9qpQDCmMEg
         YIYJ5y7f0XfXmZtTu1T9PCH7rfB+YtrqwxhrZ9QlCbtXQZbUjRXv3L1F2+1ny080Hf+8
         mRdVfzccTL4dymVy0a1dhFhXlpUsevGj4fNo3LLwxeotpelm5c9BiiKHAsRRE0aFO1jF
         KHuUL1oSHyW+hoLFMa28H44iz6zq4/tKwwrPstB2nXTfzx88an3t7PwmGU5GQi2MTAxm
         ElLR6XQAtdOXbNpMzQyKIe8lrBQAxXzPpZnRJhsFzpqBPcFcqdeF9LfeHVbhL6mfHlFS
         nR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770525922; x=1771130722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ykX/LOR3CB0adHLO32s2BpE0gk0dybL1zSVBj00zq4=;
        b=lSbS+ypnyKFpK1VtRWAO8QOTOQxdZHfZBTB7hNpYoL7PUG4y7xUlywsYNKYIio6QFO
         fb5Z6uTzW/foNMag00Rnj2OF2BtZf6bLsbSO/c9j5Xy/4/ya23qD1azzEULJW1E8A2JD
         vKugmdpOzzlFhYxtWe2knhibP7F8ZfoKu1aHaSNJldEnHXQgbDzVpELP08oevoFZfsMD
         fnba2eGTYUZjSsZflsrQolkNMlFp/0idz4yFBQFdNo9ZJJhcmH63HMSvwPxHHNlRW1Ax
         y/f2I/nlfbGN7OyIcF2aeY9W2mMsbFO5oFbHgz3q7x4P1/jtgurX0C6ofttAwgZEE0Op
         VZWw==
X-Gm-Message-State: AOJu0YyYtdP/EGwILOMqMkkjbXBPTm6QLH4pxEeMDbEjk6Pu1RGHt6U4
	RwUDKTvCpqDG3yB0WrMKnMls2kDy7eU6DuCySPVSB5bd0bQ8V+6X+gmI0E7tq7Ya
X-Gm-Gg: AZuq6aJVoMwhSTqIHI9zgFt8lOhmAL0/MNRt4/e/GYtulOn9cs1jE0Jsy4q7ycfOtAK
	0rUzArfjIFc3/y6aHxD1mK3px3I7eptIMxkKRM/hEQFC0GO5EGkbQcqTMLRObhW8CfTDxa0c/1q
	FdTl1CX7+6t+Pd2r5b3FF0BadihFqxIdIvxttnhmhASvHKacnDBGjhkSIzpA/8Szefcd3/s8GHH
	1ouNVMR5M1uBdPV/falOBcgX9tExxcuV086IOdVlgZT2apf4OUN7ydsFDbZ3dm90N4VemR6W40v
	ifQpMhlHqueIyOAb45MmNDdaPGnGlxtcEYYudLiWy7whKM0iFQj7fS57qt7eYmxiikekib+UCGH
	yCJRtn0kADrXhSbFpOAxEc+kdaGsB0aP2NMFvzxV7izK3u3NauzTb51y72vWNrwXAmkewR3Yvxh
	0ADyUkuNEuIE22bSWh0a/Ckq+ZpTJoY1z7x3lcEZM/HqWk
X-Received: by 2002:a17:902:ced0:b0:2a7:c340:4c3d with SMTP id d9443c01a7336-2a952025931mr70599825ad.13.1770525921720;
        Sat, 07 Feb 2026 20:45:21 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:2650:b6c5:3b:d430])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a951c9cdf1sm62857785ad.41.2026.02.07.20.45.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 20:45:21 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Sun,  8 Feb 2026 10:14:14 +0530
Message-ID: <20260208044450.34444-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqtsvs9gij.fsf@gitster.g>
References: <xmqqtsvs9gij.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
> > -int wt_status_check_rebase(const struct worktree *wt,
> > -			   struct wt_status_state *state)
> > +int wt_status_check_rebase(struct repository *r,
> > +	 			const struct worktree *wt,
> > +			    struct wt_status_state *state)
> 
> Funny indentation.

my bad, will fix it.

> 
> Besides, should we adding a yet another repository parameter to the
> function?  The worktree wt knows what repository it belongs to.
> 
> > -int wt_status_check_bisect(const struct worktree *wt,
> > +int wt_status_check_bisect(struct repository *r, 
> > +			   struct worktree *wt,
> >  			   struct wt_status_state *state)
> 
> Same comment about "r" vs "wt->repo" applies here.

Actually adding another repository parameter to both of these functions
is needed because of the calls like wt_status_check_rebase(NULL, state)
and wt_status_check_bisect(NULL, state) from wt_status_get_state().
In the case where wt is NULL, accessing wt->repo can lead to issues.
