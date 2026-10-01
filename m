Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E458A17DFFA
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790863788; cv=none; b=n5US8TF5ip5kxQ3+JuNsIu+ppwWa+2xLqNcmQ+AgvDVmf87DJmk+1Gn+xBIhjSjJfeKVrNyZqv08IiC747DuL+1sRJWXP9KuSky3Ve9NbVJnVB7GmeEActUBpgOYLfax2WHQqS3LNy040T1f5cKxNwAmULTRMRtxv3YCxU7wCYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790863788; c=relaxed/simple;
	bh=1qXwSRQfQx7wigLokWImnk+kvi0oRoLm+QtR12dCELE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNVJC8/MnxddpNaQ2clNZsiVka9yRnVj/gS3LacDv4oQS7+7m0V0DU92MMqpn1PGlPh4nUKF1pJStrEvKbwpXqFm3uV0q5YINLYqWcvX+28MDkuZf1VUXFMb4AHhPATeZyTivFr8Nlu/aYEznbDpCXJ98n1NGgH7p9k09ccCw8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NQE9KyLh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RdRb6c8n; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NQE9KyLh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RdRb6c8n"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 061D01400100
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 10:09:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 01 Oct 2026 10:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790863786; x=1790950186; bh=j9ku5BtfUP
	YU8CsNO/rRzx7O/LGAaCfzWTnU/LKAyo0=; b=NQE9KyLhx80b2kfxfWjmkQgKX6
	tIwiD4EkCHKjvEl/96rSXoJu6I9OlFIHyYzaOjvgSSvha/TAoBG0KFjhK7rL6zyF
	po/aJqwlY0MLdLzJG0qE9Z5OlSMBPCbb7G4mLpGfMwM9QTHoVGWrQkzBNGdqPE/N
	16wGPRgcjySZWY/V0C05AFtZupuOurGh5MJIV6vwEu1f9c6uwEs5NZAB4z5TML0M
	O9cWV1sFrp0duEtmRv4JJHAnAnZjTvr/e0A6c8IrNlwGFxuZHvboPC71HCShpFor
	XAlibsEo9AaBQBAmTIYD6JgEYhPbIHgpoiIicvl4oSPROCwTFwnz/iNfdqDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790863786; x=1790950186; bh=j9ku5BtfUPYU8CsNO/rRzx7O/LGAaCfzWTn
	U/LKAyo0=; b=RdRb6c8npuZykVuiBQE95PjR/CFFlyEtc+3ibQtVkOETbjK4CMA
	vkK7ZjLtCi2Rr3ULz78qlj2gAqtWtQFKMmEzb+jJJybxJ3Rot3mrSKI+DmSggZsD
	fn1n8xl/ZGbqx0jE5660lnReGuuuFW7EF9SmvbB3Vr4liZ4SJ+SgComd/jUC/D9c
	Y4hEqGwcpz5y5EWUX8Og2CmbJBRZ6eh9G2mSYYbB9Z5ZMiA04CjQdULcIpVxfzEZ
	Dt4ewaIvAOS8fO1qlwLbN5F84hIXwfODs6lchUeOt/KC6IM+Kd0K35lbeFHeAKKw
	6nVpXxZhw7XRNsz+YY2FTAzlX5vHuTikAjw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790863786; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:OEgEMKzmVEi4pwDVj39bqBv8p4k2M+YmieLAt1alfvCCXDQ
	xRGTpwZ/VTxbg+cvf9B9na6N/SRf/7K+ZkYchsGjsXtzmnfjCKIoxkDxgImmh2IJ
	zU42mn/dy4srsIt1KxgzZ1huRmFouK7Ryt4zfejkfPj7hEzBsIiXWxEb7UGS8t9T
	zjl/2DcqNJ3A2sTeBkOc6xf2sKm9KCFkDR+3znHiNj3yhX1oIj3ppLpZb+yH60a3
	aC+MpF6CX6ekJVpxuXUtEmFVy3j71pxd17v6UmZAlvUrETXBjhEdmemUHylocKs5
	EM7vDkoMGNMFuxGv4Yc5Q5Tffnhai+J9JydMDDg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+baebTR1bL5MeHfgBuvaRr+elYdiUWwWCwh50xgd1k4=:1qXwSRQfQx7wigLokWImnk+kvi0oRoLm+QtR12dCELE=;
X-ME-Sender: <xms:qWm-apOxTt40mZO1v5R97rr1YdjpLwFj0T8GCw3tpnBcNRt-QtLc6w>
    <xme:qWm-ajalYTptgr9lhJWgX4pco2Tvv1p4G264WHu2fznBb_pqOcI5fs5vTCiT80ZRl
    fH3mPcaozwBd1_SEHmuO9nWhOb5-OpA8x-B7_TaKj_Y4ZuaoKpLnAv3>
