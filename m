Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BF31FA4
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 23:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PT4jUAYa"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E899713E
	for <git@vger.kernel.org>; Thu,  2 Nov 2023 16:21:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B0931A56F9;
	Thu,  2 Nov 2023 19:21:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=dlq9XjSpY1O9c01d1zV51iDNW9q/GcZ0+2m065
	FFpjY=; b=PT4jUAYaFL252GaXgGtmERYtoIFEhEKW/mQsEfI7ViaP1pXXUwlkUH
	V4xRQqgGf7AYQpCydGpeVTb0MEVspQQ1ducCnBWGkq5AqsBIxrefjyJUxE65I/II
	3MVPK7m/pT+L+TeJ3xfskvLeBqcY1umaV5tIUJyq0hfau53lXD+VI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F8BB1A56F8;
	Thu,  2 Nov 2023 19:21:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.16.143.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 76D671A56F7;
	Thu,  2 Nov 2023 19:21:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Robin Dos Anjos <robin_1997@hotmail.fr>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: General question about "git range-diff"
In-Reply-To: <PR3P195MB087847E68AD2032148EFCA039BA6A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
	(Robin Dos Anjos's message of "Thu, 2 Nov 2023 18:56:39 +0000")
References: <PR3P195MB087847E68AD2032148EFCA039BA6A@PR3P195MB0878.EURP195.PROD.OUTLOOK.COM>
Date: Fri, 03 Nov 2023 08:21:13 +0900
Message-ID: <xmqqbkcblp1y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 84536578-79D6-11EE-9D8E-25B3960A682E-77302942!pb-smtp2.pobox.com

Robin Dos Anjos <robin_1997@hotmail.fr> writes:

> There are several workarounds to this situation.

It would be much better to avoid getting into a problematic
situation in the first place than having to come up with a
workaround for such a situation.

"git imerge" may be a good tool to know about for that.  You may be
able to avoid having to say: "Gaahh, I am not patient enough to
rebase this series of commits, even though I spent time to carefully
separate into logical and independent steps.  I'll squash them all
into one large blob of changes, even though it means I will lose all
that work."

An "interdiff" that compares the base and the tip of the old and the
new iterations is certainly a way to compare the changes as a whole,
in exchange for loss of the diff between the log messages and other
commit metadata.  Adding such a mode to the "range-diff" command
might not be a bad idea.



