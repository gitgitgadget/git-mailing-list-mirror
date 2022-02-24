Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6B6C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 16:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiBXQ0F (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 11:26:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBXQ0B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 11:26:01 -0500
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE181D6386
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:25:19 -0800 (PST)
Received: by mail-qk1-f201.google.com with SMTP id l82-20020a37a255000000b0060dd39f5d87so3258428qke.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 08:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=k/N8+CYCTYfxxdyEH/FwlBaMSlkSBPvsAaJ0CyTWb4M=;
        b=OiZGCnaLye+WXgB/yEZB0I/0M31lOtoqvAbcT+RvcWeIFwItvz7w7RMGRb7P3E1ZTv
         G+xJrXjRne5z8jK+D8dZ3MuzfN3nJTeAgPaHeQz7x2D5E8sf7Nhj2GJybYliEq1obKVJ
         /zVc12Kb8EzgQWcDS1soOtLRac09hvVXFCB3/N77RuNKXqDMY2eb7DsuIsOwN1nC+YEK
         bgOiBkm7eFP+Q6ZcZVhS7BXvTtYgEWwA51WQtwM3/htxPMsfDu3uA2L/Gpc5ikEzqYdi
         oGKfZOs6fMcTi7/wQEFJCAVOwlEWHYwhzpR9Mu4z70iv1CV9FLse3s0F6w5LRbIJZkJW
         Fy5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=k/N8+CYCTYfxxdyEH/FwlBaMSlkSBPvsAaJ0CyTWb4M=;
        b=3e9D1j0lwDOOubw4nh1J8dkIyThFPDs77eKqcBRCyApHoTIRGdBapDFhihP8dZ9qAA
         K5XUxNhBd+KPA9lTWH8zDmuq5j4VoDp7jIUBEvvGyCDqfSlRoUkPLMcgJWWI+kGwhtmf
         XvLHambDKgCmF0EKhoOE8elGY1fLP7BSggNQJG+jqDc5jpYnpJlfVK37Ysnc30MnuJ4U
         /17hdWbaZypbzz658//CpSTjv9S1a8dEk6UD5QQ4QpUGN76rEOxln7L9NnXlvYue1O9y
         vox2uzpjkQCx93SKl7CAzz06me1pVHtBXenGM6V6F0QyNCYEqL17T1nTjjz7V/0inffx
         4oQA==
X-Gm-Message-State: AOAM5324R4uT10zxfgrtUQmL1hfj/c+BeYybTUEd+Bi1SXlOE5pX7Snb
        kLEg+TkSOkvawYMHtZaDhUkV5pH88tBYDg==
X-Google-Smtp-Source: ABdhPJzXKMW8JNYVyGJkxWY5XXsZRiZLf5uP9kEejineq5cOizhyfqS1094+p3ZY/nhMUJpC2YuuQW6Ml6qpFg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8f33:0:b0:4cb:95a7:928c with SMTP id
 y19-20020aa78f33000000b004cb95a7928cmr3665535pfr.42.1645719331538; Thu, 24
 Feb 2022 08:15:31 -0800 (PST)
Date:   Fri, 25 Feb 2022 00:15:29 +0800
In-Reply-To: <220224.8635k8a36n.gmgdl@evledraar.gmail.com>
Message-Id: <kl6lpmnc44wu.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <20220215172318.73533-1-chooglen@google.com> <20220224100842.95827-1-chooglen@google.com>
 <20220224100842.95827-3-chooglen@google.com> <220224.8635k8a36n.gmgdl@evledraar.gmail.com>
Subject: Re: [PATCH v3 02/10] t5526: stop asserting on stderr literally
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Thu, Feb 24 2022, Glen Choo wrote:
>
>> +check_sub() {
>> +	NEW_HEAD=3D$1 &&
>> +	cat <<-EOF >$pwd/expect.err.sub
>
> Hrm, I didn't know that would work, the usual style is:
>
>     cat >file <<...
>
> Instead of:
>
>     cat <<.. >file
>
> Maybe better to use that?

Thanks, I somehow mixed things up when I wrote that.

>> +	Fetching submodule submodule
>> +	From $pwd/submodule
>> +	   OLD_HEAD..$NEW_HEAD  sub        -> origin/sub
>> +	EOF
>> +}
>> +
>> +check_deep() {
>> +	NEW_HEAD=3D$1 &&
>> +	cat <<-EOF >$pwd/expect.err.deep
>> +	Fetching submodule submodule/subdir/deepsubmodule
>> +	From $pwd/deepsubmodule
>> +	   OLD_HEAD..$NEW_HEAD  deep       -> origin/deep
>> +	EOF
>> +}
>> +
>> +check_super() {
>> +	NEW_HEAD=3D$1 &&
>> +	cat <<-EOF >$pwd/expect.err.super
>> +	From $pwd/.
>> +	   OLD_HEAD..$NEW_HEAD  super      -> origin/super
>> +	EOF
>> +}
>
> These look a lot better, but instead of always passing the result of
> "git rev-parse --short HEAD" can't we just always invoke that in these
> helpers?
>
> Maybe there are cases where $NEW_HEAD is different, I've just skimmed
> this series.

I haven't found any other instances where $NEW_HEAD is different, so I
suppose we could move it into the helpers. I don't think it benefits
readability that much to do so, but if you think it's much better, I'll
incorporate it when I reroll this.

>> @@ -62,7 +82,8 @@ verify_fetch_result() {
>>  	if [ -f expect.err.deep ]; then
>>  		cat expect.err.deep >>expect.err.combined
>>  	fi &&
>> -	test_cmp expect.err.combined $ACTUAL_ERR
>> +	sed -E 's/[0-9a-f]+\.\./OLD_HEAD\.\./' $ACTUAL_ERR >actual.err.cmp &&
>> +	test_cmp expect.err.combined actual.err.cmp
>>  }
>
> I think this is unportable per check-non-portable-shell.pl:
>
>         /\bsed\s+-[^efn]\s+/ and err 'sed option not portable (use only -=
n, -e, -f)';

Ah thanks, my sed-fu is pretty poor, so I appreciate the tip :)

I used that because I wanted +, but I found what I needed from the sed
manpage i.e. that + is equivalent to \{1,\}).
