Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E0B134BD
	for <git@vger.kernel.org>; Tue,  5 Mar 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709675924; cv=none; b=g3EmJeQMqHqsJyvleNzoBbJjwrviTtEtVtKNszKvSO8I+Ox0rtvwRMRT5mF7jk9DwK68a4SuhNL2p0990rPbQwgPGH1Luvy1siQtMIa3aiHIQ+Xx/yQ+gk4KJWCg13yVs/V1B9NQJLWcUyFDIvE197eClKwhrzM8PSMWfN3jsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709675924; c=relaxed/simple;
	bh=W2FRJWPvFleuPrWhqx6Ggd8B90U5DRnE2+qcQfzmeRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASsDb7PgzcdENUxkJteUQcqEK6GcW7pm+vSO026cQ9CqvkseJotIqlGKvzp/Ccgpaon7Pi3VccSQ/4lWjgQVVm0QqpbymKzdgjMtAnVnP2bSm9aaq6ZkaPVLHP8cLmSe035UFTN45+aMEjWgG8EEDSjDklXAjeztIyhYfSnGguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ni+5qp3I; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ni+5qp3I"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B0FDA1DC15D;
	Tue,  5 Mar 2024 16:58:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=W2FRJWPvFleuPrWhqx6Ggd8B90U5DRnE2+qcQf
	zmeRs=; b=ni+5qp3ITpYSUKEyVlIDFGZCv5p7FnixsozsSqZGfKsVZu9L5XUi5C
	kseRrx+L1jdGc8GpIUCNlttkf919AAzjYqA6enGslyWH3xqgEgPBaxz4JTK8E5av
	zXEPSlrAW6cndOc0CfJbMH/ZWAtgvNrf6FVAv8cp7mjXarEtHa1I0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A951F1DC15C;
	Tue,  5 Mar 2024 16:58:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B51D1DC15B;
	Tue,  5 Mar 2024 16:58:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Britton Kerin <britton.kerin@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] completion: don't complete revs when
 --no-format-patch
In-Reply-To: <CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
	(Britton Kerin's message of "Wed, 14 Feb 2024 11:49:08 -0900")
References: <9627364b-c0c9-4b85-a81a-ba1ef0735c9a@smtp-relay.sendinblue.com>
	<20240109010830.458775-1-britton.kerin@gmail.com>
	<a718b5ee-afb0-44bd-a299-3208fac43506@smtp-relay.sendinblue.com>
	<ZcSJaRczdHApmnVi@tanuki>
	<CAC4O8c88Z3ZqxH2VVaNPpEGB3moL5dJcg3cOWuLWwQ_hLrJMtA@mail.gmail.com>
Date: Tue, 05 Mar 2024 13:58:39 -0800
Message-ID: <xmqqfrx4z6gg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 871A6F56-DB3B-11EE-9B8F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Britton Kerin <britton.kerin@gmail.com> writes:

> On Wed, Feb 7, 2024 at 10:57 PM Patrick Steinhardt <ps@pks.im> wrote:
>> ...
>> Also, adding a test for git-send-email that exercises this new behaviour
>> would be very much welcome, too.
>
> I'll look this one over again and add some tests eventually.

Just pinging the thread to keep it visible in the list of recent
topics I need to keep an eye on.  No rush.

Thanks.
