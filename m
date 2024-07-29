Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8E674420
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278757; cv=none; b=nnqSPjfz5oNyHvIpgFDL/3Mal2K0VHUu4qzteYJiG5i033++M66vulSbc+/VhHIll7goakXe418CEezroaxdbkVj6jwOo5S1Tr6R27brpZ80necFmE451f5ZL874kijXq1DYNxuFfqHSZ1+67kaWtSe1P46kWKfA+7UQMTDivOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278757; c=relaxed/simple;
	bh=jWLtWU/aJ0A+Kpzp2ZSPQsx1KYbXOyy2UdqepRXS0ag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IDF9eu1yhbTx80x8HBh47DqaZkQNidqrfOAJbUclzFgFHStnK0JLki9aPbuM4X9ZG2W1/4GWfafl/5gfjGo00tVMSUES4Qwj+ABEfhZgb2kG9vpnJg9hy1xGzfdUnZQ8tk0grZ9ivzKrROxC3JG2w7wFEqip7bZo6ldQwT0+/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XsHyN/6X; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XsHyN/6X"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C16B02499A;
	Mon, 29 Jul 2024 14:45:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jWLtWU/aJ0A+
	Kpzp2ZSPQsx1KYbXOyy2UdqepRXS0ag=; b=XsHyN/6XrgA1tdl/jgAcjFRGTE7x
	Ze1+NhO+36quxyvoVn50DBEKnejw2kV5Duo6CQRX9KAgCa+s4MEpa44RpXaMsbSX
	DgjGt+IxC5tFxW0PXMNk8RP2e5GQwqDTWDTMy985nd/k/abWh8+Y0uSNfRo1dd7t
	JVi6uV3ucoP38cA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B75EB24999;
	Mon, 29 Jul 2024 14:45:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1F10824998;
	Mon, 29 Jul 2024 14:45:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>
Subject: Re: Re* [PATCH v2 0/2] add-p P fixups
In-Reply-To: <9e9bbff4-e2e1-4867-8f17-ebc366c7bec5@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Sun, 28 Jul 2024 11:11:27 +0200")
References: <7c9ec43d-f52f-49b7-b1f3-fe3c85554006@gmail.com>
	<62af789f-ca19-4f11-9339-a97400f7e70c@gmail.com>
	<2333cb14-f020-451c-ad14-3f30edd152ec@gmail.com>
	<5735bee3-0532-4894-b717-12a0bdcb9e84@gmail.com>
	<a25c37e2-fcfd-4a4c-890b-a85039ccef12@gmail.com>
	<97902c27-63c9-4537-8ebe-853ef0cb1d3b@gmail.com>
	<xmqqcyn1lcjo.fsf@gitster.g>
	<24e83a0f-b0c8-4cd5-b321-1d7702b844ce@gmail.com>
	<xmqqsevwui31.fsf@gitster.g>
	<1dc4cb5d-966a-402f-a880-42280750b949@gmail.com>
	<xmqqle1oszn1.fsf@gitster.g>
	<9f4c596b-cd6c-4f0c-bed4-dd6febb5e697@gmail.com>
	<9e9bbff4-e2e1-4867-8f17-ebc366c7bec5@gmail.com>
Date: Mon, 29 Jul 2024 11:45:52 -0700
Message-ID: <xmqqed7chw9r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C8F4001A-4DDA-11EF-B5AE-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> After re-reading the series today, I still believe the change in the
> message for [2/2] or rebasing on 506f457e48, add value to the series,
> but I also see that it's not a significant improvement.  Besides that
> minor detail, IMHO, I think we have consensus on the changes.

I think we have established that the "Don't attempt a one-shot
export with shell functions---it would not work" is not all that
important to stress on *in* *the* *context* *of* *this* *series*.

After all, that is why the latest shape of the series is not to do
the "keep the already known to be bad commit, followed by a fix-up
to illustrate exactly why the first one breaks" pattern, which is
designed to help future developers when the breakage is rather
subtle and we all miss in our initial reviews, but is rather unusual
for a topic that hasn't hit 'next' yet.  Instead we just correct our
mistakes and pretend as if we just got straight to the right
solution.

So, let's just use what we already have queued, without details that
are irrelevant for the final shape of the history that did not have
such a screw-up in the code.  The "Don't attempt a one-shot export
with shell functions" message, as you said, is already captured in a
more relevant place to help developers.  We could expand that part
in the documentation patch, or even a new documentation patch, but
this topic, and especially its test part, is about ensuring that the
pager support added here will correctly deals with a stuck pipe, and
no developers who hit this commit either by browsing "git log" or by
finding it in "git blame" would be seeking an advice on "one-shot
export", as that is not a mistake this series _did_ _not_ commit, at
least to them.

