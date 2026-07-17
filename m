Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A1D42D76F
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784301965; cv=none; b=OeonwA/TiglSY2xC4vakcXtexO3iyheX3ehF/DhzOlmizyxjiRw92tkdH3rra4edeqILsVbvs7IFuTT18XFljtdjFiXlb0+Tupc/7qQzpeW1RNvYFZzbbVyZDe2PdRRK1h0J/LL0KbPZhrR4lcOZZMBRLKLyNC6K1v6gREsL9aM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784301965; c=relaxed/simple;
	bh=MTRJ1NgRbHsKOBR9PIQ28ci6K9JjDP9MxA5cywOkFDI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=myimwKxzbER2Ay+I4x1lfwFF4ewpGZCf4lladCe+PhGDcBLCDLkYxLLdAY/kpy5MEAdjDxCoBq/L66JZ4p2eZlmNTD3JOaxPRFmaW1YDFyDE0Ka8i/Mmk1TSh9yDpEvHYRPyRZxknWro7oa/Jy3j4CoTzWxUxUD7giwIWCrcytQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tgFShRQS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oGI1rPDK; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tgFShRQS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oGI1rPDK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 639A5EC012B;
	Fri, 17 Jul 2026 11:26:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Fri, 17 Jul 2026 11:26:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784301961; x=1784388361; bh=QGAA3IGebC
	J7zTHY/vSTEuG1FdfGJ9RA7CtMTxMalG8=; b=tgFShRQSbC8eBXi+AwgWrlVsGZ
	ZXKeHYwNhS1e8BJDK44rQb2JrKvp0snWvq997UFEN2bnwq4z7Gx6GOo+AEuvwXXC
	v1NMpOJQO/IIqVUdeFSrvgEShX8ySYp9cwMMRkiZAg8WqsZjD1iJA/8b0K6h5RJ6
	pl63shEoc7ed9bdVGj//xaHdkBGBbnUFFR9A8x/0kd0ZaNVKF7mIzlhlwSKzUusB
	O8KIEsj9faWuSXieZRBcPtt8PPWCLKDnDtgKdMVaZPnRbabAO4NRq4ZURlFzyEBG
	IpBx1hDNi4/Iv+yx/7gTbfsrTtpF1iAjwccBSAxs49EVapyooc4O5PnuOtxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784301961; x=1784388361; bh=QGAA3IGebCJ7zTHY/vSTEuG1FdfGJ9RA7Ct
	MTxMalG8=; b=oGI1rPDKv9N0LBKRJ+3KdbiYMkwJ6VwKLd5frjuQXUHwMmULPku
	ggr5QPQnG6g3NJykED0SdHpMbB+jyHGRkdyFUyj0e6zrvZP07PtbpXINCTlQpt2Y
	+S5hR1LxxkpNCe4V7i1TZRLlZ7i2jMX8fH8IhRQvvgHOJ6Y678lWFBSSGL5kWreK
	zbIpyulT/85ltZxtgZKltiqL1dZ2PDnlED61vOe8c7DfjSZomQ48pEOSyLuGHlq/
	Zfw/FwHkQFghUlpWEnMJex8AXgM6/ZzuJcIKjMjB25RVg+ghn2Rku/ESNDYKGxu+
	vcSBfn1rU/PVAhGV+kSNnlFLKrw5It5Ug4Q==
X-ME-Sender: <xms:iUlaavNR3yv0DIUruLbNtv_HA95tyB0_2XqqQFWooQaszdNMg5GaUg>
    <xme:iUlaag_36PomMvbImZqpvGmnyTEQx_6UbiAYYc7a408IlO7jDwCD0mwyCQDiPokGM
    SwvI7Z6JezZonQDkoK3CWAS8pFQp2USf8XMJ0b0meCEyRYqt2ON3g>
