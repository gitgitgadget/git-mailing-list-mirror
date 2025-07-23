Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A3A2E36EB
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753289098; cv=none; b=Qj75sG2X3d/omOhS8Nxu5VrUkvQFW63RPN6yVqoUkdlt3Lb32FxSzGcqCO/CK4MmUzG1VkWy+AaeGIkUJt5WE6dSVdH8HVd7n+1Xa/6+mKxtZj39R1YXZ/etN+8G3nnzhFIMoesu5/tfgBUXW8rKZ+VPbrSux0cVFc0i6cPGPes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753289098; c=relaxed/simple;
	bh=cSYST3eipjlj40flOxGOrMqbd35iKx0n/86bgAK1lXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mhXKiMedv9HLRNShorx0sHaXXMrcVupK5lr7FAB02opxeYg+nrj+SE1wlv7KUsS5I5TzHfvUQVLAaO489Jj8YovTezeNVEXmz3p9HSnBl8M3Ml8H2/odXilmssrW5rENy6k+rJopUSa7gjVCd/swGDXfH1Cr4S+Ul1DAFyKqLl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZDXyV5Pd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gVa+h+/U; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZDXyV5Pd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gVa+h+/U"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0F229140011F;
	Wed, 23 Jul 2025 12:44:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 23 Jul 2025 12:44:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1753289095;
	 x=1753375495; bh=e1UAmO/BUNWFTGFPLOiSkXky7HcU+llFzITkY3iINtw=; b=
	ZDXyV5PdJR/iTUBnEB8LR4jXtYN/Oe3hvUvuikzlcXNtny4zBr4zBsuNvMsA8Gz6
	EBI/UGbbLbLC+BLEHgUXd1+zhcb4ZjvcdUo0U7k/445v90UhARsZi/6jIAcVsAxs
	0wttB0mL/Fk0if8OYxWAlrBjNEUOxAr1cXuSTiYCudTO8makRfUfwIRZO4BXEmzG
	PLYwoysb39EKgYKRz0/2IxduFHBGDiK4Fi1N/UNaMyLWPM8jFKdeerYWNhaZ3xv7
	M4Q4jLR7XUhZ+vtsuxB0w/FbgREG0Yg/fV64ADPqw3Oh1K5rvevVo5d8hLD3JBWO
	lt7HZeTKkfOgsqq/5O/oHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753289095; x=
	1753375495; bh=e1UAmO/BUNWFTGFPLOiSkXky7HcU+llFzITkY3iINtw=; b=g
	Va+h+/U2GF8wEcmE7aEgKhgdhyJHIYVhhcHAHbFnDAoa0VJKT9e0vvWpbitYCiw/
	SfzOyqtFu1xYpIfqjq3xwaze8cyiUdfygiWD+/rhAYRfebKg+2VkMd43IrD3GzBi
	9AwmC4FJ/eK8KVbSpC4XxGbqOzxOESkkBO2u+f1NunSQ9iVt3o/rxjXG4tDGQRI7
	kSKYWTYk+t+0lzk6quvgrtxe9XUjSq8rLGnEfWAzfyi+xMpw9m6DYx2YBuqmmQ6d
	1u+5F4ROiBj1KosQIGX/HAnLx3i4jzZyd2bBkFek9WgjPCAaShPSz2IDTe1zJ262
	IWFhv0T0qaxCq/yojwyPw==
X-ME-Sender: <xms:hhGBaHz93qa3ONjlGzQQHgAZwo8FfSARXJfkXmK0MtjScwLJsxH1pA>
    <xme:hhGBaJ1j6Qij2jx5PP4-YKAt9Pv14AnPGXeyRD2iVccGQDRwKq2oY3RLNv44PSSBv
    yonf2vKLupD24Vi-Q>
