Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C0D7207DF
	for <e@80x24.org>; Sat, 17 Sep 2016 00:22:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755305AbcIQAW2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 20:22:28 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33991 "EHLO
        mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754701AbcIQAW2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 20:22:28 -0400
Received: by mail-pa0-f49.google.com with SMTP id wk8so30333264pab.1
        for <git@vger.kernel.org>; Fri, 16 Sep 2016 17:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=pCqeviqYdpSAaYnLTlcfZYbc1GADe2Lsr7ye1atQuQo=;
        b=hi3gDrrMaXL7vJP6Nh9YTUYfR7B2EZzBzftTziwYY4RaxrRGGWYXCgbUX3kuIcKdti
         7vp2TZnSTlHnod7pZaB4gs8k+qyY9akK6/ZP9WdVFDPNT0r3iUhUbyhDHD1DGHWg6JV/
         kjeDhW5QwxFPpTmDmLRtKNi5Ma6aAz5qeMZqgZyPrCYoZkXA6/5CNnIplLxRuoRxtk6c
         3IEPr7cSeNhdOCe40SMWHRU8Exvo0u3fJuZqeTiWP1WhPcuGMtVhqssADKZcXmrkd4HI
         ErGdK40S23M8E/rFN8CW5VYk6SK8b6sZYhpVtZKv5IcqLPlDaWM3Hxci1ELQCA2rGOUX
         qpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=pCqeviqYdpSAaYnLTlcfZYbc1GADe2Lsr7ye1atQuQo=;
        b=T4vA7lfGCkdpB2d7Jf9wmvqmUVaDn6Gn32vZleD5mM7ZYnWgnUyF+TCSd4zPQQ0IR0
         S2gQGKMBIiOrkeAU1rMzJtrugeKAARNyhXZcQGp0ZTX+Ed0SuurHWSDV1OnAd94YxjOx
         J1u+x0O317jiLIkfohwhIMooOJBhfhKOcKdMEiEgEhdtI+nJhniVbrW2/CEVNx/e/qEq
         y/CufTF+LNogaLpKsAd/8Xg0PJT8+VPr7bNXsZFdX5RtMLY11noaXg4jYm859Mgt2P0u
         IZj30YvFLzGlFJ9vG/tQV8EnyoDBWmZieEZjRLelEjE3ym4+671lQrqjPdECqvcQqFXm
         KSbw==
X-Gm-Message-State: AE9vXwOxpScJ9YJiOPJ1INgsdFRnOxQzgid115t41QXYzPLrcW8SRigUo7jFQqQ/kIpoTALA
X-Received: by 10.66.52.42 with SMTP id q10mr27008840pao.34.1474071747232;
        Fri, 16 Sep 2016 17:22:27 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:c82e:43dd:7495:3b10])
        by smtp.gmail.com with ESMTPSA id d188sm2376292pfd.3.2016.09.16.17.22.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Sep 2016 17:22:25 -0700 (PDT)
Subject: Re: [RFC/PATCH 3/3] mailinfo: handle in-body header continuations
To:     Junio C Hamano <gitster@pobox.com>
References: <cover.1474047135.git.jonathantanmy@google.com>
 <20160907063819.dd7aulnlsytcuyqj@sigill.intra.peff.net>
 <cover.1474047135.git.jonathantanmy@google.com>
 <0152df30db0972d61ff45b2b099ad1242aacd431.1474047135.git.jonathantanmy@google.com>
 <xmqq8turk3aw.fsf@gitster.mtv.corp.google.com>
 <1b392241-461e-3b87-400d-70d66903e3d7@google.com>
 <xmqqshszimrh.fsf@gitster.mtv.corp.google.com>
 <128036e3-47b4-b7ae-034f-8d227a62729f@google.com>
 <xmqq7fabigzf.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org, peff@peff.net
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <d5eab197-e079-4c95-2661-9a576b9b5707@google.com>
Date:   Fri, 16 Sep 2016 17:22:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqq7fabigzf.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/16/2016 04:04 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>> I'm concerned about what happens if check_header fails - we would then
>> have some lines which need to be treated as log messages. (At least,
>> they are currently treated that way.)
>
> I actually think we should refactor check_header() further so that
> in-body header processing does not even see things that shouldn't be
> changed.  The current check_header() should be used only for real
> mail headers, and then a reduced version of check_header() that is
> called for in-body will _ONLY_ handle the header lines that are
> handled by the first "search for the interesting parts" loop.
>
> And of course we would update your "does it look like rfc2822?" to
> match what are handled by the "interesting parts" loop.  That I
> think would match the current behaviour much better, I would think.

There would be a bit of code duplication in that this "does it look like 
rfc2822" function would also need to account for duplicate headers (e.g. 
2 "Subject:" lines in the in-body headers) because check_header would 
reject the 2nd one, but that is minor. (Alternatively, we could just 
allow duplicate headers in the in-body headers.)

> The ">From " and "[PATCH]" cases in check_header() should not even
> be there.  We should handle them inside handle_commit_msg(), as
> these two cases should never appear in the real header part of a
> message.

> And if we clean it up like that, I do not think we would ever need
> to worry about "ah, it looked like a header but it is not after
> all".  And not having to worry about it is a good thing and should
> be one of the primary goals in this conversion, I whould think.

Yes, this makes sense. I'll go ahead and make a patch set implementing 
this (unless anyone has any objections).
