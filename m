Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20FB2AE99
	for <git@vger.kernel.org>; Tue,  6 Aug 2024 15:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722958542; cv=none; b=EmfTHNXOEnr7gRsBUrZ7Gihw4bsEvsN98LySVcAACFzBxVY5edxYSLfpT8ptLWCRrGZQ1wX94vqibg4jfDj18w5bFb0VOTGm78oMcXsqu7NsA+8BSzQNwWxOI+dfgGPSilCJpy/9OMuBtpuh8+K8vUpB75oBVqGtt5gTdig7XLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722958542; c=relaxed/simple;
	bh=TFNfDYELTPliyLw8RPFPFbKqTHnMQ2gmSFHq6Xf0AXs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s51gyHsvqT5m6klVwtw5bIiDLwJRATN4O1FaPg4awrXsekq4lg63N6+mSRUtIZPRXapXGko09zoN9+/LoeMjegADlay1CdzA9ZgCqzKlF14Ilox4yGcXRLYSMkFK4v9Ka+h2EIADdb5g3UhwC26WA67CgyWdYKMfm1zEbsEELtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=hmymKl5T; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hmymKl5T"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A57892E5DF;
	Tue,  6 Aug 2024 11:35:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=TFNfDYELTPliyLw8RPFPFbKqTHnMQ2gmSFHq6X
	f0AXs=; b=hmymKl5TLWZE2g3bohub5xlQf4WZqKUQ9d5r+03OqT7G9+w2Ad7LEV
	TkZ4NZQc2MSJ4l7TwLcliGltHbCP5gbL1K4e8FlOZnH+9Z1yBB8W9fLNTRVZJ/Lk
	0O8nuLZweFSdJh23TLxUqq0zFqVwZBJcYBNf7hT/J7XEc3uPQEfnU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CDDE2E5DE;
	Tue,  6 Aug 2024 11:35:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1007F2E5DD;
	Tue,  6 Aug 2024 11:35:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Chandra Pratap <chandrapratap3519@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [GSoC][PATCH v7 0/5] t: port reftable/tree_test.c to the unit
 testing framework
In-Reply-To: <ZrHDB1-yTv_gD1Mx@tanuki> (Patrick Steinhardt's message of "Tue,
	6 Aug 2024 08:30:31 +0200")
References: <20240802121318.4583-1-chandrapratap3519@gmail.com>
	<20240804141105.4268-1-chandrapratap3519@gmail.com>
	<ZrCx0NWRbFOOReki@tanuki> <xmqqr0b33r16.fsf@gitster.g>
	<ZrHDB1-yTv_gD1Mx@tanuki>
Date: Tue, 06 Aug 2024 08:35:32 -0700
Message-ID: <xmqqplqlzmt7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 855F33F8-5409-11EF-915F-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Oh, yes. I didn't mean to say that I relied on your feedback being
> addressed exclusively. I already reviewed v5/v6 of this patch series and
> found it to be good, and given that there was only a single change
> proposed by you that I'm happy with it translates into me being in favor
> of v7, as well.

Yes, after sending the message you are responding to, I went back to
the original thread and figured that much---the topic is marked for
'next'.

Thanks for your help.
