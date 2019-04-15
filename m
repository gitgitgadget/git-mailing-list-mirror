Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD77520248
	for <e@80x24.org>; Mon, 15 Apr 2019 14:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbfDOODQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Apr 2019 10:03:16 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43970 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfDOODP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Apr 2019 10:03:15 -0400
Received: by mail-qk1-f193.google.com with SMTP id c20so9872404qkc.10
        for <git@vger.kernel.org>; Mon, 15 Apr 2019 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=62KRfCrhLPhHSaIG+3zWF8XAg5wxNoeoyaEfknkWt/A=;
        b=BA6ihPRu0ixGiEa6pFsT73N70nTJQgxpLabYwnTfcQV/VXQ3w/GVauKbtf5NMNjIY7
         5lhF5D1BbWrxsg+klhkJ5E8uNMsRMhmZwiFcG3T/uo82amJr/g07MxVnATfoUapoPmjE
         VT3UKdQwwu3W796UB6c72uMarMhNl2Qh7wlnIhAHdWWOxhKVbDtb3HSlZemzHfTuQ73M
         UWWJTx4ZRF1UZ4BIuyPs2fByfYiaMU/ejQO2LoG6ujztbCfpSzejQ9Toz/bnsw9AgBmK
         NtYayMtVxlkwO9k3ZEiMswIutEiyIUn/bb7vQ3QCBexhedcNsQTQOkzJKPoNAzxI7awx
         8J6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=62KRfCrhLPhHSaIG+3zWF8XAg5wxNoeoyaEfknkWt/A=;
        b=UuieaQe3INTthDL5wCOsxI6di9/or3xPeM8vIqb67ysRqIfhb/vgDdt+si0tRzUa17
         GYGGP/WOKruO2b0o9lECXSmT6p+cKuDIw0HPzf27pC/j1OyW9iWviUSFEj9nAR8icY1v
         wtZAmv4ikDiZX7wGBDSOkg6i9zMjD9b3Kjk4Hqyu+OMK1pz2a0fpunXoeFHOXXA7FkBv
         l35OwvIglxWwy1MH6d2J9gF5PErekkSh9f7usz1EpV28TgE+pTeuSR04DDhf1dGQDcQu
         Q0o5/lXK/IGNwbcZnhHSi3VGw3n3nAZLIo+q8joEc4jb3rzLBWOmzN1i75gnBo9g7PJO
         x0/w==
X-Gm-Message-State: APjAAAXO/RMDcHt3Qnhuz/2+jfypqvhJNKA1ymUF3UKm/YV8xHYfecah
        4yz3Xyy74+VXmPi8Fhr1th9C7A==
X-Google-Smtp-Source: APXvYqw6jpdUkcjXETinnWVhgT/ox7J2GtE1c2GiMmM3XXne5PO83O6JljO4ajCROknH1p5ry7iSrQ==
X-Received: by 2002:a37:a296:: with SMTP id l144mr54415674qke.20.1555336993067;
        Mon, 15 Apr 2019 07:03:13 -0700 (PDT)
Received: from [192.168.1.10] (c-66-30-119-151.hsd1.ma.comcast.net. [66.30.119.151])
        by smtp.gmail.com with ESMTPSA id k4sm22604884qki.15.2019.04.15.07.03.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 07:03:12 -0700 (PDT)
Subject: Re: [PATCH v6 6/6] blame: use a fingerprint heuristic to match
 ignored lines
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Michael Platings <michael@platin.gs>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        David Kastrup <dak@gnu.org>, Jeff King <peff@peff.net>,
        Jeff Smith <whydoubt@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=c3=a9_Schar?= =?UTF-8?Q?fe?= <l.s.r@web.de>,
        Stefan Beller <stefanbeller@gmail.com>
References: <20190410162409.117264-1-brho@google.com>
 <20190410162409.117264-7-brho@google.com>
 <xmqqk1fxw8ad.fsf@gitster-ct.c.googlers.com>
From:   Barret Rhoden <brho@google.com>
Message-ID: <4c7bbc6c-805e-da7f-593c-e73989fc37c0@google.com>
Date:   Mon, 15 Apr 2019 10:03:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <xmqqk1fxw8ad.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/13/19 11:54 PM, Junio C Hamano wrote:
> Two thoughts.
> 
>   - Unless the 'old heuristic' is still available as an option after
>     this step, a series that first begins with the 'old heuristic'
>     and then later replaces it with the 'new heuristic' feels
>     somewhat wasteful of reviewer resources, as the 'old heuristic'
>     does not contribute an iota to the end result.
> 
>     It is OK while the series is still in RFC/WIP stage, though.  But
>     because I got an impression that this is close to completion, so...

Can do.  I wasn't sure yet where things were going, but in the final 
version, I can yank out the old heuristic from the patch set.

Though the old heuristic is pretty basic - really just a couple lines - 
and it may help to see it before looking at a more complicated version. 
Especially since it helps break the commit up into "infrastructure to 
ignore commits" and "brains to find the right commit to blame" while 
still being functional between the commits.

Thanks,

Barret
