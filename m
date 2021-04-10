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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D433C433ED
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 14:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31B456115A
	for <git@archiver.kernel.org>; Sat, 10 Apr 2021 14:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbhDJORj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Apr 2021 10:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbhDJORj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Apr 2021 10:17:39 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C94AC06138A
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 07:17:24 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n11-20020a05600c4f8bb029010e5cf86347so6435499wmq.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2021 07:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r7HKD/dgt6CzeD4jEi53Fa1jJ8k+yyvB0esS2zGZ/XA=;
        b=tFf0vYvU0ZJ3dUPpfWijz2cSsURLy/VRti+11lNJxHSfnOLwgP6pbuKw2tOv15jWxS
         3DDS410Zpa2OAFsDVv1ClcNl8XDRUhmPBW4QyhQttbWXRzeGXpnGFJ3EL6EUDGP6eQj/
         ihCgHCF7QtDbgJDOpE+es/IGOyfWp/9Jj4ofC70fERS/RLZP2amQRJ95QVg9QPsVrmYt
         +lY85ZblLMRHc26u/U+kvV09dgO3uXKRxLAMvVXLIfQFAX1XAbKFSYb4o/c5vGmnsEHq
         WheIYKF3f44XO4epG4Q3uoqH4hwYv5xVzHQ3Y0QbsxfWrN2L1exzaasvFE3BahWk2lMh
         LI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r7HKD/dgt6CzeD4jEi53Fa1jJ8k+yyvB0esS2zGZ/XA=;
        b=RrfDELDWZVDzKn+/7AG86k2Q3LNVh4y4x00Cz+lybvwym6Qsj0yg05I2bXmo1lDeuz
         J92sXmT6P3oQOMw1/ycKx6CBmJAzw+MbnByrv92FWpj+F0nbupcfrfcV3Yqie5J68swB
         +JZ0r6CtDgT0LdWWQBwhk0BRVBuAzM86DbSHPxjmuOXhbuZe66/q/Hg+DGSVfZaLcqvy
         WFdhlsWZ/vwjwYQ8y2IaetSFiawRFU6iWDlBHYwnWMFayzJVRbIv7ITXrry2sthEpsaF
         cx4b4sc+pbL/uTSYpgcB7KlQb83LVnHfgbIfWmdZJQN58xyZWieHrO8iNTWCoE/lvvNu
         Mv7g==
X-Gm-Message-State: AOAM533jajQDzusI0nRHKVXCwajZsALVLGwPNmg0KYKULVe+mKSBs2H6
        cE6lzJJca2/expCDRSSpdwY=
X-Google-Smtp-Source: ABdhPJwUlj0jMvtFHDi1MCDUuEewiDh4T1/h7Zt3rkdnsGADZS513gHYeDoE2orUUoldqN4h837bdw==
X-Received: by 2002:a05:600c:378c:: with SMTP id o12mr18514265wmr.69.1618064243319;
        Sat, 10 Apr 2021 07:17:23 -0700 (PDT)
Received: from [192.168.0.104] (abayonne-651-1-48-7.w92-156.abo.wanadoo.fr. [92.156.201.7])
        by smtp.gmail.com with ESMTPSA id c12sm9623496wro.6.2021.04.10.07.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Apr 2021 07:17:22 -0700 (PDT)
Subject: Re: [PATCH v7 08/15] merge-one-file: rewrite in C
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
References: <20201124115315.13311-1-alban.gruin@gmail.com>
 <20210317204939.17890-1-alban.gruin@gmail.com>
 <20210317204939.17890-9-alban.gruin@gmail.com>
 <nycvar.QRO.7.76.6.2103222303210.50@tvgsbejvaqbjf.bet>
 <c968a6b8-bc0e-04f0-b72d-9fef05b60bd8@gmail.com>
 <nycvar.QRO.7.76.6.2103241004590.50@tvgsbejvaqbjf.bet>