X-ME-Received: <xmr:qWm-alrkR-zpLtv3TH0aRPuAOG1jJLF8WL9EALVnubqpYZFRzxy01HujTGAyJf5BzzG3yw>
X-ME-Proxy-Cause: dmFkZTFOfW1+pFAgbQVy9IdJ9UGgmkAvIrlTmnGdhwow0Q7lAC/Q2cQ8JX+Pg8q+jpoi/B
    WXId/ZtwB36HSUjcjB3U6jaQyw48mwy+xqfmcgeIZz+fphALSUGcayAPMQgGPnj/VUeBkv
    zq8jVYfylUhJ+R9UOcdt1/YwnLr2oRCgfYpYOpAPBrdJ4gROqEQ4YHQO3GI5zimurWcqCI
    jnd9V1gRawGssuNWCHuzCLVsB0hZ1Z9ZRAkbtPnrUPpb4xPGJBVblCjtgAdg8NFntaQAXZ
    R7p/7NkLt7aKHI+Hxu2Oj2JT3IO/GZupA/RW5pche8KdhYzUiuG0DQdiYbM/IiWA6Mlbl/
    U8uAEmliIFCWs9Dvya/+x6gPbAxezdh8+4KDm0AThpk8TnDtiHp8T7f/hCtCnUwglqeEci
    n+4pc9az6G5Ko5/TDzcPq+tCOfK7gcruRtljwo1zVgZQJRamPFx09Gqks1pX+B9kWc6GV+
    ulZkz1SleFQ7iZXFs9m9/1CRNwHgg+r/oXgVxgYR/AiwhcjL7I2IrLlv2vTQZWVI0NB/+i
    3J17pfi/PoNX+LvgS1QoU+hN+mi0e8JT1b1mVN0+3RukEfukGg7qCn0rqxQXYCP5q7PiZw
    UEBlGqbsTssZ/r7GeIV4lfbxiqmDdCH386itbIRNYhe7zirtsYhPzpprJvIA
X-ME-Proxy: <xmx:qWm-avaZh6mLM8raKmcZs7ibnKleXUG131YscD-k08Npfx4sT5kkEQ>
    <xmx:qWm-alQNObC-7Cu2QAfeNBIe9A2Asg2SHisemLiZdQHvGmrT8nbhOw>
    <xmx:qWm-au6lRXa_Snq5N_9Kku8vLO9Oo0jk4N1TOSFzSAaQRdguaYrGKA>
    <xmx:qWm-aiyE9rfUQrrTnVndPhsFOenQxGC6T8M46BHUa_oiEYtWPdNb-g>
    <xmx:qmm-at1gBh16HUZFaZ2HPTBHklwoGM3mNk2Inj3d1eGqHATy1LEs3LUv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 10:09:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 77a077e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 14:09:43 +0000 (UTC)
Date: Thu, 1 Oct 2026 16:09:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Guillaume CHAUVEL <guillaume.chauvel@gmail.com>, git@vger.kernel.org
Subject: Re: [BUG] submodule merge tries to read B's commit from A
Message-ID: <ar5ppRMQ8NkGnbGp@pks.im>
References: <CAP4DsUexEmm1qo6jH+Qzy+n3dQs_OCJ8yg=ReF+aVrcTrC7NeQ@mail.gmail.com>
 <764b8c2e-cf09-4531-94f2-268f97a889d7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <764b8c2e-cf09-4531-94f2-268f97a889d7@gmail.com>

On Wed, Sep 30, 2026 at 02:31:44PM -0400, Philippe Blain wrote:
> I did not yet dig further, but I have a few additional observations:
> 
> - in contrast to the commit-graph bug, disabling the use of commit-graphs via
>   'git config --global core.commitGraph false' early in the script, by moving the 'tmpdir'
>   definition to the top and setting GIT_CONFIG_GLOBAL=$tmpdir/.gitconfig, does not change
>   the behaviour, neither in the "repository corrupt" case, nor in the "hash mismatch" case.
> - On Ubuntu 22.02 under WSL, the reproducer does not trigger the bug on v2.56.0-rc2 (on a dozen runs),
>   but it does trigger it on v2.55.0. Funnily on that system with v2.56.0-rc2 I get the correct behaviour !
>   (no "hash mismatch" either).
> - On a Ubuntu 22.04 Docker container, I get the same behaviour as on RHEL 9.
> 
> > An AI analysis identified a likely cause: a delta-base cache entry may
> > remain after its pack is closed. If a pack from another submodule reuses
> > the same packed_git address and base offset, Git may return stale cached
> > data.

Yup, that seems to be the issue indeed. We should really be clearing
packfiles out of the delta base cache when closing packfiles, but we
don't right now. I'll investigate tomorrow.

Thanks!

Patrick
