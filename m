Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD19448FF94
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588416; cv=none; b=uCiAsBMHDFreWETVR8I+vCPodjK+d6d73ozdxPEHOLvBccob4JN7NTgMUNCEhJdKst/TaJZ0ylcnmKJ6MvG+wN23EKK3hGuNfAefDzti7tvH2V7TYD0vyma8dKqdJ1NCuVx+IfnBB7wq03OluxF2JEx0QLShMlFzyICTbemiHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588416; c=relaxed/simple;
	bh=PkxvGC/Xf63cHvrRmH1J+ccYH697TYCc3VuAsARsz/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DJJaDum1pl4sf/F+/xiishrLhZ8f5E9Iyizqw7ukLKfU6WLgglbsXg2YihZv/d3vN78+PlvFV+rXyLkjE7VZsdc01ZeuQWJPJobWaPqtu5wS8SvOF2N/fL5BymVeZXI1XTOG9RdzjDje9NSUZ9cRiD0VZmq7BejQ+4mQ89iGDn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CK+2MZAm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uiR6g7HJ; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CK+2MZAm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uiR6g7HJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id B0EDCEC00EF;
	Mon, 28 Sep 2026 05:40:13 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 28 Sep 2026 05:40:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790588413; x=1790674813; bh=AlWEay+8pa
	lssHx6y/jImbFBmAGZfNEM3Gzb8ktu/Cs=; b=CK+2MZAmv6/n5o2tjqU/I5+Xit
	fljQ7PZyTBGyiU+851s2s1gQN48ka1+V/44JBZPYSJJqY2/qQ6kGol7IOuvz+2xX
	t6tGBvc/2s/LgNF8leeAVZQUV0tQmgGvJtzckJWW5cLCLokoIuDyGMs4Q2XNiU+e
	/oIxT0oOn8/hdn7B+EsFO4NPpeA54dZsZ+Lkv0fBMtcVYIoDGMc3tQjooDfRrg9A
	D6dIoljBvrxq6fBIS9FARdLA2Qf89ZGdbboPO7hUHSnXYzZB/srLnXjUXxup4sZT
	l7UFfTAeqwjb25AfXrQPU9Hu9y0hN5u5LW4EuPR6+4OiHab13wzka6Dlp2fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790588413; x=1790674813; bh=AlWEay+8palssHx6y/jImbFBmAGZfNEM3Gz
	b8ktu/Cs=; b=uiR6g7HJSjSvlnz8PNLN6PqJAGlaWQzduAs1d7d810HSRCoXiQn
	KedufaIYchP7UidJqm+tG1Dm/yA90o8aVRGV4pe+Ei6thnrFK4gep0iuqlsbKgil
	/hr0p6BT+iYmZDpefbGUQs2QrYHMrFaYr+x5I1a3OKg27XrJOAu6VN72t0JnlI5X
	o6vmxY7kyQhGSaxHsMFp7KO5j0sXuGvKv6wVrktjPcWnf6soo1VwxAUCMJDlyxUH
	nJgLfmkbUkb4rdPbU+f+BreeC7dVR2hL1iu6lJtVs6cn3gvIG7L4f7jDFcY5e79v
	lstRq3d3z1P7aLpweG4+WwkKm3RJFDtsx8w==
X-ME-Sender: <xms:_DW6ahuucy3dEP-1wsCybcrlbPY07oDzZrmC3Ae5YeSV9Z6KAWjq7g>
    <xme:_DW6aovpCZYiUwkYnz8J44VuXmi2fx3wNqGHtzq_fRFkvfirAZjIs6q1e_ZENroDE
    CzUwxKPwEFJQn2ezwrEwTZJnfiwD8KdMgSq1nScaooUVcywwtE_RJ4>
