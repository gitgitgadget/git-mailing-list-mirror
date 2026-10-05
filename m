Received: from mail-oo2-f36.google.com (mail-oo2-f36.google.com [74.125.231.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486DD3FBEC1
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235571; cv=none; b=Eqm9jjQM+xSED+Dkg7mtSID8KnXPTAzdTEPswSwYfhH6FEGDbip9o5BVHH4JJzxiBICzTatXXzXtbfPwEguS4Eje19WzOyZj8vtsJhIvmfMD/W4dRScYsOHYAYGsakgt0j5H/luVkeD1zRiA86AWEjlj5LRdKjs9wF4xwBCfrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235571; c=relaxed/simple;
	bh=qloI7fPoamjS8JA6ZD3Wqjy+du1l0gutU50R0UQGIdY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWtvhwJ9CoEHQcWo6IM/LnOXk34veWjF5Bv9W9gNQw7vBH9HKBdAghfo6zs0AXJwH8YhdX0wCw2vpuaC4HFEFFHZWGWkHrB0KO7pstEjp8LWcGsXoJRPq93phaFZtTvBFlY94VLUFP38E09+zy6zPdts2fgXg5gpgRYJMUEqan0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com; spf=none smtp.mailfrom=tylercipriani.com; dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b=xv5ziKlW; arc=none smtp.client-ip=74.125.231.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=tylercipriani.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tylercipriani-com.20251104.gappssmtp.com header.i=@tylercipriani-com.20251104.gappssmtp.com header.b="xv5ziKlW"
Received: by mail-oo2-f36.google.com with SMTP id 006d021491bc7-6dcf2ba1fa0so1367413eaf.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 14:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tylercipriani-com.20251104.gappssmtp.com; s=20251104; t=1791235569; x=1791840369; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qloI7fPoamjS8JA6ZD3Wqjy+du1l0gutU50R0UQGIdY=;
        b=xv5ziKlWKOVfYGjVA1g/PUR9pRROrc7cvgHWx29UCUYMzyyNfcsIP2+RsrMqit4Jir
         GL+8epUJXXjpmANDjFU3yrCJ0/wFcQ1hsjxKUpj/m7WCNSHsXAGJqLx7SzGIQKHvxBhQ
         stSV0FOM6ecYMPvqVz+J56Q/RfXzaOzzgyepotChjjhCQTwSsUG1wXZIEiOOBkyoNXiz
         rGBOupqbQ7hFPEm5Xpc2AlgofSYv/qq8+9/tppKyY4fhANsVQG2rlmmwZ13Rik8HoRqq
         w3KBs09HbthJJEAk1+lOf+nmtceCd8YlMnE8uJkGxWEhwoz5mnDndn8kR4XAklpnvG8J
         0KXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791235569; x=1791840369;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qloI7fPoamjS8JA6ZD3Wqjy+du1l0gutU50R0UQGIdY=;
        b=vWMtfPtJRFcnaPF0vUFsCfOiI1gI7D1AgYQlQKNOtlvaKX1TolGbAJuOuyz4vxX361
         vV2OLkhq2OsDRsVVwIqDWNGt18XUJrmG8o5QITneVSwsNTM3FYCiQRmoG3d6rX/DEXir
         rycKMSoUDsV6SxFeJ+WfVUwiunT4JVD1XXA0hAaieBCO9RMwcXTTwoWW9VLrSbPn4J7H
         JiZeWUvnArRCde6g09RZw1qRckDYW/PQwYCzfoZZ0C6HyodbWbkPZeiIsEPLCaav96PV
         eRRw2e3B7DynxUnUQnPoi/jWdopTynvCX6P0h1dNQoNuLXC2oHwUtSv79dAen9vKvhsz
         bzNQ==
X-Gm-Message-State: AFuF++m8k0qq4khn+sUlo34gNO/H3xrWibYSuDhBTWFKh+zWN4/tyU8a
	a8UI93Dr6DCmHjEklkDY4kw8R9Au6fj8WSD7AIFhah8lNwPunK79rCse0c01iS9gT4xL2BrZbnz
	uODMy
X-Gm-Gg: AYBFou1Xy0ULTtop9lm06A7dpPqfWxuejdE3l3Pw7AmAbP9vhIajQaoYQVixBV0a80G
	v+65NEMyLQO0n+LRiJMsZdwCSiSq1Ek521Drry1s6gFbLTOjCp2m1eaakjSdN1apbZgHKpltrvN
	g83C4FlCHuRuFh8iLXh1STO5AzLuzhe2wqAiFA78Ed3YhSATn1tjb6Du378Ob+WT+gd660HK6kv
	Aw1kO/etF5OEOLCGBJxJZr3ll59oXavTs+WkUZhQsf9/85r1BiVpKrBJN8UKrxyNeHCLge050Xq
	aEYvgX4LfOiW7f/BrULBbYzw3MPlkUmqaklJhmO45Qku71l+h3ywS576Z0/IF2zccZGjlF6CgUz
	UgmRhpcB+1fRoyzwAvoZFBdP2rS/LYOGMy7fje2be5GJMah5mPOlmwuNn9anz2JGxWyu/jnBCut
	EpiSdH3tnH2wU9P/xtuMS+TKi0b4iwb51dcJWDc16Y1dQ8rLyyyqILlhNrnDAksjh70FW1mKdh
X-Received: by 2002:a05:6820:1387:b0:6d8:171b:58ae with SMTP id 006d021491bc7-6df2c3f835emr11317765eaf.0.1791235568973;
        Mon, 05 Oct 2026 14:26:08 -0700 (PDT)
Received: from localhost ([161.97.204.248])
        by smtp.gmail.com with UTF8SMTPSA id 006d021491bc7-6e4c2c750f4sm459383eaf.7.2026.10.05.14.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 14:26:08 -0700 (PDT)
Date: Mon, 5 Oct 2026 15:26:05 -0600
From: Tyler Cipriani <tyler@tylercipriani.com>
To: git@vger.kernel.org
Cc: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Aleksei Sviridkin <f@lex.la>
Subject: Re: [PATCH v6 0/3] push: check pushed ref for --force-if-includes
Message-ID: <asQV7QpGglThldfD@localhost.localdomain>
References: <20260904210122.431757-1-tyler@tylercipriani.com>
 <20260917224351.57171-1-tyler@tylercipriani.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260917224351.57171-1-tyler@tylercipriani.com>
X-PGP-Key: https://tylercipriani.com/018FAC02.asc

Adding Patrick to CC, like I should've from v4 onwards. Whoops!

Patrick: to address your review, since v4, I no longer special-case HEAD
(as in v3), and, instead, resolve any passed source ref. Now, if the
source ref resolves to a branch, we check that branch's reflog for the
remote tip. But for any other source (e.g., tag, oid, detached HEAD), I
reject the push as unverifiable. I'd value your opinion on whether that
matches up with what you meant.

I'm rejecting anything other than a branch reflog as "unverifiable" as
other reflogs fail to record the integration info we need for
--force-if-includes. HEAD's reflog spans all branches (rejected in the
OG review, c. 2020), tag reflogs (when they exist) record where the tag
pointed. And while a source tag/oid may be the same oid as the tip of a
branch, using that to map a tag/oid to a branch seems specious: many
branches could point to the same commit with no way to say which
branch's reflog to check.

Ben and I have talked a bit about the consequences of rejecting
non-branch pushes with --force-if-includes, viz: it breaks workflows
that give the appearance of working today. For example, pushing
<tag>:hotfix is allowed today (if you have a local "hotfix" branch whose
reflog looks right), but --force-if-includes has never checked anything
about the tag. 3/3 lets fast-forward, non-branch pushes through; 2/3's
advice points to --force-with-lease=<ref>:<expect> for the rest.

Very interested in others' opinions about this tradeoff.

Note: Junio flagged a trivial textual conflict in t5533 with
as/push-force-if-includes-no-reflog: both topics add tests after the
same existing test.

There's a small conflict against the tip of maint now, too. a85a43c480
(push: suggest <remote> <branch> for a slash slip, 2026-06-27) adds some
advice that sorts alphabetically after my 2/3. Happy to send a rebased
v7 if that's helpful.

Thanks.
