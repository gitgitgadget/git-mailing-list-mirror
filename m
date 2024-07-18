Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E61013C3E6
	for <git@vger.kernel.org>; Thu, 18 Jul 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721318692; cv=none; b=aCGdDObOILwiFaaRtM0EimXmbj2qv/8koGrPJlIG5W2VLlg2yLWCjfzJK8JJ0kqBGc8fsJFDEniBjAP+ZEddv8Y47UjdOcUmgvDaUO5YDLnV/4rG3//acSCa3B1sJDawVQg6WwbKo/c5sN2DACciFTZGaXcZMxGtffoiy9o59tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721318692; c=relaxed/simple;
	bh=xBz4AT9skM6o0wuHVJnmo52t+iHkAPKjDoj15BC16XM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nn425NKb7eRBODpeQNyXOrW4DV/5KkQuPGt0tqcXZSbSl8Bm2tTPtwJ6QfN0VJ8lQId/LF/Xxf7fdaM9cie9aJH8xz0Uxo2ZjKxuGBZcOhFnzm0miNUICr7Kj18PisTSaTWcis2VONdmg4YN5hj1/Z1kol/XbUtglDH3aJs6qak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rWA1O+VM; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rWA1O+VM"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E66A22C21;
	Thu, 18 Jul 2024 12:04:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=xBz4AT9skM6o0wuHVJnmo52t+iHkAPKjDoj15B
	C16XM=; b=rWA1O+VMa7TkdTxdteYhWfLCtwMja3vHNGWVu6WCnvad0n1T/LcJJt
	UywLnNVrJ3QyDgReTwyXQb90cbaJA98OOQHKnDpX0XIXWAB2gxedxo62wmaU5Ukg
	PbW/WV5auTBFJMQFfxU2cy/5rlaiLo4ja+J54p5hTSCUtWHU+DKho=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 132AB22C1E;
	Thu, 18 Jul 2024 12:04:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 682A222C1B;
	Thu, 18 Jul 2024 12:04:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 4/6] ci: run style check on GitHub and GitLab
In-Reply-To: <xmqqmsmeycj7.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	18 Jul 2024 07:56:12 -0700")
References: <20240715093047.49321-1-karthik.188@gmail.com>
	<20240718081605.452366-1-karthik.188@gmail.com>
	<20240718081605.452366-5-karthik.188@gmail.com>
	<xmqqmsmeycj7.fsf@gitster.g>
Date: Thu, 18 Jul 2024 09:04:48 -0700
Message-ID: <xmqqmsmewusf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75CD5A44-451F-11EF-911F-BAC1940A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
> ...
>> +      R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA?}}
>> +
>> +      if test -z "$R"
>> +      then
>> +        echo "CI_MERGE_REQUEST_DIFF_BASE_SHA should always exist!"
>> +        exit 1
>> +      fi
>
> If you update the assignment to R to
>
>     R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}}
>
> an unset CI_MERGE_REQUEST_DIFF_BASE_SHA1 or an empty value in it
> will be rejected there.  Then you can lose the if/then/fi here.

Actually, you also need to pay attention to the exit status of the
assignment, i.e.

    R=${CI_MERGE_REQUEST_TARGET_BRANCH_SHA-${CI_MERGE_REQUEST_DIFF_BASE_SHA:?}} ||
    exit

