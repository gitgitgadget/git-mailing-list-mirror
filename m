Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132D72D0C92
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 15:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953331; cv=none; b=QcI3HrNy+G61MtQ+YHl4ei6OLNwryI9yRLJQbaTj5kao67VaCHByyPMgHX6UKQGy4g1vYzzmeRyL2903gtsr5w6E3Es4vP+F7FUoEtoVorKb31FLKnywySwHz6QrXeNpCF7uW25DrqQs21QwWci3IwA2stcN9wMHMa7AGX17skw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953331; c=relaxed/simple;
	bh=EUm/oNyB1VrDH5vtmPc5AmCi9cW3L0wOJ79XaO1AVJw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRB4l8B0ZALrjlyTh8Mg78QsC88RpLh6dGHKSeLtSUgJSYarMqhDhEEvVv7bvWb2qD/CnUNw91OGAM8dtIjzT9WNIVSCtKvto6FCrjecaxWaIr8Et2XUbKOa3R4xrUygfklhrRX67vBIO9My+hxFebI2BP0xHdLzIMOvm2dEkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RQan7CP+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p1mmqXcO; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RQan7CP+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p1mmqXcO"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 355921D000CF
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 11:02:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 02 Oct 2026 11:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790953328; x=1791039728; bh=oEtC1QsT5X
	98s5BsSd/HdWreQoANXEfbiPdBxzDi0Tg=; b=RQan7CP+sxegWZ4bvIgMvsne1F
	L9KZCOyTKxkAoTSu/SJtvNOxRG04KOOlndv9y9B+ZpJdhvsgSL1dp+nLuQ4J9Jk3
	9fNecCEJoa/XsiC21JhtFjgH421pNqZNOp/GJPPjdwOpXg7qL6aj9gOKxUkThHgq
	3KerpmnW63/JoQI9lA0K0/8zNddcqQQKZyHrn0kLR3Cmle/9O9ryLInOMCojmlcU
	qgo6/YBliGKqUb6k0gD6kkTYHgJTxy9bctUO3K1klCBgxPTcXGkXKWWrlwsJoa5O
	GsZ4ZEpxCeHlpOx5W2SB0lKOfUxPIps2E7/oosmBK6dOsmqYUIey4cbWCNLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790953328; x=1791039728; bh=oEtC1QsT5X98s5BsSd/HdWreQoANXEfbiPd
	BxzDi0Tg=; b=p1mmqXcO4flu2TV+Z28fkH+hMloWP5hghSBwzW1DnzjRqZYhk8v
	uHAR9Gw73/PJQq8cDxVippVHS9is0Q1H2p+YLYxDUUVqmB3orKISA7vBmnbZFp4U
	PqNwLrA5n/lLctvOutvswZf/1wc46q3ePFSeqCa4x8x1vhOfgiDsp6BJ7fC6rdHl
	zT0+W7Kc7bTKfkgebV3/zzjwhWmPTJ4VEIJba/YZJnjnVncOVr+VXzgvf7m0+cIQ
	e6qBx2DcGs2zWOGIsNUwwt2UAsOLAb6b9Ihbqp0BINO1TNByqTFaZeET98kW/pjt
	exPwgoWcxI121NVSmwvBEqCCQj/yw/ehuug==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790953328; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:Cghd8TxDVcVTOXsQfRbNxP2sNTmiIJZF/2ArHthfsDGD9g1
	58KuhkluZdBrj4soU4FFkja4sT4BhyXDLrb1ftIjQMNbNN5RV1EWEBU31YB7A75q
	pXRmtCliXZ7T5/lOhoMpOKOHfY3agLiJ7fH5X+wK89skSJYv7yz7nxFCRuLb0UDY
	/7l7EOsKK1+ggDGSrqI27Vt4p1OA/i/bYiuipehnQi4WCrpDf0mpO1EueMqSnuJT
	a3/Yp/EzJTtXv6nPGs2xTbwPpl7Hrjpxed/MhoMhhjihP0fI93uCEu8juCQPd8Jv
	NW4+z1hL3lCDSxu9oBj6U6n4mEHRBLKMJWLqRLg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:a8Qz7G5PgeCOjUIm38qCnennHWpAbCj+31cKsZJYr2M=:EUm/oNyB1VrDH5vtmPc5AmCi9cW3L0wOJ79XaO1AVJw=;
