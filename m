Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E44BA9F6
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 14:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531681; cv=none; b=EMwQoFym1EPloTf20uxF0A8mtTdYSpVxAUrzNQQLqV8c9nufTwIu4fpwl38svUB8u0HEy7JONtA2MJ0BDXu81WVAX+H/FcAW5jukv/newNEJ8FFlmy1kk3jZ15G3YFPoGp3Q3mInKGl+G9bIP9C1QAdvcbMnERaCqNYhJVgb32w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531681; c=relaxed/simple;
	bh=aemOEC/hDzSCpbDX5xoRiCSC0BouNG6/TNQLLQWaD4g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UPTxQ9aPi77dWyZJhXxJvAJIV8A3ODPcmOjzhzulMRyLZLvnuxTaexBV+UiVKsGo20o1d4BBFAziOtI1kpXoZp/LwIW6MQZtwUR2fs7IA72irC4UAfzGoPSO/0WuQUxQ9bFvxY5Qk1D9+hxA/g0Fc6WU2QaD67/q/NIWKIP/Dp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Klq3Z+jC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g9292H2F; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Klq3Z+jC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g9292H2F"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AB3F140011B;
	Fri,  4 Sep 2026 10:21:17 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 04 Sep 2026 10:21:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1788531677;
	 x=1788618077; bh=WK0e6Jg/+8SIa9VzvcLMc6mEeC+RRmVZBdD8Tb4+9/Q=; b=
	Klq3Z+jCv/ZVru4bbqf1SW1WN0ir0sD/L5OEYaFONKtbGDfRyujiG7crul2f67Tv
	cfB0UzUwpDiEJFxabY14UdUqH928BJwyccFp3eYvv6NXTzkZ32RypGOOwCQYrbGV
	Yv55PmOoBrP6OWLEjl124IzDFHui77KewaN8M63ijabXWb6EBW8TYREwEKcASyfl
	JFxoYM8V8x0vvxywZ2JOBHE0UwslrXvvovPlgPj/5QaQS7MFYisXClPtoF/5hrov
	9z4uyaSF3uiSSTuJGXUsoq1NwqKQ8FEB6jaEp5lzrz2Bg9TW+xLqLrFYl0jM5OmW
	jQ3jw5/pKR7K94imbYo/pA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788531677; x=
	1788618077; bh=WK0e6Jg/+8SIa9VzvcLMc6mEeC+RRmVZBdD8Tb4+9/Q=; b=g
	9292H2FNtXhoguZ3CosSPoI2pvtfnt6brBXyMVe+9grtZGg32KEYlOhNraRmaGN5
	o0cykKhJjlTT1lfOG8zMR1Q+6KuA6w83KP+mrx+rz6Eqe2V81U6BEP5rjkrnET/U
	bix7uev62kubmS4totjZcmYqGwIH+ENw4nJ38kNBvgm9icDgSaZoMv+3/PQ8ZKCj
	rONsMpZ30dG/D01Felg5zP5r7dS7vXz0Z7uE8A4/9jJfuDj2zI6v5KFDqcHEjJEp
	oBqn7d6Q3cyjOxAEuD86nzF6236LdZmf3p5VCzMe/D1VFaJvkq114b1DVa4IC1R9
	6/moqN34Evb0mZdbMJiRQ==
X-ME-Sender: <xms:3dOaatbSfgfSThQx3ln1ncEBxQfzXyS0zrcukkovSwJ5vicHwK2ciQ>
    <xme:3dOaarbJ4nYVRleC7nZCwxP5SyOcTN5w8DRBwshzyPdpfW0vHx_tOzDIffaHF6wtM
    uU7OJE91O13sPd9nVrgOLA-1WQFHkgMuimQT_1EllOnp2dMZYZCJx8>
X-ME-Received: <xmr:3dOaak90e5XPC8TOXk1RyKV0CNwbnzrwoav3y2_ZsuRFdGTiCvRLdN5ZORMk_4M_WJ5aFFHbU9_BEm3hsZNdwL5KjZ5Ajvcu3w>
X-ME-Proxy-Cause: dmFkZTGq2lvlJCEwMZNEMUw5e6PtZLplmLfDgbbXyKjuDRd2MT5edUlzKpvrj9dzeqorNz
    Yc/y5qDdSvDq89/wUrTZDT3pxlZfJ46BdbWe025Q1Lk+6kXmSL3pQm8aBqNrR3iY7mPKFv
    +RXq+JL8WEn/9HHfWNEGqafeBCIg1VYsZrfdK5o1j+F9YQo7SpNXFkNz/mFA5epBpDmf7K
    MB7Mtw6I2Qz9O5EAVGPjoydfjuxfFasTqTjKFj5slwipbYd3ZhhF0hWf/qoOHq96YVLLaK
    fzHRsvuCH7vzmRXquSU26XNW6shl72IvI+eu6UVNZh0s9zTTz0aGzLibqNAJHLx7yWiha9
    UrR5omHnXf+fO3lvamKTrWsoOpaA6Yu4qjKNq5HXn70bpbDNiqg4TNrFeqf0EXLkpRYhUG
    OSSHwcaexqT20DXwF6vKhLOPVLZQtSltRa3d9ZdRNHXX04hq3ReeK58SbvqSK8OSabeGa8
    hcaH/EAGda7LG57NQ3dcHVaQPNtOTsxvg4wFJ34837sFJwunkfKMEh31vxqZeni6qSuQwt
    +toDgK4cMNAh4ECod2gnxx2uDM6G9Tdi/yJHCHCKPYAahOtlTsLUW0rThTWpieyVlEtEnb
    ufujsIpOsSODYWKdBjMD7PvU9h1LWgeYtGASSKydEd5eQIZQ+CaZ97K47taw
