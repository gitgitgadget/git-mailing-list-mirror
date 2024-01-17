Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1B1C691
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528710; cv=none; b=s1TMiCw/KohVyA9rqsHB6Qtnr8yPXXDJor8bdIYIEfF9fzazffmrKGYWngy935iHDEEPv1LxuNFIhRvGWnBQEU87Ivjo6RfrppM8h5eSoA71ayCgASVEqRCaPTBdG4ljajnak/p/wf/vlm/0kr8H0IRp0er09NtxCYf+yOGeMbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528710; c=relaxed/simple;
	bh=g9UaQ22SoEWM3r4Xlg54ZjNgFqenb8XiLEdHWIMwZO8=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=qqkAPcOyJl5gOLp+T5B+NBIlPjZR43IkhddouJx+ODi9ybkojTiXYdRhvJm+Am2CR7OlTca5p1bq/n/0YlPkVS2/zkJR1ntRE221Y1DnUOQe8nHC4rUzGJ4SvjfWSn7YcY17sa9mHgXCRv+q0EicPlNnCg6HnO39XVIzoN4kWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=HgcFB5G4; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HgcFB5G4"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 883061C253B;
	Wed, 17 Jan 2024 16:58:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=g9UaQ22SoEWM3r4Xlg54ZjNgFqenb8XiLEdHWI
	MwZO8=; b=HgcFB5G41fQuHP7IVq7PPT8hW4IJ2XnHn4iVG8FYL+4cblMzOlLzDx
	D8hm2c1YgjsYvlA4Jo2qCj5NDEFydCJLbRtCYyvaUejSatl3PoHGkdYqVYhHmqlg
	iQXk3rERbpirH2hCW45T6MsBBRYD4CayP/Ek197wsraHovX+ZTi20=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DCC91C253A;
	Wed, 17 Jan 2024 16:58:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DE0061C2534;
	Wed, 17 Jan 2024 16:58:26 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Chandra Pratap via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Chandra Pratap <chandrapratap3519@gmail.com>,
  Chandra Pratap <chandrapratap376@gmail.com>
Subject: Re: [PATCH v3] tests: move t0009-prio-queue.sh to the new unit
 testing framework
In-Reply-To: <pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com> (Chandra
	Pratap via GitGitGadget's message of "Wed, 17 Jan 2024 14:38:23
	+0000")
References: <pull.1642.v2.git.1705220304781.gitgitgadget@gmail.com>
	<pull.1642.v3.git.1705502304219.gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 13:58:25 -0800
Message-ID: <xmqqa5p3vczi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8ACFF7D4-B583-11EE-9CCA-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

I forgot to examine the contents of the tests themselves.

> -cat >expect <<'EOF'
> -1
> -2
> -3
> -4
> -5
> -5
> -6
> -7
> -8
> -9
> -10
> -EOF
> -test_expect_success 'basic ordering' '
> -	test-tool prio-queue 2 6 3 10 9 5 7 4 5 8 1 dump >actual &&
> -	test_cmp expect actual
> -'

This seems to have been lost from the converted test.  Your basic
input test feeds an already sorted array of 6 items and dump to see
they are the same already sorted array, which is a lot less
interesting than the above.

> -cat >expect <<'EOF'
> -2
> -3
> -4
> -1
> -5
> -6
> -EOF
> -test_expect_success 'mixed put and get' '
> -	test-tool prio-queue 6 2 4 get 5 3 get get 1 dump >actual &&
> -	test_cmp expect actual
> -'

This is a faithful conversion.

> -cat >expect <<'EOF'
> -1
> -2
> -NULL
> -1
> -2
> -NULL
> -EOF
> -test_expect_success 'notice empty queue' '
> -	test-tool prio-queue 1 2 get get get 1 2 get get get >actual &&
> -	test_cmp expect actual
> -'

This too.

> -cat >expect <<'EOF'
> -3
> -2
> -6
> -4
> -5
> -1
> -8
> -EOF
> -test_expect_success 'stack order' '
> -	test-tool prio-queue stack 8 1 5 4 6 2 3 dump >actual &&
> -	test_cmp expect actual
> -'

This test got truncated in your version, which is not horribly
wrong, but if we claim "move t0009 to unit testing", people would
expect to see a conversion faithful to the original.  And with the
use of result[ARRAY_SIZE(expected)], there is no reason to truncate
the original test with this version, no?

Thanks.
