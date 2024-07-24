Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD0314B978
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840172; cv=none; b=NijS03VuufvtQ8l8EKzvjhx2+I2jB//ojMiSMUqCihGvhbLX71nYO1hKEObTx4J0VL9quEi+9acceOT/qRHAxg8NUUanOEd3AOlrMngtnUUiEApGofALbfCD+n30Pcyw+Cd421gQGrzGtSw9lA497keUsWu2Kv7ER4v/lGME6xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840172; c=relaxed/simple;
	bh=mrryHPYxxMdiOJTN5LWaZcvbb+ToQNX2Rgku9hscAS0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vz7gWIikk9SfBU3P7U5OMcl5BSPyZMrxBNpv61N6DYGWmxgicUtWNAkxKUQQ+D0oakLjX46bY0TnsU1sI9/yFvPrlZXklXoXzHOdPgunEUAf2O+9luobpwVwsdYtmmtBuIue6qpetu/BgQ6i8n/T+VgG9QH02nI0FOjyO6Laha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=H1nfAi/4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="H1nfAi/4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75A3B193FA;
	Wed, 24 Jul 2024 12:56:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=mrryHPYxxMdiOJTN5LWaZcvbb+ToQNX2Rgku9h
	scAS0=; b=H1nfAi/4QSN8lKI5hlC7WCQOLHvTvWIy/XA21CCpYmBxz27M91HSiE
	BuBW0t8o4LGSIfLPYBrk8rBgdbGBLsXi6+PPsbi7J0US9lxE5P5O4OvCJTu/LQa8
	s011zFIgcRn4R8nImNVklKPo080ktKwsjI+EVBnRusVd54fCt7gxI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 65A18193F9;
	Wed, 24 Jul 2024 12:56:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 55AF9193F7;
	Wed, 24 Jul 2024 12:56:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] Documentation: document naming schema for
 struct-related functions
In-Reply-To: <xmqqikwuwx7j.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	24 Jul 2024 09:50:40 -0700")
References: <cover.1721818488.git.ps@pks.im>
	<7f07bf1f3beee2f74a3572d2b9a8d28b6535053e.1721818488.git.ps@pks.im>
	<xmqqikwuwx7j.fsf@gitster.g>
Date: Wed, 24 Jul 2024 09:56:02 -0700
Message-ID: <xmqq8qxqwwyl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 9C7B2A5A-49DD-11EF-A063-34EEED2EC81B-77302942!pb-smtp1.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> + - Functions that operate on a specific structure and which are used by
>> +   other subsystems shall be named after the structure.
> ...
>> + The function
>> +   name should start with the name of the structure followed by a verb.
>> +   E.g.
>> +
>> +	struct strbuf;
>> +
>> +	void strbuf_add(struct strbuf *buf, ...);
>> + ...
>> +	void strbuf_reset(struct strbuf *buf);

Another thing we may want to say about these "The primary data
structure subsystem 'S' deals with is called 'struct S' and the
functions that operate on 'struct S' are named S_<verb>()" theme is
that the convention for S_<verb>() functions is to have the operand,
which is always 'struct S *', of the verb as the first parameter.
