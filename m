Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A3C205E3C
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085818; cv=none; b=syA8xk89K5m5vPGjSHfagGN5UxKBZgpSpCEcAe6WRgcSTnTUeGkv+hV40ARtQD6NfLKPmf1qeIsEWSb1uvgkiJ/Y5SvuxZYjVwY5fukbUSlkjEYcHDhWKcD8muRUVFr1QP0nt/AcJ0O7iBRvoqWCDZtK22fFHt5DNjVKZTXQq3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085818; c=relaxed/simple;
	bh=I7NXPLWfk/6xa7iFajbjT/CLLPoF1nVd8g2IzXuN+94=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CrabD3JvwmmRFk0t0/yUI5XN2pftUVPRgcDIcuqMKhc4XHyzZqV34JCNbIK8GJ4lbYc24jo3KWDPJvm55yAO3m0vVMu4G0lBwT11SOARO/YOj6z3ueaPdjEcJBzEZFzTI9dC4ehwhPpR8j7IgPevnj1TK7wHVbwu3v/H4mp9wfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+UK0Ii2; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+UK0Ii2"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43155afca99so1537125e9.1
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729085815; x=1729690615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=al0lwRRsBi8CTAEImU3dyJXXwwpd5K06uvvTjiRrr3E=;
        b=R+UK0Ii2bGc4WWv3Xl/DzaEQBN77zA7tapPFTqUX8jxoJmR5KKj9ODgZy+FgM76ZJY
         tT+kmMAyHRqVlHa4/ABrzso1uOMKyrLRwu2+U9lMSLzgriCK5F8YkyEdXjqRejVosSxs
         9FvxHeutGhnK/zBG2CmiNQwp52m6hGCcSlM6qjwUvgDtMoDGAreT8xL3P+RxZrKsixQJ
         +cHhpD44g2Km5k2kTsCNA6O83M1Jtg7dsAO4cJuk/rKjXlWqZlzMNnHBxNp9U1X+g2Bh
         rcCSHZf2piHnK7wTGaKy0o1IjfoqYIy9H9uEx9d0SgYdHw8GY19gyL8NibrRfQoCfhjN
         xIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729085815; x=1729690615;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=al0lwRRsBi8CTAEImU3dyJXXwwpd5K06uvvTjiRrr3E=;
        b=YwTE7gIzdIPE2/8ZiSTtoYyjVZdbcOpIiNKp8HVs3Fd6h0DAzoGhXDq+oIpyBzYzzx
         Jrp1Jn4WzJU+m4oAVCFooNiwempDZvItumxiNmhAGgJNLBe4r/XrAG8HMfCluC9AfBhk
         e65nSWEn5JDkUyB+npsRP2xABs57fB3maRX1k3L1t7ZGal+XuIO74Cagh/r7zfpn2Hqj
         TsWv+MCXUEnJijmwFUyhiMtInaLdhzV0iKbwOMPPeOvAlXtQml/Aqf4nLeArDThHIccd
         qKGd9gtFRSDHrDM9NufkoXrtPgRI0lBqSfaUATlDZMv81DcK3sSVpSUGS4QmW9Y5K6jr
         5sFw==
X-Gm-Message-State: AOJu0YytgcBme8QDNnv+33Tbp8DrRfxjpV4OWLZd4LcVzhrXO+KtA56G
	vDsOS35V9PkqzaN/EXFAd8wL2iLEQ4iih22GekSCxfF9ZXtkA8Fq
X-Google-Smtp-Source: AGHT+IEhK/Xi/5s76Y77en65BKoGZhJxszka4yYEZdDLwDhRIjESleksC1pppTFEdAV9GNlXwLI8FQ==
X-Received: by 2002:a5d:44cb:0:b0:37c:ccdf:b69b with SMTP id ffacd0b85a97d-37d552ffd90mr13069745f8f.32.1729085814638;
        Wed, 16 Oct 2024 06:36:54 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc27ed9sm4303495f8f.97.2024.10.16.06.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Oct 2024 06:36:54 -0700 (PDT)
Message-ID: <f68685c4-c8c8-45ac-a34c-1cff30cc11f5@gmail.com>
Date: Wed, 16 Oct 2024 14:36:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH v2 23/24] Documentation: add comparison of build
 systems
To: Patrick Steinhardt <ps@pks.im>, phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
 Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>
References: <cover.1727881164.git.ps@pks.im> <cover.1728485139.git.ps@pks.im>
 <afa2f79d46cb9b2e25cd31b622d5f547e2746f2e.1728485139.git.ps@pks.im>
 <72da40d7-2570-456c-966d-cd09579edd22@gmail.com> <Zw5cMv_fyctQsyT8@pks.im>
Content-Language: en-US
In-Reply-To: <Zw5cMv_fyctQsyT8@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Patrick

