Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9E160628
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 17:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227436; cv=none; b=gOCkS0vHhGA8Hhs8OkqfK5pXV27iza0qv+kyImRupelhlRfWAhIJx2eDjdoa4Kj+wv/Sbj7W8Z4FZ4zonjPAXCALGyJMvxCA3v3o0/qg/YdpLmsifPd2ApeNjjpXT6yy5AAfRsBr1Ndv3GZZ/1bGOffLUW2uP0vys82joFTZUYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227436; c=relaxed/simple;
	bh=KRXpUlYSxOV4odzrjbErkMB+mm8sbCp4G4vODx2RKrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UeWRtG0OR3MGdFhPXNEdtbOgp0Y8D3DvFbOMFIC5GACVk5Vw2ZRsuE9L7Es/MP7WLEYwYtPWyJZDqloJUkVLPCHWIkqgkbZl1CxYIY0Lvn1cRlJl3gwjJUFeOSVBa2MDrLRAPUKN70nEKVIuLLx9TTEfE5fUyPNyvb2WGkxjl+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gPgxEPmq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gPgxEPmq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 085FC1E5227;
	Thu, 29 Feb 2024 12:23:54 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=KRXpUlYSxOV4odzrjbErkMB+mm8sbCp4G4vODx
	2RKrc=; b=gPgxEPmqieFvAgSK36Alg2F3lkwmQT3iZLjGNM5hBoGp6IFKLftCTs
	KBGf+BACo/C5WjiJr3FT0ebn5tOLMFjE9pdEHfOQmq3+OTucDwcS0ECu27hazPyT
	dw2Lg6+DquqvSwzMiD1hmqJKI1FWfogzEz0oykGX88PmQdHuKwq2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F36DD1E5226;
	Thu, 29 Feb 2024 12:23:53 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5CD021E5225;
	Thu, 29 Feb 2024 12:23:53 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>
Subject: Re: [PATCH v5 2/3] git-std-lib: introduce Git Standard Library
In-Reply-To: <db8b2398-c6d6-47a1-a4d4-7e4726d13312@gmail.com> (Phillip Wood's
	message of "Thu, 29 Feb 2024 11:16:41 +0000")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-3-calvinwan@google.com>
	<db8b2398-c6d6-47a1-a4d4-7e4726d13312@gmail.com>
Date: Thu, 29 Feb 2024 09:23:52 -0800
Message-ID: <xmqq1q8vi3pz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4F95E654-D727-11EE-8744-25B3960A682E-77302942!pb-smtp2.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Calvin
> On 22/02/2024 17:50, Calvin Wan wrote:

Thanks for reviewing -- I held mine back as I expected this will see
another reroll soonish, but you already have raised many points I
also had trouble with, so I do not have to ;-) 

Below, I'll liberally omit everything you wrote that I agree with.

>> +libgit.a, which is then linked against by common-main.o with other
>> +external dependencies and turned into the Git executable.
>
> I found this description a bit confusing. As I understand it to build
> git we link git.o against common-main.o, libgit.a, xdiff/lib.a,
> reftable/libreftable.a and libpcre etc.

In addition, there is no single "the Git executable", simply because
not everything is builtin command.  The purpose of using libgit.a is
because we are too lazy to list and maintain all the internal
dependencies to link final executables like 'git' (which has all the
built-in command implementations) and 'git-remote-curl' (which is a
standalone program).  Instead of feeding exact list of object files
to "$(CC) -o git" command line, we throw everything into libgit.a
and let the linker pick what is needed.  To link "git", we may
include all builtin/*.o, git.o, common-main.o, libgit.a and the
external [*] library dependencies they have.  To link "git-daemon",
we may not link builtin/*.o and git.o and link daemon.o instead.

	Side note: here I am counting xdiff/lib.a as an external
	library as it is mostly a borrowed code.

In other words, libgit.a is not a true library in the sense that it
was designed to be _used_ as a library.  It was merely a detail of
how we implemented lazy dependency management in our build process,
which happend with 0a02ce72 (Clean up the Makefile a bit.,
2005-04-18) whose commit log message uses air-quotes around the word
"library".

>> +From the above dependency graph, we can see that git-std-lib.a could be
>> +many smaller libraries rather than a singular library. So why choose a
>> +singular library when multiple libraries can be individually easier to
>> +swap and are more modular? A singular library requires less work to
>> +separate out circular dependencies within itself so it becomes a
>> +tradeoff question between work and reward. While there may be a point in
>> +the future where a file like usage.c would want its own library so that
>> +someone can have custom die() or error(), the work required to refactor
>> +out the circular dependencies in some files would be enormous due to
>> +their ubiquity so therefore I believe it is not worth the tradeoff
>
> I'm not sure if we want to use the first person in our technical
> documentation, unlike the cover letter to a patch series it is not
> immediately obvious to the reader who "I" is. This applies the
> passages in the first person below as well.

I found it highly annoying while reading it, too.  If the document
(not the commit that introduced the document) were signed and
written to state the position of one author, as opposed to spell out
the position the project will collectively take, it would have been
OK, but this document is meant to set a course of the project (and
discussion on it is the process to decide which course to take), the
first person singular "I" did not sit well for me.

Another thing to consider that I do not think you covered is the
name of the resulting .a archive.  By starting it with "lib", a
customer can find your libstdgit.a with -lstdgit on the command
line, once libstdgit.a is installed at an appropriate location (or
the build-time library path is configured to point the location you
have libstdgit.a at).  libgit.a that wasn't really designed to be
used as such a library did not have to follow the naming convention,
but if the thing being proposed is meant to be eventually used as a
library by external entities, git-std-lib.a is a rather poor name
for it.


PS.

I seem to have been hit by a power outage and am on UPS, so I'll
probably be offline until the power comes back.



