Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85E2C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:46:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E098022B45
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 17:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtWjji+Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHCRq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 13:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgHCRq6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 13:46:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EBBC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 10:46:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id f9so323766pju.4
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 10:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zqjDRqlewtM8k2J/tIlreWgTXW1PxuLrvZTaxrsrxp0=;
        b=jtWjji+QYCXa+CMYTxJYQSD3BJLP1va6692SAei1+MTuNo60+u/eivQREvDO/rYgEj
         I1skw4JNoVSIS2oNul1W9QPp36OIONX/8jaD4q2KVAQ3EyooV7Dg/8poEtjQ3tcpt2nV
         yODFCiYYAgNy0SmWNGJrIL2XPW9bKkhomPiCz2W1IogqQKMfkEd3acXyoZffDYlsJ/nC
         oXqGxagSAF1S8LKVJg+/UiCOfS6+QBxZb+Bn54Sb6rDewHVo7C5XZ9zR3Ric2LJuVmXV
         JPxtwf+p17MFdEH5+yOkMFiqBooO7EVUEZakuETQ1GYvNg1ANwKXLzQlm/8Bds0y96Jd
         +KgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zqjDRqlewtM8k2J/tIlreWgTXW1PxuLrvZTaxrsrxp0=;
        b=glfvVRR9Ah1JgV7zX+wI2HyRdR3dDguAL0MwJKC5/LBMZeSk2H04/25hEDlj/ZYhZ/
         ri/OFFuCIxGDPbog2xiev4GBjvRT9gon3pBtFGGe/HC6Nln81wrHFLJHdJ0r57iX15d3
         JBLxBlxFqfVkth4t5soJB9xhVXFWDVN4DG2FvVQ9/6lSnrc1sRdRVFZoZOl1ijFViSJO
         oR5Wa15TOUy5Gy2CnIji/6Tvkd16QiUfnz8oPEiRyOfStwgSFuR5ez8m4zVE0Sklsdwy
         /6nwcc6KBlZU8B3/KQhy6nx0diXPyFGSZaYLHWObqmVykADp0+9HU7MKjnqVUwLuBtDI
         rNfw==
X-Gm-Message-State: AOAM533LBzyEbYWlO+a1mv1mmnbwZB6LNVV2jwuExKUEATXUTXwmHVwp
        PyA/qET0Py2xymyvkB8nzdc=
X-Google-Smtp-Source: ABdhPJxBr5JvAQ9t2rLTbbAmLkcj2yb+Tlb5cDGBDCpZizwntvsiApKQi2k3W73oPTC2Hy8L53TaAw==
X-Received: by 2002:a17:902:7281:: with SMTP id d1mr15057761pll.247.1596476817743;
        Mon, 03 Aug 2020 10:46:57 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id x6sm10226975pge.61.2020.08.03.10.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 10:46:56 -0700 (PDT)
Date:   Mon, 3 Aug 2020 10:46:54 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200803174654.GA2473576@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 7/30/2020 8:30 PM, Jonathan Nieder wrote:
>> Derrick Stolee wrote:
>>> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:

>>>> [jrnieder] How do I supply the tasks on the command line?  Are they
>>>> parameters to this subcommand?  If so, it could make sense for this to
>>>> say something like
>>>>
>>>> 	run <task>...::
>>>
>>> Hopefully this is documented to your satisfaction when the ability
>>> to customize the tasks is implemented.
[...]
> I mean that there is only one task right now. Until the commit-graph
> task is implemented, there is no need to have a --task=<task> option.

Ah, that wasn't clear to me from the docs.

You're saying that "git maintenance run" runs the "gc" task?  Can the
documentation say so?

[...]
>>>>> +static struct maintenance_opts {
>>>>> +	int auto_flag;
>>>>> +} opts;
>>>>
>>>> Packing this in a struct feels a bit unusual.  Is the struct going to
>>>> be passed somewhere, or could these be individual locals in
>>>> cmd_maintenance?
>>>
>>> This will grow, and I'd rather have one global struct than many
>>> individual global items. It makes it clearer when I use
>>> "opts.auto_flag" that this corresponds to whether "--auto" was
>>> provided as a command-line option.
>>
>> That doesn't seem idiomatic within the Git codebase.
>>
>> Can they be locals instead?
>
> Which part do you want to be idiomatic? The fact that the parse-options
> library typically refers to static global values or the fact that the
> data is not organized in a struct?

parse-options has no requirement about the values being global.  Some
older code does that, but newer code tends to use locals when
appropriate.

Putting it in a struct is fine as long as that struct is being passed
around.  What isn't idiomatic in Git is using a global struct for
namespacing.

[...]
> The natural thing to do to "fix" that situation is to create a struct
> that holds the information from the parsed command-line arguments. But
> then why is it a local parameter that is passed through all of the
> local methods instead of a global (as presented here in this patch)?

I'm having trouble parsing that last sentence.  You're saying a global
is preferable over passing around a pointer to a local "opts" struct?

[...]
>>> If there is a better way to ask "Did my command call 'git gc' (with
>>> no arguments|with these arguments)?" then I'm happy to consider it.
>>
>> My proposal was just to factor this out into a function in
>> test-lib-functions.sh so it's easy to evolve over time in one place.
>
> This is a valuable suggestion, but this series is already too large
> to make such a change in addition to the patches already here.

Hm, it's not clear to me that this would make the series significantly
larger.

And on the contrary, it would make the code less fragile.  I think this
is important.

https://chromium.googlesource.com/chromium/src/+/master/docs/cl_respect.md#remember-communication-can-be-hard:
if you'd like to meet out of band, let me know, and I'd be happy to go
into this further.

Thanks,
Jonathan
