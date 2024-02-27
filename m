Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B061B949
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 02:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709001948; cv=none; b=gaqZys0KQ6xhMZoa9kIoA3q/1Oy6whjx7eqrqAhC3HEa1CcQpWJqb8jWtVsdK4MMf/eUImTQSdZtJjwcUoznNNaHorNnx3FF9dxuSd/7q4iS/H+QXV+AAZ38ZuOg7dgxWkDR9IVJCnx32fCnN4tVYVSesEaOgKXoxgXOoK/6+e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709001948; c=relaxed/simple;
	bh=Hhs8TIpLrbCW76PhePnSxI19lzJuKKtaxXzY8xhkQ8s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tQHPL4tAhGyjZzYf7AE7vEPfa/iuAQahl1iiCz9nGLl2jnWI9SwQXoo7l9qR1Wn1LdrQgAYSbZO/ZPpmFUthe+UDv/GWc7NJEm79tJP6SmaiV0yGdYreVeJ41q87qTV2PeQ+kmWYXwLObwtpsjlEmW8MY1KyUq5b0gGuEjmU104=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=vLf+zlgU; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vLf+zlgU"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 81B1C1D6E6C;
	Mon, 26 Feb 2024 21:45:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Hhs8TIpLrbCW76PhePnSxI19lzJuKKtaxXzY8x
	hkQ8s=; b=vLf+zlgUwq1LJqdyQdw60wR1wBHxfcO6clNGgHlHnYCb+uJk/E2Bva
	MEvyPS5ln7R6WPTDStFwzIum7k54szSF6kuNPHnaPNDxReWfidg6tqU08e69uzrO
	NU9g+AJ7SETUoWXvo+jrhuFSUJ/CPxBOVAqidkPwf7H5IZpt0KKIw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 789601D6E6B;
	Mon, 26 Feb 2024 21:45:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B77351D6E6A;
	Mon, 26 Feb 2024 21:45:44 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,  Jonathan Tan
 <jonathantanmy@google.com>,  phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
In-Reply-To: <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
	(Kyle Lippincott's message of "Mon, 26 Feb 2024 16:56:28 -0800")
References: <cover.1696021277.git.jonathantanmy@google.com>
	<20240222175033.1489723-2-calvinwan@google.com>
	<xmqqh6i0cgyo.fsf@gitster.g>
	<CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
	<xmqqle76iwqw.fsf@gitster.g>
	<CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
Date: Mon, 26 Feb 2024 18:45:43 -0800
Message-ID: <xmqqzfvmhbfs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 4DE3BC6E-D51A-11EE-893A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Kyle Lippincott <spectral@google.com> writes:

>> In any case, your sources should not include a standard library
>> header directly yourself, period.  Instead let <git-compat-util.h>
>> take care of the details of how we need to obtain what we need out
>> of the system on various platforms.
>
> I disagree with this statement. We _can't_ use a magic compatibility
> header file in the library interfaces, for the reasons I outlined
> further below in my previous message. For those headers, the ones that
> might be included by code that's not under the Git project's control,
> they need to be self-contained, minimal, and maximally compatible.

Note that I am not talking about your random outside program that
happens to link with gitstdlib.a; it would want to include a header
file <gitstdlib.h> that comes with the library.

Earlier I suggested that you may want to take a subset of
<git-compat-util.h>, because <git-compat-util.h> may have a lot more
than what is minimally necessary to allow our sources to be
insulated from details of platform dependence.  You can think of
that subset as a good starting point to build the <gitstdlib.h>
header file to be given to the library customers.

But the sources that go to the library, as gitstdlib.a is supposed
to serve as a subset of gitlib.a to our internal codebase when
building the git binary, should still follow our header inclusion
rules.

Because we would want to make sure that the sources that are made
into gitstdlib.a, the sources to the rest of libgit.a, and the
sources to the rest of git, all agree on what system features we ask
from the system, feature macros that must be defined to certain
values before we include system library files (like _XOPEN_SOURCE
and _FILE_OFFSET_BITS) must be defined consistently across all of
these three pieces.  One way to do so may be to ensure that the
definition of them would be migrated to <gitstdlib.h> when we
separate a subset out of <git-compat-util.h> to it (and of course,
we make <git-compat-util.h> to include <gitstdlib.h> so that it
would be still sufficient for our in-tree users to include the
<git-compat-util.h>)

<gitstdlib.h> may have to expose an API function that uses some
extended types only available by including system header files,
e.g. some function may return ssize_t as its value or take an off_t
value as its argument.

If our header should include system headers to make these types
available to our definitions is probably open to discussion.  It is
harder to do so portably, unless your world is limited to POSIX.1
and ISO C, than making it the responsibility of library users.  

But if the platform headers and libraries support feature macros
that allows you to tweak these sizes (e.g. the size of off_t may be
controlled by setting the _FILE_OFFSET_BITS to an appropriate
value), it may be irresponsible to leave that to the library users,
as they MUST make sure to define such feature macros exactly the
same way as we define for our code, which currently is done in
<git-compat-util.h>, before they include their system headers to
obtain off_t so that they can use <gitstdlib.h>.

So the rules for library clients (random outside programs that
happen to link with gitstdlib.a) may not be that they must include
<git-compat-util.h> as the first thing, but they probably still have
to include <gitstdlib.h> fairly early before including any of their
system headers, I would suspect, unless they are willing to accept
such responsibility fully to ensure they compile the same way as the
gitstdlib library, I would think.