X-ME-Received: <xmr:hhGBaN6Fuk4nTYEwhQ4H8iWPeglVEIGaFoIaGLyF_eR8zhjOg_mUiQuaYCQh5IhgfW61qleN1GhNWEU8gEDytusQJioEDQwIOCQ3lj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejkedvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtg
    homhdprhgtphhtthhopehlhhihfihkugdvvdesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:hhGBaEWpmbPMK1Q9EyYqOYcCByElf73lqpDi_7F2PQ2iDXB9vbaYVA>
    <xmx:hhGBaEBes7Yq5EmMN08WwNCNDlC6EHZjATmH_IP-6r2vG_Lbs7AX3w>
    <xmx:hhGBaL6099ugZUoUL2dmS-wLAooJwtkuHUnstmtu0yLZD9M7NM_alg>
    <xmx:hhGBaHyPL7MuNv0iewwt8PTnLl7bGGcVzPbzw1ZyzIdNjNcS9RWIkA>
    <xmx:hxGBaDAcvMc23SsOIOf8bNG0j_HOEtH4fT0DkzaSHmSDRf8BvnvOwoqY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 12:44:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Hoyoung Lee <lhywkd22@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
In-Reply-To: <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 23 Jul 2025 03:28:05 -0400")
References: <20250722174102.1876197-1-lhywkd22@gmail.com>
	<20250722174102.1876197-3-lhywkd22@gmail.com>
	<CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
Date: Wed, 23 Jul 2025 09:44:53 -0700
Message-ID: <xmqq5xfiq2ka.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jul 22, 2025 at 1:41 PM Hoyoung Lee <lhywkd22@gmail.com> wrote:
>> Initialize `fd` to -1 and unify all `open()`-related `close()` calls
>> under a single cleanup label. This prevents undefined behavior when
>> `fd` is used without initialization in error paths.
>
> It's not clear what this means. As far as I can tell, the original
> code never used an uninitialized `fd` in error paths.
>
>> The cleanup logic now safely avoids calling `close()` on invalid
>> descriptors and ensures consistent resource management.
>
> Again, it's not clear what this means. Although your previous version
> of this patch did add a call to close() with an invalid descriptor,
> the original code did not do so. So, the above statement seems to be
> misleading.

Great to see that good guidance is offered to new folks.  Yes, it is
a great thing to keep in mind to describe the latest iteration for
readers who haven't even seen the previous iterations.

> Those issues aside, the patch itself has problems, some minor, such as
> making the code a bit confusing or misleading, and some major, such as
> calling close() on an already closed descriptor.

>>   data_size = st.st_size;
>>   data_buf = xmalloc(data_size);
>>   if (read_in_full(fd, data_buf, data_size) < 0) {
>>     perror(argv[3]);
>>     goto cleanup;
>>   }
>>   close(fd);
>
> The descriptor is closed manually (again) because a subsequent open()
> call is going to reuse the variable. However...
>
>>   if (argv[1][1] == 'd')
>>     out_buf = diff_delta(from_buf, from_size,
>>              data_buf, data_size,
>>              &out_size, 0);
>>   else
>>     out_buf = patch_delta(from_buf, from_size,
>>               data_buf, data_size,
>>               &out_size);
>>   if (!out_buf) {
>>     fprintf(stderr, "delta operation failed (returned NULL)\n");
>>     goto cleanup;
>>   }
>
> ...although `fd` was closed, it still holds the previously-open
> non-negative file descriptor, which means that this `goto cleanup`...

Good eyes.

>>   fd = open (argv[4], O_WRONLY|O_CREAT|O_TRUNC, 0666);
>>   if (fd < 0 || write_in_full(fd, out_buf, out_size) < 0) {
>>     perror(argv[4]);
>>     goto cleanup;
>>   }
>>
>>   ret = 0;
>> cleanup:
>>   free(from_buf);
>>   free(data_buf);
>>   free(out_buf);
>>
>>   if (fd >= 0)
>>     close(fd);
>
> ...will arrive here and the condition will evaluate to "true",
> resulting in the already-closed descriptor being closed again.

Very clear description.

Thanks for your review.
