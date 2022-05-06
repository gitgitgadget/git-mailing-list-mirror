Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38DCC433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 10:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390816AbiEFKNd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 06:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380183AbiEFKNc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 06:13:32 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B401D5DBDE
        for <git@vger.kernel.org>; Fri,  6 May 2022 03:09:49 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id hf18so5557783qtb.0
        for <git@vger.kernel.org>; Fri, 06 May 2022 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ces3L2OSxlaM2qqyJmbJAdFcZ1SoZLe+7IE5wcPvBUw=;
        b=XkydPLmr8cuhoBtC1rgsdh9KNhKBAu7aVBFVBJUpXRSmvvlmdIliBZvsChaZbuHCc8
         nDqZRoGqmU+pjBrzB2E0hvliqH4usya50U1wWiMl6acNo8qWFkKdoRYVAOQvMm0SisBM
         +gO81Yxn2iNrGOhdL/JnCDVk2VvtsdpehTfpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ces3L2OSxlaM2qqyJmbJAdFcZ1SoZLe+7IE5wcPvBUw=;
        b=b4Y890QJAD/EjjQ/La0kyaR+5SZ2WtNAUTwEm47xApwaRdCsP6iP0HZvdRZXzbZjsp
         1owStE94BSj6q6ySWO2b6k5iJXb9XZFFPJTWVv/Qr16GlPcX9UaRwh3khRpiceYIpFAt
         XrDVb3svVo2kFxlSaSn5M4/h19TcMSxrdPjrCPgWGJs5rgvb/PTxe3h+KyGFqHay/y7c
         Bz1zGsYngbZY7PSL2D9Xc8jmFEuKJAUgoyPfaMYi9+dqJ10e/58DSKb52GlMkUZ1+mRp
         XBeAAXd0JvhqeI7OGCYZd/RBQKzqaWLHhXPpP0HbGLZU0G+nRUE2ixaTJLIwnBfetFW+
         I8iw==
X-Gm-Message-State: AOAM532rlg5wfLHKsHx7NalEjmYfOUMiOoT95cAo3bUQWMifCFDktnlL
        +jy2uzCZjWI2GiO4k8Su+5KsrA==
X-Google-Smtp-Source: ABdhPJwCwKrQL1ioh1earawz/kD5PO4MXDt09S1wai5zaHkj2+NttSjsCezZuo05CL6If2hrPDcY7A==
X-Received: by 2002:ac8:7c4d:0:b0:2f1:f584:ad36 with SMTP id o13-20020ac87c4d000000b002f1f584ad36mr1926940qtv.589.1651831788740;
        Fri, 06 May 2022 03:09:48 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3428])
        by smtp.gmail.com with ESMTPSA id j5-20020ac84045000000b002f39b99f6a1sm2623396qtl.59.2022.05.06.03.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 03:09:48 -0700 (PDT)
Date:   Fri, 6 May 2022 11:09:46 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 2/2] bisect: output bisect setup status in bisect log
Message-ID: <YnTz6mbP2UDrsTaL@chrisdown.name>
References: <cover.1651796862.git.chris@chrisdown.name>
 <acab8859d02c95750fdbc691ac672c17d5be0291.1651796862.git.chris@chrisdown.name>
 <YnSQDzhNjmu5ws4f@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YnSQDzhNjmu5ws4f@nand.local>
User-Agent: Mutt/2.2.4 (c3baa83e) (2022-04-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau writes:
>On Fri, May 06, 2022 at 01:52:54AM +0100, Chris Down wrote:
>> This allows seeing the current intermediate status without adding a new
>> good or bad commit:
>>
>>     $ git bisect log | tail -1
>>     # status: waiting for bad commit, 1 good commit known
>
>Hmm. I was worried that this would make it harder to turn the output of
>"git bisect log" into something you can inject into "git bisect replay
><log>". But it doesn't, because you prefix the status lines with a '#'
>character.
>
>That's good, and I think it's an improvement over what I'd currently
>recommend, which would be something like:
>
>    git bisect log | grep '^# bad:'
>    git bisect log | grep '^# good:'
>
>to see the state of our good and bad endpoints.

>
>I'm not totally convinced it _needs_ to live in "git bisect log",
>though, since it feels like additional information that is just added
>for convenience. That's not the worst thing in the world, but I think
>it would be fine to just take the first patch (with my suggestions
>applied) as well.

There was some discussion in the v1 thread (Message-ID: 
<xmqqv8uo1mk6.fsf@gitster.g>) about adding an additional `git bisect 
status' command, but while writing it my immediate thoughts were that it 
doesn't make much sense to separate from the rest of the log. I'm curious what 
Junio's thoughts are on that, happy to do it whichever way is preferred. :-)

>> Signed-off-by: Chris Down <chris@chrisdown.name>
>> ---
>>  builtin/bisect--helper.c    | 25 ++++++++++++++++++++-----
>>  t/t6030-bisect-porcelain.sh |  9 +++++++--
>>  2 files changed, 27 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
>> index 9d583f651c..ef75f0a0ce 100644
>> --- a/builtin/bisect--helper.c
>> +++ b/builtin/bisect--helper.c
>> @@ -404,6 +404,21 @@ static struct bisect_state bisect_status(const struct bisect_terms *terms)
>>  	return bs;
>>  }
>>
>> +__attribute__((format (printf, 1, 2)))
>> +static void bisect_log_printf(const char *fmt, ...)
>> +{
>> +	va_list ap;
>> +	char buf[1024];
>> +
>> +	va_start(ap, fmt);
>> +	if (vsnprintf(buf, sizeof(buf), fmt, ap) < 0)
>> +		*buf = '\0';
>> +	va_end(ap);
>> +
>> +	printf("%s", buf);
>> +	append_to_file(git_path_bisect_log(), "# %s", buf);
>> +}
>
>This direct use of vsnprintf might be avoided by preparing the output in
>bisect_print_status() via a strbuf and then calling:
>
>    append_to_file(git_path_bisect_log(), "# %s", buf.buf).

I'm not intimately familiar with the codebase, so maybe I'm missing something, 
but isn't it overkill to use a string buffer for something which is isn't going 
to then be used as a mutable buffer?

Happy to do it whichever way works for you folks, but would be good to 
understand the rationale so that I can write better patches next time :-)

>>  static void bisect_print_status(const struct bisect_terms *terms)
>>  {
>>  	const struct bisect_state bs = bisect_status(terms);
>> @@ -413,13 +428,13 @@ static void bisect_print_status(const struct bisect_terms *terms)
>>  		return;
>>
>>  	if (!bs.nr_good && !bs.nr_bad)
>> -		printf(_("status: waiting for both good and bad commits\n"));
>> +		bisect_log_printf(_("status: waiting for both good and bad commits\n"));
>>  	else if (bs.nr_good)
>> -		printf(Q_("status: waiting for bad commit, %d good commit known\n",
>> -			  "status: waiting for bad commit, %d good commits known\n",
>> -			  bs.nr_good), bs.nr_good);
>> +		bisect_log_printf(Q_("status: waiting for bad commit, %d good commit known\n",
>> +				     "status: waiting for bad commit, %d good commits known\n",
>> +				     bs.nr_good), bs.nr_good);
>>  	else
>> -		printf(_("status: waiting for good commit(s), bad commit known\n"));
>> +		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
>>  }
>
>Interesting; this patch removes the output that we were giving to users
>in the last patch. Should it go to both places?

Not sure I understand, we printf() in bisect_log_printf, no?
