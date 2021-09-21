Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76C5C433F5
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D4C061186
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 18:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbhIUS5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 14:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbhIUS5d (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 14:57:33 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59012C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 11:56:05 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id x124so551728oix.9
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 11:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OOP769Fq0v0Y2SeqvKv8fav5oNYKJesw3GEsbQYcLbk=;
        b=OL5rR8bQwzETi1T4v871H0gqCMuMygEP80s2Jg998y5pv612oKzmbXT2V8Qj5kYkcY
         RQSDWZeRxt1qYh/EP17UsXKgwLW5NAUU3aAyZDaMOBMwALT93L2r7+sH2cWHpHXw+Sm9
         MKfnoDtwnMLUBaxcc36tuZDJCEGk3aJAcX48paSWeSM+oDSPp0ODyX9q5QhUPPZBhgfZ
         8CoCcT9XwFwG5W66X+j75SZZtP6i1gTxwgewd2iNFf2V+w2CBrxFOrxS+g56OQQTE72g
         eLJuVkJdm2lUzjPrpndSZOAWisTqjaO30dTfX0041oWNrF0xHvekHmY2yJ0aMDBLD/jr
         Q4eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OOP769Fq0v0Y2SeqvKv8fav5oNYKJesw3GEsbQYcLbk=;
        b=diAmNZ5bPMYlppGscnpnRWpbLSZ9qNDeYvB72CV5eKbangLoUMZbBmh8oK/HfupzVc
         hSK4k4p1/oZWOAgtIRPOu6fuQo8WsGgTUE4YTdtXg/jcMvR8CHObt7C1AktPzlmxZMJ8
         4af7+9UH3tne0H8mG9WM9vchFtm76HUOfXK8S35wR90C6i9TGefvi80NIzLFIh/Z/tdZ
         irG+OUfvNzev1rPaSuQvEVz8O9hY183MASDTK2SQSlQkoJrvefhF2TZ9pqkM+954+QDM
         0mdYCYQOC2wk0DHYntdQfXXfltfgXmGxWAnvnHq8jKK6QtMpChBslNyeD7RvtsXX0Ccy
         nJ2Q==
X-Gm-Message-State: AOAM533FczgT4exC/4YJZKRCEVrr/x0Uhcce6lNUNBFC0GbhDiPZmGHY
        dkSAIVPzSWnZRGLWNjHr7WOoX+V6K7GkXg==
X-Google-Smtp-Source: ABdhPJzt5EsT8MdgKJn60UnmbENmuOzpVjDNLkp1zKSDOLJvTlMBVHgXVU5U2XumvCeHxLPBqlg9Qw==
X-Received: by 2002:aca:3110:: with SMTP id x16mr4940361oix.64.1632250564274;
        Tue, 21 Sep 2021 11:56:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:ace4:98aa:c023:6ae9? ([2600:1700:e72:80a0:ace4:98aa:c023:6ae9])
        by smtp.gmail.com with ESMTPSA id q13sm4297549ota.17.2021.09.21.11.56.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Sep 2021 11:56:03 -0700 (PDT)
Subject: Re: Memory leak with sparse-checkout
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Calbabreaker <calbabreaker@gmail.com>, git@vger.kernel.org
References: <CAKRwm5a9PyqffEC5N__urSpNcZ-d5vz9GBM2Ei16eGS25B=-FQ@mail.gmail.com>
 <YUiuWSXO1P3JwerH@nand.local>
 <8a0ddd8e-b585-8f40-c4b1-0a51f11e6b84@gmail.com>
 <YUi55/3L9nizTVyA@nand.local>
 <b082f98b-eb49-7cc4-9f75-fe1ec480bd61@gmail.com>
 <b7ee5ff5-dfff-8d3f-36f6-b30daf2d71ec@gmail.com>
 <YUjcMu7Z094eaFRA@nand.local>
 <427c6d86-f123-035e-b0e6-4a21598ed111@gmail.com>
 <YUj7GN/qWhw67jyk@nand.local>
 <734ecf93-e563-20d5-7cf1-74048aa74d56@gmail.com>
 <YUoJGV0wj0ba7n8X@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <3c9af4e9-f3db-99af-d875-fb11bc8a643e@gmail.com>
Date:   Tue, 21 Sep 2021 14:56:01 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUoJGV0wj0ba7n8X@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/21/2021 12:32 PM, Taylor Blau wrote:
> On Tue, Sep 21, 2021 at 08:55:01AM -0400, Derrick Stolee wrote:
>> On 9/20/2021 5:20 PM, Taylor Blau wrote:
>>> On Mon, Sep 20, 2021 at 04:56:47PM -0400, Derrick Stolee wrote:
>>>>>> I double-checked this to see how to fix this, and the 'list' subcommand
>>>>>> already notices that the patterns are not in cone mode and reverts its
>>>>>> behavior to writing all of the sparse-checkout file to stdout. It also
>>>>>> writes warnings over stderr before that.
>>>>>>
>>>>>> There might not be anything pressing to do here.
>>>>>
>>>>> Hmm. I think we'd probably want the same behavior for init and any other
>>>>> commands which could potentially overwrite the contents of the
>>>>> sparse-checkout file.
>>>>
>>>> Could you elaborate on what you mean by "the same behavior"?
>>>>
>>>> Do you mean that "git sparse-checkout add X" should act as if cone mode
>>>> is not enabled if the existing patterns are not cone-mode patterns?
>>>>
>>>> What exactly do you mean about "init" changing behavior here?
>>>
>>> No, I was referring to your suggestion from [1] to add a warning from
>>> "git sparse-checkout init --cone" when there are existing patterns which
>>> are not in cone-mode.
>>
>> This warning is part of the sparse-checkout pattern parsing logic, so
>> it happens whenever the patterns are loaded, including the "list"
>> subcommand (among other commands, not just the sparse-checkout builtin).
> 
> I might be misunderstanding what you're saying. But what I'm wondering
> is: if we detect when existing patterns aren't in cone-mode, why didn't
> we catch that case originally when the memory leak was discovered?

Easy answer: there was a bug. The pattern in the original report evaded
the checks that were implemented to identify non-cone-mode patterns.

My patch 3 [1] fixes that problem, with this hunk:

diff --git a/dir.c b/dir.c
index 03c4d212672..93136442103 100644
--- a/dir.c
+++ b/dir.c
@@ -727,7 +727,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 	}
 
 	if (given->patternlen < 2 ||
-	    *given->pattern == '*' ||
+	    *given->pattern != '/' ||
 	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);