On 15/10/2024 13:12, Patrick Steinhardt wrote:
> On Mon, Oct 14, 2024 at 04:23:33PM +0100, Phillip Wood wrote:
>> On 09/10/2024 15:57, Patrick Steinhardt wrote:
>>> +== Requirements
>>> +
>>> +The following subsections present a list of requirements that we have for any
>>> +potential build system. Sections are sorted by decreasing priority, even though
>>> +these priorities will naturally differ between users.
>>
>> This last sentence sounds a bit self contradictory - whose priorities are we
>> using?
> 
> I guess it's priorities as received by the author, namely me. I didn't
> quite know how to write this, as I didn't want to force my own prios on
> everybody else without saying so. But if people agree with the general
> ordering I'm happy to drop this sentence.

I think that would make sense - anyone who objects to the order you've 
selected can also say so in a review.

>>> +=== Platform support
>>> +
>>> +The build system must have support for all of our primary platforms as outlined
>>> +by. These platforms are:
>>
>> Something seems to have been lost when the first sentence was edited.
>>
>>> +  - Linux
>>> +  - Windows
>>> +  - macOS
>>> +
>>> +Furthermore, the build system should have support for the following secondary
>>> +platforms:
>>> +
>>> +  - AIX
>>> +  - FreeBSD
>>> +  - NetBSD
>>> +  - OpenBSD
>>> +
>>> +The platforms which must be supported by the tool should be aligned with our
>>> +[platform support policy](platform-support.txt).
>>
>> The platform support document does not use the terms primary or secondary
>> when talking about support so I'm not sure what distinction we're trying to
>> make here. Also where does NonStop fit into this?
> 
> Yes, true, and that's an issue from my point of view. I think we should
> make explicit the different kinds of support we have and have a proper
> list of systems that are supported and their general "support tier".

That would probably be clearer but as you say it can wait

> Anyway, that's a different can of worms that I don't want to open right
> now. My table is still crawling with worms from previously-opened cans.

It's going to take a while for me to get that image out of my mind!

> I've reworded this slightly now and added NonStop.

Great

>>> +=== Test integration
>>> +
>>> +It should be possible to integrate tests into the build system such that it is
>>> +possible to build and test Git within the build system. Features which are nice
>>> +to have:
>>> +
>>> +  - Track build-time dependencies for respective tests. Unit tests have
>>> +    different requirements than integration tests.
>>> +  - Allow filtering of which tests to run.
>>> +  - Allow interactive tests that drop the user into a shell with `test_pause` or
>>> +    `debug`.
>>
>> Does this last point mean we want to be able to selectively pass
>> --interactive to the test script(s) being run?
> 
> What I mean by this is that when I see that a specific test fails, I
> want to be able to execute only that single test such that things like
> `test_pause` fail. What I don't mean is that the build system should
> know to automatically rerun failing tests with that.
> 
> I've reformulated it to "Allow running tests such that utilities like
> `test_pause` or `debug` work."

Ah so this is basically "there should be a way to disable 
parallelization and let the test access the terminal"?

>>> +=== CMake
>>> +
>>> +- Platform support: not as extensive as GNU Make or autoconf, but all major
>>> +  platforms are supported.
>>> +  - AIX
>>> +  - Cygwin
>>> +  - FreeBSD
>>> +  - Linux
>>> +  - OpenBSD
>>> +  - Solaris
>>> +  - Windows
>>> +  - macOS
>>
>> This matches the list in the CMake README but in practice it is available
>> for a much wider range of platforms including all those listed below for
>> meson.
> 
> I was searching for an official statement, but couldn't find anything.
> Do you maybe have a pointer?

I've not been able to find any documentation but 
https://github.com/Kitware/CMake/tree/9c25632ba0ad0525b20195d371b3d78a8bcc4113/Modules/Platform 
seems to show which platforms and compilers are supported.

>>> +- Ease of use: easy to use, discovering available options is easy. The
>>> +  scripting language is straight-forward to use.
>>> +- IDE support: Supports generating build instructions for Xcode and Microsoft
>>> +  Visual Studio, a plugin exists for Visual Studio Code.
>>
>> This is my main concern about meson - it means we either loose the nice
>> integration on Windows that we have with CMake or we have to continue to
>> maintain both. As I understand it Microsoft Visual Studio support requires
>> the user to open a mingw terminal and run some to generate a build
>> description which they can then use form the GUI which is what the CMake
>> support was added to avoid. I guess they also need to install meson somehow
>> as well.
> 
> I'm personally not particularly worried about having to generate the
> MSVC solution from the command line once, as long as things just work
> from thereon without requiring the developer to jump through hoops to
> get it set up. It certainly doesn't seem like a particularly high
> barrier to me, and should be a huge improvement compared to our current
> Makefile.

It's an improvement on our Makefile but a regression compared to our 
CMakeList.txt which was specifically aimed making it easy for new 
contributors to get started without downloading any extra software or 
running terminal commands.

> I'm mostly there by now with the subprojects added in this version of
> the patch series, which make it way easier to use MSVC without all deps
> having been installed. But I still have to port over the SANE_TOOL_PATH
> hack that we have in CMake.
> 
> I do understand that just clicking a button to import a CMakeLists.txt
> is easier. It's mostly that I personally value the sanity that Meson
> brings with it higher, which is of course a subjective opinion.

Right, I suspect the people who added support for building git in Visual 
Studio with CMake have different priorities. It's a real shame the meson 
there isn't a meson plugin for Visual Studio.

Best Wishes

Phillip