X-ME-Proxy: <xmx:3dOaaqiNAyQEFEkjFp4dZwepv6fL8n3WGqM4bsAAp76RnC4neRvRRg>
    <xmx:3dOaakd26Xq30hKPMgIWA8U6JoF3cpcYbCk-1Rm1FQI1DnQ4CoLmyA>
    <xmx:3dOaahp0tf-6MGvWZF45BrOfH6L6eWEKGE-OqtjO77661q77UPUgow>
    <xmx:3dOaapDedAKcU63HifhF4SYtVCXF3fnyJBRs2XXCEatuGpW3oTdEqQ>
    <xmx:3dOaai_immNNM1mJ-zwHHtFwutfLfa5r4-w4eEonVz4P8tHBTfoJZUOU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Sep 2026 10:21:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Yannik Tausch <dev@ytausch.de>,  git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dir: do not apply prefix to negative pathspecs
In-Reply-To: <CABPp-BFJo80oE=rtWc0FRNUxVh=6NHZeQmHD2q69VGwDcrHNhw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 3 Sep 2026 22:00:57 -0700")
References: <AA085B7A-F528-458A-8AA9-7664480997AE@ytausch.de>
	<xmqqecfbk2eb.fsf@gitster.g>
	<81EC0E28-13E7-4D10-BD07-3601124CBD77@ytausch.de>
	<886A25E6-8854-4AF6-BF0B-CFB57B673026@ytausch.de>
	<0617001F-13BB-4548-A10A-89877977CFB5@ytausch.de>
	<CABPp-BFJo80oE=rtWc0FRNUxVh=6NHZeQmHD2q69VGwDcrHNhw@mail.gmail.com>
Date: Fri, 04 Sep 2026 07:21:15 -0700
Message-ID: <xmqqmrtx6qsk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Elijah Newren <newren@gmail.com> writes:

> Hi Yannik,
>
> On Thu, Sep 3, 2026 at 3:23 AM Yannik Tausch <dev@ytausch.de> wrote:
>>
>> common_prefix_len() derives the common prefix solely from positive
>> pathspecs, skipping those marked with PATHSPEC_EXCLUDE. However,
>> match_pathspec_with_flags() also passes that prefix when matching the
>> negative pathspecs.
>>
>> A negative pathspec may be shorter than the prefix. In that case,
>> match_pathspec_item() advances item->match beyond its allocation and
>> subtracts the prefix from item->len, producing a negative matchlen. It
>> then dereferences the out-of-bounds pointer. If the resulting byte is
>> not NUL, matchlen is converted to size_t when passed to ps_strncmp(),
>> which may cause a much larger out-of-bounds read.
>>
>> The problem can be reproduced with AddressSanitizer:
> ...
> Would it make sense to add a regression case whose failure before this
> patch is deterministic without ASan?

Very good point.

Even if a negative pathspec were long enough, it would produce an
incorrect result if you strip the leading part of a negative entry.

With positive elements "a/b" and "a/c", and a negative element
"x/b", both paths "a/b/m" and "a/c/n" should match the pathspec with
these three elements, but if you incorrectly use prefix=2 to strip
the common prefix computed across positives, i.e., "a/", while
trying to see if the path "a/b/m" matches negative "x/b", we'd end
up trying to see if subpath "b/m" (in "a/b/m", after 2 leading
prefix bytes are stripped away) matches subpattern "b" (in "x/b",
after incorrectly stripping 2 leading bytes).  Yay, "b/m" begins
with "b" so it matches!  Not quite.

    $ git init
    $ mkdir -p a/b a/c
    $ >a/b/m >a/c/n
    $ git add a
    $ rungit jch ls-files a/b ':!x/b' a/c
    a/b/m
    a/c/n
    $ rungit master ls-files a/b ':!x/b' a/c
    a/c/n

So "if prefix computed across positives is longer than a negative
element" is a special case that may manifest as one extra breakage
(i.e., logically it is wrong in that it uses incorrectly shortened
pattern and path for negated matching and produce incorrect result,
but in addition to that, the negated pattern string points outside
the original string, accessing wrong piece of memory), but I tend to
agree that it is equally if not more important to demonstrate what
is broken even without that extra breakage.

Thanks.

