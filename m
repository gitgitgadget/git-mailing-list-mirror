Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF8C58200
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709076348; cv=none; b=QlGSNWb8rYrMU0bas2Gc9YTm+DYw9c5cMz5iPo/h3X8BQuuRicqZcKVVOv3l162iD8/qCLS+SCVhis8e8uUqOPL/o+F7niZec4KAyqBmPrEAnRWWw5dWqNWxznlZBwzh5WonsMhvtmdVjG15B7siFcQ5twUqnjGRi2sj8pc525c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709076348; c=relaxed/simple;
	bh=cT8atl0+UEk4uHhrkjbnDZozwqvZt6YWElwelzwNDAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NzQ8qAVJbU9RurVS9//kttiao+frwc51tVx7P423ACFN4KwW6V7+RUUVzl4s/lBnbgM7MePLUzTxc7tMv4CSuK7fID+X6gsJZf/EyDPokPpyjSGH31eyebWHkRV2bc24pK6at83UrQIUmIKyHlzfc9jiXdTL0JVIrfRIzDkfxcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VNDD25yP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VNDD25yP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9C3122697A;
	Tue, 27 Feb 2024 18:25:46 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cT8atl0+UEk4uHhrkjbnDZozwqvZt6YWElwelz
	wNDAQ=; b=VNDD25yPvwRddAZg/5hZam/lhaYqndsEZLqULxTw1lkht6lH2fvaK7
	OyoxVj7N+iMxzvS7xavpcQs+dHc7OWOcT5147cL7lL3ghd+xaoV++gsXaNIgmXi6
	gqV5Px2CgrH+fDKMiDrO6uScOu/b1KJQ+b95zujdKSAHVYBKsDGho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 944D526979;
	Tue, 27 Feb 2024 18:25:46 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 349A026978;
	Tue, 27 Feb 2024 18:25:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>,  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
In-Reply-To: <CAO_smVgmaXvyZZ7zp6RCFD_6kpL2pHKC9gMDeg+yXBb9R4rR5w@mail.gmail.com>
	(Kyle Lippincott's message of "Tue, 27 Feb 2024 14:29:23 -0800")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-2-calvinwan@google.com>
	<xmqqh6i0cgyo.fsf@gitster.g>
	<CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
	<xmqqle76iwqw.fsf@gitster.g>
	<CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
	<xmqqzfvmhbfs.fsf@gitster.g>
	<CAO_smVgmaXvyZZ7zp6RCFD_6kpL2pHKC9gMDeg+yXBb9R4rR5w@mail.gmail.com>
Date: Tue, 27 Feb 2024 15:25:41 -0800
Message-ID: <xmqq1q8xo5fu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 86D3F400-D5C7-11EE-A3FD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Kyle Lippincott <spectral@google.com> writes:

> of <git-compat-util.h> that enforces that we're using C99. Therefore,
> I'm assuming that any compiler that claims to be C99 and passes that
> check at the top of <git-compat-util.h> will support inttypes.h,
> stdint.h, stdbool.h, and other files defined by the C99 standard to
> include types that we need in our .h files are able to be included
> without reservation.

We at the git project is much more conservative than trusting the
compilers and take their "claim" to support a standard at the face
value, though ;-).  As our CodingGuidelines say, we honor real world
constraints more than what's written on paper as "standard", and
would ...

> To flip it around: any compiler/platform that's
> missing inttypes.h, or is missing stdint.h, or raises errors if both
> are included, or requires other headers to be included before them
> _isn't a C99 compiler_, and _isn't supported_.

... refrain from taking such a position as much as possible.

> I think the only viable solution to this is to not use these types
> that depend on #defines in the interface available to non-git
> projects.

OK.  Now we have that behind us, can we start outlining what kind of
things _are_ exported out in the library to the outside world?  The
only example of the C source file that is a client of the library we
have is t/helper/test-stdlib.c but it includes 

    <abspath.h>
    <hex-ll.h>
    <parse.h>
    <strbuf.h>
    <string-list.h>

after including <git-compat-util.h>.  Are the services offered by
these five header files the initial set of the library, minimally
viable demonstration?  Has somebody already analyzed and enumerated
what kind of system definitions we need to support the interface
these five header files offer?

Once we know that, perhaps the next task would be to create a
<git-absolute-minimum-portability-requirement.h> header by taking a
subset of <git-compat-util.h>, and have test-stdlib.c include that
instead of <git-compat-util.h>.  <git-compat-util.h> will of course
include that header to replace the parts it lost to the new header.

It does *not* make it a requirement for client programs to include
the <git-absolute-minimum-portability-requirement.h>, though.  They
can include the system headers in the way they like, as long as they
do not let them define symbols in ways contradicting to what our
headers expect.  <git-absolute-minimum-portability-requirement.h> is
merely a way for us to tell those who write these client programs
what the system symbols we rely on are.

So, that's one (or two? first to analyse and enumerate, second to
split a new header file out of compat-util) actionable task, I
guess.