X-ME-Received: <xmr:_DW6auGVfZczRO__aoLr0D__lPtO37fEuJszT5RLH2aRMPipUSJKIpkRXZZwuQhVGkEX3FaPyOent5Sf2QKUnQFvKHeqyUKh_KGG>
X-ME-Proxy-Cause: dmFkZTEp0I6kS2YPBRrVfJTGSWMC4akITlT067TDp7dztOyBblpYSnD7tRVv3J63Wc43NV
    g50sdSuEvSTAFszzy/FxEJ3x4VkZi21M98CswP8UCVDH/h27/SfgF0FMghMvD3eF/SfzxK
    UAWOE8k209peUG3k+rFZmRl8CNoAC/0h+/Th4vGPEGCvPSQxyz7/xAMkZqR2yWgnG+sCNo
    hClGV3wNj7w8tDfgoSNemgIA9JCa5WFkJEV/OXBq7pmqttTHrWb17u7IQI7TWJerAc4edf
    UQmMFzQTMsAn7g3TsZ7mnAEIhA0EViNo/CeuHvJlTB090T/4qP/LnB3jQuaO8IO21G40e2
    L4uVMcxvf90C5J+olhSFBKnqOYDr9k5jcQGSLERD2ZoFgb1aDqP69ZCYXjGcG5rqdOhiB+
    LxWg/HGybpPyMiopEpHiTJm+ZWC0SfoZ7WvlipwyhMozz+DIKvnmASfGHHnwL8Vwz/Ydr8
    epvn2R5cJSHlUKsG6WvPfJMtI7RYFzURO+ustlnyuWNhMFmDHJeSlutvnH7IFIed6t1Ejm
    rO8ifgVnFT2C651FXEsyLhtl5+h4o+1dwQmXyVHk30XYjtDA5/nGXXkCNCuTxs4tKHOg1O
    QwPjGlhxeaGyId/vil0S5gY6+I27ajp+QcfYytEzWdOjdG8Y8q8zHn5UYKTw
X-ME-Proxy: <xmx:_DW6arPJcZULN3EhMzKFu5TdkFzMU7YbCwUAW3kvAkuTsjTNRefrNQ>
    <xmx:_DW6alLOeNfuJkl3mMPaa-wYagFvcx2U0FUu5eVll07Le1_rghrXiQ>
    <xmx:_DW6as_vllTn6WDP7j4d3GoMIfTi36mXWnr-asSpxo8-GNbJfv13kA>
    <xmx:_DW6apFO3fz3pl8WY4MbSmsoB_X_ardK6w2UNSGAWyBfkc7MT0ViTQ>
    <xmx:_TW6aofMPjW0t9yKLHVmBh4E2qXUC13dmxrg-8y_SWR2A17HQSw62Xzi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 05:40:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org,  Eli Barzilay <eli@barzilay.org>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Elijah Newren <newren@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>,
  Victoria Dye <vdye@github.com>,  Adam Johnson <me@adamj.eu>,  Jeff King
 <peff@peff.net>
Subject: Re: [PATCH v3 5/5] builtin/stash: merge index in-core
In-Reply-To: <fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
	(D. Ben Knoble's message of "Sat, 26 Sep 2026 08:16:48 -0400")
References: <cover.1790168285.git.ben.knoble@gmail.com>
	<cover.1790425008.git.ben.knoble@gmail.com>
	<fde7fb7988b695707c6f2776adc18eec7fe4696a.1790425008.git.ben.knoble@gmail.com>
Date: Mon, 28 Sep 2026 02:40:10 -0700
Message-ID: <xmqqmrt1pvd1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> +			merge_incore_nonrecursive(&o, merge_base, head, merge,
> +						  &result);
> +
> +			oidcpy(&index_tree, &result.tree->object.oid);

This is risky, isn't it?

If there were catastrophic failure (e.g., missing object that were
involved in the merge), merge_incore_nonrecursive() may stuff -1 to
result.clean and return without populating result.tree, and when
that happens, result.tree->object.oid would be dereferencing NULL.

