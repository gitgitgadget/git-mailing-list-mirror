Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 182641F461
	for <e@80x24.org>; Tue, 25 Jun 2019 12:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729573AbfFYMkw (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 08:40:52 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45176 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfFYMkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 08:40:51 -0400
Received: by mail-qt1-f194.google.com with SMTP id j19so18127981qtr.12
        for <git@vger.kernel.org>; Tue, 25 Jun 2019 05:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3mMLTCRNXb0eR1PuurybV8B8OQ9gLK32H1cMI3/XyRY=;
        b=dffAiUdEHEb+MvTZy3Hrbm/snDlEmesEt6UD/o1oXIu3r9MCcZLV9UpE4oNT6coEup
         RRr2m6Lr+j89NSpXMJwIo0dcXE2SVqyPoA2BT307KIsj7fBvI2ln1iVp+vt8G3unZCLG
         euRw5ca/+SX1OaJuJMTjnyWZREk5hBGe5zkKj6sirCdhzhmjBh05pIY1XobHEScKshYm
         TSppvmObWkHQLX5nNKx36ji0BUI6Bvyp5MCMV+X0VQULbtmZj/StM2/V204E1FRhE8Ly
         E+/RhIlfIY3zJwx5DNYQ/wVRjU5pTUYFgM+/2bZjZb1VX6Ygf9bJdrKobJLI6V1wPJhn
         4ccw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3mMLTCRNXb0eR1PuurybV8B8OQ9gLK32H1cMI3/XyRY=;
        b=fS2tdQImbTLeohk7zxRSF3JGXyWkfxmVQvRs+22u5B/PHYWCH/BWv0T6Il0DVm+5fG
         pc6mb1CdCxUmJPWb2x+M9E2hJLPX1Eo8Zoi0wOcjunkRnn7FmrfuI1CjXhkoxnRJWFUm
         aM2UKV3c5AdMsR1WzszeNP4l9DqZr+7rcOfXFBL+CIthD1bfzQWm0GaBrUzw+TTczMxZ
         IwB0VBl64fbG4g8HbHikEKIvCL5KOfxMaCIyswsTFad5QcgrbGlNgcDaYrTOsyeHPC6o
         M7cxT5Hw+8sucVZ34bHka73ICqOVQmITg0R7OhNR2ajX41rMh571jDCaikHgiUCZ8Ljg
         3XTA==
X-Gm-Message-State: APjAAAVhd8jemLukQhvwkVai2HGFAdzVP4vF30kX/B0sch65WYAXTc60
        aGf60t5h4LSQEB+GMqtVu3U=
X-Google-Smtp-Source: APXvYqzVa2ysyq0X7gZnwbniuGasksOJJbY2UAPNdLSHheW3r5yGeJ4mlOK6MXQtO4fMoqcbBCiIxA==
X-Received: by 2002:a0c:d1f0:: with SMTP id k45mr64170225qvh.69.1561466450871;
        Tue, 25 Jun 2019 05:40:50 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:64c6:ee1a:485:1947? ([2001:4898:a800:1010:15fc:ee1a:485:1947])
        by smtp.gmail.com with ESMTPSA id l63sm7365326qkb.124.2019.06.25.05.40.49
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 05:40:50 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     Duy Nguyen <pclouds@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-6-pclouds@gmail.com>
 <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com>
 <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <98afb501-ef57-9b64-7ffb-f13cea6fd58a@gmail.com>
Date:   Tue, 25 Jun 2019 08:40:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/25/2019 6:29 AM, Duy Nguyen wrote:
> On Tue, Jun 25, 2019 at 3:06 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>> I'm curious how big these EWAHs will be in practice and
>> how useful an array of integers will be (especially as the
>> pretty format will be one integer per line).  Perhaps it
>> would helpful to have an extended example in one of the
>> tests.
> 
> It's one integer per updated entry. So if you have a giant index and
> updated every single one of them, the EWAH bitmap contains that many
> integers.
> 
> If it was easy to just merge these bitmaps back to the entry (e.g. in
> this example, add "replaced": true to entry zero) I would have done
> it. But we dump as we stream and it's already too late to do it.
> 
>> Would it be better to have the caller of ewah_each_bit()
>> build a hex or bit string in a strbuf and then write it
>> as a single string?
> 
> I don't think the current EWAH representation is easy to read in the
> first place. You'll probably have to run through some script to update
> the main entries part and will have a much better view, but that's
> pretty quick. If it's for scripts, then it's probably best to keep as
> an array of integers, not a string. Less post processing.

I don't think the intent is to dump the EWAH directly, but instead to
dump a string of the uncompressed bitmap. Something like:

	"delete_bitmap" : "01101101101"

instead of

	"delete_bitmap" : [ 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1 ]

> Another reason for not merging to one string (might not be a very good
> argument though) is to help diff between two indexes.
> One-number-per-line works well with "git diff --no-index" while one
> long string is a bit harder. I did this kind of comparison when I made
> changes in read-cache.c and wanted to check if the new index file is
> completely broken, or just slighly broken.

You're right that the diff of the json output is an interesting
use, and the "single string" output is not helpful. What about
batches of 64-bit strings? For example:

	"delete_bitmap" : [
		"0101010101010101010101010101010101010101010101010101010101010101",
		"0101010101010101010101010101010101010101010101010101010101010101",
		"0101010101010101010101010101010101010101010101010101010101010101",
		"01010101010101"
	]

This could be a happy medium between the two options, but does require
some extra work in the formatter.

Thanks,
-Stolee
