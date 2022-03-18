Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B64EC4332F
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 16:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238967AbiCRQ3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 12:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239240AbiCRQ2D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 12:28:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EB28EB45
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:26:44 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j18so2797255wrd.6
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 09:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/jrDAHlvg2PIB44yZE0OYe9PDBCTai9gBzeHI6fiWK0=;
        b=FlCIdYotC14Y4DyI6MyH1PKddA6M2mlCSuhoHW6+j7NtFGtu7p8USjd5LxZv3jHu2C
         Kympe3qkX4fYWNFxP31HuILtFzffabJGkZQsv24cHqMc+nKsNtLfhtm4Gtn58muJBe4A
         sCoMRYBpihKTudcR4YKxZDt868N4US3BNhdXXj1kf8Mrwi0l9rYtOw1W7F61buKehHGz
         e7ahcGa1fI9t/g4VkInFqOsjYinYgRIFRB6tDx2dG/SQPrdP5lLF2+P+zlTwicOvGLkH
         T4KXK3VGMVKK4bC53hy1gXQ4eWF8i/jLN2b9UtlqOPp7xHPLAMGYqdOOGUNj6UFUsagu
         tRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/jrDAHlvg2PIB44yZE0OYe9PDBCTai9gBzeHI6fiWK0=;
        b=hkX427/kx+tZqbpBMQJZZlkoG5uTdTqYgOuG9+uU2ktp4AO4JVEh1L529hWFnxZq0N
         GC46vRia2F531D55UiF43zNjX2/zywNmkgwfCSVF7BmeKPoP983tVeRlUYwyxsEg6lzY
         2vweRqy2nh/p0XdALzhlxyBKmNfhmZqo8Ngg1Q8bZTtFV0wxIIU2V5tDYJ9tuDJLlKCX
         GcEO9W4hzBOVumXJuL9ypnzPD24Tndn8pQSaNFobLHdaj/jLYmlFVTK6iiDWY091woBS
         nBYKp0cE7UAi0dVZebIdfo+q3nza30yS6Pyq70Vv6ebQywHeTEmv5R3Lh2FF1dpuxMEQ
         wb2Q==
X-Gm-Message-State: AOAM530kq96R7qAwxDpMScyPsd0Pokyd63D1txX8FVT9GSPbAX2MuUEZ
        DZfkRdqEUAHjECht2Bv01rg=
X-Google-Smtp-Source: ABdhPJzmsnbGVEKPAjZRbXGyvdRFtmYPYQfRNl9wSEn2c5/LpoGXPfH/aWsWNUzAybsqDusIAm9nRg==
X-Received: by 2002:adf:ebd0:0:b0:1e3:f9b:7b77 with SMTP id v16-20020adfebd0000000b001e30f9b7b77mr8263620wrn.691.1647620802587;
        Fri, 18 Mar 2022 09:26:42 -0700 (PDT)
Received: from [192.168.1.240] (31.107.7.51.dyn.plus.net. [51.7.107.31])
        by smtp.gmail.com with ESMTPSA id i15-20020adffdcf000000b00203efad1d89sm4901672wrs.9.2022.03.18.09.26.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 09:26:42 -0700 (PDT)
Message-ID: <a67e0fd8-4a14-16c9-9b57-3430440ef93c@gmail.com>
Date:   Fri, 18 Mar 2022 16:26:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: C99 %zu support (on MSVC) (was: [PATCH 4/6] builtin/stash:
 provide a way to export stashes to a ref)
Content-Language: en-GB-large
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <20220310173236.4165310-5-sandals@crustytoothpaste.net>
 <220311.86bkydi65v.gmgdl@evledraar.gmail.com>
 <2422376f-79aa-2d35-2646-c3611e2ef8d6@gmail.com>
 <YjJbJ9ZXlUAd2evC@camp.crustytoothpaste.net>
 <220318.86bky3cr8j.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <220318.86bky3cr8j.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18/03/2022 13:34, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Mar 16 2022, brian m. carlson wrote:
> 
>> [[PGP Signed Part:Undecided]]
>> On 2022-03-14 at 21:19:10, Phillip Wood wrote:
>>> Hi Brian and Ævar
>>>
>>> Firstly I think this is a useful feature to add to git stash, thanks for
>>> working on it Brian
>>
>> Thanks.  I'm glad folks other than me will find it useful.
>>
>>> On 11/03/2022 02:08, Ævar Arnfjörð Bjarmason wrote:
>>>>
>>>> On Thu, Mar 10 2022, brian m. carlson wrote:
>>>>
>>>>> +	size_t author_len, committer_len;
>>>>> +	struct commit *this = NULL;
>>>>> +	const char *orig_author = NULL, *orig_committer = NULL;
>>>>> +	char *author = NULL, *committer = NULL;
>>>>> +	const char *buffer = NULL;
>>>>> +	unsigned long bufsize;
>>>>> +	const char *p;
>>>>> +	char *msg = NULL;
>>>>
>>>> These shouldn't be initialized unless they really need to..
>>>>
>>>>> +	this = lookup_commit_reference(the_repository, &info->w_commit);
>>>>
>>>> ..and some are clobbered right away here, so all of these should not be initializzed.
>>
>> This function got hoisted out of what would otherwise be duplicated
>> code, and that's why they're all initialized (because we would otherwise
>> have called free on an uninitialized value).  I can remove the ones that
>> aren't strictly needed.
>>
>>>>> +	buffer = get_commit_buffer(this, &bufsize);
>>>>> +	orig_author = find_commit_header(buffer, "author", &author_len);
>>>>> +	orig_committer = find_commit_header(buffer, "committer", &committer_len);
>>>>> +	p = memmem(buffer, bufsize, "\n\n", 2);
>>>
>>> You could start searching from orig_committer rather than buffer but I'm
>>> sure it doesn't make any real difference. The sequencer does something
>>> similar to this to replay commits when rebasing - is there any scope for
>>> sharing code between the two?
>>
>> I can look into it.  The amount of code that would be duplicated here is
>> very minimal, so I'm okay with just adding a few lines here.
>>
>>>> ...since by doing so we hide genuine "uninitialized"
>>>> warnings. E.g. "author_len" here isn't initialized, but is set by
>>>> find_commit_header(), but if that line was removed we'd warn below, but
>>>> not if it's initialized when the variables are declared..
>>>>
>>>>> +		for (size_t i = 0;; i++, nitems++) {
>>>
>>> Do we need i and nitems?
>>
>> I can look into removing them.
>>
>>>>> +			char buf[32];
>>>>> +			int ret;
>>>>> +
>>>>> +			if (nalloc <= i) {
>>>>> +				size_t new = nalloc * 3 / 2 + 5;
>>>>> +				items = xrealloc(items, new * sizeof(*items));
>>>>> +				nalloc = new;
>>>>
>>>> Can't we just use the usual ALLOC_GROW() pattern here?
>>> ALLOC_GROW_BY() zeros out the memory which would mean we could remove the
>>> memset() calls in the loops. I noticed in some other loops we know the size
>>> in advance and could use CALLOC_ARRAY().
>>
>> Yeah, I can switch to that.  I was looking for that, but I was thinking
>> of a function and not a macro, so I missed it.
>>
>>>>> +			}
>>>>> +			snprintf(buf, sizeof(buf), "%zu", i);
>>>>
>>>> Aren't the %z formats unportable (even with our newly found reliance on
>>>> more C99)? I vaguely recall trying them recently and the windows CI jobs
>>>> erroring...
>>>
>>> According to [1] it has been available since at least 2015. It is certainly
>>> much nicer than casting every size_t to uintmax_t and having to use PRIuMAX.
>>
>> If we're relying on a new enough MSVC for C11, then it's much newer than
>> 2015, so we should be fine.  It's mandatory on POSIX systems.
> 
> FWIW I dug into my logs and I ran into it with %zu (not %z), but that's
> what you're using.
> 
> Sorry about being inaccurate, it seems %z's portability isn't the same
> as %z.
> 
> I ran into it in mid-2021 in the GitHub CI, but those logs are deleted
> now (and I didn't re-push that specific OID):
> 
>      https://github.com/avar/git/runs/2298653913
> 
> Where it would emit output like:
> 
>      builtin/log.c: In function 'gen_message_id':
>      311
>      builtin/log.c:1047:29: error: unknown conversion type character 'z' in format [-Werror=format=]
>      312
>       1047 |  strbuf_addf(&fmt, "%%s-%%0%zud.%%0%zud-%%s-%%s-%%s", tmp.len, tmp.len);
> 
> This SO post, whose accuracy I can't verify, claims it is supported in
> VS 2013 or later, and that the way to check for it is with "_MSC_VER >=
> 1800":
> 
>      https://stackoverflow.com/questions/44382862/how-to-printf-a-size-t-without-warning-in-mingw-w64-gcc-7-1

Oh, so it is mingw that is the problem, not MSVC. Indeed using "%zu" 
(see the diff below) fails for the "win build" job[1] but the "win+VS 
build" succeeds[2]. mingw config.mak.uname to uses 
-D__MINGW_USE_ANSI_STDIO=0. Even if we could change that to =1 it would 
be insufficient as it does not affect the format specifiers allowed by 
__attribute__((format (printf, 3, 4))). I think to do that we would have 
to change "printf" to "__MINGW_PRINTF_FORMAT" for each attribute 
declaration[3].

In short unfortunately I don't think we can easily use "%zu"

Best wishes

Phillip

diff --git a/add-interactive.c b/add-interactive.c
index e1ab39cce3..1790ad6359 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -193,9 +193,8 @@ static ssize_t find_unique(const char *string, 
struct prefix_item_list *list)
         struct string_list_item *item;

         if (list->items.nr != list->sorted.nr)
-               BUG("prefix_item_list in inconsistent state (%"PRIuMAX
-                   " vs %"PRIuMAX")",
-                   (uintmax_t)list->items.nr, (uintmax_t)list->sorted.nr);
+               BUG("prefix_item_list in inconsistent state (%zu vs %zu)",
+                   list->items.nr, list->sorted.nr);

         if (index < 0)
                 item = list->sorted.items[-1 - index].util;

[1] 
https://github.com/phillipwood/git/runs/5601840748?check_suite_focus=true
[2] 
https://github.com/phillipwood/git/runs/5601840528?check_suite_focus=true
[3] https://sourceforge.net/p/mingw-w64/wiki2/gnu%20printf

> So if we are going to use it and that's true (which would be great!) it
> would IMO make sense to introduce it in some prep commit where we delete
> e.g. "_MSC_VER>=1310" and other things you'll see in-tree if you look
> through:
> 
>      git grep _MSC_VER
> 
> I.e. to push out some canary commit for using that specific feature, and
> along with it delete the old MSVC compatibility shims (which presumably
> we can't use if we're going to hard depend on %zu).
