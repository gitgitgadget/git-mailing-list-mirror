Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB9B15AAC5
	for <git@vger.kernel.org>; Thu,  2 May 2024 16:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666006; cv=none; b=EV5cGw7Er2zMuAPq8gWR0KlIVwJg2YAYEYG7j5H8L9CcaYAD3eXAWNTgcq/I8fEXJ92PlhTBApWNhvSVv8E2cteqRgrtD0dIZ1eFZJV+EgSP7D53UAgLFfkHrHy/Y/eQ76VjpGp4J3gxim9vNtR08dPKvARigY0wDgwfOxoFqoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666006; c=relaxed/simple;
	bh=dc6zSIPCIChpx+/BwH57GziU8crHbRtPIh6Y4qrIXyA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mHQdcuMyby9kvjIunOGHdgKrbZhAi6sj9GIYW549PJraiUFO7Qt1RpC16wxC63HqIScFrRUCY8eHS0+TqNXQRocRsnMKCDiDKJjAOyAazuErEpi8V49jzXx5SRGmcP0o3lW34dxXcRjGJfsZ4ayDN7W9Ik70agfqZxcG6uGYIpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KTyf/kfZ; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KTyf/kfZ"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8696621750;
	Thu,  2 May 2024 12:06:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dc6zSIPCIChp
	x+/BwH57GziU8crHbRtPIh6Y4qrIXyA=; b=KTyf/kfZ7g3gYT8IQVYmPlsFGALT
	tQgcRePvMwjfK2tcVqNXm/Y2WL9VqVxH9dX0Q/0pkqEacXVuNZaKQehew1uGU7NQ
	Iq9/dkbugykmE7wYozftp7Wt+ZDLeDJYvr/fcfVHDU02gfOZyMg/D8jYwf05kdAT
	BAcnbu+cFVpMBRM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7C6082174F;
	Thu,  2 May 2024 12:06:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CD4502174E;
	Thu,  2 May 2024 12:06:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: git@vger.kernel.org
Subject: Re: t4216-log-bloom.sh broken ?
In-Reply-To: <20240502055621.GA29945@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 2 May 2024 07:56:22 +0200")
References: <xmqq8r0ww0sj.fsf@gitster.g> <20240502055621.GA29945@tb-raspi4>
Date: Thu, 02 May 2024 09:06:41 -0700
Message-ID: <xmqqsez0fbam.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F797ABE2-089D-11EF-9363-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> []
>
> Highjacking the Git v2.45.0 announcement:

I am not sure why you want to do so.  You are perfectly capable of
sending a new message to the list (and I know you have done so in
the past).  Why would linux-kernel@ list want to hear about the
macOS issues?

> There are 4 test cases in t4216-log-bloom.sh, that do not pass on one
> Mac here (they pass on another machine)

Another machine being another mac?

> expecting success of 4216.141 'Bloom reader notices too-small data chun=
k':
> 	check_corrupt_graph BDAT clear 00000000 &&
> 	echo "warning: ignoring too-small changed-path chunk" \
> 		"(4 < 12) in commit-graph file" >expect.err &&
> 	test_cmp expect.err err
>
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

Is this failure preventing the later steps of the test work as
expected, I wonder.  Is there something curious with the permission
bits of /Users/tb/NoBackup/projects/git/git.pu/ directory or its t/
subdirectory?  Is there something curious with the "umask" of the
user running the test?  Are they different from what you see on your
other mac that does not exhibit the problems?

Thanks.


