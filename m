Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5F28E03
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wJT3a0Pp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 152E33350D;
	Thu,  4 Jan 2024 13:29:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=CgvWzKv9rig/Sn621dHJY03t2Ar5iqMIhr4B/a
	2XIz4=; b=wJT3a0Pp0bdZHVe/Nxl7jzfo4UIF2oKU+jLehMHqPjMnydX2W0gel3
	A7foGKqUouSCvs5pbmwhrKVPuAZDIdyOYuOQYU7lMqbBXRHqsBVaQBBSMic1oRkd
	N/DZDIc081x6DNGhgwU5STA4IqFce0p/JMbW8tLydWQBq8/d+s1b8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0D8343350A;
	Thu,  4 Jan 2024 13:29:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF9EB33508;
	Thu,  4 Jan 2024 13:29:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Tamino Bauknecht <dev@tb6.eu>,  git@vger.kernel.org
Subject: Re: [PATCH] fetch: add new config option fetch.all
In-Reply-To: <ZZbr4yAJe0dnHRcO@nand.local> (Taylor Blau's message of "Thu, 4
	Jan 2024 12:33:23 -0500")
References: <cc74dc58-4fbe-470d-a212-4c2d2249918c@tb6.eu>
	<20240104143656.615117-1-dev@tb6.eu> <ZZbr4yAJe0dnHRcO@nand.local>
Date: Thu, 04 Jan 2024 10:29:07 -0800
Message-ID: <xmqqo7e16jgs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 262C44BC-AB2F-11EE-B7F6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

>> +cat > expect << EOF
>
> This should be `cat >expect <<-\EOF` (without the space between the
> redirect and heredoc, as well as indicating that the heredoc does not
> need any shell expansions).

I noticed the same but I refrained from commenting on them ;-)

The original already is littered with style violations of this kind
(aka "old style").  If we were writing the tests in this file today,
we would also move the preparation of "expect" inside the
test_expect_success block that uses the expected output file.

If we do a style fix of the existing tests in this file as a
preliminary clean-up before the main patch that adds fetch.all and
its tests, that would be great.  But for an initial step, I think it
is OK to have a single step patch that imitates the existing ones.
Perhaps after the initial review, it can become a two-patch series
to do so.

Thanks.
