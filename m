Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 702C4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232524AbiKGP53 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:57:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbiKGP51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:57:27 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF74F1C41C
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:57:24 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id y14so31309555ejd.9
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xe0iiMSywY4miXePlP/3ob5ZYaIezlrtm//rVwVUoic=;
        b=YYifp5DRJqqYKn/8U0zq1jcQswxAwszXGxz6pRyte7UBv65bMA4/leHRqmsW8zJB1b
         6KenAEFUJCMGqNRLcncpu3f0ba9fdBhhARHb41v2svX5uMlqZj8+/jYBEYAoSmCG01B5
         YwSyXjKVS3PMeMOxV67/SPuez6f59NFpDGowL1FTS/+NqsNvPqfAF1m/JzQjOLbOoxor
         v2FyusIMyuFiXE+ULIYfix02U+y6jFpgKWPobOwghF0b3FTgm/yqxzo9QR1aaF/jgmKZ
         /HHit855C2Zp2JE9R909PiG+IR+lw99S/urzC/9qa82b6aWOTX29GywTW9wPtNIrPwJ/
         Dclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xe0iiMSywY4miXePlP/3ob5ZYaIezlrtm//rVwVUoic=;
        b=xn4dYONgxu94x3WTJrGC72WfTBzkSeUcSoGj/IvQcrbHxD9y1AB/+rJOFqGiZPR6Hd
         mpZ1z2HuFBZaUyhNolPOFsg5R3DGIJGS/iXmr4bJB6CS0TNzDOcZjS32OVZzCLCYj+pz
         kg4znnif81vwDdDw4T/iDl3mToNpU/3wlZcusDgoWtaf2Fw0ttbH2dyMVfYT0RmGdNiw
         Ar5Q/WufCPx8oId9VqUYqcRsOEQVT5DNZxLPn3BoXivdfEPp0Ugc3+Ou/dKEzNn+N6aQ
         TlC+yS73jAP6A61AGnwzjjwK6Yf0nISj8ZKi7k3hCNnk2xIwX8yqCUuR3r1tGQ3vU0tD
         JbqQ==
X-Gm-Message-State: ACrzQf1pI4UWEb9+RBS2pUUXyKpO7bxKI0BKA1oLpQlq48f70YIjsY96
        qPuRwkZtHzGASDUy7PlzKHI=
X-Google-Smtp-Source: AMsMyM73KLCAoyHr3SVxdUNOZv6tcweFbil9fFUd8xxAoSih98OVhKNEnn9wgizXdGMFWUAYjMZmPg==
X-Received: by 2002:a17:907:7e97:b0:7ad:b45c:dc19 with SMTP id qb23-20020a1709077e9700b007adb45cdc19mr45704790ejc.352.1667836643223;
        Mon, 07 Nov 2022 07:57:23 -0800 (PST)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id o11-20020aa7c50b000000b00463b9d47e1fsm4392205edq.71.2022.11.07.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:57:22 -0800 (PST)
Date:   Mon, 7 Nov 2022 16:57:21 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 1/3] line-log: free diff queue when processing non-merge
 commits
Message-ID: <20221107155721.GB1951@szeder.dev>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-2-szeder.dev@gmail.com>
 <Y2MJRRfwG7rSp6Ra@nand.local>
 <20221107151115.GA1951@szeder.dev>
 <221107.86r0yevkt5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221107.86r0yevkt5.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 04:29:39PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Mon, Nov 07 2022, SZEDER Gábor wrote:
> 
> > On Wed, Nov 02, 2022 at 08:20:21PM -0400, Taylor Blau wrote:
> >> > +void diff_free_queue(struct diff_queue_struct *q)
> >> > +{
> >> > +	for (int i = 0; i < q->nr; i++)
> >> > +		diff_free_filepair(q->queue[i]);
> >> > +	free(q->queue);
> >> > +}
> >> 
> >> Though I wonder, should diff_free_queue() be a noop when q is NULL? The
> >> caller in process_ranges_ordinary_commit() doesn't care, of course,
> >> since q is always non-NULL there.
> >> 
> >> But if we're making it part of the diff API, we should probably err on
> >> the side of flexibility.
> >
> > On one hand, strbuf_reset(), string_list_clear(), or strvec_clear()
> > would all segfault on a NULL strbuf, string_list, or strvec pointer.
> 
> But the reason we do that is because those APIs will always ensure that
> the struct is never in an inconsistent state, as opposed to the
> destructor you're adding here.

Taylor's suggestion quoted above is not about the internal state of
the diff queue, but about a NULL pointer passed to diff_free_queue().

> I.e. if you were to work with the queue after this diff_free_queue()
> call in process_ranges_ordinary_commit() you'd segfault, not so with
> those other APIs.
> 
> > On the other hand, given the usage patterns of the diff API, and that
> > it mostly only works on the dreaded global 'diff_queued_diff'
> > instance, I don't think there is any flexibility to be gained with
> > this; indeed it is already more flexible than many diff API functions
> > as it works on the diff queue given as parameter instead of that
> > global instance.
> 
> I pointed how this could be nicer if you made it work like those other
> APIs in
> https://lore.kernel.org/git/221103.864jvg2yit.gmgdl@evledraar.gmail.com/;
> I.e. we could do away with DIFF_QUEUE_CLEAR() after calling this
> "free()".
> 
> But in lieu of such a larger change, just adding a call to
> "DIFF_QUEUE_CLEAR()" in this new free() function seems like it could
> make thing safer at very little cost.
> 
> We're also far from consistent about this, but I wish it worked like
> that and were called:
> 
> 	diff_queue_struct_{release,clear}()
> 
> I.e. the usual naming is:
> 
> 	<struct name>_{release,clear}()
> 
> In cases where we don't free() the pointer itself, but assume that we're
> working on a struct on the stack, whereas *_free() functions will free
> the malloc'd pointer itself, as well as anything it contains.
> 
