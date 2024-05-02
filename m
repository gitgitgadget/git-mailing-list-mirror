Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E829E154457
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667210; cv=none; b=OKFiiNemv0lCvkd3wgOsswYkJRMh8s/QwpggG7WbvfIxHCsr4Q5eVisaw9VwBy2ehW8Q27K2adLZLUmWNBRo932qTZPb6sJXIjKPr1AvKZ3ez7/B4cmftXwexGMC15Q5cz8MLaM4NIhA24uy8KQ8pNRbRGUaytKQTPZ/JZxhhpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667210; c=relaxed/simple;
	bh=lr++2vewuurmmnoVlPt+4HkWyN8kMFAfZHMYZw5Njhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aXZ9Yzy+QR6VQIXYGvj517tPJc4y2q5On1/5YeREPO5vmxdK3AOrLlPl7GdzsO8b/cY1RKdElAc8yoi/dIznllhog+lmF5cksvHVKAHZ/7LbcvvnWiEaFsoTchMF2gAIjkUpwgoxjv9BS+gnVBxoVQyw+yEouY5jQ7bGXKHq8m0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ybC9daJs; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ybC9daJs"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A7D23054A;
	Thu,  2 May 2024 12:26:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lr++2vewuurm
	mnoVlPt+4HkWyN8kMFAfZHMYZw5Njhk=; b=ybC9daJsAI23KgGK583NoPuU/Xnq
	Qv+ugiaT8IyUr0DUWH2Zvw2aDF4cbi3RZH05sgPwP97aJTRt9Q/7t3PiyOcL7qfP
	mP64ZXKpGXMjIN2XK5qhu3rwO2mm+0CD2KFKYU6Zi1bQbrwub0KWu/V4BdnOBTK5
	WIGGXL5oiNnHG7Y=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 22B4130549;
	Thu,  2 May 2024 12:26:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 52B8730548;
	Thu,  2 May 2024 12:26:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
In-Reply-To: <20240502055621.GA29945@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 2 May 2024 07:56:22 +0200")
References: <xmqq8r0ww0sj.fsf@gitster.g> <20240502055621.GA29945@tb-raspi4>
Date: Thu, 02 May 2024 09:26:41 -0700
Message-ID: <xmqqle4sfada.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C32527A6-08A0-11EF-9051-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> ++ check_corrupt_graph BDAT clear 00000000
> ++ corrupt_graph BDAT clear 00000000
> ++ graph=3D.git/objects/info/commit-graph
> ++ test_when_finished 'rm -rf .git/objects/info/commit-graph'
> ++ test 0 =3D 0
> ++ test_cleanup=3D'{ rm -rf .git/objects/info/commit-graph
> 		} && (exit "$eval_ret"); eval_ret=3D$?; :'
> ++ git commit-graph write --reachable --changed-paths
> ++ corrupt_chunk_file .git/objects/info/commit-graph BDAT clear 0000000=
0
> ++ fn=3D.git/objects/info/commit-graph
> ++ shift
> ++ perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/corrupt-chun=
k-file.pl BDAT clear 00000000
> ++ command /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-c=
hunk/corrupt-chunk-file.pl BDAT clear 00000000
> ++ /usr/bin/perl /Users/tb/NoBackup/projects/git/git.pu/t/lib-chunk/cor=
rupt-chunk-file.pl BDAT clear 00000000
> ++ mv .git/objects/info/commit-graph.tmp .git/objects/info/commit-graph
> override r--r--r--  tb/staff for .git/objects/info/commit-graph? (y/n [=
n]) not overwritten

Another probing question.  Do t5318, t5319, t5324, and t5328 pass?

The "mv" is part of the corrupt_chunk_file helper is used by this:

    corrupt_graph () {
            graph=3D.git/objects/info/commit-graph &&
            test_when_finished "rm -rf $graph" &&
            git commit-graph write --reachable --changed-paths &&
            corrupt_chunk_file $graph "$@"
    }

and reads like this:

    corrupt_chunk_file () {
            fn=3D$1; shift
            perl "$TEST_DIRECTORY"/lib-chunk/corrupt-chunk-file.pl \
                    "$@" <"$fn" >"$fn.tmp" &&
            mv "$fn.tmp" "$fn"
    }

If the final "mv" is what is failing in the above trace, the test
tried to corrupt the objects/info/commit-graph file, expecting that
later steps will notice breakage.  But if the broken file written in
commit-graph.tmp failed to become the final commit-graph, later
steps will see healthy graph file and it is understandable that we
do not see any breakage that we expect, thus failing the test.

Is "mv" somehow configured to always go interactive on that box and
on that box alone?  For example if you have ~/bin/mv that does
something silly like

	#!/bin/bash
	exec /bin/mv -i "$@

and have ~/bin early in $PATH, it may be sufficient to explain the
error we see (I am not claiming that is the only way to cause this
test failure; it is just one possible one).

