Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5B83D01C
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 22:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uN93hATX"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D62DBE
	for <git@vger.kernel.org>; Thu, 12 Oct 2023 15:53:02 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 830FB1A0091;
	Thu, 12 Oct 2023 18:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=527qqHr5ZSSfynmitZ/XiF4kITdS6fqFt53uTf
	/1Pbw=; b=uN93hATXcjdhXyhAuJI4bilYiTKLjvfsfm+q/nWDJXYPZGEjMWb6PA
	Ysz+Q2MEXrq/vILnq/NkxJ/50aFKHGn/ZyG30nCzd0IWohElrl3LzIa/V7x5lBSJ
	uX6AUmOGzbudZQlA03p+Fkua1WeQ99fnoiY1Up2sh+kavhihEms1c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 638F71A0090;
	Thu, 12 Oct 2023 18:53:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 750C61A008F;
	Thu, 12 Oct 2023 18:53:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Taylor Blau <me@ttaylorr.com>,  Jason Hatton
 <jhatton@globalfinishing.com>
Subject: Re: [PATCH v2 1/2] t: add a test helper to truncate files
In-Reply-To: <20231012160930.330618-2-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Thu, 12 Oct 2023 16:09:29 +0000")
References: <20231012160930.330618-1-sandals@crustytoothpaste.net>
	<20231012160930.330618-2-sandals@crustytoothpaste.net>
Date: Thu, 12 Oct 2023 15:52:59 -0700
Message-ID: <xmqqsf6f312s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 17F1C486-6952-11EE-B706-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> +	fd = open(argv[1], O_WRONLY | O_CREAT, 0600);
> +	if (fd < 0)
> +		die_errno("failed to open file %s", argv[1]);

contrib/coccinelle/xopen.cocci tells us to write this simply as

	fd = xopen(argv[1], O_WRONLY | O_CREAT, 0600);

https://github.com/git/git/actions/runs/6500777388/job/17656837393#step:4:657

