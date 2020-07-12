Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ABEC433E2
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 18:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF6722063A
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 18:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kpG3jnyl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgGLSCg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jul 2020 14:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgGLSCg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jul 2020 14:02:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9BEC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 11:02:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g10so11986047wmc.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 11:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b0mC6SXebfjWQPgRgml1DJAXdtvdPGv4mCJYYha4poI=;
        b=kpG3jnylQ69qH0jZjVx+jtRfhMBDQ3GxorOTPrprssMhYO+xtbFIIpw8uHMgZMf6Bz
         kzdqumWdOHzVol9g8qBcb/kcyhFgdbQf1qIttCHoL1GAuQ+4r4VExI/kq8aQGS6I3CyQ
         DDtHEA7nky8LGCwYt2x8zQDlU1SnrwWSLOpec5OOceWf/bYFdJdAugwwovPDFXXT3C7+
         PQ3YoqcUFIQNlHJ1ESc/aMPSGMT5gwWGqZi9f2CF93piwXltKN8UqI+D/tX97r3YjEUF
         vYIRXEGX5yV1V/Fa98K5yDJP1UC3G1/SxhZE0aoNR944DgPe2Dlu4/WPHi7/iF3JNBk/
         U1zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b0mC6SXebfjWQPgRgml1DJAXdtvdPGv4mCJYYha4poI=;
        b=EsCYCWF4bWKijajFz6HbPtPttLQG5wkiFc1lp3+Bp1FrLy8LqCTBsD4n88yHd+WhEX
         NyM6dPcYsDoOUF0d2oEZtlpmfUfp172YTPzhZj2HEqIbVI4TdZyY1yPPMCLrWlgfUyYs
         JbuFPeRQHKUM5wLEGccI7mb/ykxbHG9aO8zzlnOV+8G5/Reuf8uxzloPDFnDhDXlWBaq
         nPUQUY/PKmK4WYHGSV9uZm/JG3Jwdcp+DIK8iNqEtJTWKy2iihwVKLdrqRUoGXH44Ypr
         EEq1VQAkg+imv7+p9l6b8VMJ5ZQVnvGMr+Y5huUn2F0GgPzYU/AXQmrP5yWT34uBdW8S
         Hc4A==
X-Gm-Message-State: AOAM532I83lqfW87EHLau9Kdn4i7E5veWYh2Zk+VgIZj99WAhPPU3XkJ
        2jmb3+g6qf3yIRaSlCujlTg=
X-Google-Smtp-Source: ABdhPJwC8xj8y5VK0OFicx6RhYPv3IeQNyWEStDOOThlnzIomuF1F4rAbY7lrb5BglPUnYYdoKRLKQ==
X-Received: by 2002:a1c:a181:: with SMTP id k123mr15404392wme.172.1594576954110;
        Sun, 12 Jul 2020 11:02:34 -0700 (PDT)
Received: from [192.168.1.201] (130.20.198.146.dyn.plus.net. [146.198.20.130])
        by smtp.googlemail.com with ESMTPSA id h14sm20859465wrt.36.2020.07.12.11.02.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jul 2020 11:02:33 -0700 (PDT)
Subject: Re: [RFC PATCH v1 06/17] merge-index: libify merge_one_path() and
 merge_all()
To:     Alban Gruin <alban.gruin@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200625121953.16991-7-alban.gruin@gmail.com>
 <0e20fa12-4628-d1fe-fc6e-df83d26edda3@gmail.com>
 <alpine.LFD.2.21.2007121330130.17922@andromeda.lan>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <6f1427f7-29f3-ef77-b2a9-41264dc2fd32@gmail.com>
Date:   Sun, 12 Jul 2020 19:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.2007121330130.17922@andromeda.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban

