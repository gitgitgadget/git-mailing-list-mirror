Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB713CABC
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 23:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727220203; cv=none; b=nK+HTXFiU9PCA+nDTcu8+2rNcJHgwRItFTiBTE+EsVkz11CSLX0OkcsvuaiIhs5TjULzfi+oivgXzQbGm3gYCL1/qWqg2GV0PIZ2K3vpxsYCZmyhkD0WvyPriBRwAqbzZGs6vcHfvPfZDR0LIUAER48MwlVUuCO167mhIbOB010=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727220203; c=relaxed/simple;
	bh=3ODmqbj8o29T+c/80jlHr6duGmGV+4k/r+v15lbchPA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qB4ovrTNs630VM1xFLOCi2jgeUZjeYXO0eOVBhDcPjDPPo/aE8TZkr+FDENQIAFdYYuSIn//bCQXsobOkbHJ3Bt9ZDjOgx8cgg/pWvZU7OR2OvmM4WXINdM7siOCaU1abs2PS15egHAFuGoN/ArDinonUxNBchLDMcMbcsVh/sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ODqYze++; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ODqYze++"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C9A5D1F82F;
	Tue, 24 Sep 2024 19:23:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3ODmqbj8o29T+c/80jlHr6duGmGV+4k/r+v15l
	bchPA=; b=ODqYze++dDgve5w8Z9GUoqcj/6BBDr6fQpb2eS0i+BecAyK1oBFcgF
	7BvMfRQLOinGZn0IAFVaFU8uFGpPmMzM31zG9ed/wylbbS6DI8JlyVs4ilf16urq
	0t6YD0frPm5w0k6fjxzU0quXXKTQm0baO7F6c05GbcivwvsXKFry0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C0FF21F82E;
	Tue, 24 Sep 2024 19:23:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 390D31F82D;
	Tue, 24 Sep 2024 19:23:20 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH] send-email: document --mailmap and associated
 configuration
In-Reply-To: <CO1PR11MB5089016E24E7142587E3478DD6682@CO1PR11MB5089.namprd11.prod.outlook.com>
	(Jacob E. Keller's message of "Tue, 24 Sep 2024 23:15:33 +0000")
References: <20240923222429.4102405-1-jacob.e.keller@intel.com>
	<xmqqr098rap4.fsf@gitster.g> <xmqqmsjwraj3.fsf@gitster.g>
	<CO1PR11MB5089016E24E7142587E3478DD6682@CO1PR11MB5089.namprd11.prod.outlook.com>
Date: Tue, 24 Sep 2024 16:23:18 -0700
Message-ID: <xmqqikukr5zt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 FC5A3B5E-7ACB-11EF-A5F0-9B0F950A682E-77302942!pb-smtp2.pobox.com

"Keller, Jacob E" <jacob.e.keller@intel.com> writes:

>> -----Original Message-----
>> From: Junio C Hamano <gitster@pobox.com>
>> Sent: Tuesday, September 24, 2024 2:45 PM
>> To: Keller, Jacob E <jacob.e.keller@intel.com>
>> Cc: git@vger.kernel.org; Jacob Keller <jacob.keller@gmail.com>
>> Subject: Re: [PATCH] send-email: document --mailmap and associated
>> configuration
>> 
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Jacob Keller <jacob.e.keller@intel.com> writes:
>> >
>> >> +sendemail.mailmap.blob::
>> >> +	Like `sendemail.mailmap.file`, but consider the value as a reference
>> >> +	to a blob in the repository. Entries in `sendemail.mailmap.file`
>> >> +	take precedence over entries here. See linkgit:git-mailmap[1].
>> >
>> > No such documentation page git-mailmap[1] exists, hence this breaks
>> > "make check-docs".
>> 
>> IOW linkgit:git-mailmap[1] -> linkgit:gitmailmap[5] everywhere.  I
>> did that while requeuing and reintegrating 'seen' for today's
>> pushout, so unless there are other things to be updated, no need to
>> resend.
>> 
>> Thanks.
>
> Ah, yes. Thanks for fixing!

Thanks for updating the documentation.
