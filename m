Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5230E10FA
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 16:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953969; cv=none; b=OxMOrW0OBEOQryuL6eRzO8zzSAIpytznebbVGX1ad0X0VLzrHqK78qG39o5ZZVmjA4Z11W7SUeZlmhBz9A+eKzJi6y4YFe1AQ8arLsJyY470En3I2ptbjf76GByQA9ypet31/EKZG0GtpcR7hecf4gKT5/xuJ0EjeZD78jg/Wco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953969; c=relaxed/simple;
	bh=z0Q1vlXAdtw9vF/SU4qHS2vP3PcunH69ua+2AxfqXdk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YHYS4LPueLYkPIwumSiNY9rE9SJIn7TCjMPAbN4ChdLW2FFDrLb+M3kfhoRg+SQt24qL2CKFBpQhrUhsdvqv4E5kTvHL/Y5wMTbgENF99t+EU/76p9ZVFnqc4IOsLlyHa8zDDtoXXFml+WKbLA9YtnSXwzLwkJ0S1zOL1woFZWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VA8Yw2Bc; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VA8Yw2Bc"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C23E930C06;
	Wed, 20 Mar 2024 12:59:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=z0Q1vlXAdtw9vF/SU4qHS2vP3PcunH69ua+2Ax
	fqXdk=; b=VA8Yw2Bc4pKk8nJx3CQQ/3rDkrT1ODIQEgK21v/BWSVUYIUdejOY93
	69LEBK0n7WjjzgcafRP/5GybTbM58MJdK+7bXwyY3lAVLDBGZCLndImb4DcBsNmJ
	L/0qhr7uyKbmUeTrzi4DEJlRWRQzlQSaVbGOTJwBxmwAJ0F+/1Mb0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BC89F30C05;
	Wed, 20 Mar 2024 12:59:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4B71830C04;
	Wed, 20 Mar 2024 12:59:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] doc/gitremote-helpers: fix more missing single-quotes
In-Reply-To: <20240320091748.GA2444639@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 20 Mar 2024 05:17:48 -0400")
References: <20240320091748.GA2444639@coredump.intra.peff.net>
Date: Wed, 20 Mar 2024 09:59:16 -0700
Message-ID: <xmqqbk78hmaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 30A26BDC-E6DB-11EE-849F-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> There are a few cases left in gitremote-helpers.txt that are missing a
> closing quote, so you end up with:
>
>   'option deepen-since <timestamp>
>
> with a stray opening quote instead of rendering correctly in italics.
> These should have been part of 51d41dc243 (doc/gitremote-helpers: fix
> missing single-quote, 2024-03-07), but apparently my eyesight is not
> what it once was. Hopefully this is now all of them.

Thanks.

  $ git grep -e "^\(['][^']*['][^']*\)*['][^']*::" Documentation

does not have any more hits after this patch.
