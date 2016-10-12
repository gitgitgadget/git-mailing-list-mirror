Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97EAF215F6
	for <e@80x24.org>; Wed, 12 Oct 2016 21:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752683AbcJLVkP (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Oct 2016 17:40:15 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36616 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbcJLVkN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2016 17:40:13 -0400
Received: by mail-qk0-f181.google.com with SMTP id o68so102615692qkf.3
        for <git@vger.kernel.org>; Wed, 12 Oct 2016 14:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VrOI9KANspuMZL2qUt1qPzLKvF/WhPSwg3K8CD1p0iU=;
        b=hDSuYcrJmKpjT1vfCMsaopVyhdORIkhSv9oZcluR79x5wFmvGHDWrH3kBz19Vqk3ZP
         nf0Pv6O5diuHtazG6DdeT3nN9weiXE1/bC4pIWLATctUcc9PQKFrWRmA+JREEA3XbbCx
         OwSv+txFgiC8Yq2f/fU3Q2Y6EG/Wq5RsKmEyIVXM8SbTPNK/aZ1YH+4G+4pVhTsaJiZ9
         Q7Hwk9uup730RjyWIT9mv0PFymIiDYYtB02au3oBXg2N10viKbubMRKY2MOocGfaPH9W
         lirQmftbk5NXDQaVmY4in+4FfbkaVKTcWvcNwg3AmcbNnNlkyVtg9KwyDsJpLVTZyQh7
         PsQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VrOI9KANspuMZL2qUt1qPzLKvF/WhPSwg3K8CD1p0iU=;
        b=KqCXAYNJIAyxmX2kZlvQh4eOHiqmRvEYbcv2zZTPL69Ua/GPuLWhkVBhsj6Vu/lBl4
         gZz1eFt97P2aB5SS5/OaZCUqbdm+zSMhS2WCVKX08xDX6Ret+eQHHVhBz8+5TAKEmDky
         2lz3ntIU6UNRZFNqQPRy3677CikuWJbiGMzRfr/Qqc71h8fYpNMNXSZXAEiMqsesYXOv
         QyvYdgtmlWQB0cxu+mTdOzqD5QvVWW8ov2TFMDznPYMgb1GJTlhAEXVC3PQZ7h5Xb+pE
         pgtnhzl7oSXMHv32UgDskDs724mH6sFD0lwhl+mzVujd9YZMPcwVLuSL/6BewqpLa4LJ
         IvFw==
X-Gm-Message-State: AA6/9RlQ0QkYPmoEA5Rg2VC365PDHgmZaSQrL+eM+SxkTN8x9n1HeF2k4I1qxHWkowo1zPLP1xL74PXBF18X06zw
X-Received: by 10.55.45.193 with SMTP id t184mr3147418qkh.58.1476308358388;
 Wed, 12 Oct 2016 14:39:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 12 Oct 2016 14:39:17 -0700 (PDT)
In-Reply-To: <xmqqh98h2r5t.fsf@gitster.mtv.corp.google.com>
References: <20161011235951.8358-1-sbeller@google.com> <xmqqh98h2r5t.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Oct 2016 14:39:17 -0700
Message-ID: <CAGZ79kaQGs_3dhd-yEzaq=CRXGQhbMuN_7FdFY=FeKZ4scmMeQ@mail.gmail.com>
Subject: Re: [PATCHv2] attr: convert to new threadsafe API
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 12, 2016 at 2:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This version adds the actual thread safety,
>> that is promised in the documentation, however it doesn't add any optimization,
>> i.e. it's a single global lock. But as we do not expect contention, that is fine.
>
> Because we have to start _somewhere_, I agree it is a good approach
> to first try the simplest implementation and then optimize later,
> but is it an agreed consensus that we do not expect contention?
>

I agree on that. Did you mean this is obvious to the reader?  I just wanted
to state how I'll do it, such that if in the future someone digs up
this code, they'll
know I did not look at performance in the first run.
