Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBE016CD33
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 01:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782006533; cv=none; b=Fqy7vDPoqNa9y4uRGYVtzl4mOIa2TvXC8AnPyStHMjj7fXulJvEwB8//Wnznfur+TtEEStZMBAqHQqKc/cjN0XTdf+iQi+Jihh7SF3WROIZYqbeK9v7/n33kChvho2fhVwLwzMRCfzxsSuc7pWX10L3p9hF30NzbDegDA52pxgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782006533; c=relaxed/simple;
	bh=3MU+MJGjRUxrXjOIphh3sGgpfGKtbESlCoK2cfF+tzI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kD98xwdPMfOeoF3+U/YPDaGuBX30F44wZwV4RpnBg+DIHQgNtIDsCWbe5vzbFxUNY/1xs64Xx8ORMZZDQpH8csGjQ24XqAaWWk+oRJyqX6XDqD//+yTBWwW5X2tdM80P11BRZw6kjKeGxQ8y+sbMpkwceAidhhK6vZd2Kih8jtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ELPULBAJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YErl3fKo; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ELPULBAJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YErl3fKo"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1D2E1400051;
	Sat, 20 Jun 2026 21:48:50 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sat, 20 Jun 2026 21:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782006530; x=1782092930; bh=I8YSi5gSAi
	wvwDIx/tlh0NbTuigCGhPPmaMopKjVhO0=; b=ELPULBAJ+Dnbg1xuDzBvnkrXMd
	rSqyKg+nuH21AEwjSCfUpmANKKdG4bLGy/99vgi5rHubp+ujHvv/nlTcQTAxBhni
	NdVAYlh4xo26h+SCfHL7JnMrJEMPWSO6gG9eO0scXZR0BfeiebgBDuumnPU4YDsJ
	MQcvLbf1nTxw4YvaOJvMRsgUXcTGTnQdtmqqJrFFxR77UQmCwi72ReF8ZI5/VxxW
	4A4FOdJ7NrOCwO+xvdVTIaoQr/MAyCoBDdvMjrn/DLwEPN4oGDRpBQBUbeuK54oB
	QpKP6qdYSMUqDIkQRiLOnjb4aGorTfJlmJDXP4VdNI/UsnXw8K76O8Yy8teQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782006530; x=1782092930; bh=I8YSi5gSAiwvwDIx/tlh0NbTuigCGhPPmaM
	opKjVhO0=; b=YErl3fKoJG5driXQWTAi13Nwf3lMdbUHa1Kpd+dlzEUhwFyuCeC
	ImrxsWI646sNrNtz7zjkkjRmHsPtWP337Oiv5JpKMht/5AZ+chnfkrWKL+BVj28L
	aB64wmGNj9sJgfaBvboVd6aC2xrKSRwq8egSZ4cMM/w9f4j/xP2o3XDoltdNvPSx
	wYPWOjp+j1Z4jxHWrHR4z9NN1LyMZabs148FAcX1Ymsj+trVZ1MyLVzAbeUvU3d8
	KKUdKjNWQQOBXH7fMhQxjk1YKd7LI87ytBPgmMNr8HxKPBappyhk+vsZxMhBi3Ew
	sct+A2K66Uxz3mMlS2byFaR6vStdEdLOsYA==
X-ME-Sender: <xms:AkM3alBw9mIDYL9K_sReOrsq5Mm_tZBioY_xo9aDJmkFfDlomuto6Q>
    <xme:AkM3aqBRA9sRnOllA4iNDhLhMo84jn2i1G9qGKD-YoIWMO2b2NcKWTG_5E2FaSZC9
    umHpAK2mUKRKZqedZoiatCBUFyitkRaznuqknMm26sK7qSFlbKAjA>
