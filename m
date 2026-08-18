Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C3E3A8724
	for <git@vger.kernel.org>; Tue, 18 Aug 2026 18:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787079516; cv=none; b=VulaTFDENF+uYlKSX9T2Ngn72qbQ4IWF6Gk30DPlMh+8GBoIarcdt7Qm3VHAN20YJofe3I5lWox/4qUsSqntOWptgMdi+5uk5/HNWFDDh0+LZ3KKpK/lhGGusSYxdSt9kDBE4lP5w+DmC/XMqblZeSx9zHhtk/uu2lhOnvgQwrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787079516; c=relaxed/simple;
	bh=xo+j+uvjDipmvYweyttolRyJA24PRQdluoR7U5wu108=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cUvTMlcWv0PJq/+AeyLHVHoBZKMArGHJWdRvQJe8DxA43K510fUV8RuOQ+r7Z2ncW98s3IBQtrWtTCzxobP7CwjX/8YOfEsM3KzCB0+MpUOBbr0iOLA2TkBLlbEvg0+U/h2P/OtcMSTEtl8vNrAxd4TONbcHX6SQSiqkX+la0yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WIwYYltE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DEnvmSsW; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WIwYYltE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DEnvmSsW"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AB9151400107;
	Tue, 18 Aug 2026 14:58:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 18 Aug 2026 14:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787079514; x=1787165914; bh=xo+j+uvjDi
	pmvYweyttolRyJA24PRQdluoR7U5wu108=; b=WIwYYltEZQvJcTF8L8uwbpT8Yt
	E8FaECrkO7ZMQMbUmHfCECERz1vaXTVY2GJzZDJvMee5rVfzDrAk9LM9L7tTGhPI
	PSDCXTIuTf57/Aqp9pkg1/Kf7VkQTwuW/tYi/gQucc/w+KvXV26lyxr0LHSs/DFl
	H+ukelu+bsaoaCQfQ2Dw6wE4Hij+u/jBUTTPaiJ9so1tuBG031jY3NXDP6R9cXLr
	nZDMV2CCL1JGnlJdNwuuP7SuODlRLafJpchQuTriWwRADeCvM3MGKOpvuEhvm69T
	nXdoKgAV0rswX5ddxrs1I6Lf/M+UyJ9PfkYSux5ydYMVxVoLJvLWE6/vM3LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787079514; x=1787165914; bh=xo+j+uvjDipmvYweyttolRyJA24PRQdluoR
	7U5wu108=; b=DEnvmSsW2bEauY7EDYjI/v4dYJZxMVW9nih5esHRDvg5RQ4gJoR
	WKhCEE6gh5eEmB2PmUVlMojbTD4vX0J0UsGRvcQGSPOkvqhpqziay/EKWWkpzVIv
	YL6ZoWegyiUn7IJvp784rXaisZ9AoACIYv8ICz97EjEyTqsv/k12+dOamcE1HBWh
	HqU5TTPP4bHxpF17FzJBAgpYqU9/4DXpB45fg/8TnF3dD6spl+h12xxSF7muq/m4
	QDxMa9yzLbREUHM7QHMXbGWL4Z8dkCdcM6AWiBOvTdoBS9k9Wrc3D4VeFx/JDSti
	ZJobR3rmbx9DfkVAuzJrDdIdHxYw1w8Pfjw==
X-ME-Sender: <xms:WquEarW8Iisdmzem07tnWc3T4Mvms-K6Dq_OfktlRpGVJKCftuT89g>
    <xme:WquEarDuAjIebv_TuH45PZOkqjrUgh0Nsbs2CRXKzFsilcj1fPmP2asTUA9kvq0MV
    9X2cF-uoTrQNtoHQ6pj7Zt4-BT3oOA1xqhBKO_wIzEtgyBWAhs>
X-ME-Received: <xmr:WquEakzJb8wfDnudSoUx2iEiEePXZvu4BD3evrv_7cCaNTHGa0OkpA9r1VQNhb9TQrUT-tKBV1bIGrWdC7cz5kugUfL9NmPvQA>
X-ME-Proxy-Cause: dmFkZTFSAed2/y6xNMICsrW+xyZ+EufHVqKiRqCl8b9A7b5GBurMbZ2hUc+m5qzsBl8hVb
    UwusApxEIqUWf/RXvBEKdrLzuMcoeBFdTdeuxSw7DgjRImFcSD/z7mqjomvmDRDSwkFnxD
    iI+4XZO7YJUyFVyS8O6U9ar34AoubypDbKFetaa0PcI7hp/B2X0XmbdiKWFN7K+sJYHL1K
    29PCyfZiri8SZ5211kRs55eVbPPCk9jDlmUM6SJ0heROdBmBEKDqGSgtyEKEOuxwO5a3TD
    Ti0204ZkLGrxkGRCh4Ll0+uA9VxTWKuRgCnFKmI4ookTUVoPs9/SeqvTaY5BrX/pCVLsp6
    +vGhqXf7utVNLHxzZfV6kS2jj560EUKjF9MMNHp4a/ieOlcABpvxXCYte15FIZT16Yenlg
    A/2bQxPF735D+4aCVQfqFTW/fRxzpkoDMOoXft0KL5cy7F1u7p41j1ufz7SIwTiAMdGwOO
    lBCP5bsY4pIUx9FU37KTb/sNOrUTv2RZO37lyvLCbHhTUtVlcCBHgrTYHTYc/nekM4hi/7
    8Mg51PAPyQaZgX1lAu232Hvq6N/g2kzte4HsMF6lZuDeGM7x38LygFNGo/u2epHge/2YpY
    QogYYNJVUWBp4NmPk4snlx6WGYKv0bqQrbB5UmwnwGB4LSWOGOgsgDrxleOg
X-ME-Proxy: <xmx:WquEagCBTd2OCyqWg1T4jptowqxrTE5DSgYRMmCBTcFF19esxxCACA>
    <xmx:WquEapZoRzLPsHef64oFDZqHoEF_FVfGnd3JxwXvVfpfWuY5-LCStw>
    <xmx:WquEagjNNxn3X0z7V46X0rph4BeOEbrGSzoNE-ZedyLolQuN1JnSuA>
    <xmx:WquEaj6GKkA4cTMOc4EzeSg28d4POvjEPpTJYFCmgJpdpczrWHf7tg>
    <xmx:WquEarJ0S-vxr28v6NdQcLKqMdwAUL5XXBPGej5k6TyOiFYd4KZ_Yd-W>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Aug 2026 14:58:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/7] odb/source-files: signal mark objects via positive
 return
In-Reply-To: <20260818-pks-odb-generic-corrupt-objects-v1-5-ec234567510f@pks.im>
	(Patrick Steinhardt's message of "Tue, 18 Aug 2026 16:19:32 +0200")
References: <20260818-pks-odb-generic-corrupt-objects-v1-0-ec234567510f@pks.im>
	<20260818-pks-odb-generic-corrupt-objects-v1-5-ec234567510f@pks.im>
Date: Tue, 18 Aug 2026 11:58:33 -0700
Message-ID: <xmqq8q63xnl2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Subject: Re: [PATCH 5/7] odb/source-files: signal mark objects via positive return

"missing" is what you meant intead of "mark".
