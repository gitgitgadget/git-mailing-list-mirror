Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3202392803
	for <git@vger.kernel.org>; Fri, 15 May 2026 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778842983; cv=none; b=JQbOTHyqdYvqJSJB+5TB2gAoiP9+rsEeq0hUOYaZuSxLyL1guxYxtPow14RKWlrG4KcKz6ag3QAYDzxcyuSNse6wEFpMEl9t7qzZC1/fyV8rBurEOmj767U2Jso9ED6KqQsA6KQAjV7wgMrHnw3GUghD7DvgGNNRv5S7jl08zRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778842983; c=relaxed/simple;
	bh=l9TgOhpv9swh7qVrtWNYbGQOUcQCY1BmyWCRAudvRyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpVRas89Mat462tTV566b0hKSXO+MGR8uBmvB/2KdaZZRkouqQDQR+gqTK+TJV+qV+EibbOaQkod+vjfS/zdkyi15HvLYNp3aa1nNYL/nHuUc07wdqOejGgh3nFVmnsht7uA0mo8w0d4H4Uxql9Sb7Pb6MNIVhC5lumkfxYVtxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu5k6N1I; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu5k6N1I"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8367df48711so4313860b3a.1
        for <git@vger.kernel.org>; Fri, 15 May 2026 04:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778842981; x=1779447781; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLFxecJUlcznY42BF4UABuKCV1V4YChRXaEuYvrZmnY=;
        b=Uu5k6N1Ik8xMdfOmT0YHRHA6819itcztpJxTgQ9T9U4MgtTTBm/Ui4gyLwyzqpfNl8
         uj9n8ani9IIutxEs9uM4KhDXumP2ZlnE0xDolsTzWmpLpuRSIZDC2g0zKXOBZWmWv8yL
         Hz1xe4G9xa5n5g9u68cPtYVxmfMJkTNkHSVKsFqO65D9LJoZaBKs1ZOr0qM2dfhhZMDm
         BY8+AYt2KebiNSM8LSW7/LqYjf18LnAGxOjYhex45w6wuaUSVxtfwv8m7w6GByxfemXi
         PsLsHQLl5BAbszSUwFX83OWty+byQwLqBbbSW363IGGUSOs/3iua+ZYznjFwx69IMVdN
         JwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778842981; x=1779447781;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLFxecJUlcznY42BF4UABuKCV1V4YChRXaEuYvrZmnY=;
        b=I4isi+PdcLPSju4DVWLEluFsE87eyHWrkdw74G+nUK3wm1aayQhtGLDmlnGrbr6P+4
         B7fBxPjAHtC0JDPQ4WyhRvSNcnT/ZAN0Hn8nivFMycn31D3aHw20BrwEbMxFNZAQEp71
         Qj1k/p4vzHgW3zVOrbqMoFDWcIuFZWbDy6YVvAnYApIt8O/hyKUph9B7Jf5VmRUa/EG4
         w79US6Cdegtf5ni0WsRNV1ozNkSsCePL6EniF9haMBRR4gN+OSqjvZ7jbZDZO/5Q1qQn
         q3hxotzhQdzmdWZHGctCUooMUX1mn34abAOLO/AkJLvWhR0MyrlAJVQipHDxG8c7KupG
         i3rg==
X-Forwarded-Encrypted: i=1; AFNElJ8B6bWovKaecPCzIG8cbi/aPLDLdP8V7VjzPCS0N3CmP8UVtCgX38JPYZjCilRaXJjHWw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwthuvAjC8Wr5BiW40xm6Ph/sPeIiP2UOV2ABqn4tlGhDSPSU4v
	6j7fDlE7pTJwdlwbpaPzxc3bWfUSfqd4dvJET0gABWaHWX7YV5EqoRoR
X-Gm-Gg: Acq92OHgCdsgdhz50Aqs2i5BV74MzwjVDWmYkXx/0sHLplsqYqcAVu1ZgdZl+qtDcc4
	IkaPT+lmhmMvs5L/e6JMsci5IRr291n+Dj5jF19KDObBHitzB9sRXRtFnLytPHCuPFiOMPRwhoi
	q+Sqp9hmEpbd8ZuUB2Gcqu2ACMzYG5+H8m7ebjWHm3YjnBfGMvvQO4XVYGXSWHmkEPgmaKWQAoS
	JL4qrAFYnKELjFoDY4XumE/Ii8flp9dTSRMtMR1Ans/V5fJEsfqC0bQWh/8YWE2ykFmo4VKpN+2
	onuyfBmQArjnqefrLvbkbgkv8Oo644jseBSjMcCeqjdQebnCDP9waySKk6lJjIu8e9PB4KdW89I
	p0wVUdbJ/UUBjzS61UDFMD9XpqJBUs8WuTVCQnTQPbu4rqtmaszsj60RomgtaAYiEtV0SoyS+tO
	BOQstIXYrfJj9RIzh5MTyMOGfughheQP0jZcmCRK4uMV315wcc7v0=
X-Received: by 2002:a05:6a00:391a:b0:834:efcb:12b4 with SMTP id d2e1a72fcca58-83f33d8bb94mr3852541b3a.28.1778842981146;
        Fri, 15 May 2026 04:03:01 -0700 (PDT)
Received: from DESKTOP-IB4GOVS ([121.239.179.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f19c5b296sm5228630b3a.32.2026.05.15.04.02.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 04:03:00 -0700 (PDT)
From: Aina Boot <bootaina702@gmail.com>
To: Mark Levedahl <mlevedahl@gmail.com>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Shroom Moo <egg_mushroomcow@foxmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v1 04/11] git-gui: put choose_repository::pick in a proc
Date: Fri, 15 May 2026 12:00:22 +0100
Message-ID: <20260515110027.426-1-bootaina702@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.3
In-Reply-To: <20260514143322.865587-5-mlevedahl@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/14/26 2:33 PM, Mark Levedahl wrote:
>  set picked 0
> +proc pick_repo {} {
> +	unset_gitdir_vars
> +	load_config 1
> +	apply_config
> +	choose_repository::pick
> +	set _gitdir [git rev-parse --absolute-git-dir]
> +	set _prefix {}
> +	set picked 1
> +}
> +
>

Here inside the proc it create vars locally, "global..." is missing.

Aina
