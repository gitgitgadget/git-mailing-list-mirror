Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE7E33F9
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 03:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754019809; cv=none; b=LW2Rzp9OzIPdIe1Q7N/FKuudR+Ub9dp2enAwCFyriNW/mqFkF9SND8WTQvQuhL+zv55aDgRrvfyOjKht7WtHcRaVD5/acKqsJJFaAqUO6AlkI4/I23v49oujUswmhXncykBZGy10ld3VK5I+hpX0KMb3XH74UhmtXDd9aKoRVH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754019809; c=relaxed/simple;
	bh=14a3chu0mki7+VnquoAAxzSDwX0mseCO1iqz62SjH5E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M4qyL4WApngqy7GLHOiVQBRX/FF1MP0gMkhc67TR6J8U8PJPACMSMfst+wZSUrZkYHYpVQ2CGp/oQtVuzj0EuDMqoBwhK6ljU9YUIBc0NfCa0voyYDqdMpJwuSqkSTPvuORS1n8vcLOsuWNcLfH4/yalzKBLFw5gkF2+aRW/pWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=adW/XRi7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nOrGdL4R; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="adW/XRi7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nOrGdL4R"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 26DCD1D0043E;
	Thu, 31 Jul 2025 23:43:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 23:43:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754019806; x=1754106206; bh=fAtJul9ZQV
	0dz080V4HEJY2suqKRU7r+AV4+xz3u8FE=; b=adW/XRi7UnBQkWGvxgBFLXE/sO
	cFE/Z9y8rBp6uYDxcMUdlbgb0gV7OWsB5HgKng9ageQ4mymkYQ9eOfW+JQljYCkB
	Rbqa6lp7Skz0lUn8K94mP0l96/15AbxU0e7prrn30ncTHCRVY26YedGZcKGETo3o
	YDOd0lxRk3wg+MQ8pTfabgJeBN0gWl07JMxoPVlS4X40rjQ3tL6aJMMkEBZCNu9G
	mGm49a2K6gr1MI+j1fXD0lXzWdeLwFCL2tRQ/WSXf2eV4PSBr6bSQbRJFbKZ3t6v
	Gy2q8V+2jXk1qwSyJ+0QMvVJQHMFKc1syoJYrsT/3rjlgo6+RBqMoXuw/5dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754019806; x=1754106206; bh=fAtJul9ZQV0dz080V4HEJY2suqKRU7r+AV4
	+xz3u8FE=; b=nOrGdL4R/CBapu+C0s/Ufl8kYKVDHzDO43Yo6AA3aHeBKI7zken
	DKGoC85RRr5/Gsb50GuErgc/InZgDya/WhMIchNq/My0NDydPlqJHow+T0pTtvDN
	OGnZ8TQ0g7CwSodirU1yssJXvDJuWwiHa6CgTLdSiOz+GsQv4iS+iluOKLqXRWhy
	VtP4XgvhD2qbZXVe1XHpLUGuGUAdAwzdHzKwI3tWR8imStUQBD1dSjqAsNGTojcx
	gLwt+7lwe2vlbLriatM4hG8A7diK8wpYKj4gSkwLFOdLCO5O/EEcanliQbNx+hoH
	dxEi9WfoxfF6EkHnmig9+lXEFAW8mU+bJ8w==
X-ME-Sender: <xms:3TeMaDt2jGf5GBuda0ugjbwDpjNIh76sy7bQt21lxkJWzQwz0l1mhQ>
    <xme:3TeMaHth6aUrmTFYsfO-BfPrFn8v-KDYUE2KCNT852CtHOTcrmEV33cOXOnLz9WqN
    6bCLV6b2PZs9K-kUQ>
X-ME-Received: <xmr:3TeMaAOHIcKB1za2gKp4c_77BVz8h17v3UXh10HGq9qpwv8F-MCTy12fCLnBofcUVHFD3Ma8kygU-xKbxoqiZxTtrTuEbx5YcleWVb8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvieegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhi
    rghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:3TeMaN2puEJtczFdKWfLt7Uvoj7l5qV3WcWUU4qVq4OkK8PuCLzMbA>
    <xmx:3TeMaENiipkR5AP_it-V_r0FMzgrxaGjs0YlkmdAmUPFW5en1X4uoQ>
    <xmx:3TeMaF0Sy9Ft_ucjVotmjNpV6vO-LCAP6HkKzayTIxlBGtBQeN-3zA>
    <xmx:3TeMaDEg4bytYCcCfLdHVYzFMhQABLNPRNU3_LK5fvKaOx5WqFCEjg>
    <xmx:3TeMaMVdPU9BNopx4YyYQTte4XBwUZd2BXnj2NCrLVmCLExdoz0T4Ir_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 23:43:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/7] string-list: align string_list_split() with its
 _in_place() counterpart
In-Reply-To: <aIwndQtEoKNXRG5z@mbp> (shejialuo@gmail.com's message of "Fri, 1
	Aug 2025 10:33:25 +0800")
References: <20250731063949.1601669-1-gitster@pobox.com>
	<20250731224607.3942417-1-gitster@pobox.com>
	<20250731224607.3942417-3-gitster@pobox.com> <aIwndQtEoKNXRG5z@mbp>
Date: Thu, 31 Jul 2025 20:43:24 -0700
Message-ID: <xmqqikj7ogf7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> On Thu, Jul 31, 2025 at 03:46:01PM -0700, Junio C Hamano wrote:
>> diff --git a/setup.c b/setup.c
>> index 6f52dab64c..b9f5eb8b51 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1460,8 +1460,9 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>>  
>>  	if (env_ceiling_dirs) {
>>  		int empty_entry_found = 0;
>> +		static const char path_sep[] = { PATH_SEP, '\0' };
>>  
>
> I am a little confused why we need to use `static`? Would this function
> be called many times?

I actually am confused why you would want anything other than static
here.  Writing this way would allow the compiler to realize that the
array can be prepared at compile time, without need to do anything
at runtime.  If you made it non static, the runtime code would
allocate two bytes worth of memory on stack, and stuff these two
byte values there, each time this block is entered, which would be
at least once.

> And I have a design question: by using "PATH_SEP", we need to convert
> this character to be string. Should we create a new variable named
> "PATH_SEP_STR" or whatever to do that?

Sorry, but I do not understand the question.  You want to see
something like

	#define PATH_SEP_STR "/"

you mean?  I do not offhand see why anybody would want to do so.

>> -		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP, -1);
>> +		string_list_split(&ceiling_dirs, env_ceiling_dirs, path_sep, -1);
>>  		filter_string_list(&ceiling_dirs, 0,
>>  				   canonicalize_ceiling_entry, &empty_entry_found);
>>  		ceil_offset = longest_ancestor_length(dir->buf, &ceiling_dirs);
>
> Thanks,
> Jialuo
