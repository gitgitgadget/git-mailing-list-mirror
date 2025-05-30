Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAD127450
	for <git@vger.kernel.org>; Fri, 30 May 2025 05:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748581469; cv=none; b=fIuXiRgUkPunsZq3xTQN2B41esqFmqBAXcCi6ChGErL20uWus4hQqGFdJSsFievVKfGl6LyuII0KMk3g4aIJ3/UwZxdhnUJh+VfRg5sl0/oaU5PWuuXS4dVW0Gi2rrbLk7zSDj1xF40vZlwJzCxt26SpNzPEbioz0FwiRXLYn6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748581469; c=relaxed/simple;
	bh=GU3Qr5pd0nt+HyBNIcxHsyPLW06NHUdeMDG4i/kxlek=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MfvQTQzdHnq4Fyk0tiY5KWOq+5sSGlYAF0YavRuf5Xah0CE8FPmnAV8nI/jrkostPNjmKSaa+onmJY/Ij3YKAWqyIazELyPN6uHhGEZ/6C3X7BADfc92NVwERLzb1xrtTPl+vJ5+14jzpVYYWAm7t5Q/OE6gPytV8+epPnxSTmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V0czy9eY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eR+IlHD4; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V0czy9eY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eR+IlHD4"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 7E149114012D;
	Fri, 30 May 2025 01:04:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 01:04:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748581466;
	 x=1748667866; bh=c0QIO4z0E+ZSf6/5s2Th3/djm+iXYH727iRcm6Rdf/M=; b=
	V0czy9eYcJgWOcXWEqzOuz2zi9x6hrHyRV4cKQaDZPN6n/ksCOiHbhmzJHnSa8m3
	o9rdUhmoX+J8BzuJRaVnVvfb+hR/73h1SBO2MTux/XEJ7lu00BfZeiQc9LPH46vx
	QyIwy7tbNF73eI7MrYmA7CrA/+WsI5CwDsZ8qLY1n0g4qQ5e6TeALxLaM35pVMv9
	zKZVT5t4ao/qk4Maulu9Aj6RJpXjTrOBhKZwFGNkqqkF/5m7MRzciX2WXyXxU/EA
	Opy0GTmkGaxluwWoEnPdWJQ1HoErinj9GeKu6EhP1GJT3hkJySVk5vqqGdmsN2gv
	rN6lihILeVSiL4YuS1gQEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748581466; x=
	1748667866; bh=c0QIO4z0E+ZSf6/5s2Th3/djm+iXYH727iRcm6Rdf/M=; b=e
	R+IlHD4eoIc8ARW0Vz9v/hNIeP7ebQ+p6NGwnpSWZM9peodfOGjzZ2D3SAn65sbJ
	D9veYVpjhRa8lkwP1hcXdfrl09+ZbxrZuJscmFkI4QAzUUzkKlnTC1CAVjmqJi9V
	IMFOwuMOqTwW4K3tKO3hPme4BnMJGWzXaXg7n8euIs7PQmSD/v+uWosFB4ziIL4L
	MgXHs3XxV5OfbqISvNFTF7/aYqfYxwnvEUvRPjarvXNd9MtFSSe4phC2WnoP7t0p
	c9vO3OX5Y0BW2yOwrvIikOj7IAcAjgnhLnRTGx2lPqZ80bW4o22pAp6JWmUbldXg
	8H9vu5JdDUgDst2H3A/cQ==
X-ME-Sender: <xms:Wjw5aBlvGRJZ1jB8sIdf-O_u-XFx79IEJQMLo6qSk7gJbVDnswwMug>
    <xme:Wjw5aM3fpu9KaQIFsMdN5lL8wT4VaEaQxpaQm3A00tPsDe23tyD7SE0VK-yOTMa5a
    O8qYJCm73PMx4reew>
