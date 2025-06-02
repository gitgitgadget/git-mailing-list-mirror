Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F315C224240
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880489; cv=none; b=oXCL3CqFXVbZbGExGhRDvbMjwlCiKJ9es4wtXbRMBO+QEZPrLORjZnnbtNTJTGDulsoakstqVbnWMb7zm9mfwzqK9K9vzItLHlBU7W/bD5MrL2xaCsAOhEkgM8zg5L9g1ZspBNlhFfu2qnDo0eeapwb1Pf/G++fsaZ0sZRAxy9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880489; c=relaxed/simple;
	bh=ngJ6RT0B7lzG5yh/o2CyjB6PEeGrvp1idiYAOrCBInY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sO0AqpyozwcvTZ951yaPIAsr1rTaciK9hJoW9XexF8XPSzbHnoqkuilovOs+S3m5IctPGsyXO5eyU+OQzwV5UC9SYAM/Hsua6y0XEkqJYxwYmnhh7OOW2mlcvaP6A6KgY3iZDyBO4mwuRY/m2jBSQoKDfF5kL6qIfqbDBWQUpP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N/ObswRV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N/ObswRV"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6f8a87f0c0fso48241946d6.0
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 09:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1748880487; x=1749485287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:message-id
         :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2aH227rqA3s0cGYYxn81yWnrHvDGF6zhCxVE59r0DM=;
        b=N/ObswRVzVAWNJikkM3j24AdjEKUGPnRCPmHoQ9N73grqrARAwHmd4jpOM4BfOK1kD
         L3kTC6nY2DYKuABIcoCTeOKFYHQbGROA/+559X18GQL2V5b0uzG+/Hj73kyig/bjVm5O
         AcWNqhsbZyFIbyhPo3i+CcsQ1504+47/rQuyE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748880487; x=1749485287;
        h=content-transfer-encoding:mime-version:references:message-id
         :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2aH227rqA3s0cGYYxn81yWnrHvDGF6zhCxVE59r0DM=;
        b=WfX5dAFjzaZcTrt0GKSzwQ7uuhQWvEH4/x1yJNdsDxEK1o3H0dYD1/4gN+534+oUME
         YJHYXWbURghv8BmvmHITX+f0+5nVCXbZldRnIeViaorOYNdbKt0m56Pln9LuQApnhskZ
         mdgEHhRrYjymKemRSbGynmTvz+4YehE6y7TlvvwmSEYUmnWycVdKbky5cv2L9ND7Y9sE
         3WCo5CTc4Sl8g+EgLqoZcT43iiEiCwaUmu3CIZGJCHuwjbDAId1d3GSEY2tIDGyX4opN
         q6hF4URqO+T9afTV5D0T+mGLEBaiIKijhELKPoNCRAfpKwDbcLSpkWfmf+tTgyLmoLdo
         73yg==
X-Forwarded-Encrypted: i=1; AJvYcCW2BPKdjk1/ekNzrUzcM9HEiwx8+H2+b4yQCWwDLa95xULVIw2oWhQewQrEplbeyMRYz9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwWIpFgqt/EkIaonuEp4dmooj/Cy9912O5tsf9NG4AGwfMCxNX
	d+w3uiUmLMKpdSpZmpTeqXTX9NM3dJa1MIUxjg/BKGp/SH3JhofOIblPL9oSVbSyTA==
X-Gm-Gg: ASbGncu68+pRVeFbJ53iSWOkA4BMTEju81uPgFbyN0/y+jkmG3pG4tvgGSG8K4+cMfy
	Q5HClkmmf/NsM9pEFLZUe5T4/AQ8zdSI2J0rDxOeT9jUk9wddXMoEZgWwB3LTxM2OPunTw2oGr7
	v5uyNxgOYUhPMcc1c1A5rGucosNF2xItaVRXTMj7/NIAIiBDoIbmcK0jYyOGZhegz/jwyHcTKW9
	hE87BFDWRgYOO47YtOQaALiOtvm4Xycz+9rxtfjUNcUIuF0GIvAdEenmtF7ikKoSezyp90ojTOV
	syVz8PSpm3kPyHtKurgYbE8MSKvq/9y1ODSjIHMMum7QLlMY9VLgvdsQJnCxzQtgh9IeFQfrHdh
	1lbd8looEeQLFJw+SOZg25bicKW7eqDViRbmwwx0hot3aAZEIj7800L8OuZuVmedxhA==
X-Google-Smtp-Source: AGHT+IGWm0uEffASHfByOjSjP769NhJx82ob22x/eb0nHqDPUmJTSBUCgr0Zy9VzBIX5wA6Lq9AjJQ==
X-Received: by 2002:ad4:5c84:0:b0:6fa:bedb:f61d with SMTP id 6a1803df08f44-6faceb7f9d6mr223509616d6.14.1748880486638;
        Mon, 02 Jun 2025 09:08:06 -0700 (PDT)
Received: from [2a00:79e0:2c11:a:d9bc:ac28:113d:7a27] ([2a00:79e0:2c11:a:d9bc:ac28:113d:7a27])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fac6d4c912sm62586546d6.33.2025.06.02.09.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jun 2025 09:08:06 -0700 (PDT)
Date: Mon, 2 Jun 2025 12:08:05 -0400 (EDT)
From: Mark Mentovai <mark@chromium.org>
To: Junio C Hamano <gitster@pobox.com>
cc: =?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>, 
    Git Development <git@vger.kernel.org>, 
    Eric Sunshine <sunshine@sunshineco.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2] t: run tests from a normalized working directory
