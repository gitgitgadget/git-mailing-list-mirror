Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FE3CD8D7
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 22:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892984; cv=none; b=ctMVcb4y/cEu07bX1B7d7NvWNKhAUFlbdp50ht83uELlfFLQc3fv/e+8EWyjrSJT1FUIX+EL5z81kYsnYaaRpxbli5wj3Xz7I3AzM2JEK16Zp6bJyvWyxBV3U1LQM6RR9+cSBMzJLs0ulw3AM7kx2gzBdvrVUlZt63pDExpKKQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892984; c=relaxed/simple;
	bh=Iv0krZCDwvebv5XQS7QUMa3LDLbHdF0SEDJPrurlUjs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=et3uu/J6OFpKCzCmF9QgM4VNNZ112SAzYESnw4SwG8fJgKP8T+f8XTZ1tAB5WCCkE/7B96yn2N+WPu+NQBFbxR2WxQIH/drrq4IxavaNJsVnL6GliW1yxg31zYfmdYj3iyV+McgPt77yvPAgMkk1ZlqD3k9ZzgMfyPSW+Szqxmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s7UM/YTi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YEr/rbqp; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s7UM/YTi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YEr/rbqp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 231381400120
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 18:16:19 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 18:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790892979;
	 x=1790979379; bh=Iv0krZCDwvebv5XQS7QUMa3LDLbHdF0SEDJPrurlUjs=; b=
	s7UM/YTip8d0pnmYnPePy5oKCidXjDaw5FLH5pCpym0QFI/ZSAdIjHFXt1D6qwKO
	sPVGJwqaW5QPLsxlGUdoIADUOU/SF0j3oPlLdcHF/dQZt5AVp3wlDLze+hVi3aRj
	Xv0wG2O7kyYHzqD9KBQp6qwEJs7JJakcdR9iMR7VLKcODGC+guDtJIw+9w7qVqcK
	Aj41QwylT2goRLsrgM55qvFKe+u+db8JU1IIiG3R+uDVysWecwIaIQyBQNoHzX0+
	XEzZZYOrWLEobDqzSvRk5arnrJhn96wVuvQqCk66CqMPP+5TduvyIZT0Af+ZSdCx
	sb9SMfEy+6bqlXGeGlbRuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790892979; x=
	1790979379; bh=Iv0krZCDwvebv5XQS7QUMa3LDLbHdF0SEDJPrurlUjs=; b=Y
	Er/rbqpQJcDwOlkhChu5ZpGfLbgLkxoKezAHXw7cRkjfJXKXnfJKYRWua6tPydx/
	7gaWzUePY7ZCyc60dpLjFN5RPvXxiCobBBA1cuhCMoLWtwfW9hVMx6isnerpODHI
	WK/2x7Bk0bbIGsDrLvOGQeiZJpppt5JGraV6PHKbHBZJyXOkYbYKTOEJCneMDA7N
	p6dy5xOQ6OaOVdCECHgrJJ9roWZfdZ3AMNnAevM955ww25f40XpuaLi8NUHOnSa7
	5uf/nUoIb5IvoUTd3BbYhKffE5CP5dBnuHfNfrdjvUBF6y7Est40Z2NnU/RXZiNJ
	GoNBySqFKIPJsXqHGVZaQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790892979; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:nEHTPlp2M16kRDbks8jhr1qrT0vga1apsZ+sdarnUNI7Vrr
	7s0XhYkXXWrTqbzsL3g6FifyHDXWI25SGrX9OlF4Y6wd8hEHVLVe5Mq/UZBYbizU
	/oysA8C84CjO/v/RFy2bAR8KnNyLLlZnhtt4d3c7O4tv8RuagYNW9uVvcRJhMRWk
	EdfjRjj7UwTcKOOmYdrzUy2iqfpjxEMtWjkESx0jFhl2aN9/YbhDOsccsxLqsjfc
	eFHIlUm84f/fjz9ZtsMhZz/3d7LEkuO46/tzwrqVQNB3Knh9nsGw/i0Y/3p3FhUt
	+rmife5nfW2JEbF2DlEB9gCfoYKP5HYppxUpDBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=13;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to,
	user-agent;