X-ME-Received: <xmr:Wjw5aHrQewXtpZuTTP2uer7jlW9mO1OtytLkEbjUoHRuw7Eyvl2uX22Y803PS5CP1yvuB-aODbmkxsCBd5dIwfJkvHc67T4Vu_A8m80>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvkeduvdculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhff
    kfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouc
    eoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdet
    gedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveeftdehnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphho
    sghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtg
    hpthhtohepthgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehmrghrkhestghhrhho
    mhhiuhhmrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghp
    thhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:Wjw5aBnMYNROD0JZxsRC5PMte2EbcIJMHk3ICkMElLa0kxLecyWLIA>
    <xmx:Wjw5aP0g5XVFGIdAmGlUW21MCAeUahqoFIly9YsT5jy-v4_vdqP_XQ>
    <xmx:Wjw5aAv2VF4er97NyO2PHHIq3P8BhzjdKL2-1p-Xh1i9uquFA4GYFA>
    <xmx:Wjw5aDU2_E28JCGNFuLyq9RhHwi9gpVBLAiGHfevD8i8aIxx1u3MEA>
    <xmx:Wjw5aENvGtK8m0S3enb2q-9Y1Ucnnv0XMQKdr-QCXod80O4-lArXP3Cp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 01:04:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc: Mark Mentovai <mark@chromium.org>,  Git Development
 <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
In-Reply-To: <20250528230804.GA16856@tb-raspi4> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 29 May 2025 01:08:04 +0200")
References: <20250523193722.68344-1-mark@chromium.org>
	<20250528201737.55268-1-mark@chromium.org>
	<20250528230804.GA16856@tb-raspi4>
Date: Thu, 29 May 2025 22:04:24 -0700
Message-ID: <xmqqfrgmhep3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Torsten Bögershausen <tboegi@web.de> writes:

> On Wed, May 28, 2025 at 04:17:37PM -0400, Mark Mentovai wrote:
>
> The problem is well described, thanks for that.
> However, different words and terms are used for the same thing:
>   "normalized working directory" (which is easy to confuse
>     with normalized working tree where CRLF-LF conversion had been
>     done and clean filters applied.
>   "pathname canonicalization"
>   "canonical absolute path"
>   "normalized path"
> ... and that is done in "strbuf_realpath()"
>
> May be the word normalized can be replaced here ?
> Starting with the head line, how about this:
> t: run tests from an absolute path
>
> And later in the text:
> use "absolute path" instead of "normalized path" ?

Thanks for a careful reading.  When I read the log message for the
first time, it did not bother me too much that it said canonicalize
and normalize interchangeably, and the two verbs still do not bother
me terribly.  I agree with you that clearly describing what the
canonicalization rules do (i.e. fully resolving symbolic links to
make the path absolute) very good idea, but I think the last
sentence of the first paragraph does a good job at it already.

Can you offer a rewrite along the lines you suggest so that we can
compare?  I personally felt that what Mark gave us, albeit a bit on
the more verbose and repetitive side, were written clearly enough.

Thanks.

>> Some tests make git perform actions that produce observable pathnames,
>> and have expectations on those paths. Tests run with $HOME set to a
>> $TRASH_DIRECTORY, and with their working directory the same
>> $TRASH_DIRECTORY, although these paths are logically identical, they do
>> not observe the same pathname canonicalization rules and thus might not
>> be represented by strings that compare equal. In particular, no pathname
>> normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
>> change their working directory with `cd -P`, which normalizes the
>> working directory's path by fully resolving symbolic links.
>>
>> t7900's macOS maintenance tests (which are not limited to running on
>> macOS) have an expectation on a path that `git maintenance` forms by
>> using abspath.c strbuf_realpath() to resolve a canonical absolute path
>> based on $HOME. When t7900 runs from a working directory that contains
>> symbolic links in its pathname, $HOME will also contain symbolic links,
>> which `git maintenance` resolves but the test's expectation does not,
>> causing a test failure.
>> 
>> Align $TRASH_DIRECTORY and $HOME with the normalized path as used for
>> the working directory by resetting them to match the working directory
>> after it's established by `cd -P`. With all paths in agreement and
>> symbolic links resolved, pathname expectations can be set and met based
>> on string comparison without regard to external environmental factors
>> such as the presence of symbolic links in a path.
>> 
>> Suggested-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Mark Mentovai <mark@chromium.org>
>> ---
>>  t/test-lib.sh | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index af722d383d9b..92d0db13d742 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -1577,6 +1577,8 @@ fi
>>  # Use -P to resolve symlinks in our working directory so that the cwd
>>  # in subprocesses like git equals our $PWD (for pathname comparisons).
>>  cd -P "$TRASH_DIRECTORY" || BAIL_OUT "cannot cd -P to \"$TRASH_DIRECTORY\""
>> +TRASH_DIRECTORY=$(pwd)
>> +HOME="$TRASH_DIRECTORY"
>>  
>>  start_test_output "$0"
>>  
>> 
