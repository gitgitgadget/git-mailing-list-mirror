Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9732814EC72
	for <git@vger.kernel.org>; Thu, 16 May 2024 15:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715874795; cv=none; b=BKUdMEvjOXvcXfaab+7+/tzT8ftxXqOYDtd8mA3/FlB3hpzaVsjZHpSDe63VUU9Zd/ojD8GmaKHK8UyJfmECdsrqakRHtG1qDT6Lx8zctKm7yv0vyh3Wy4qHPa4hZLWO30CdaVvYm+HzDFJGzgFqfdd9A3awRLPIoXApNqZDsDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715874795; c=relaxed/simple;
	bh=1eMmjiw0hCaxHqqaE1hx5o1gFtEBJwn9AvIsvHDhRT8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BHMOTfHJDuyHZiHH/Y7boDIsoaRbzJkfXlg8dcrD+DAiRp4hGG/tWkyBf649HMQOCKc0wVd8oXxGcDoFZS1C01r3X4tzoOOeh1RsLMQ6m9AcWMauHtYPmn1czPkQfFLTqqA1MPZQFqB2lQX3AA3zR6K3G+Km7GAuJO3qdQDpYeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=t70Bj4xE; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="t70Bj4xE"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 24B72269A0;
	Thu, 16 May 2024 11:53:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1eMmjiw0hCaxHqqaE1hx5o1gFtEBJwn9AvIsvH
	DhRT8=; b=t70Bj4xE++bYedrMWmIDeifj8DpY9ITj3gfGEFgcOOLpqfwtOrBgU/
	jZW+zPkrBs/LFkH8CxX2lhNhj+5GS0w8czMidEAcQLj7TyJdbng02nF32mWcYmQT
	5EHYNjdWC3uiw/fUlAGesNo6MrAf36DdVs+oNQgZc/SXx7SqTPa0c=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1D7272699F;
	Thu, 16 May 2024 11:53:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89A5F2699E;
	Thu, 16 May 2024 11:53:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] completion: adapt git-config(1) to complete subcommands
In-Reply-To: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
	(Patrick Steinhardt's message of "Thu, 16 May 2024 06:56:54 +0200")
References: <e0039edb9b7dce1e33c4cb6e964c50281c815e97.1715835356.git.ps@pks.im>
Date: Thu, 16 May 2024 08:53:08 -0700
Message-ID: <xmqqv83dsqhn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 649FB546-139C-11EF-9096-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +	local subcommands="list get set unset rename-section remove-section edit"

Wouldn't "git config --git-completion-helper[-all]" work here?
