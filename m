Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B79C04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 13:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiI1Nqx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 09:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiI1Nqv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 09:46:51 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAB89CCC8
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 06:46:50 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id j8so8110984qvt.13
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 06:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=WzXdB1h6reLvtBKjcdkFns4ESgSvzIr7Ii2+vePLhz4=;
        b=KEIgLUsTJL581uhgdWnjpE8G5Pwg/nfFHUSc7ozeZEDwTmvykDzV0zgqalKKaEYHC6
         MopF8nOjgzIhbwFS8CZnSOmos1InAb94AGoYMP6lDEOLSyzMQ5+5Fv1m9u3yUzOFR15o
         b5hCf/+MGLnVm0r/jIKbvLHLmLxBMwlKWpKQZvPa4PB79FrZYd2TXsx2EzknkJgKCIs8
         6VlAfWr0l9e0ZMOeqd+ppL2gmO3yLM6BhNO5QDiIiem1jYyC/NLAbHdsh+VeM7Cg1Who
         9n+htAYwzWHJ7sJS4b1JE4T0zTrTVQ9gW1C9yAxf3TfNaVVhuuXkMc/Q1YFFR5FIxXXp
         mBRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WzXdB1h6reLvtBKjcdkFns4ESgSvzIr7Ii2+vePLhz4=;
        b=jM9uuj2nDEA95zEuOPqf6qYHYpdX+Cd2IJHAgyITmPuy9Tsx/PdVmfg/hoQT+IoBtE
         +rkXKj3sePHM5v7B/OTqztmZh5kNn/rjusbL8nxAetRvh61AFocPVi/dbUJnP0h+lspn
         MkrKuLvZ4W3h/P45p1XaJq12hZWqkH2b3R/rsTle02hBo2wEqB3RDqSB5XYOrAlsOb89
         +gWUIX0V8iyN23fSZDxzWFaSfoU6AGn27Q/Auoz4J9NWwhKHnRFJ8ZLw0+OzMla2EaH1
         o2afIhMTWOe4KEsG3Uv84uzqgnHKzak1tbQto6fV6FQ7aOpDJcmritQY0PLah8OE+WpI
         j3Aw==
X-Gm-Message-State: ACrzQf1FnFPc50jfj8tKlT36Qc6sPMnd9uCYP5AkQWmyOhm/NHw0lKpV
        EVFw/3ZsnRlJK5HwNRLe60BFLUGopMV3
X-Google-Smtp-Source: AMsMyM7cpvWGlCeuzyTuuD7qHFkj3Pq6s+bsAsE6QnlsJlUYeR86gx2Mc6kQdy7NIh9lI+dbwKGEZQ==
X-Received: by 2002:a05:6214:23cc:b0:496:fa7b:2503 with SMTP id hr12-20020a05621423cc00b00496fa7b2503mr25112001qvb.38.1664372809847;
        Wed, 28 Sep 2022 06:46:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:7cc4:e6ac:5e8e:b74d? ([2600:1700:e72:80a0:7cc4:e6ac:5e8e:b74d])
        by smtp.gmail.com with ESMTPSA id h28-20020ac8777c000000b00304fe5247bfsm2820853qtu.36.2022.09.28.06.46.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 06:46:49 -0700 (PDT)
Message-ID: <26b3c9ef-5dd7-18f2-89c4-8d210a409ce4@github.com>
Date:   Wed, 28 Sep 2022 09:46:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [PATCH 4/5] config: return an empty list, not NULL
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1369.git.1664287711.gitgitgadget@gmail.com>
 <396343ce7dd17f86bbbc66197c6f0b4012caf445.1664287711.git.gitgitgadget@gmail.com>
 <220927.86sfkcyebf.gmgdl@evledraar.gmail.com>
 <b85d8a43-6640-aa9c-3103-0c3d43c2a479@github.com>
 <220927.86k05oy5oi.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220927.86k05oy5oi.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/27/22 3:18 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Tue, Sep 27 2022, Derrick Stolee wrote:
> 
>> On 9/27/2022 12:21 PM, Ævar Arnfjörð Bjarmason wrote:
>>>
>>> On Tue, Sep 27 2022, Derrick Stolee via GitGitGadget wrote:
>>
>>>>  /**
>>>>   * Finds and returns the value list, sorted in order of increasing priority
>>>>   * for the configuration variable `key`. When the configuration variable
>>>> - * `key` is not found, returns NULL. The caller should not free or modify
>>>> - * the returned pointer, as it is owned by the cache.
>>>> + * `key` is not found, returns an empty list. The caller should not free or
>>>> + * modify the returned pointer, as it is owned by the cache.
>>>>   */
>>>>  const struct string_list *git_config_get_value_multi(const char *key);
>>>
>>> Aside from the "DWIM API" aspect of this (which I don't mind) I think
>>> this is really taking the low-level function in the wrong direction, and
>>> that we should just add a new simple wrapper instead.
>>>
>>> I.e. both the pre-image API docs & this series gloss over the fact that
>>> we'd not just return NULL here if the config wasn't there, but also if
>>> git_config_parse_key() failed.
>>>
>>> So it seems to me that a better direction would be starting with
>>> something like the WIP below (which doesn't compile the whole code, I
>>> stopped at config.[ch] and pack-bitmap.c). I.e. the same "int" return
>>> and "dest" pattern that most other things in the config API have.
>>
>> Do you have an example where a caller would benefit from this
>> distinction? Without such an example, I don't think it is worth
>> creating such a huge change for purity's sake alone.
> 
> Not initially, I started poking at this because the CL/series/commits
> says that we don't care about the case of non-existing keys, without
> being clear as to why we want to conflate that with other errors we
> might get from this API.
> 
> But after some digging I found:
> 
> 	$ for k in a a.b. "'x.y"; do ./git for-each-repo --config=$k;  echo $?; done
> 	error: key does not contain a section: a
> 	0
> 	error: key does not contain variable name: a.b.
> 	0
> 	error: invalid key: 'x.y
> 	0
> 	
> I.e. the repo_config_get_value_multi() you added in for-each-repo
> doesn't distinguish between bad keys and non-existing keys, and returns
> 0 even though it printed an "error".

I can understand wanting to inform the user that they provided an
invalid key using a nonzero exit code. I can also understand that
the command does what is asked: it did nothing because the given
key has no values (because it can't). I think the use of an "error"
message balances things towards wanting a nonzero exit code.

>> I'm pretty happy that the diff for this series is an overall
>> reduction in code, while also not being too large in the interim:
>>
>>  12 files changed, 39 insertions(+), 57 deletions(-)
>>
>> If all callers that use the *_multi() methods would only use the
>> wrapper, then what is the point of doing the low-level manipulations?
> 
> I hacked up something that's at least RFC-quality based on this
> approach, but CI is running etc., so not submitting it
> now:
> 
> 	https://github.com/git/git/compare/master...avar:git:avar/have-git_configset_get_value-use-dest-and-int-pattern
> 
> I think the resulting diff is more idiomatic API use, i.e. you ended up
> with:
> 
> 	        /* submodule.active is set */
> 	        sl = repo_config_get_value_multi(repo, "submodule.active");
> 	-       if (sl) {
> 	+       if (sl && sl->nr) {

You're right that I forgot to change this one to "if (sl->nr)"
in patch 5.

> But I ended up doing:
> 
> 	        /* submodule.active is set */
> 	-       sl = repo_config_get_value_multi(repo, "submodule.active");
> 	-       if (sl) {
> 	+       if (!repo_config_get_const_value_multi(repo, "submodule.active", &sl)) {
> 
> Note the "const" in the function name, i.e. there's wrappers that handle
> the case where we have a hardcoded key name, in which case we can BUG()
> out if we'd return < 0, so all we have left is just "does key exist".

The problem here is that the block actually cares that the list is non-empty
and should not run if the list is empty. In that case, you would need to add
"&& sl->nr" to the condition.

I'm of course assuming that an empty list is different from an error. In
your for-each-repo example, we would not want to return a non-zero exit
code on an empty list, only on a bad key (or other I/O problem).

If we return a negative value on an error and the number of matches on
success, then this change could instead be "if (repo_config....() > 0)".

> In any case, I'm all for having some simple wrapper for the common cases
A simple wrapper would be nice, and be exactly the method as it is
updated in this series. The error-result version could be adopted when
there is reason to do so.

> But I didn't find a single case where we actually needed this "never
> give me a non-NULL list" behavior, it could just be generalized to
> "let's have the API tell us if the key exist".

Most cases want to feed the result into the for_each_string_list_item()
macro. Based on the changes in patch 5, I think the empty list is a
better pattern and leads to prettier code in almost all cases.

Thanks,
-Stolee

