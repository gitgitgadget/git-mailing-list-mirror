Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00632DB7BB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 15:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115353; cv=none; b=mxrILDL9kb/qGVOeyuocJpzjLEJYuGEpBlW2SN2hmBBbd2jNy1Z/xVmP2OtJ20viVzda1ilUMOOkbAQh6Qmu+78zCO3lNfe1T+1eXpL4EYkE9jRwYhfknCandKD+eMralQ4xy+F3aPilo7Z/61HVBDm7ptAkE6PA0Eo3P/Oyop0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115353; c=relaxed/simple;
	bh=UEHAMyzy35GG3216TL32BkGKxU/XUPEmE9FENJYWah4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GiOmW2ycD+xYFxt9MB0QrvRRVayyk4a7J0998XOxrK9n5pC42lhJW6eXh56mp1STM6QdlGZCWPWmPpfqZKC8lZez4XyvAkQxXTGD7iLO1zwJ2wwCCzYe0YJ2ivcTdbcp0uwPnAT++g0tdnB1VsyZ88vU6ac16uViXlJBS65KNls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r/iJ6M4r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=A3BvE7SQ; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r/iJ6M4r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="A3BvE7SQ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id B83761D000E2;
	Fri,  7 Aug 2026 11:09:10 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 11:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786115350;
	 x=1786201750; bh=BIL7sVtMCQs2MGuoYrP74pXBq+VSWjrKpBCjlmLZSCc=; b=
	r/iJ6M4rggqEexiOs4AvNBF9Lef8ea4I8LDGZAyALR08WR+M5nqAKoBLpM/Y/Wgp
	SkXkIUvt2ezn17JYOz0ELAqPWzc73Z1FZhsVmB0GNk6c/oYP+BbxtPPmlxTHoHHM
	8kcCWTE+F9Qh9ChWDlUUxNL5QiJIUmdUghshKclxGgB7zCdr+0IXlyzSreL46l9J
	IG7rLg3Vs4oZc0kWadssF+PpM9K2eTmeVRIGVGQ0kFmkYEjUvxXBWGDm3OkiRiFw
	/1GKCcORryOWP9rT2XL8CpQhRqT8zhwHVG0vkUSfZ607H9KmetgQyjVJZGCYCXMP
	ack4eh+NE/GhqQm7feERNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786115350; x=
	1786201750; bh=BIL7sVtMCQs2MGuoYrP74pXBq+VSWjrKpBCjlmLZSCc=; b=A
	3BvE7SQk06kp7RqKqQdLXp2Lry+GWU8Lh4ouyHSkF6xMjNBQdQSLB+DttscuYHfX
	FjZrbWC2tcunIuLU1xdnm7jLSguaAWMD68WeKfpMG8aWHVPA8azksrrXPYzhwT7t
	3tlhLmlvjKjANLqZvj6Z+0DvjMVTQj8d+wzjKjHXwtq8lRzcfg42gRZuqstw+9JQ
	gctD6ArCZKL36T7Gi5COf1riHwjg+AWs+AOw2j2mW22saxNcSjDwikic1FAlFft2
	TiBFumsEaBuN5MJunuyGwlwV97QxhC7AZcuu5NVEB/rjZTRhanK5brrp0AZi2m46
	IfXQvH6OeUf9zhbyfTdOg==
X-ME-Sender: <xms:FvV1alEacBgFeuHYpj83VBmYZDo6YFhMXfgL1kJDwbGCRZKL-J6iuw>
    <xme:FvV1as7av9Ji33gOzxFghSw2kznHCyl37pX6XFXyf2eMaEbbb_aRlZEOSYuypFJ2b
    cb1RUyWW_mLQWCaqCGBM6n8HfHuKKIoZoU_u1WUmILg61r2E2QEaGY>
