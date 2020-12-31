Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3620C433E0
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82090207A1
	for <git@archiver.kernel.org>; Thu, 31 Dec 2020 11:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgLaLUi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 06:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgLaLUi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 06:20:38 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E05CDC061573
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:19:57 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id j26so12622562qtq.8
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 03:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K/KYz92mY0kAM6qptuLcM/U6WxG4GA7mugvwQmcq2YY=;
        b=oAB3qunKfc6HmrI/0En5yY4EBp+sMdGhIvXUa4wPjVg+HGbxO0dhCz8qosXwuXIgsW
         A/c7/oJR9RhKvEI3sTGzjeOmNwzlOl94By4pFKthHzM5CGb/DXbBDtTxRZ2hvq0jFHMV
         G7rhvzTX3wuSYlj9GEnTt51rQtK2NHw3HVIyWy+v+WTlngzI+GgnaBVKRLOc5oJhHt9C
         /UZaGLrwX7DUgta0ZZdEgM6iuYN4/qR9eZtBa3pvj/BUCTKp3YReyp3FeZCtaVhLHuiA
         fwS3asflvSwWvhUWv8lOCZLiVQPpAScPzJ5O83WNm/cgKvuVfYvPeaMDZtMvzwRn7pQi
         TUDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K/KYz92mY0kAM6qptuLcM/U6WxG4GA7mugvwQmcq2YY=;
        b=sRjsEb+wpO901yj7ClspVY2NPd3828ewzE8odfQfbeoEwFRof1Lbffn5YCkc6VhyY1
         qj/O0ldz98ypp4zdIlpzfUcffASL8VCFCQFTfhGx80EUPtMUHUvDc793tg4ncYitzPiO
         /lzNEaQrMxDpcwxzZQKhRUe0SKhV3VUYxmVUIgEuuCMXXBPIUq0RWpn6IbOkxyVIu3yb
         bpO0pclyjJKceBzHO1vlTlcvIEwUKxd+ZYwj7glcGhcrC7tPKBkTjZhUzmH08N6u24gG
         QdxDmHGV29p7S6JCHdSw+NrnSvNDDhso1yW5H7US6ptzJiNu37VFgooTR6OV1m1FnimQ
         qw+g==
X-Gm-Message-State: AOAM533+LizXce24RhDaaFIW1yTbbHImokGBpTqdaWJhbXJoIG6bbD/t
        XeyIcAfljXD+iGax2kHTRcYOeG8Sbzk=
X-Google-Smtp-Source: ABdhPJxzuqEjSWcm3Os+YZUv3r0Gx0axBalgJ2Wl/z80VaJTNtlYtk9d2j24VP8aR+VoZ4uKIFRgyw==
X-Received: by 2002:ac8:7559:: with SMTP id b25mr55156043qtr.126.1609413596628;
        Thu, 31 Dec 2020 03:19:56 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id p10sm29855252qke.32.2020.12.31.03.19.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Dec 2020 03:19:56 -0800 (PST)
Subject: Re: [PATCH 03/10] merge-ort: implement unique_path() helper
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <pull.815.git.1608270687.gitgitgadget@gmail.com>
 <6ac555b3c0fe605fbbe6e304482c2e3aef321865.1608270687.git.gitgitgadget@gmail.com>
 <3a07f700-18fc-9f4e-3117-41e534d737b0@gmail.com>
 <CABPp-BF37UeBdF4T68rvOaFRtPyZ2uoUSe48V4K8CUigy77CfA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0636b843-5dbd-2855-5c43-8f65a528bbc9@gmail.com>
Date:   Thu, 31 Dec 2020 06:19:55 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:85.0) Gecko/20100101
 Thunderbird/85.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BF37UeBdF4T68rvOaFRtPyZ2uoUSe48V4K8CUigy77CfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/30/2020 10:10 AM, Elijah Newren wrote:
> On Wed, Dec 30, 2020 at 6:16 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 12/18/2020 12:51 AM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Implement unique_path(), based on the one from merge-recursive.c.  It is
>>> simplified, however, due to: (1) using strmaps, and (2) the fact that
>>> merge-ort lets the checkout codepath handle possible collisions with the
>>> working tree means that other code locations don't have to.
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>  merge-ort.c | 25 ++++++++++++++++++++++++-
>>>  1 file changed, 24 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/merge-ort.c b/merge-ort.c
>>> index d300a02810e..1adc27a11bc 100644
>>> --- a/merge-ort.c
>>> +++ b/merge-ort.c
>>> @@ -343,11 +343,34 @@ static void path_msg(struct merge_options *opt,
>>>       strbuf_addch(sb, '\n');
>>>  }
>>>
>>> +/* add a string to a strbuf, but converting "/" to "_" */
>>> +static void add_flattened_path(struct strbuf *out, const char *s)
>>> +{
>>> +     size_t i = out->len;
>>> +     strbuf_addstr(out, s);
>>> +     for (; i < out->len; i++)
>>> +             if (out->buf[i] == '/')
>>> +                     out->buf[i] = '_';
>>> +}
>>> +
>>
>> Thank you for pointing out that you based your code on merge-recursive.c.
>> I see that this implementation is identical to the one there. I question
>> whether this causes collisions in a problematic way, when "a/b/c" and
>> "a_b_c" both exist in a tree.
>>
>> To avoid such a problem, we'd likely need to also expand "_" to "__" or
>> similar. This might never actually affect any users because of the
>> strange filename matches _and_ we need to be in a directory/file conflict.
>>
>> And maybe it's not a hole at all? If it is, we can consider patching or
>> at least documenting the problem.
> 
> add_flattened_path() can certainly result in a collision, regardless
> of whether the char *s parameter has any '/' characters in it.  For
> example, if you are trying to get a unique path associated with
> builtin/commit-graph.c due to changes from the 'next' branch side of
> the merge, and builtin/commit-graph.c~next already exists, then you
> have a collision.  It's actually pretty rare that the parameter would
> have any '/' characters at all, since it's pretty rare for me to see
> folks (other than Junio) use hierarchical branch names.  But if the
> branch name were ds/line-log-on-bloom, then the provisional filename
> would be builtin/commit-graph.c~ds_line-log-on-bloom.  The '/' to '_'
> conversion exists just to make sure our new file remains in the same
> directory as where the conflict that caused us to need a new unique
> path occurred.

Ah, I am misinterpreting which '/' characters are getting squashed.
Thank you for fixing my confusion.

> But unique_path() does NOT end immediately after calling
> add_flattened_path() and there is no collision possible in the return
> from unique_path(), because it ends with a
>     while (strmap_contains(existing_paths, newpath.buf)) {
> loop that modifies the resulting path until it finds one that doesn't
> collide with an existing path.

And this extra care here is helpful. Thanks!

-Stolee

