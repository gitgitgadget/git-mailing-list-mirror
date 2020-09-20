Return-Path: <SRS0=oWbz=C5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECD3C43465
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 05:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AE0E2075A
	for <git@archiver.kernel.org>; Sun, 20 Sep 2020 05:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IraT30Gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgITExr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Sep 2020 00:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgITExr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Sep 2020 00:53:47 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135A6C061755
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 21:53:47 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id q10so5577800qvs.1
        for <git@vger.kernel.org>; Sat, 19 Sep 2020 21:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QaIW0jGqHM1jcBrtZ8CCWTn8A+WHZllybPrdkmd3qbI=;
        b=IraT30Gc+VPD9e6+02eW+IXRrmOQ/F4COb8wgraCPVzZtK6h8bqlh6J8yDrvTCn6tJ
         CiBmm3StXRZqrErf3fFwwYOL9QXpTr7iMkNitol/teF6Zs/pV8LqvOPRIFSwdqV0O99n
         gOYU/JTn+h1/uWuBaRVFMvwjf6CGfquBn7TBKOqsdzOO5pu2s9RCIweWkLDDcVjbxrXo
         62zckZALTJaNKO9xx9hgBIRwKtlgaNOhHDm2QjQtHe3SAyNOS0bRRwauPFcjblJx9RLk
         lKgzyfW5/FpwtIkH5xYyHUgQXbKqEDvmEErhCPO8KzUhyREisDKMaOBxh1i4ya8ZP8ig
         m55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=QaIW0jGqHM1jcBrtZ8CCWTn8A+WHZllybPrdkmd3qbI=;
        b=hnI9/mZ69VV1oS3ftacjPs8XHP1Slel6MQfYuhbGKlgkju5aTYoK6lzfG39WEo9OLz
         AlaxOltzmjN8fUUkf4azPkJnqUDizLtpZiYyqVhHogpUVsCUwLPAFjnq2crUVh+ymA5j
         A7CO88uR1R/esoHTdaT8qj+G+x0TVYYI732vL3HZOcTrbhELny0taIqom4d+eoBfRNay
         J4IMxgO0ZqIVwxhvrVSPfKfEi1G8oRQfIrFBgLq4zXURNSc9hx74zSKUU/j4BiwPOs+H
         K4lfs9CxOf/VqeZgLi6lBdgEdKaFvQubd8ogKxPr6VV8rk1hPdjkfs1QAegYaCrkpf6z
         YuAw==
X-Gm-Message-State: AOAM532bDnFE6+Y0SlsY8GRDXSWPIup985kSjeZD7clOeSXCRjPOOTnX
        g03ARuUSpg7OVAPjVT2BEnAqJcsiD1ebTg==
X-Google-Smtp-Source: ABdhPJxf9WVf8Vf/I6ju1QDWffe6v23X3lmCOlnVns8cbzTOEnZSI2D904VxlVYhJuEwmKVk2OrKnQ==
X-Received: by 2002:ad4:4f30:: with SMTP id fc16mr40341850qvb.6.1600577625915;
        Sat, 19 Sep 2020 21:53:45 -0700 (PDT)
Received: from [192.168.67.200] (dsl-216-221-52-235.mtl.contact.net. [216.221.52.235])
        by smtp.gmail.com with ESMTPSA id i5sm5780433qko.86.2020.09.19.21.53.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2020 21:53:45 -0700 (PDT)
Subject: Re: [PATCH 1/2] diff: Fix modified lines stats with --stat and
 --numstat
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Thomas Guyot-Sionnest <dermoth@aei.ca>,
        Jeff King <peff@peff.net>
References: <20200918113256.8699-1-tguyot@gmail.com>
 <20200918113256.8699-2-tguyot@gmail.com>
 <20200918144651.GA1612043@nand.local>
 <CALqVohfQZu=itUyfU7nubJpgBETh2q7W1TVx=c2E32ey2cFZkA@mail.gmail.com>
From:   Thomas Guyot <tguyot@gmail.com>
Autocrypt: addr=tguyot@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <f4c4cb48-f4b5-3d4d-066d-b94e961dcbb5@gmail.com>
Date:   Sun, 20 Sep 2020 00:53:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CALqVohfQZu=itUyfU7nubJpgBETh2q7W1TVx=c2E32ey2cFZkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi... Added Jeff as he got involved later and comments below are
relevant to his questions.

On 2020-09-18 11:10, Thomas Guyot-Sionnest wrote:
> On Fri, 18 Sep 2020 at 10:46, Taylor Blau <me@ttaylorr.com> wrote:
>>
>>   - Why do we have to do this at all all the way up in
>>     'builtin_diffstat'? I would expect these to contain the right
>>     OIDs by the time they are given back to us from the call to
>>     'diff_fill_oid_info' in 'run_diffstat'.
>>
>> So, my last point is the most important of the three. I'd expect
>> something more along the lines of:
>>
>>   1. diff_fill_oid_info resolve the link to the pipe, and
>>   2. index_path handles the resolved fd.
>>
>> ...but it looks like that is already what it's doing? I'm confused why
>> this doesn't work as-is.
> 
> So the idea is to checksum the data and write a valid oid. I'll see if
> I can figure that out. Thanks for the hint though else I would likely
> have gone with a buffer and memcmp. Your solution seems cleaner, and
> there is a few other uses of oideq's that look dubious at best with
> the case of null oids / buffered data so it's definitely a better
> approach.
> 

After looking further at the code I understand your point, although
pipes can only ever be read once, so even if we do that we would have to
buffer on first read. It appears the files are first read by
diff_populate_filespec() - builtin_diffstat isn't even called if the
files match (even for two pipes).

Jeff, on your suggestion to compare size, the size is set even if data
is null. Files in-tree appears to be mmapped on demand for reads.

diff_fill_oid_info explicitly resets oids for is_stdin and return, and
if the file's been read already and it's a pipe, we would *have* to have
buffered the data already so I don't really see what else we can do
besides memcmp() (technically we should be able to tell if the files
have been modified at this point but apparently that information isn't
transmitted to builtin_diffstat - it's assumed and I won't make complex
change for that odd case of diffing two pipes. That's what I have now:

    /* What is_stdin really means is that the file's content is only
     * in the filespec's buffer and its oid is zero. We can't compare
     * oid's if both are null and we can just diff the buffers */
    if (one->is_stdin && two->is_stdin)
        same_contents = (one->size == two->size ?
            !memcmp(one->data, two->data, one->size) : 0);
    else
        same_contents = oideq(&one->oid, &two->oid);


Even when we implement the --literally switch, considering we can't
guarantee a single read per file, for now I'd keep using the is_stdin
flag as an indication of in-memory data, and we'll have to read in all
pipes we diff (like earlier patch). It could be a concern if we
--literally diff a whole subtree of large pipes. In that case the only
fix I can see is to reorder the operations to generate the stats on each
file diff (or at least keep the diffs around for the stats pass).


Regards,

Thomas