X-ME-Received: <xmr:FvV1aqwSS_ubpxWKfiAx-yYiXtLMV0-rnN9JtThDitVLKMHB9KA5bH9o-YL-uj0ihyD1Vm3KhXMVdaqcEfMMwmCBWuN59Xwt6w>
X-ME-Proxy-Cause: dmFkZTGEqvN9dqYpH+sS3Ox55YG9t96+YcDitLsqzKfqtzCgyIDcAPoUS65JIDpXXy66uz
    cJ7YMkf28/ckr3KUyqtYWfMCfzC4W1nSX6VllJXera5iSLqzkoA5Eg4tZTroa+OiSgakhx
    CJ0IqeKLUHspYNb86HWzBcu9Yuj5xklsvbgJfSBsp/Bo33h0XDGBjJtUrUx9m3MYBjv8Mg
    PKWHVgpomxq0f/sI3x6ZEa8naqfW6nAI5yQOPNZFmp7zI3fpBtfWpshN3SLqdzrdI4ergw
    pZf7Up0ICvEiAozwOs0OT55d2V8RVZLXDb65TEF0L4BFRtPlSSflnpehfxK3HUeQiMijOw
    8F/CeI6e+SkYX61YKUlYHfoyiInFpouYWJQBjuWgksjPncWp3oydFjjBObqxsFyYqxydGf
    DEXMqAIoDumQYIt4pD/n6zQLwz7e0rrWCjB04mT8XPjhlBcV8aj5WHexBLRQoLvwIjp5+p
    CjCXnbxJxaQxP7+XGFfE5txqRimenHMfhuNwAjiA/hemnq2Hp/fDdmPhQB4XC4NzGK5Ql7
    H4F5HOhgmMg22pcxyU82spJZS4+0lqdFQBqXEyhl88GiYyQrAOIfVKkl0GcduIuIy1aZF6
    OlvButgOvEDGc2T7uy8G/Fjfl+7ibU2vI0Bdwcn4JNZ5SpxeOtrklTE2qipA
X-ME-Proxy: <xmx:FvV1arMw2t2uqC_n9uUlr309NLsfsqhDHhnzHvm-38tvX1vIryU55w>
    <xmx:FvV1agm-Kx4y_Q72SKpVCdsPADTXLqxWHCZUadUdNhc3YcKdtSs4Ig>
    <xmx:FvV1agS2STU76Z6MLCgfXTvPpQX3O0cB3CFgnzWGkAW4d-E9JW0N5A>
    <xmx:FvV1avUTofZg2BMedF5tAj40FeqBBhV-NjxncAbVLwGXYM0L2aLeVA>
    <xmx:FvV1anBJo6cp7ADwuoExPiDXUD2NfwiNzIwVLvD_DnMbrHX_RgVPnlN5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 11:09:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org,  Philippe Blain <levraiphilippeblain@gmail.com>,
  Britton Leo Kerin <britton.kerin@gmail.com>,  =?utf-8?Q?Rub=C3=A9n?= Justo
 <rjusto@gmail.com>,  Patrick Steinhardt <ps@pks.im>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>
Subject: Re: [PATCH v4 1/3] completion: no-op refactoring of diff completion
In-Reply-To: <CABPp-BHhNHBN0Mt0LVjGEcNL_y7mad7rS6NRX6p14ELrRD-+bg@mail.gmail.com>
	(Elijah Newren's message of "Thu, 6 Aug 2026 23:15:52 -0700")
References: <xmqqcxw010me.fsf@gitster.g>
	<20260807013830.698340-1-gitster@pobox.com>
	<20260807013830.698340-2-gitster@pobox.com>
	<CABPp-BHhNHBN0Mt0LVjGEcNL_y7mad7rS6NRX6p14ELrRD-+bg@mail.gmail.com>
Date: Fri, 07 Aug 2026 08:09:08 -0700
Message-ID: <xmqqpkzuezmz.fsf@gitster.g>
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

> On Thu, Aug 6, 2026 at 6:38 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> The "git diff" completion function punts very early when it sees
>> "--" on the command line, since it is a sign that options or
>> revisions can appear and the current completion does not need to do
>> anything "git diff" specific. By returning, it lets Bash default
>> action that completes the names of the files in $PWD to kick in.
>>
>> In preparation for the next step to change what happens when we
>> "punt", arrange the code flow to avoid this early return.  The
>> behaviour at this step is unchanged, but the control flow just
>> falls straight to the end.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>  contrib/completion/git-completion.bash | 61 ++++++++++++++------------
>>  1 file changed, 33 insertions(+), 28 deletions(-)
>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
>> index e875787710..ccd3b2a372 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -1947,35 +1947,40 @@ __git_diff_difftool_options="--cached --staged
>>
>>  _git_diff ()
>>  {
> [...]
>> +       if ! __git_has_doubledash; then
>> +               case "$cur" in
>> +               --diff-algorithm=*)
>> +                       __gitcomp "$__git_diff_algorithms" \
>> +                               "" "${cur##--diff-algorithm=}"
>> +                       return
>>                 ;;
>
> The refactor in this commit is a faithful no-op -- every arm got
> re-indented by one tab as expected.  One tiny slip, though: this first
> case's ";;" didn't get the extra tab that every other arm received.

Good eyes.  Will fix.