X-ME-Received: <xmr:AkM3aumLKdSQzlkCYTqtWwrkxM0nBKDSF_NrhNmzYSOVW00W_tnt5hzXnIU-wc_chew1l-ML_GI7s7qtg9ZTr8e5WW9mIZyHPL6_9S4>
X-ME-Proxy-Cause: dmFkZTGmakUlG2/tl1zV4mTBvapLzkw1C3JwQXVtBa3oZU8CYk06xtbHUr0rI1gMJvlyQQ
    ZJrsJXowOqNvCRRUJYNzfd4Wnt+agIgW7eodI4gOF92WbSaijp124kcXCTW1yx/kbFgaof
    gRasAwICwkuREhsYH+LIDOQpP6zZjmQCqZI1ND9Q5fZ4MB5cRSwHuc3eCdkBd/PPF86KMT
    hoy86x2omBKsXmxtDE39mYdK0+ATcXPxNvvwc5xBKBNTUymBn/58emoxhGuQqToHMeUtDs
    13xqKb9MIIS1EQ7077YiSPF6FaIEDF9xu97rPVA2kqM/369YhJqg4cJiOMzbL6zJhkP8c7
    CbnKpb/A6D+iHLIsKU6dbQApEtlB9YFFgUVa99PKK4jZ9TBanLS4bkA6lSK86zQDsw6OoB
    fWXcP+u1+zS7nkqPpY2NdInDgK0xEiRbimipI42K4f5unPej6/xbF9P1xxVqRR8iwK5B89
    C83N3lQk5Sq029F1xRb2Wshw7l7+XmjMyzxkmFrxdbhatY88qvc/GZ0nsg/YXOBRstFQ8+
    ib4V4rUn6hbfpFzxZ5eNnWA2cL2qBsD5MSXpnvSUsgdSHjOqmi4A5NQkkLXg0jIsIM+AHu
    uWG3sLN8wf3aAxoTr+i/2RprCZwPyUA3f/5/L0FAIu84fHzjW4EahNtavhvQ
X-ME-Proxy: <xmx:AkM3aig02r8I22h56_artDMmDsrV3NG_fZBvGcu_Gd11eURjZAJyZg>
    <xmx:AkM3aggIkvmOlXcSkapakAtmyYtQO4mNCURyIIASdb_5vwSlPPJuXA>
    <xmx:AkM3asuOimu3E6IggjCNsDGa5hSs-2D0aqejuc816V1UcBDBp7Eh0g>
    <xmx:AkM3agt85LoxI_tBGMrCzdC0zNN2ixKR7SGDVbu0YpczUIGl5FLVjQ>
    <xmx:AkM3ar7G_OW80ggTSTJ_OJ3xvEpyhAb5Rcofbw4RDyGr-BeHL2EvdCLS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Jun 2026 21:48:49 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org,  krka@spotify.com,  ayu.chandekar@gmail.com,
  chandrapratap3519@gmail.com,  christian.couder@gmail.com,
  jltobler@gmail.com,  karthik.188@gmail.com,  peff@peff.net,
  phillip.wood@dunelm.org.uk,  siddharthasthana31@gmail.com,  Kristofer
 Karlsson <stoansen@gmail.com>
Subject: Re: [PATCH v6 2/3] revision: add peek functions for lookahead
In-Reply-To: <20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
	(Pablo Sabater's message of "Sat, 20 Jun 2026 12:11:51 +0200")
References: <20260613-ps-pre-commit-indent-v5-0-8d308efea63d@gmail.com>
	<20260620-ps-pre-commit-indent-v6-0-cdc6d8fd5fbc@gmail.com>
	<20260620-ps-pre-commit-indent-v6-2-cdc6d8fd5fbc@gmail.com>
Date: Sat, 20 Jun 2026 18:48:48 -0700
Message-ID: <xmqqwlvsek8v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> +int revision_has_commits_after (struct rev_info *revs, int n)
> +{
> +	struct topo_walk_info *info = revs->topo_walk_info;
> +
> +	if (info) {
> +		int visible = 0;
> +		for (size_t i = 0; i < info->topo_queue.nr && visible < n; i++) {
> +			struct commit *c = info->topo_queue.array[i].data;
> +			if (get_commit_action(revs, c) == commit_show)
> +				visible++;
> +		}
> +		return visible > n-1;

The loop needs to be rethought, perhaps with a better abstraction
than ".nr is the number of elements in the queue and we can walk
them over as a dense array", using prio_queue_for_each(), once this
topic meets the kk/prio-queue-get-put-fusion topic.

I see Kristofer is already on the CC: line.  Depending on the
done-ness of the topic, we may want to include the topic in the
updated base for this topic to resolve semantic conflicts early, or
the other way around (i.e., let this topic graduate first and then
rebuild the prio-queue topic on top of the updated 'master').

Thanks.

