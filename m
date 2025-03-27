Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CF218DB1D
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 15:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743089320; cv=none; b=cXoO7t22X3Qqs8KruZSmwMP3kKIpfacAMlSnRs/2GWvpEgpiCeU0FYu0+3pvcwq+19wZ2dNHgK1G/OOF6gCSgKPiJpj2vE8uSaYlweOxopZg9GMaq6L5Xhx0tlQv9mP1NHXlONXI6MnBdJZexLFjhJHSJPJqlbakU1TecoKD3s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743089320; c=relaxed/simple;
	bh=IxGr6KonzU4L7P6x6wb8ryw8Ij+LdVzNsWWQiQrjblY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=c9JokC0au3X/q6LTEd5V4PbKLwAyLMfvfvEwAhjSFM2TioeAzaW6tngHvWzX+eJ/9OUDFcfMg01OLyPb8rlJ2mwEed5OoduOy0wBPJ6rPt77dXLJC28IqUtk4sQccYoOvVr1oxvCm6iERJXcGZhXBcJf1v55LnESzYrmdhsphHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qItn6h7l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ty5sGMOz; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qItn6h7l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ty5sGMOz"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id B73761383827;
	Thu, 27 Mar 2025 11:28:36 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 27 Mar 2025 11:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1743089316; x=1743175716; bh=FmCfm0tnYT
	GEODzu6l0AXR9iBouLgxV0YrjzXpfqK/M=; b=qItn6h7lLKsBZ8p/teaOhErEWC
	QIjSYUZSmiRznx301fY/5tz/rgsgHclzJbxRfeZym5lBpEMQN24e1HxLC4CKLAfR
	yATrtaXtNqspKS12JSE1xH3J0QYSVjBWkKQNVezIG1RDJQOnDc9lfv1iXmxe1NS6
	Nq/mNj24VBXczfc26Z0GVmKuSDNWKzfocgGp+UXFe3qKLlAKAq+BqOyhzMztJrl7
	gn5B/S4EFiQWpnHco+NgwV8EUIwiHiD6FUUAY75GcfAsbQ+ckdfc8iAJ8jDfbBmY
	Wivdus8Qu0TW4aCGQwE2IGaMuc0UGN4VpdKRm9iztLa0gB+QbsegAz/J7dsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743089316; x=1743175716; bh=FmCfm0tnYTGEODzu6l0AXR9iBouLgxV0Yrj
	zXpfqK/M=; b=ty5sGMOzWHWYZ8Vl+oVfYsghJs63TWvOQYxjIYJGYFvRo6ZO+TK
	CPn+vvW3aapTbJKhX4sW2/pJwsHjAyLXXaOdQcMDhPDdRD8p393jywwmiGuroLve
	0maQnDIQH1FnJlQzgY4wNmQQoZYSPFMIm5V4wLczsxcBsdf62g+AgWcgEKzsAfAc
	dRkUNJFdtppB3iTvI/C4yUPhdQNY987OlnjODIWtOeV9IH5WjF2R/VAgxLLPbW5j
	obKWuJ+v6ui2G+//fuG+IKcy4Z13ulHhPp6tY0k0Y6nrHp6vDAUqxBGwh/o0SCP9
	lH39/BrCBoULXbXNWEA6N9h+LeKWrHdUz6w==
X-ME-Sender: <xms:pG7lZ7mzqCsCU561dEdIB5T-E4cdWGsmvHbx9knEwq3S0X-Pfub5hA>
    <xme:pG7lZ-3XzozdPMxG2_0gaBKzPtRQfsCCU59hRZx80Yk56mzjLsjKji57VGYu6hdlH
    dM13Yb55S1KBf3wTg>
X-ME-Received: <xmr:pG7lZxo27VW2mzn39t5Gg47sx_PEPCWmfK6XpCe_HoERfExzln4QMHyYj5gK_y0ssAQVmCDsRjbFaHLpaViUsGNTfRD_X6t-XRhgtf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhig
    rdguvgdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:pG7lZznRdmVesZq-Mjt0Z3mQeXdTvu4ZIQhpDzKqfzzzgv49dNMwKg>
    <xmx:pG7lZ50PYH63Bm7d6fY5FcUzp8RlD7brRBwprQuCTDW60V7pfQztUg>
    <xmx:pG7lZytQkCiyGMX0sxLw5oJRwmAqmK4JrswPwHxC7U2YZvm7rIOx0w>
    <xmx:pG7lZ9VVupETpfu0alfk6LBuAL96TCwVr8KeRu0vwDLg8wfsqyB3Fw>
    <xmx:pG7lZ0TqDowCT1sKkah0zXqXjJ7ZgiFRD1K6iMfeuQSCEjLm27oscFC9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 11:28:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: ps/reftable-sans-compat-util, was Re: What's cooking in git.git
 (Feb 2025, #09; Fri, 28)
In-Reply-To: <9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de> (Johannes
	Schindelin's message of "Wed, 26 Mar 2025 17:57:19 +0100 (CET)")
References: <xmqq7c591sus.fsf@gitster.g> <Z8aeLc-xelujEjTE@pks.im>
	<0c808b85-d97c-ecd3-0b1d-fba546a1124b@gmx.de>
	<9cc294f6-03de-d88f-9734-510a23fc8991@gmx.de>
	<Z8bL0HUuQqj7LlTp@pks.im> <Z8bQsflIqzZd3AMs@pks.im>
	<9cd879ed-5366-a7bf-f440-e35222a733d2@gmx.de>
Date: Thu, 27 Mar 2025 08:28:34 -0700
Message-ID: <xmqq34eyijbx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Below patch addresses the issue.
>>
>> Patrick
>>
>> diff --git a/compat/posix.h b/compat/posix.h
>> index b484029f751..5ad3539d55b 100644
>> --- a/compat/posix.h
>> +++ b/compat/posix.h
>> @@ -176,6 +176,16 @@ typedef unsigned long uintptr_t;
>>  #define _ALL_SOURCE 1
>>  #endif
>>
>> +#ifdef USE_MIMALLOC
>> +#include "mimalloc.h"
>> +#define malloc mi_malloc
>> +#define calloc mi_calloc
>> +#define realloc mi_realloc
>> +#define free mi_free
>> +#define strdup mi_strdup
>> +#define strndup mi_strndup
>> +#endif
>> +
>>  #ifdef MKDIR_WO_TRAILING_SLASH
>>  #define mkdir(a,b) compat_mkdir_wo_trailing_slash((a),(b))
>>  int compat_mkdir_wo_trailing_slash(const char*, mode_t);
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index 8d2acf86670..a102a365592 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -226,16 +226,6 @@ static inline const char *precompose_string_if_needed(const char *in)
>>  # include <sys/sysinfo.h>
>>  #endif
>>
>> -#ifdef USE_MIMALLOC
>> -#include "mimalloc.h"
>> -#define malloc mi_malloc
>> -#define calloc mi_calloc
>> -#define realloc mi_realloc
>> -#define free mi_free
>> -#define strdup mi_strdup
>> -#define strndup mi_strndup
>> -#endif
>> -
>>  #ifndef PATH_SEP
>>  #define PATH_SEP ':'
>>  #endif
>
> I integrated this into Git for Windows' `shears/seen` branch (i.e. the
> continuously-rebased Git for Windows patches on top of the `seen` branch),
> and for the first time in weeks, it passed the CI build:
> https://github.com/git-for-windows/git/actions/runs/14087673643

Thanks.

So we'll see a final reroll with the above changes and the topic
will finally be moving?  That's a great news.