Message-Instance: m=1; h=sha256:7k60M0ZNb7BfJ29TxA/emnBFhiV6Dqjs1AuerWdcavA=:Iv0krZCDwvebv5XQS7QUMa3LDLbHdF0SEDJPrurlUjs=;
X-ME-Sender: <xms:s9u-avy6jcYoXe_5tXphC0Q9KvNXW3IhGw8SjGuNjtA_kg9sK-5AdA>
    <xme:s9u-auTF1StLlvqlL258nt7fbUzBLi6T3-1Sn9TGvkFmwj-7DK0GwsSLJBfPxPLrh
    _G03Y7sjkZh6GZJYY0KLFmRzjm5RX74O-pWa3dmS1n244410VpNTCM>
X-ME-Received: <xmr:s9u-auUn6k3Ey96rXq0zx6vub2isfvUbdRYl3RpTDJdVPugABJStedmQ7B_mhjFz78Nn-wO61Abaq8DSritrDI3jl70u5N4xpqNL>
X-ME-Proxy-Cause: dmFkZTFIc89kiBMDQTLqibmuRfXT1sMmx0U2H4czKXysJ6O1FJlFBb6TH1csmaVJjf/89r
    /TPIqMEKGu/9C29RFzRyloGy7Ap9sfDYyrJ1orL8BiqjXrMKFFxIgFmgNidnG92feSvE59
    ndwJt067Ezi9Zlbh7W6o99dTpJPgQ1QITCAEOOG09MXPA0pjYfwvDB+9EezfSfw4SDTFyf
    6pKJdEfrnR2ZX4IEdfcnn9kwE1SDduxXUAbC3IfHoN8QWXvaVr4Dxbf5PJHqj4jeINJ6/i
    Wh1Sz61DDkfz8Zg9TSUp/kDaUTp2eISIj7G6ATjKGVbZqRnvVEpnpGO+aDgl/LiWJzaUgO
    SppwW6huiwDNkQImX1BGF4aDbcb9cMapt2yUlT9214gQCeTqYx4q6xKiIr4kmTLKTFTfuR
    Tb4mC0QIu0gRlSjuNx0SjhwjrQ8Uy7kd9oKQ/ZPEbyB7ZjXCf0+W0lkKTrLVuv+c7CYtiw
    61r7e1qJMRLhTLCpkCzZnWi9uOxDynCVIk6Qvecxu8b7UzfA4DpyqFvzdZCDrja6Jm/pjF
    c7tCCkeXNg4Q/yk2nPz4R+ek0nCBwTPv1bOelaBz+8+Icb6kVxc1ze3TsF9lbFF0YIjD7s
    bzea5HMBjCNPtaFaVwNMANspnlOi4ivWb5I8Qg28cOZp0BFkBLckGjC3W/Jg
X-ME-Proxy: <xmx:s9u-aobIxsLm0yP2UI3c-N2lDILQx4l7ovxV9Ag3sMvllE-Cs7l-eA>
    <xmx:s9u-as36lEMBeQ83DBMUIX9PMA4R5Jhl3g4A2eH5QvH4rslmFQ8Agw>
    <xmx:s9u-aihFVemCUytVa_563Ku3J9ZpMA3AXzrFAccPOsdxJ1Dggzer8A>
    <xmx:s9u-aoZ1O-6wXRlxS-bss6ESxQJSDhrrydyPuuPBHkpIf0LChBYDQA>
    <xmx:s9u-al0-06ImdB_8RL3YW9xUDnVcwMJog3TMRbqrWHDE4Lp_uoXhHDxQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 18:16:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Hanan Arshad <hananarshad619@gmail.com>,  git@vger.kernel.org
Subject: Re: [RFC] git stash: add porcelain for sharing stashes through remotes
In-Reply-To: <CALnO6CBL552Ny8-cqo9EE0uy6j-TMszJFRrRuTOFC=nRJEv5qw@mail.gmail.com>
	(D. Ben Knoble's message of "Thu, 1 Oct 2026 18:02:39 -0400")
References: <20261001085330.73586-1-hananarshad619@gmail.com>
	<CALnO6CBL552Ny8-cqo9EE0uy6j-TMszJFRrRuTOFC=nRJEv5qw@mail.gmail.com>
Date: Thu, 01 Oct 2026 15:16:17 -0700
Message-ID: <xmqqzewx2hji.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Oct 1, 2026 at 5:37 AM Hanan Arshad <hananarshad619@gmail.com> wrote:
>>
>> Hi,
>
> Hi Hanan, did you mean to send a copy of your prior thread
> (https://lore.kernel.org/git/CAKPibBw2XxjGpE_DZrWLZmMHs7kAyvOaP8504kfoh61c4UkGyg@mail.gmail.com/)
> ?

Perhaps they sent a wrong message after they composed a message to
respond to the excellent idea-review made by Brian?
