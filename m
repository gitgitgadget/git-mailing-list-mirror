Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA035C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 833D520829
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faMeryxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730887AbgGaAa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728086AbgGaAa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 20:30:26 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5EFC061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 17:30:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so2299346pjr.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 17:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yBhVigPbjxAYrObvDm5FfZgzDYYKJrzX7sYw/M+o7q4=;
        b=faMeryxDKrpgYQEwk5rHpW64i41BP1e1UJnIZ+9HPik3LKtwfPdMt5k181hX4JGPwg
         hI0D5EL4LJd0JqyubG603llr81+VYh58BGeBtC706KEfCIQek3cdrSeVm4bKmsc4QUoy
         ioOv0ibVP1SsaPEkMIYY8yeYwy5DfIp/fi65AKuEsAOy//HTIA0V/Lj/H1u9hHpp+6il
         ZB6XD2bDxTUywKObTbMkpReu7BkvO2tTR0tFRyR7R9302OoWXnIFVoh+X+YThG1fpvm/
         w+wtwuuT/ryI5fZzQ7Rr1ehDzRWT7jq8gKMtR8W92kRUK7pOaJ/MMXF7fOf15oHhqKlf
         ILiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBhVigPbjxAYrObvDm5FfZgzDYYKJrzX7sYw/M+o7q4=;
        b=WldzxPUzNSkQCA4ZkzhfhSfvAHZvxep3/TjCSAxaT9BoGGG6s0NzMe6wo/KGuuvGLL
         I/r7pGVIXHc/vWXODbp+xgeDJED9TXXV4uZVuM0/5rVa4g5101nwxgvXlmlTvgxnOyxT
         lQF6cR1MyNhFUMGLQv9q8sjNo6wbyyTPKHlmZe3Fenbj7GadtGMs7NI/ppoVzFgRUAYZ
         +B+Q/r+wXqR0ZGKBxh01JZtkVLEAP3gJJi7pcMWtuArq/WcDXSixcbEjeJhszeNJyhsu
         qoMTOO1Wkij3y7KQjoho/NJ117iHv64yCIwzheooEH9Bpit2kPGSL/V7NtDkFzZ4LULe
         mRYg==
X-Gm-Message-State: AOAM532IVVOmPVW91S27faop71aUu5ZhsuoAhCN0bMH6zkjVkoZBdpD2
        60aBhzjxdW4/UZJK1dHyXJA=
X-Google-Smtp-Source: ABdhPJyN1mABty6nQ6AYKLvA+6bNsL7sd13xtSB6UvtLD0yEPzjo335I0Q3EOIIn56EzpkpZwaMy8A==
X-Received: by 2002:a62:7b43:: with SMTP id w64mr1340147pfc.282.1596155425503;
        Thu, 30 Jul 2020 17:30:25 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:a28c:fdff:fee1:cedb])
        by smtp.gmail.com with ESMTPSA id g18sm7822287pfk.40.2020.07.30.17.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 17:30:24 -0700 (PDT)
Date:   Thu, 30 Jul 2020 17:30:22 -0700
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
Message-ID: <20200731003022.GA1029866@google.com>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 7/29/2020 6:19 PM, Jonathan Nieder wrote:

>> [jrnieder] How do I supply the tasks on the command line?  Are they
>> parameters to this subcommand?  If so, it could make sense for this to
>> say something like
>>
>> 	run <task>...::
>
> Hopefully this is documented to your satisfaction when the ability
> to customize the tasks is implemented.

Hm, do you mean that this change is too difficult to squash into the
first patch?

>> What is the exit code convention for "git maintenance run"?  (Many Git
>> commands don't document this, but since we're making a new command
>> it seems worth building the habit.)
>
> Is this worth doing? Do we really want every command to document
> that "0 means success, everything else means failure, and some of
> those exit codes mean a specific kind of failure that is global to
> Git"?

I mean things like "what exit code does it run if there is no
maintenance to do?"

[...]
>>> +static struct maintenance_opts {
>>> +	int auto_flag;
>>> +} opts;
>>
>> Packing this in a struct feels a bit unusual.  Is the struct going to
>> be passed somewhere, or could these be individual locals in
>> cmd_maintenance?
>
> This will grow, and I'd rather have one global struct than many
> individual global items. It makes it clearer when I use
> "opts.auto_flag" that this corresponds to whether "--auto" was
> provided as a command-line option.

That doesn't seem idiomatic within the Git codebase.

Can they be locals instead?

[...]
>> Perhaps this is suggesting that we need some central test helper for
>> parsing traces so we can do this reliably in one place.  What do you
>> think?
>
> I'm specifically using GIT_TRACE2_EVENT, which is intended for
> consumption by computer, not humans. Adding whitespace or otherwise
> changing the output format would be an unnecessary disruption that
> is more likely to have downstream effects with external tools.
>
> In some way, adding extra dependencies like this in our own test
> suite can help ensure the output format is more stable.

Hm, I thought the contract for GIT_TRACE2_EVENT is that it is JSON,
which is a well defined format.  To that end, I would sincerely hope
that external tools are not assuming anything beyond that the format
is JSON.

If that wasn't the intent, I'd rather that we not use a JSON-like
format at all.  That would make the expectations for evolving this
interface clearer.

> If there is a better way to ask "Did my command call 'git gc' (with
> no arguments|with these arguments)?" then I'm happy to consider it.

My proposal was just to factor this out into a function in
test-lib-functions.sh so it's easy to evolve over time in one place.

Thanks and hope that helps,
Jonathan