and a test case change is required to avoid having the warning message
appear in the wrong places:

@@ -182,9 +185,9 @@ test_expect_success 'set sparse-checkout using --stdin' '
 test_expect_success 'add to sparse-checkout' '
 	cat repo/.git/info/sparse-checkout >expect &&
 	cat >add <<-\EOF &&
-	pattern1
+	/pattern1
 	/folder1/
-	pattern2
+	/pattern2
 	EOF
 	cat add >>expect &&
 	git -C repo sparse-checkout add --stdin <add &&

[1] https://lore.kernel.org/git/d513b28b75189d066f9c66de44a1a578cbc38139.1632160658.git.gitgitgadget@gmail.com/

> I thought that it might have been related to your third patch to change
> how bad patterns are detected. But I ran the following script after
> applying each of your three patches individually:
> 
>     rm -fr repo
>     git init repo
>     cd repo
> 
>     git sparse-checkout init
>     git sparse-checkout add foo
>     git sparse-checkout init --cone
>     git sparse-checkout add foo
> 
> and the only difference is that we started silently dropping the bad
> "foo" pattern after re-adding foo in cone-mode starting with the second
> patch.

In patch 2, we "detect" that the old patterns were not in cone mode
because the core.sparseCheckoutCone config is false when parsing the
patterns, so use_cone_patterns is 0.

> I guess my question is: it seems like there may be a friendlier way to
> tell the user that we're about to drop their sparse-checkout definition
> instead of just doing it silently. And it seems like you're saying that
> we already have something that detects that and is used everywhere. But
> I wonder why it wasn't kicking in in the original report.

You are correct that we should make better documentation around the
re-initialization of patterns. And this _is_ a change of behavior and
I will cave to concerns around that. I think this is more a case of
matching what users expect from the interface, or at minimum helping
them fall into the "pit of success".

Let's move the discussion to that thread so we can interleave the
patches themselves.

Thanks,
-Stolee
