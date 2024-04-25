Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7E8155A2B
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 21:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714081742; cv=none; b=iFdcUQpTmg+wS1wFtopyv/2N7oGGk0Kx4YWI6gtqfCZrQ0Lx4NiOMN1lMvmYwzKV5Ld8ZvTdqNHx2Nla8yVCA/mk4OTAEcxPdBBjcctHV2VFI/swtxRDEioXpVVsjOZNklecEknLr9H5zdaVWOIQb7UnYfkVaF6P6ZB2/+421go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714081742; c=relaxed/simple;
	bh=RbhADyB99VaVrSxwc6cFBFAMSUhQEkQEQaRmRorz924=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bZltWyepl/P4RWM14GzZ8qERfLaZIMdvnvBQVEmqSzWwxnLx/UnpqkHxV2fyvxOnmP7DyIbO4RGkuTOJNdroXgS49bwpqfsE0VqGvrqSVfsUgSDoptCCFOtzaA3frxa1glM+MfEvrE4etVPAvPyBzs2O8Rx9P6RrHTGqYP+KM/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NnBkD3d+; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NnBkD3d+"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1FD6F25971;
	Thu, 25 Apr 2024 17:49:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RbhADyB99VaVrSxwc6cFBFAMSUhQEkQEQaRmRo
	rz924=; b=NnBkD3d+TiVeccGmXbyh4wxAvckm+HSh5V0/C3xI27Ox1EJmv2yH9w
	hmLhdkCTLzTrSuC6Xw5teSUi6vb2QlVGgOngDZWSIPCqQSD8J6dmWFu5z6lhZe0x
	r1FRfDZ8NvIaMv+Wb+F7UQeaZeVogGZHH7z4mxyzLldKDSNPQRGls=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1872125970;
	Thu, 25 Apr 2024 17:49:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E00C2596C;
	Thu, 25 Apr 2024 17:48:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  Roland Hieber
 <rhi@pengutronix.de>,  Denton Liu <liu.denton@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] completion: add 'symbolic-ref'
In-Reply-To: <prwckjhoktcmdgl7637jekssonghcjcbsyuivwzq6w6eqvl7g5@nfumrglobhyl>
	(Justin Tobler's message of "Thu, 25 Apr 2024 16:40:15 -0500")
References: <20240425101845.708554-1-rhi@pengutronix.de>
	<4ea09a34-bd62-434e-b893-8e3780aa915f@app.fastmail.com>
	<mg33zswrxwxrlbzcvxyssxpqty5qxbezw43rwwnkepskne6fmh@3fypf2gskbyh>
	<xmqqh6fpgzs6.fsf@gitster.g>
	<prwckjhoktcmdgl7637jekssonghcjcbsyuivwzq6w6eqvl7g5@nfumrglobhyl>
Date: Thu, 25 Apr 2024 14:48:55 -0700
Message-ID: <xmqqjzkldsfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9E3DF8B2-034D-11EF-B8C9-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Justin Tobler <jltobler@gmail.com> writes:

>> We should improve the situation by probably moving[*] more from the
>> latter to SubmittingPatches so that people do not need to refer to
>> both just to find out the essentials.
>> 
>> 
>> [*] If it is small, just copy; if it is large, move and then replace
>>     the original with a reference into SubmittingPatches.
>> 
>
> I think this is a good idea. Submitted a patch that attempts to improve
> this.

Thanks.  Its details are a bit different from what I expected, but
this will work just fine in practice, I would think.

Will queue.
