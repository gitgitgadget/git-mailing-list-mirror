Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D87C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 22:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiKJWyK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 17:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbiKJWx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 17:53:58 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFECE13D67
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:53:56 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id s15-20020a170902ea0f00b00187050232fcso2269874plg.3
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 14:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0AaY8mlfMnlj/u6BsseFC7XzCfloGCBHqIHIFIKIR/M=;
        b=TY7K7mRMvx0fp8ZlwmetYUGj7oLR2aMoJJ24Bxciqg78HC3EGiztyjBMs6h+RmYP8h
         E2jIDVdfUs4MYt5nJWV3+UAEoIjCKuLw62GFIuRLVuwwxJbUl8nAwpdWF+KKrKxJdml4
         tDohkFcKMUD9xpEUV18u/JFFVhPWo0r2N1wP23Kd4bq8ZEYArCF+uw82RM+43hDn6MjG
         OBPbpR0qCD0jCA+/TeY63mxrucI9U8jXgr7Bb3gQjSu/aC8vFOgeGT8io1EiVaJbdNUC
         nWqpdRJa2vjp+8b1ELRyoAEUKx8ym6QzBCKA0HgLfbF5Yde62gMwxwo/iGS/G7DiZiI1
         7Bzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0AaY8mlfMnlj/u6BsseFC7XzCfloGCBHqIHIFIKIR/M=;
        b=4ovkAzY73lbQSy01/4FEogxuESE0lb0xhDtk9Tt99dQ6U+MEEuZtqWuWmsyd7rNbR2
         wNeU4M4J86Xx1naFvksVfe5Z86i041RWzsRQ8QJCtIgSNdoHGhtueWOKphG82CajeP4U
         VEmK92nGox+0sbsac19T/wRbCW7YTX5G+XHAedAZacVizGGhu1pcMhsRaItbZnZE/8eH
         YUB1o+fdr6qAUpGMsMCSq1DDalBbYrfYFIBgH/pJfImrOk41ZcpDDVOouPO9mDBv0tqy
         GhifTaMbueTAhnPzorq1tt8p4M/dNkkxX3vBUAYOZKleHtqafjTh7NmhLYAROqS1ni5O
         R2Cg==
X-Gm-Message-State: ACrzQf0X2mn7BJ7Lz/csHMG9JDMv02VTU2bTDfY7INsGpSgsy0tcdKHl
        Gb+zF+yFik3SxJ+Vlx0/07Now0pFt/b5Zw==
X-Google-Smtp-Source: AMsMyM4bV/jZEO2oZRVEdZ6sJdWZogyi68xaRmy2XW8/lqhVTECtyrEjNg7NFYnnIpL0tm3dOK+DlXq9G/U3uw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a65:6a4a:0:b0:439:753f:c81f with SMTP id
 o10-20020a656a4a000000b00439753fc81fmr3756415pgu.51.1668120836483; Thu, 10
 Nov 2022 14:53:56 -0800 (PST)
Date:   Thu, 10 Nov 2022 14:53:54 -0800
In-Reply-To: <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
Mime-Version: 1.0
References: <pull.1377.git.git.1667955151994.gitgitgadget@gmail.com>
 <Y2xnUyEoCFmbPtUI@nand.local> <kl6lpmdu3dl5.fsf@chooglen-macbookpro.roam.corp.google.com>
 <Y21yPIDmwB53e+aj@coredump.intra.peff.net>
Message-ID: <kl6lk0422zgd.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH] http: redact curl h2h3 headers in info
From:   Glen Choo <chooglen@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 10, 2022 at 09:48:38AM -0800, Glen Choo wrote:
>
>> Taylor Blau <me@ttaylorr.com> writes:
>> 
>> >>      * How could we set up end-to-end tests to ensure that we're testing
>> >>        this against affected versions of curl? To avoid regressions, I'd
>> >>        also prefer to test against future versions of curl too.
>> >
>> > Does that necessarily matter? We want to make sure that we don't see
>> > sensitive headers from the h2h3 module with any version of cURL, no?
>> 
>> It would help, but it might not be worth setting up infrastructure for
>> just this use case alone. Given the various platforms running tests
>> against the Git codebase, we probably get close to a representative
>> sample of the population with enough time.
>> 
>> I think it would be more important to have tests against HTTP/2.0. If we
>> did, we probably would have already caught this, e.g.
>> t/t5551-http-fetch-smart.sh:'GIT_TRACE_CURL redacts auth details' and
>> friends.
>
> There's some discussion in b66c77a64e (http: match headers
> case-insensitively when redacting, 2021-09-22) about testing with
> HTTP/2. Which ironically is basically this exact same bug in a different
> form. ;)
>
> The short answer is that it's do-able, but probably there are some
> headaches to make it work portably.

Argh, what a shame :( Okay, maybe it's not worth trying to use httpd
then.

Some other ideas I had were:

- Create a test-tool that calls the redaction logic directly (without
  involving about curl), and we pass the strings we want to redacted to
  it. Way less than ideal, since we'd never be able to proactively catch
  failures, but better than nothing I suppose.

- Write our own HTTP/2 server for redaction tests. I assume this won't
  be trivial, but maybe not prohibitive, e.g. [1] implements its own
  http server for credential helper tests.

[1] https://lore.kernel.org/git/4947e81546a51883365d0087ce616b6b77e24a63.1667426970.git.gitgitgadget@gmail.com/

>
> I agree with you that trying various curl versions isn't worth doing. If
> enough people/platforms run Git's suite, one of them will eventually
> see the problem.
>
> -Peff