X-ME-Received: <xmr:iUlaajS55lSvmEIvnJZywgERQCjDSjMTtglVVy_11mzM4KMffUln7EAVnWsOR7XvT-_olZehj9rCrNID-2Vqbh9I376GRSImRxNvam0>
X-ME-Proxy-Cause: dmFkZTFdHcs8im+0NKIiT6daX6MhbCUpadI9OQ2jM41djdMtiezP/XZhUg7HDR1vHpl196
    seOVIEdzGOWmDxpVnwjSMJpOZfyt5f9+isKoiJJ/axmjSyoZ1SP3pMbBgPQB5TJQanj7Fu
    hl4f+hQRklnGECtQxzviRwt6kZskNCcdyaQqDQBcdlT/qvfyQEKFH5FG93hLX0i0Z/7AAm
    U5/0G3CuCAzUwit/aVGUZ94zUfecYkJohLCK0plEKzCSUjm0g9m185+ojfiIb8Wq5azHrs
    PPW+7zMrWRNnNSmmz3zm+6oBy08r1lJ4/tN2N4f+OTAs7HwcpD0vuPPyVpONte5Mj+Zkpc
    XyiSHNfJ+mXUv3g8Z/3QBkgQS15dNLCGqzFUSFv0ZCevJagX45cN7snQqwGVvvzZSC3eHt
    DuAChJEuJW34iKAu/2OcI8EpF3D/2VpVwbhDMDXxj9vA2w35xv9ZpzeeAtMoeKbyKZTmeJ
    S7d0NGkXNrsuh/QJRrYelv639LInhLR0RlicYIS+K97ftUOvkPUsKmGI7vM4Z+VK8Bax2x
    uPWVj/KN2Agv2tTJnFMX8wRqWLhG/9Vwup/PPo1v21TA51LuyfV9++orNpXIaHkimr3/GR
    O5pp4AcFnxjNW11Gnc3S0B8QoG44mcPpojaUQnjsz/IAQx09hpto8Qo9nHUg
X-ME-Proxy: <xmx:iUlaaimhsR3MonlPK1Y4gib_v2cSiiB542Tx4RTjNUrJ2qODpvxxoQ>
    <xmx:iUlaajSqeQivcObiHcBFWvWkFm-dQkaewYKL05zeHykLfkiyldhGAg>
    <xmx:iUlaagN-PjkHGwPs5BRSdljus6J8G04cn9YTP2BviHPI3TkYsDMW_Q>
    <xmx:iUlaasVsgdGUSgoRR6Cw9PYeVBRM_JpP34QNxHbmrhmF3GlXVeg2Vg>
    <xmx:iUlaamzoBex9GXXkzbUZOB_KcReB1sAqeL6lFDMwJh5wnRyCZ2qtAUz9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jul 2026 11:26:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Gatla Vishweshwar Reddy <gatlavishweshwarreddy26@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v7] show-branch: convert per-branch flags to commit-slab
In-Reply-To: <aloHDhoerEhIXxFA@pks.im> (Patrick Steinhardt's message of "Fri,
	17 Jul 2026 12:42:22 +0200")
References: <alntPJy2VwVK75qj@pks.im>
	<20260717103454.62750-1-gatlavishweshwarreddy26@gmail.com>
	<aloHDhoerEhIXxFA@pks.im>
Importance: high
Date: Fri, 17 Jul 2026 08:25:59 -0700
Message-ID: <xmqqse5h63js.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Hi Gatla,
>
> On Fri, Jul 17, 2026 at 04:04:54PM +0530, Gatla Vishweshwar Reddy wrote:
>> Hi Patrick,
>> 
>> I am a real person. I used AI help for structuring reply in that thread. I understand that is not
>> appropriate here and will write my own from now on.
>
> Okay. Using AI is fine to help you out, but the human-focussed bits
> should really rather be written in a way that it feels like we're
> talking to a human. We're a community here, and when you see text that
> is so obviously written by an AI it can get very frustrating eventually.
>
> We've seen a strong uptick in threads that are obviously AI generated,
> only, and at times it just feels like one is merely talking to a prompt.
> This just doesn't scale well, as it leads to constant iterations and
> back and forth without much thinking being involved. So we require the
> other side to stop every once in a while and invest the necessary time,
> too. Otherwise the community will simply stop working, and that doesn't
> serve anyone well.
>
> Sorry if I came across as harsh.

Thanks for saying this.

When viewed in that light, what the v7 patch does is extremely
incoherent.  It gives the impression of having been generated by an
automated assistant and sent without human oversight, or perhaps
drafted in a state of severe late-night exhaustion.  For instance,
the commit message claims to have lifted 'max_revs' completely, yet
the proposed documentation updates still reference a hard limit of
64.  It also removes the local definition of 'UNINTERESTING', even
though the comment immediately above it still advises our future
selves to migrate to the shared definition eventually.

It appears the automation was not used merely for structuring the
reply; the changes in the patch itself show signs of having been
generated and sent out without any human oversight X-<.
