Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4934432F76D
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 00:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829326; cv=none; b=SmHn+xde8GA/cn0D0xE94ytgVMLVLrN3EyNWLrA10EHA1mY9F7R4FF6ycu1Y1oH5wnoEti7FPAc7YGlnEhLQhN7rkV6OVaHdkNG5gaKM/fDXIvdPwPMiuOEPlIh+O3MuK1XGprTB/n2naI0LKfutCfDOYHsnc7nsQ7PqTmRDxDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829326; c=relaxed/simple;
	bh=lq9LkyxfGgsQiQgqt688eI6ardI4WOMG5nGPd87PPos=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A9lHSBI0Lf1sfYmfl8v/xtmBrsCKRMUC7Hver/jCIlwEN5LoOxB/99WEu9yA8kHZS457geNbIJaqnmrQbBS2tJdIA9AblFXtm28sXEur2cBtripgIZ1ZKnDz6Sl7fB8OCIQF17X4ceC/RQSpFdgILTuecpEx0AylwA+wtFWbAWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nliknVRW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a0VLin0n; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nliknVRW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a0VLin0n"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9FD147A00F9;
	Thu, 18 Jun 2026 20:35:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 18 Jun 2026 20:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1781829324; x=1781915724; bh=6UhCdSeOL8byxV1ya9iCOgqH6Gn0W3z2
	OhnV5EIwaWM=; b=nliknVRWLu9pzglKVHmZxsClek0FHZNP8NVkFFBeotPIf8M+
	E2InWB0KkIYC/pXJZQX2bTgpEPqDfHO+qOiQpVjTWFPjY4DKkO2kS5a88hQbbFgJ
	BG5KFeNSax+/MtAxwuwz6ntvytZ+eP7fc30VLhBbcc8zpGvZzPeYjPsaaND51fVu
	mYRuc2DfBpzJvHGHkwG66uWYR1zaB+KXmfQDz1TqN4pWfgmjHC+XvHTWm5EhP5ja
	9qBNi3xjAhLZgumU9Alx/NEhUMMbQi9ZVcynPszlyry6NN//ylpWtAPZ5bwONl/b
	QymLpcxlb98lDxPkybkqWSdEr2le4+pKoIzYig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1781829324; x=
	1781915724; bh=6UhCdSeOL8byxV1ya9iCOgqH6Gn0W3z2OhnV5EIwaWM=; b=a
	0VLin0nnJ6rOyEgZeeHURd7+3mgOcEmZm9oQnY/5NFP/3LUPlzQeWVU/9gcjg+hd
	/UytR3D45FdZ2EaUOYcHDQieA/Iy7cZ2r0Hcv3/DvLCP+iwsC5mGp/3JRpSfTn7q
	ZMIqhuUBKlPK2xn/m/SdbFrkiZ3LX2BvEVxwB5OIP1MT2ngYcopph3fCHfpaNHbn
	DIdltPsspms+i4k5RFGmqxRYXDHlqw+BXsv5OAMt8qHu1tVLSwNQ5rpHEdErNFHR
	4+YwoGNNOmHl25ZCgCU0HBVk8aJhe3R8ErMOupF6e0Sypx+f/HZjdMw17lIoYWWK
	0vRL47aLMvrxalTSbHW9A==
X-ME-Sender: <xms:zI40alWeVEL7xhHS3VCnvUSiE1W2vr79O7ILhLaJajkf5qjhol09_g>
    <xme:zI40arlnN8nUuezw4NLwVqgimQ1HTcbQKbylzl6sunLV8E8IIbOWJdBvhfRn_KL0v
    hcvpEY0dOZBGc2dSuefFHqjQcH2vLM334zye02elke8cC50yZo4wA>
X-ME-Received: <xmr:zI40avBVnLRKGj9Jkgxl05Bh6wuM46SNG5D3qJS2PotKM2Aa8L8LQq5f4WBxlZkO6ON4dAPtHqE1SvZsiNDwDW4xxMhncpJLfGT4>
X-ME-Proxy-Cause: dmFkZTGw/BqkiPtSpxxeORhBYt1VaEzRfzHiMb5k8gGViGLgwzEaeEZ2yBE+/deYnDBFhv
    XL7ygIwoZfzPPZrtTfHI3SdgdUiQXiXcKkZKknXq/DjccB8xQC1nAS1vRqoVvoiIaQWhkS
    jAqptgWZc+GiTltD6SWfvYGyldbQknH1xT25sotTpqgThurjHJoYf2fJ7rO/HbiMZlIf3J
    shhfruNx9/eg+OWv8js+1Dh37y9KQh/M582jdw1Ck04UQjYHF1M4kBAylFndVDQoSCE+oZ
    3TSb8MpZYOrFRFOzlGk7wjdI0sabRq0zVRuTZFXhCijZmHs17ARwg+h52Gxt+BDZJcFTLM
    xkBB2FqOjZaTt3QAGklWeCZuuqwuY7pLIyewWJvFljHkNXLMK7q/q5kFSa0pz1Oa0m0geS
    HjzFbeapz3VsS0KKnoCWalMSsOEDEDW/IAbcw+tRGLuaTAjUZ1DzKknGzzlswYTS7wELji
    76ZOhgWV/vaJnJ9ldcFod8SCEFUW1rl4SMZX9uEURVWqDy0Z92KCi3ijIYoszS+igED9he
    wsE+hN/AoIlituS52GYVTlpI4X146soPq7+hwBaDT19TTQcfsXZq+WTaPz9sWtMs5GUlir
    lrQczhxdjKXQvjwp4Lzs+vAws32c9b2Out/sC6aiPCrP356cWTYlhLvbLPng
X-ME-Proxy: <xmx:zI40ajeA4Nz6Rr4yeVNXGUxmRSJrVSSx-ZGObK3nqZwo_Izcnrivow>
    <xmx:zI40aiJ_Qo06tk3rGSVQn0klTvmLULfJnD0fQFBRNgqTVnWeVOEydA>
    <xmx:zI40aueYeDBAevJEXprHpIjLyqcrLjkVt3Os3scLR2lvXwh71UaJHw>
    <xmx:zI40ah1XQR_k7giE5hgHRo23dApJjRjZhMI2yt62CfRcWwGAKSZGFw>
    <xmx:zI40agt7CFYRdMCZTaz0DINmsDtDPIPAojIGn2lpdqFW0jmrm6Puhi6X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 20:35:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [RFH] Why do osx CI jobs so unreliable?
Date: Thu, 18 Jun 2026 17:35:23 -0700
Message-ID: <xmqqik7fnz90.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

I've been observing that in recent push-out to 'master' and 'next',
osx-* jobs in GitHub Actions CI keep running for 6 hours and get
killed.

What is troubling is that this seems to be very flaky.  For example,
https://github.com/git/git/actions/runs/27778820659 is testing
95e20213 (Hopefully final batch before -rc2, 2026-06-17) which got
killed after wasting 6 hours in osx-clang and osx-gcc jobs.

https://github.com/git/git/actions/runs/27790036076 is testing
the same 'master', with a patch to .github/workflows/main.yml to
remove everything except for config and osx-* jobs, which succeeded
within 30 minutes.

Stumped...