In-Reply-To: <xmqqcybnxvr2.fsf@gitster.g>
Message-ID: <f0d4c85a-b833-c52d-b54f-77ab81f22451@chromium.org>
References: <20250523193722.68344-1-mark@chromium.org> <20250528201737.55268-1-mark@chromium.org> <20250528230804.GA16856@tb-raspi4> <xmqqfrgmhep3.fsf@gitster.g> <20250531054618.GA30443@tb-raspi4> <xmqqcybnxvr2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8BIT

Junio C Hamano wrote:
> Torsten Bögershausen <tboegi@web.de> writes:
>
>> The word canonical has been removed.
>> After reading the help for
>> 'pwd -P' and 'cd -P'
>> "absolute" is replaced by "physical".
>> A matter of taste.
>> If absolute is more used here in Git, I am fine with any.
>
> It is OK as long as we are locally consistent.  I do think inside
> our codebase it seems we use "absolute" more, but the change in
> question is about use of "-P" option, which certainly was taken from
> "physical", in our test scripts, so I am OK with your description
> below to use that word.
>
> If somebody really cared (and I don't), we may want to pick a single
> word among physical, absolute, and real, but the only thing is that
> we are using them interchangeably, so as long as we make it clear
> (e.g. perhaps strbuf_realpath() and the underlying helper functions
> that are used by it may have a comment or two that says that we use
> these three words interchangeably to our developers), it would be
> good enough.

An "absolute" path is well-defined and commonly understood to have a 
singular meaning. These paths are relative to the root directory, and are 
identified by a leading separator (/). POSIX specifies this at XBD.3.2[1] 
and XBD.4.16[2].

This change is not concerned with absolute paths. All of the paths in 
question are absolute, both before and after this change.

There is no single term that's widely understood to have the meaning that 
this change is concerned with. "Physical" is a contender, but this term is 
not broadly understood without providing additional context. In fact, 
while "physical" is the namesake for the pwd's `-P` option, the POSIX 
definition of pwd(1) doesn't even use this term, instead explaining the 
concept fully in prose[3]. I don't believe it's appropriate to discuss 
"physical" paths without an introduction clarifying its intended meaning.

`realpath` is a library interface that transforms paths to those having 
the semantics at issue, but it's somewhat obscure, and easily confused 
with "real path" whose meaning would be entirely ambiguous. realpath(3) 
documentation from POSIX[4] explains the semantics fully; glibc[5], and 
Linux man-pages[6] provide full explanation while also using the term 
"canonicalize".

"Canonicalize" alone is too generic, because there are several axes of 
canonicalization that may apply to a path, some filesystem-dependent. This 
change is concerned with canonicalization via symbolic link resolution, 
but in other contexts, path canonicalization may refer to other concepts, 
such as case matching on case-preserving filesystems, or encoding 
canonicalization (such as Unicode normalization) on filesystems that have 
defined encoding rules.

All of this illustrates the difficulty in choosing a single term to 
unambiguously convey the meaning. I chose to write a commit message that 
favored technical precision, even if it meant tending toward what Junio 
called "the more verbose and repetitive side". I believed that to be 
necessary to fully explain the background, the problem, and the solution.

I don't know that this amount of scrutiny of a commit message that's 
precise and correct is entirely justified, but if there's a strong 
preference to converge on a single term, provided that it's not 
technically inaccurate, I'll accede to the request. I don't expect that it 
will shrink the amount of explanatory text, though, because as I've 
illustrated, there isn't really a term in existence that conveys this 
principle generally in a way that's suitable for broad understanding.

[1] https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap03.html#tag_03_02
[2] https://pubs.opengroup.org/onlinepubs/9799919799/basedefs/V1_chap04.html#tag_04_16
[3] https://pubs.opengroup.org/onlinepubs/9799919799/utilities/pwd.html
[4] https://pubs.opengroup.org/onlinepubs/9699919799/functions/realpath.html
[5] https://sourceware.org/glibc/manual/2.41/html_node/Symbolic-Links.html#index-realpath
[6] https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/tree/man/man3/realpath.3

>> ==================================================
>> t: run 7900 tests from the physical working directory
>>
>> Some tests make git perform actions that produce observable pathnames,
>> and have expectations on those paths. Tests run with $HOME set to a
>> $TRASH_DIRECTORY, and with their working directory the same
>> $TRASH_DIRECTORY, although these paths are physical identical, they do
>> not observe the same pathname normalization rules and thus might not
>> be represented by strings that compare equal.
>> In particular, no pathname
>> normalization is applied to $TRASH_DIRECTORY or $HOME, while tests
>> change their working directory with `cd -P` which resolves symbolic links
>> returning the physical path.
>
> "physical identical"?  I think the problem is $HOME and $TRASH are
> the same but not physically normalized, which means "cd $HOME &&
> pwd", "cd $HOME && pwd -P" and "cd -P $HOME && pwd" can give
> different results from these two variables.  How about replacing the
> latter half of the above with something much simpler, like this?
>
>    ... although HOME and TRASH_DIRECTORY have identical values, the
>    physical path to it (i.e. what "cd $HOME && pwd -P" reports) may
>    be different.
>
>> t7900's macOS maintenance tests (which are not limited to running on
>> macOS) have an expectation on a path that `git maintenance` forms by
>> using abspath.c strbuf_realpath() to resolve the physical path
>> based on $HOME. When t7900 runs from a working directory that contains
>> symbolic links in its pathname, $HOME will also contain symbolic links,
>> which `git maintenance` resolves but the test's expectation does not,
>> causing a test failure.
>>
>> Align $TRASH_DIRECTORY and $HOME with the physical path as used for
>> the working directory by resetting them to match the working directory
>> after it's established by `cd -P`. With all paths in agreement and
>> symbolic links resolved, pathname expectations can be set and met based
>> on string comparison without regard to external environmental factors
>> such as the presence of symbolic links in a path.
>