X-ME-Sender: <xms:cMe_aiMNJhhD5QxwQddoPD0ewBNHeuKAYXEuj5oFF6zzKMH7ujOJTQ>
    <xme:cMe_aoYBF6ACiZWp2EVqMzYXp0KxnQKbvKFIwgpvdg7aZOXqeVeqqEhVFmIbJ_sLp
    LbPBZ1461LFlaEGv36-0reJByv030ngykcx5B6Lc7FE-9ow99eSYG0>
X-ME-Received: <xmr:cMe_amoSMKWD80yk3v-uTkwvDQpLxgg3kx2Y2XX3v8Hr-O1Z_E5s_qydA6DAtv7Zq71g_h0Kc4WKOZoubEeN5b_gCglcmHgUsNdn>
X-ME-Proxy-Cause: dmFkZTGPwHtWe7vDltuY4+aSXLdQ1jnUIWNPn3dVBD2n5YM1oP7uHKOP9Yt+gAATfUhiWT
    pSNth7vGr/CFBx5SWtrliSjTN0iOCV/X1/McEDfK1zmzNyexJQLOfSZAMEqwIuWdyjuGDg
    t8uJlyA2bBrEuLM/qElYCd1C+FJuNSFPfpsM7w9UIH37P5iV7O1eJ0s5SvXyIIEWHs4syE
    N/4gNI2uGzjyHZ6lWRq65H6hFXG8OajE6g0OrYhOcimJDlgyCnGgl3VNywjfyC64iFBeul
    YWxWnv/hB8FbRaUIKFtXH8QJpibG6JXIbZ4gc/T29QbHizAhSSuNuWkYDUJIWS2TwudEXH
    meoEVypti2O2ZRg0iPK/22e5MlTZu6RIlbexoBb9I1L91xIqh/OLoEHVt7tS+BS7zKDLsu
    nyYTrDRsfMk4ICkpvgiNcian4h6fDi93tjxAEOnyPN9qkuWhhX/+gsk1RpBFjKAiP9Mfeg
    FakeyFX4xwTCnW+DC/iX0oIuPOcTn5TgZ94uUzkJDiGeI0wn760vxeuAIwmShEVtYGHfS2
    z2RoM5pXmG5lz9GShwtN96DYFYF4/zyyI0sLDmOcVEceQwvEMDGfa3wOW1UL+s9/CHd7JS
    yGJo00qt2RfxzrM1voe1yUoOtZun6My1O1Su1hzlsEUy4JSq29AZI5+hCwAw
X-ME-Proxy: <xmx:cMe_asaWhVRfIZMrsHaXi90EdoL1WOs47trOjQyURe6OXCZg9WC-uA>
    <xmx:cMe_auSRQB_kCsdmHQpiDhXCDB7HFkeqxVXOBTmNS_I0e_ix2USofg>
    <xmx:cMe_aj53UpLjxQDqDNN20NgHVCtPulv6nvK69bD_lgK1HmqHbfzqjw>
    <xmx:cMe_ajyDOYOoWCXc0BUDqh6l8kG-VjbVY3n4rF9693C0L3MxLdNXmw>
    <xmx:cMe_aoiq_0Ds9dDHBz2bQyNVE406UVCrs9n9vhUaljh2-L0o79O-Ss7n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Oct 2026 11:02:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2026, #01)
In-Reply-To: <ar91BoTedI3gHntX@pks.im> (Patrick Steinhardt's message of "Fri,
	2 Oct 2026 11:10:30 +0200")
References: <xmqqv77l2g2e.fsf@gitster.g> <ar91BoTedI3gHntX@pks.im>
Date: Fri, 02 Oct 2026 08:02:07 -0700
Message-ID: <xmqqjyo016z4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>>  Waiting for response.
>>  cf. <b0ec2ef9-7aef-4f7d-b31b-7141b39c2d24@gmail.com>
>>  cf. <xmqqtsn9mkog.fsf@gitster.g>
>>  cf. <CAOLa=ZSX0e25wK5qQwznXN9rVM+WHn8631pkTEN9Zm-BrXfEsg@mail.gmail.com>
>>  source: <20260928-pks-create-repository-stateless-v2-0-a03612f703fa@pks.im>
>
> Hm. All I can see is the discussion around free(3) vs free(3p). Is the
> expectation to do a reroll with s/free(3p)/free(3)?

Sorry, I thought I already relabelled the topic, but apparently I
didn't do so.  I think this should be ready.