From:   Alban Gruin <alban.gruin@gmail.com>
Message-ID: <23f47974-36e2-7d28-49c0-e6ddc06c75a1@gmail.com>
Date:   Sat, 10 Apr 2021 16:17:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103241004590.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Le 24/03/2021 à 10:10, Johannes Schindelin a écrit :
> Hi Alban,
> 
> On Tue, 23 Mar 2021, Alban Gruin wrote:
> 
>> Le 22/03/2021 à 23:20, Johannes Schindelin a écrit :
>>>
>>> On Wed, 17 Mar 2021, Alban Gruin wrote:
>>>
>>>>
>>>>  	for (; i < argc; i++) {
>>>>  		const char *arg = argv[i];
>>>> diff --git a/builtin/merge-one-file.c b/builtin/merge-one-file.c
>>>> new file mode 100644
>>>> index 0000000000..ad99c6dbd4
>>>> --- /dev/null
>>>> +++ b/builtin/merge-one-file.c
>>>> @@ -0,0 +1,94 @@
>>>> +/*
>>>> + * Builtin "git merge-one-file"
>>>> + *
>>>> + * Copyright (c) 2020 Alban Gruin
>>>> + *
>>>> + * Based on git-merge-one-file.sh, written by Linus Torvalds.
>>>> + *
>>>> + * This is the git per-file merge utility, called with
>>>> + *
>>>> + *   argv[1] - original file object name (or empty)
>>>> + *   argv[2] - file in branch1 object name (or empty)
>>>> + *   argv[3] - file in branch2 object name (or empty)
>>>> + *   argv[4] - pathname in repository
>>>> + *   argv[5] - original file mode (or empty)
>>>> + *   argv[6] - file in branch1 mode (or empty)
>>>> + *   argv[7] - file in branch2 mode (or empty)
>>>> + *
>>>> + * Handle some trivial cases. The _really_ trivial cases have been
>>>> + * handled already by git read-tree, but that one doesn't do any merges
>>>> + * that might change the tree layout.
>>>> + */
>>>> +
>>>> +#include "cache.h"
>>>> +#include "builtin.h"
>>>> +#include "lockfile.h"
>>>> +#include "merge-strategies.h"
>>>> +
>>>> +static const char builtin_merge_one_file_usage[] =
>>>> +	"git merge-one-file <orig blob> <our blob> <their blob> <path> "
>>>> +	"<orig mode> <our mode> <their mode>\n\n"
>>>> +	"Blob ids and modes should be empty for missing files.";
>>>> +
>>>> +static int read_mode(const char *name, const char *arg, unsigned int *mode)
>>>> +{
>>>> +	char *last;
>>>> +	int ret = 0;
>>>> +
>>>> +	*mode = strtol(arg, &last, 8);
>>>> +
>>>> +	if (*last)
>>>> +		ret = error(_("invalid '%s' mode: expected nothing, got '%c'"), name, *last);
>>>> +	else if (!(S_ISREG(*mode) || S_ISDIR(*mode) || S_ISLNK(*mode)))
>>>> +		ret = error(_("invalid '%s' mode: %o"), name, *mode);
>>>> +
>>>> +	return ret;
>>>> +}
>>>> +
>>>> +int cmd_merge_one_file(int argc, const char **argv, const char *prefix)
>>>> +{
>>>> +	struct object_id orig_blob, our_blob, their_blob,
>>>> +		*p_orig_blob = NULL, *p_our_blob = NULL, *p_their_blob = NULL;
>>>> +	unsigned int orig_mode = 0, our_mode = 0, their_mode = 0, ret = 0;
>>>> +	struct lock_file lock = LOCK_INIT;
>>>> +	struct repository *r = the_repository;
>>>> +
>>>> +	if (argc != 8)
>>>> +		usage(builtin_merge_one_file_usage);
>>>> +
>>>> +	if (repo_read_index(r) < 0)
>>>> +		die("invalid index");
>>>> +
>>>> +	repo_hold_locked_index(r, &lock, LOCK_DIE_ON_ERROR);
>>>> +
>>>> +	if (!get_oid_hex(argv[1], &orig_blob)) {
>>>> +		p_orig_blob = &orig_blob;
>>>> +		ret = read_mode("orig", argv[5], &orig_mode);
>>>> +	} else if (!*argv[1] && *argv[5])
>>>> +		ret = error(_("no 'orig' object id given, but a mode was still given."));
>>>
>>> Here, it looks as if the case of an empty `argv[1]` is not handled
>>> _explicitly_, but we rely on `get_oid_hex()` to return non-zero, and then
>>> we rely on the second arm _also_ not re-assigning `orig_blob`.
>>>
>>> I wonder whether this could be checked, and whether it would make sense to
>>> fold this, along with most of these 5 lines, into the `read_mode()` helper
>>> function (DRYing up the code even further).
>>>
>>
>> Do you mean rewriting the first condition to read like this:
>>
>>     if (*argv[1] && !get_oid_hex(argv[1], &orig_blob)) {
>>
>> ?
>>
>> In which case yes, I can do that.
> 
> Yes, that's what I meant. Or this instead:
> 
> 	if (!*argv[1]) {
> 		if (*argv[5])
> 			ret = error(... mode was still given ...)
> 	} else if (!get_oid_hex(...)) {
> 		...
> 	}
> 
>> BTW the two lasts calls to read_mode() should be like
>>
>>     err |= read_mode(…);
> 
> While this is certainly shorter than
> 
> 	if (read_mode(...))
> 		ret = -1;
> 

So, I folded all of this into a single function that reads the mode,
convert the oid, and show an error if needed.  Now, I have:

    if (read_param("orig", argv[1], argv[5], &orig_blob,
                   &p_orig_blob, &orig_mode))
        ret = -1;

    if (read_param("our", …))
        ret = -1;

    if (read_param("their", …))
        ret = -1;

    if (ret)
        return ret;


> I actually prefer the latter, for clarity (we do want `read_mode()` to be
> called, i.e. we cannot use `||=` here, but it is also not a bit-wise "or"
> operation, therefore `|=` strikes me as misleading). What do you think?
> 

Yes, I think it's much clearer that way.

FIY, `||=' does not exist in C.

Cheers,
Alban

> Ciao,
> Dscho
> 

