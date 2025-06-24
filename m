Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1AF246781
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 19:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750791711; cv=none; b=Hvi6wjUmkbnE2r+t9OEQaPminNf4bkzFsqO/65IfwmzznJY9wvoJjeWlbpYMMsw4al8WgP+U+6a1R/FMi5k0nGRh2lUwEWGa9en02RmNVOiY/TVXXdOAN4J7/LKwmeYReY93s3svRRv+SuARbRbvCe21LbNAfC8ZkywxYe0/Pjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750791711; c=relaxed/simple;
	bh=P3KQ3pOLLUWX+9OYQnl7L6M0qX+b6VYrdVGtsYMLfuo=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YGJCIFDHHGI3ZyfQIuSZYkqP+6TyBZgJyG9z5ZrlPF5o8RP26PIzDCwf//XjBpquMMwwNduNp7YzeYyRfeTmUvTXYyS69F7DnQMn1nXIfXxVXUXwtfGsLsuIevyEMzgPqSK734g1vc5yc9xMUVZ3xB6WZ0uxw3Bv93vAcfNyscU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NP3dtAIe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hgmUsAWx; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NP3dtAIe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hgmUsAWx"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 592771400143;
	Tue, 24 Jun 2025 15:01:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 24 Jun 2025 15:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750791708; x=1750878108; bh=P3KQ3pOLLU
	WX+9OYQnl7L6M0qX+b6VYrdVGtsYMLfuo=; b=NP3dtAIeiO4I6/PTGB5HlB367z
	tMANSUVxVgIziqcpMNPfAs53RLFLMeUoiLcpmAkSFXhx1Zbo+jTVsq3bF7hkEOlL
	WtmYHrSSMdj5YKA8G0vL0CP33ku6RrGOduXxXD+nCo0B6rv06GeL3377nN553COe
	T/sEh8oSVg8mP6LobknQxRfxqbrCXR816iZ4JWGEqVHNI/m7XV1Gv/dbkY/pIMnk
	qmumvwLsd7s9jjlMudN6dC6huZzEAb5O0tFa7jexCZX7ZBjP5+VqHFAGpuLCFdHW
	I/cEZLn7OvjvM2CFrvm8cEnDtvdQGBUKQGwSHT8yeJ9U62tJrrBgjq7aagQQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750791708; x=1750878108; bh=P3KQ3pOLLUWX+9OYQnl7L6M0qX+b6VYrdVG
	tsYMLfuo=; b=hgmUsAWxwTFRMJs0xn/eHfETbmn+ziqx6/W8Ziw6YaFWMo4PWVL
	gyy5aQ+VZmMpvJeqQrCD7rOvVzTIrr7PGXu1sbLbF5WzPRudF0W1RbFWsYev3UGL
	1v2uCpA9+Q7rH3k28KGENC4Nk/D9mUkyx8AtJ/sXlsKH4TmgKxTxHxpgPryG4pa8
	uS8xcEJ69y980v1oxiSsIbGd6yBrI/q7kObs7CgerA92hwEcmkNPctvmVJvfVCSg
	KfTi7B8EnnRMwQN3ple4VeV+LQdVfp5Z9iOilKRxjEmP6ns7WoyHkKFnB4e4bY69
	OMJc+ji3QkygyUnAr7eVJPKYRdJm3w8cn9A==
X-ME-Sender: <xms:HPZaaDo8gxvmzwE5gYD98Op7XT1Txe0IxLCnD5hPVnyHIcUFY42BUA>
    <xme:HPZaaNrcariG5JDsaw9xwCjfEDXj3tRgRRKLyhEbX5GKm-s3Ex7azq29A4lmmeSb1
    7xZArvdI836mKJFjA>
X-ME-Received: <xmr:HPZaaAM9RCTZC9Z0XXi9zTZsMFFHdiA2H4FaL9VIpgf5-m2y1sO6dmVQJgUasjOOvQWZFB5-aylWWbccFYgO3bkaEuv1p5LQ4BHIdSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdeijecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvufgjfhffkfgfgggtsehttdertddtre
    dtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgs
    ohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgeefteelleegfeduvefguefhgefgge
    egveffvefgiefhkeejtdevtddtiefhheenucffohhmrghinheplhgrthgvlhihrdgrtgen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:HPZaaG4Yht0O2mDiO3_8i9l2HPO-s9JHOJjm0jtqn2EkTV-1EsrEPA>
    <xmx:HPZaaC7_tvFB5MWR3RtabQV99vzziZNNqFJmaSTC92NQxhCjit6iDg>
    <xmx:HPZaaOiWfPd2PLKhOxRAg4aS1SruZSyRuoMqSdluC1KfMmJbLW9tgQ>
    <xmx:HPZaaE5CHhDshsX4-q2xj8ijNurmrmvDgz080gQEzUO8UKO5GTNVtA>
    <xmx:HPZaaHr7fC-Dd5Yol81oc663BFL199W2qGf71rfm2xjnBFox7Fqw-lwp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 15:01:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2025, #08; Mon, 23)
In-Reply-To: <xmqqtt462bye.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	23 Jun 2025 17:57:29 -0700")
References: <xmqqtt462bye.fsf@gitster.g>
Date: Tue, 24 Jun 2025 12:01:46 -0700
Message-ID: <xmqqqzz9yndx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Here are the topics that gradulated to the 'master' branch lately.

 * ac/preload-index-wo-the-repository (2025-06-10) 2 commits
 * ag/send-email-edit-threading-fix (2025-06-04) 2 commits
 * jc/cg-let-bss-do-its-job (2025-06-11) 1 commit
 * kj/stash-onbranch-submodule-fix (2025-06-10) 1 commit
 * ly/prepare-show-merge-leakfix (2025-06-09) 1 commit
 * ly/run-builtin-use-passed-in-repo (2025-06-15) 1 commit
 * pw/stash-p-pathspec-fixes (2025-06-07) 2 commits
 * pw/subtree-gpg-sign (2025-06-04) 2 commits
 * rm/t2400-modernize (2025-06-16) 1 commit
 * sa/multi-mailmap-fix (2025-06-13) 1 commit

Some topics are now newly in 'next'.

 * jk/test-seq-format (2025-06-23) 2 commits
 * jt/imap-send-message-fix (2025-06-20) 3 commits
 * jk/submodule-remote-lookup-cleanup (2025-06-23) 7 commits
 * jc/merge-compact-summary (2025-06-12) 2 commits
 * bc/stash-export-import (2025-06-11) 4 commits
 * ps/contrib-sweep (2025-05-12) 11 commits

For details of each topic, please refer to its entry in the last
edition of the "What's cooking" report.
