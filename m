Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C6146BF
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 19:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722023326; cv=none; b=CoVUNAJ4JgmeC1/E+VQRTzYhnVZpV+PYDGi9QoIDoFr6o1O8826ob6SxNZkWK7Bn2drNr0HK9VVnjdwPLhVQQxRY3BI3fyA/RJQd4KfZgEAK4850xDxlejr68UGIy1rFOAeVISQInVBMxmolVCxXjVIHxmsimJG2Iqr/SD5PcLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722023326; c=relaxed/simple;
	bh=Z2aD26aORFZsmEc8bKDjsLNphB4NJYNHwHFrDF5XJrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e8sGAXWQkyt3Q8Qu7N/gFpiQxbkpolCZw1lLm1lvvUzn0IfXrQ6w8lud2o9KW0c8m/m1WiHAoo5beRupK5xwrSzg/qJxI9L69CJv0lD5y6tHtqcwJm5o1/uc1ubfzVXMzHI5tGpAMMpqps195xzeRaFKfCpzWOoSJkes3ABkBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VXMNE6qB; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXMNE6qB"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 272212862F;
	Fri, 26 Jul 2024 15:48:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Z2aD26aORFZs
	mEc8bKDjsLNphB4NJYNHwHFrDF5XJrA=; b=VXMNE6qBLKXYbuIuymRGnLmK9d7E
	RJjyFEreqvntOhyMCCFVNxp4SxN3A0gN4fi8h9X5d38coKUuuL6Ljm+ULEonZc31
	18OOWRUny1n8dldqUp/GVQl3jLMCt4lg0ygoOYueLzU5QcYy9S+2hQTtiH/fJM58
	FhPOYxSCjd7an1s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F66B2862E;
	Fri, 26 Jul 2024 15:48:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 75AEE2862C;
	Fri, 26 Jul 2024 15:48:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: phillip.wood@dunelm.org.uk,  Git List <git@vger.kernel.org>
Subject: Re: Re* [PATCH v2 0/2] add-p P fixups
In-Reply-To: <1dc4cb5d-966a-402f-a880-42280750b949@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Fri, 26 Jul 2024 21:22:15 +0200")
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
Date: Fri, 26 Jul 2024 12:48:34 -0700
Message-ID: <xmqqle1oszn1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 0C40D1CC-4B88-11EF-A039-92D9AF168FA5-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I thought it wasn't necessary to modify the first two, which remain
> correct, and I didn't want to bring them up again.  Additionally,
> keeping the dates of the first two different from the two modified here
> could be interesting.

Then at least you should have said so.  From the receiving end, that
and retracting the first two would look the same, so there needs to
be some clue to let the receiver tell which one is the case.

Thanks.
