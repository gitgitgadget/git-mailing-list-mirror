Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/JzVGfq"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4034412E
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 10:59:06 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7F780361C6;
	Sat,  9 Dec 2023 13:59:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+5ylSrX9kmiTl5LSS+QYoVieeY439SsYk7glhO
	2Fl3g=; b=Y/JzVGfqkX2QgMCYHtDorqAwX5V4/TzwyD1o+Amn4KqXPgljD/UdJ/
	kBFjt2yiCwWVz46lObxLz+tIjNkCHUKt2j8xXfnfQWuXHwtquBcOWcVCMvgWJtO4
	theDWGl/xCVELiG62XM3mKW8ZUsdzU6CjOPkS5oHb7dB466WY5Cyw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 767DA361C5;
	Sat,  9 Dec 2023 13:59:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1E0D1361C3;
	Sat,  9 Dec 2023 13:59:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: git@vger.kernel.org,
    Jiang Xin <zhiyou.jx@alibaba-inc.com>,
    Mathias Lafeldt <mathias.lafeldt@gmail.com>,
    Christian Couder <chriscool@tuxfamily.org>
Subject: Re: New attempt to export test-lib from Git, maybe Sharness2?
In-Reply-To: <802ca62b9d9672e9553ab064452d46e0d72dfc76.1702116416.git.zhiyou.jx@alibaba-inc.com>
	(Jiang Xin's message of "Sat, 9 Dec 2023 21:35:39 +0800")
References: <CAMP44s3qa_CoM_4--UmwYQTgO-5dHh6=jogH-rxF7OXEWr53Lw@mail.gmail.com>
	<802ca62b9d9672e9553ab064452d46e0d72dfc76.1702116416.git.zhiyou.jx@alibaba-inc.com>
Date: Sat, 09 Dec 2023 10:59:00 -0800
Message-ID: <xmqqcyvfmccr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0462F3B8-96C5-11EE-A35E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jiang Xin <worldhello.net@gmail.com> writes:

> It's not easy to upgrade sharness to the latest test framework of Git.

So?

> So I decide to start a new project. The new project is named test-lib,
> see:
>
>   * https://github.com/jiangxin/test-lib
>
> Some of my projects have upgraded the test framework from sharkness to
> test-lib:
>
>  * git-po-helper: https://github.com/git-l10n/git-po-helper/tree/main/test
>  * git-repo-go: https://github.com/alibaba/git-repo-go/tree/master/test
>
> I wonder if we can start Sharness2 based on this solution. See the
> README of the test-lib project for details:

Is it a viable option to stick to the name "test-lib" (or possibly,
"git-test-lib" to make it more prominent to say where it came from)?

If you do not plan to coordinate with those who work on (the remnant
of) the original sharness based on an ancient version of our test
framework, and do not plan to actively transition its users to your
version, it is less confusing if you named yours differently, as it
avoids hinting that your version is a successor of theirs.

I am not sure if reusing the history of our project verbatim using
filter-repo is really a good way to help those who are interested in
the test framework, by the way.  We make changes for our own purpose
and as a part of such an effort we may touch the test framework to
make it easier to test the changes we made, e.g.,

https://github.com/jiangxin/test-lib/commit/0d5db66ef2b9d8ed5bcee9a0167672dc88b1b026

and unedited filter-repo result will describe such a commit
primarily to explain why the changes in the commit was made on Git
side.  Most of the changes described in the resulting commit message
are discarded by filter-repo and the resulting history becomes hard
to follow.
