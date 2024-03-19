Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B800D25778
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 17:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870187; cv=none; b=Ire2SVbLJyC6W8wrD4PamIJMk/d6GynYcjiYGJFMtBBxaa+QLcyE/rhO6I0Qb8XegWXd0xKbxjykhqGwuKd9oUBePsgc18dqb7nsb7BqOhAmDCNJ7UyZjcKr7idZuDpn8v+6uLleaiV5u+I6yHxzUvq+W4ZDgya7STGyxFSpyK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870187; c=relaxed/simple;
	bh=vI2hNL6OKE7bW84bihxJilBUWfmHKelf3ydLXZIh9pE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=riy3lpqsMKkJFhGrT6kFW/sS4kouMlivHqsBWGcXsx7INMuqKrfDcEtUZCw3/ooRPi1XCxCJdP5/1kpEjenBhPkbUUzhmZ7OLt7f9lXprpnNzUuEcBXiqgSS3ZB+x3eS/xw6pFTizXCt/JwqYnnSOIxdSzvbcJV1gnTcOms/vd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PopCjfKu; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PopCjfKu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5C23E28267;
	Tue, 19 Mar 2024 13:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=vI2hNL6OKE7bW84bihxJilBUWfmHKelf3ydLXZ
	Ih9pE=; b=PopCjfKuqn1SAfTLTC0oGEeLY1osWq3cQd8WeBerBChPqjVvXm7orj
	09tfl0APvUcGTBf5pZxqvIdCzxFVXPlEtThC57rlMPKmuJU9fwhTxlzlB3j6WfED
	oqrGCD97ty/rb4pAIs98k6VFknYy4aok8wYYo751Q22bJ+TBZBRh0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 32DA628266;
	Tue, 19 Mar 2024 13:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A12DF28264;
	Tue, 19 Mar 2024 13:43:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/5] New config option for git-grep to include untracked
 files
In-Reply-To: <c68a6d94bb02e5d9aa2f81bee022baa8@manjaro.org> (Dragan Simic's
	message of "Tue, 19 Mar 2024 06:09:34 +0100")
References: <cover.1710781235.git.dsimic@manjaro.org>
	<xmqqwmpzt6jk.fsf@gitster.g>
	<c68a6d94bb02e5d9aa2f81bee022baa8@manjaro.org>
Date: Tue, 19 Mar 2024 10:43:00 -0700
Message-ID: <xmqqcyrqqfrv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 21DC5EF0-E618-11EE-81DE-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> However, I think that the usability of this new configuration option
> outweighs the possible issues it could cause to some users.

"Screw others who share my preference and want to set this variable,
but use third-party tools and scripts that will get broken with this
change, because I do not use them" is what we try not to say around
here.

> For example, I quite often find myself in need to specify
> --untracked while running git-grep(1), to see what's found in the
> code changes I haven't staged yet, so I find this new
> configuration very useful.

The feature (not the command line option, but the behaviour that is
triggered by it) surely may be useful.  Otherwise we wouldn't have
added it.  As I already said, I often find myself doing "--cached".
But that does not make it a good idea to invent a new configuration
variable and set "grep.source=cached".
