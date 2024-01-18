Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F383174D
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 22:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616886; cv=none; b=F2nJbLfYvfKUSyK+787msb5O+J+A95HJzwWlVrA9NCJKApdqzZq66+vGEt4UjHSAyxeD/3RlbIKYIBhAhTtPDBBPJowSGe+Xh8wDuz+BI8n5EOQhXHe6kmUymffRmDZiE4KIPZfPoYnB8cKx4UzC0gTBE5Yr6TsV4yUP3JkTHXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616886; c=relaxed/simple;
	bh=uOE+xrMoxwvRB1lk4gqbh2aE80VBwFJIsby1KMnZ1h4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tPeF7Y749ymwto7h1QpZVIzgZc7Zfqd6N22BtbN7nenul+demclBg0nTUCh0HaNHNp/ytvAuszDtbCJFdsCqbB/nkw9FiaB8X82kwK/cnRQgSjK6xkRq//3yP55Y74FiiiwxJUkEgybgjd/EKP1OYhMCNuZXKYkXlMWYsFbeIn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ol+XfB+M; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ol+XfB+M"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3045C1CD222;
	Thu, 18 Jan 2024 17:28:04 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=uOE+xrMoxwvRB1lk4gqbh2aE80VBwFJIsby1KM
	nZ1h4=; b=ol+XfB+MiEOnaIaJ3zPHD3zK/nVnPI2KHJ5c9Ib/+xOSUmG7oDfZm2
	1sMCV/YrEt23hPvnImBFG9wDCwhbBoq40nAPao4Jxm7+cam4GPY7EK6DBXHXV9/k
	JFQm8n8k5E9SnItR41SQOrrd4v2V9O7BurooIkJ9A7ETuKoYhJR1g=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 17DE31CD221;
	Thu, 18 Jan 2024 17:28:04 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B4A31CD21F;
	Thu, 18 Jan 2024 17:28:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Emily Shaffer <nasamuffin@google.com>,  Christian
 Couder <chriscool@tuxfamily.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH 02/10] trailer: include "trailer" term in API functions
In-Reply-To: <5f64718abfc2e61b4e259de700c137bc817fbb1c.1704869487.git.gitgitgadget@gmail.com>
	(Linus Arver via GitGitGadget's message of "Wed, 10 Jan 2024 06:51:18
	+0000")
References: <pull.1632.git.1704869487.gitgitgadget@gmail.com>
	<5f64718abfc2e61b4e259de700c137bc817fbb1c.1704869487.git.gitgitgadget@gmail.com>
Date: Thu, 18 Jan 2024 14:28:01 -0800
Message-ID: <xmqqfryup98u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D7E2CFA6-B650-11EE-A710-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> These functions are exposed to clients and so they should include
> "trailer" in their names for easier identification, just like all the
> other functions already exposed by trailer.h.

Oh, if you were to do this and code movement in two separate
patches, doing the rename before the move in the previous step would
have made much more sense.  If we stopped after 01/10, the tree
would have been a very sorry state.  If this came first, even if we
stop after these renaming of internal functions that are not extern,
nobody wil be hurt by these new and improved names.