On 12/07/2020 12:36, Alban Gruin wrote:
> Hi Phillip,
> 
> Phillip Wood (phillip.wood123@gmail.com) a écrit :
> 
>> Hi Alban
>>
>> On 25/06/2020 13:19, Alban Gruin wrote:
>> -%<-
>>> diff --git a/merge-strategies.c b/merge-strategies.c
>>> index 3a9fce9f22..f4c0b4acd6 100644
>>> --- a/merge-strategies.c
>>> +++ b/merge-strategies.c
>>> @@ -1,6 +1,7 @@
>>>  #include "cache.h"
>>>  #include "dir.h"
>>>  #include "merge-strategies.h"
>>> +#include "run-command.h"
>>>  #include "xdiff-interface.h"
>>>  
>>>  static int add_to_index_cacheinfo(struct index_state *istate,
>>> @@ -189,3 +190,101 @@ int merge_strategies_one_file(struct repository *r,
>>>  
>>>  	return 0;
>>>  }
>>> +
>>> +int merge_program_cb(const struct object_id *orig_blob,
>>> +		     const struct object_id *our_blob,
>>> +		     const struct object_id *their_blob, const char *path,
>>> +		     unsigned int orig_mode, unsigned int our_mode, unsigned int their_mode,
>>> +		     void *data)
>>
>> Using void* is slightly unfortunate but it's needed later.
>>
>> It would be nice to check if the program to run is git-merge-one-file
>> and call the appropriate function instead in that case so all users of
>> merge-index get the benefit of it being builtin. That probably wants to
>> be done in cmd_merge_index() rather than here though.
>>
> 
> Dunno, I am not completely comfortable with changing a parameter that 
> specifically describe a program, to a parameter that may be a program, 
> except in one case where `merge-index' should lock the index, setup the 
> worktree, and call a function instead.

There is some previous discussion about this at
https://lore.kernel.org/git/xmqqblv5kr9u.fsf@gitster-ct.c.googlers.com/

I'll try and have a proper look at your comments towards the end of the
week (or maybe the week after the way things are at the moment...)

Best Wishes

Phillip

> Well, I say that, but implementing that behaviour is not that hard:
> 
> -- snip --
> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 6cb666cc78..19fff9a113 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -1,11 +1,15 @@
>  #define USE_THE_INDEX_COMPATIBILITY_MACROS
>  #include "builtin.h"
> +#include "lockfile.h"
>  #include "merge-strategies.h"
>  
>  int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  {
>  	int i, force_file = 0, err = 0, one_shot = 0, quiet = 0;
>  	const char *pgm;
> +	void *data;
> +	merge_cb merge_action;
> +	struct lock_file lock = LOCK_INIT;
>  
>  	/* Without this we cannot rely on waitpid() to tell
>  	 * what happened to our children.
> @@ -26,7 +30,19 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  		quiet = 1;
>  		i++;
>  	}
> +
>  	pgm = argv[i++];
> +	if (!strcmp(pgm, "git-merge-one-file")) {
> +		merge_action = merge_one_file_cb;
> +		data = (void *)the_repository;
> +
> +		setup_work_tree();
> +		hold_locked_index(&lock, LOCK_DIE_ON_ERROR);
> +	} else {
> +		merge_action = merge_program_cb;
> +		data = (void *)pgm;
> +	}
> +
>  	for (; i < argc; i++) {
>  		const char *arg = argv[i];
>  		if (!force_file && *arg == '-') {
> @@ -36,13 +52,22 @@ int cmd_merge_index(int argc, const char **argv, const char *prefix)
>  			}
>  			if (!strcmp(arg, "-a")) {
>  				err |= merge_all(&the_index, one_shot, quiet,
> -						 merge_program_cb, (void *)pgm);
> +						 merge_action, data);
>  				continue;
>  			}
>  			die("git merge-index: unknown option %s", arg);
>  		}
>  		err |= merge_one_path(&the_index, one_shot, quiet, arg,
> -				      merge_program_cb, (void *)pgm);
> +				      merge_action, data);
> +	}
> +
> +	if (merge_action == merge_one_file_cb) {
> +		if (err) {
> +			rollback_lock_file(&lock);
> +			return err;
> +		}
> +
> +		return write_locked_index(&the_index, &lock, COMMIT_LOCK);
>  	}
>  	return err;
>  }
> -- snap --
> 
>>> +{
>>> +	char ownbuf[3][60] = {{0}};
>>
>> I know this is copied from above but it would be better to use
>> GIT_MAX_HEXSZ rather than 60
>>
> 
> Cheers,
> Alban
> 

