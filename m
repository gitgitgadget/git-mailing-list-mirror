Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C114280324
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 19:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768246626; cv=none; b=k4f0AHFvCJg1211XVzljkMbzOyRdaDJoRA+L7zA/+bqNJ75GZahUszr6IpA64z2BRBRAyuXhO5dyUEI+ppBl+Wy6GqXo+vV8ocB7Jul+ndDZhrpgRgGcDOzN6Zxi3DPisk9Powlwgx3LSTymawriD3Nh915lR5a/N8mwhhlKyX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768246626; c=relaxed/simple;
	bh=be6iOttZGUNN5KonV0SAaVyyS8e4271S8sirVkACVw0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eemk0rYkP+AogrKuJUNRKtch8BL6gQ9XFp0VbjKRcXxI5NFUSADEHympG8rHqrfYr9ohIJCQNLzs/LzhdbJtpq1RLWMT9F3dOl1f2kC9jrfUeD5YSa4F7NVd8Zu6iE3SefMC67Tl81Z1QsvTHXpdTiR0D9Y2UdacYwEYcOZv/DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=PrSDbgbm; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="PrSDbgbm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1768246622; x=1768851422; i=l.s.r@web.de;
	bh=+L86v2kPyHg+2Aj8rZ/9PL6KjE1mQHKfRJYM/vA1OMw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PrSDbgbm7SWygyi7+jyheENdkpre4bfFB8J81ki4YsxLKXmvsvAtjIXCPiPchB7Y
	 GlvUsnwcLZUEaNVt6i5KBiVhoAJA8/luQA36wDw/LUCH20fy+VaLZ/vlt9br7d3BG
	 UE6m5p1g/KDfczly/z7jSTKZX4Ue5wc2iQuo9LudPfjSHdU/Akk/JdzVHKokDJ4sS
	 HtqrkSbbY/vnA9BZSh6Oh5P+ZtteO03BayfU5DXtfWu8ofHFdpvNDMcuppkyUUgGW
	 1kAV9xIYMFbcCRg5dFYftR3o8lMdDYtFAQNOrCZf83CeaA2tu94QWOdeVKntQAZwZ
	 eF8Xxdnv24xzLula1A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.19.215]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M6pUQ-1vlRBo1V6s-007byy; Mon, 12
 Jan 2026 20:37:02 +0100
Message-ID: <cf8330f2-e624-4d58-9250-57f0dbe7a0d2@web.de>
Date: Mon, 12 Jan 2026 20:37:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] environment: move access to core.maxTreeDepth into
 repo settings
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
References: <20260109213021.2546-1-l.s.r@web.de>
 <20260109213021.2546-2-l.s.r@web.de> <aWS9JLb3UyxOwg9Z@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <aWS9JLb3UyxOwg9Z@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OW/fJ6okgx0MIVtqJwZlAn3ujojLDVVUX2DUhEVfTTpImmPRbNu
 G0/DtYSVLf2uH/b2DOSWw0VkCd4tiQeOrYBDXcIgI/YymFvRI+KXAj+G+IERZ3+541nQc3t
 XKI7iY5FfoDKsPlvjS8ejejBzqr3SFMLyCmD5tfq2h5KJ6MxjVcDeBmfawkZvitHjc1BvmI
 x+wShZHzPc0BLL5fMFMjw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:QQrNXfvpKd4=;zXOgBSDhDK8R2owQuOS47CvFqdw
 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

On 1/12/26 10:21 AM, Patrick Steinhardt wrote:
> On Fri, Jan 09, 2026 at 10:30:12PM +0100, Ren=C3=A9 Scharfe wrote:
>> diff --git a/git-compat-util.h b/git-compat-util.h
>> index b0673d1a450..bebcf9f698c 100644
>> --- a/git-compat-util.h
>> +++ b/git-compat-util.h
>> @@ -578,6 +578,30 @@ static inline bool strip_suffix(const char *str, c=
onst char *suffix,
>>  #define DEFAULT_PACKED_GIT_LIMIT \
>>  	((1024L * 1024L) * (size_t)(sizeof(void*) >=3D 8 ? (32 * 1024L * 1024=
L) : 256))
>> =20
>> +#ifdef _MSC_VER
>> +  /*
>> +   * When traversing into too-deep trees, Visual C-compiled Git seems =
to
>> +   * run into some internal stack overflow detection in the
>> +   * `RtlpAllocateHeap()` function that is called from within
>> +   * `git_inflate_init()`'s call tree. The following value seems to be
>> +   * low enough to avoid that by letting Git exit with an error before
>> +   * the stack overflow can occur.
>> +   */
>> +#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 512
>> +#elif defined(GIT_WINDOWS_NATIVE) && defined(__clang__) && defined(__a=
arch64__)
>> +  /*
>> +   * Similar to Visual C, it seems that on Windows/ARM64 the clang-bas=
ed
>> +   * builds have a smaller stack space available. When running out of
>> +   * that stack space, a `STATUS_STACK_OVERFLOW` is produced. When the
>> +   * Git command was run from an MSYS2 Bash, this unfortunately result=
s
>> +   * in an exit code 127. Let's prevent that by lowering the maximal
>> +   * tree depth; This value seems to be low enough.
>> +   */
>> +#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 1280
>> +#else
>> +#define DEFAULT_MAX_ALLOWED_TREE_DEPTH 2048
>> +#endif
>> +
>>  int git_open_cloexec(const char *name, int flags);
>>  #define git_open(name) git_open_cloexec(name, O_RDONLY)
>> =20
>=20
> Why is this new constant defined in "git-compat-util.h"?

No particular reason, I just put it next to the existing similar macros
DEFAULT_PACKED_GIT_WINDOW_SIZE and DEFAULT_PACKED_GIT_LIMIT.

> That feels way
> too global for my taste for a value that should ultimately only be
> required by "repo-settings.c". Is there a reason why it's not declared
> in "repo-settings.h"?

No.  The same goes for the above two, I guess.  Or they could go to
packfile.h and DEFAULT_MAX_ALLOWED_TREE_DEPTH to tree.h.
> I think we could even get away with declaring it in "repo-settings.c".
> The expectation is that the settings need to be prepared anyway, so we
> can simply set up the default when parsing the config.

True, REPO_SETTINGS_INIT is the only user of=20
DEFAULT_MAX_ALLOWED_TREE_DEPTH outside of repo-settings.c and is itself
only referenced there, so we could make it private, or even inline it to
its only user, repo_settings_clear().

Ren=C3=A9

