Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D4A7220281
	for <e@80x24.org>; Mon,  6 Nov 2017 02:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750857AbdKFCh7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Nov 2017 21:37:59 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:47343 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750778AbdKFCh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Nov 2017 21:37:59 -0500
Received: by mail-wm0-f45.google.com with SMTP id r196so10886720wmf.2
        for <git@vger.kernel.org>; Sun, 05 Nov 2017 18:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1cPhzAz4XTVer8EeY9Oq1OXEHOAupDHSb60EnwzhYv4=;
        b=JuuhrxJi+L9Yatth86m0eTHW5gPUCnft1sD9lPQbVKnUZjOFSMoqY3jFkKfhS1qz6T
         swX+kytTcGU+5EvYaqflMxFqZFYz26QO1S0nV5WpU85cEzawNZhSW3OkScGUXTRuoXea
         4ltrs66jen8vjpWxHavWD6DOoWrnmbHsXwS+qvPGuISVi/UjZtrU79pk9mNq3Ary0pzR
         BS/bCWoA/t2avc+OYbu8xt+9RWPbMhUuhfl3jkncMbyMUa8NbEDS/j+VYk4Jz/fRk+o9
         Z80mGY5J5zfSnT3bHOvS/m5bU5wnZUKEw6Rbifq5BqatQIDkeUX+La/pagq59wMh+1mR
         zyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1cPhzAz4XTVer8EeY9Oq1OXEHOAupDHSb60EnwzhYv4=;
        b=qp8dCwVoi1BVh8HTXqDna/7LV3a64WJ41RxGczYNginBARz5juVqj/LtWohrMvZs53
         FBHOpFQonPlFwFHBP5ff2VbrBSHrSCd1jUlbIHD1x3sLJLAp53IExvU8+MJg7OtpbQfw
         7zwda6h3NgXd3YX4+HhyvntQV/uBRXfQ4kyC7oiw+Xo8k3RzvpkYbmOwyVEbkB0yNjxN
         udlR1oM3rDsOdzXbLRxblAdG3EAiGg7iFO8RQQ16cUBg0YXaLq5x+QvF68B6KMAXDNgS
         zotmhjxD1Uf8xxLHmqwUqKXXLJ3x/kUCxfVUOzAVBJM7DR524a2si8ul4t0ujgUwAFLR
         tz4Q==
X-Gm-Message-State: AJaThX56d2+WKEcYSNX2jAq4g3NZ7LAjiTtUcKIUMS7JQD2+kgQmREzO
        3kU4gxBmbWX7XnTT+2zM5Y4pZyRONhc=
X-Google-Smtp-Source: ABhQp+QDKQ6bEKHMkqRrhcRXFpPc9uwa/Tj/t6FIDvvtp/XuI7ZBugHs57TvqcmUWAcVsOIMU802tA==
X-Received: by 10.28.111.76 with SMTP id k73mr4212412wmc.110.1509935877806;
        Sun, 05 Nov 2017 18:37:57 -0800 (PST)
Received: from [192.168.1.22] (101.154.108.93.rev.vodafone.pt. [93.108.154.101])
        by smtp.gmail.com with ESMTPSA id o190sm9736888wmd.32.2017.11.05.18.37.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Nov 2017 18:37:57 -0800 (PST)
Subject: Re: [PATCH v1 1/2] refs: extract function to normalize partial refs
To:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Cc:     git@vger.kernel.org, me@ikke.info, hjemli@gmail.com,
        pclouds@gmail.com, ilari.liusvaara@elisanet.fi
References: <20171104004144.5975-1-rafa.almas@gmail.com>
 <20171104004144.5975-2-rafa.almas@gmail.com>
 <4dc4eefc-56b9-1b13-ae46-83a3af9c7ee3@alum.mit.edu>
 <xmqqwp34jj3h.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
Message-ID: <4b0fd3ff-3331-14be-2478-03f44ae3b0a9@gmail.com>
Date:   Mon, 6 Nov 2017 02:37:55 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqqwp34jj3h.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/11/17 01:23, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> [1] I say "almost entirely" because putting them in one function means
>> that only `pattern` needs to be scanned for glob characters. But that is
>> an unimportant detail.
> 
> That could actually be an important detail, in that even if prefix
> has wildcard, we'd still append the trailing "/*" as long as the
> pattern does not, right?
> 

> So the interface might be simplified by having two functions,
> 
>     void normalize_glob_ref(normalized_pattern, prefix, pattern);
>     void ensure_blob(struct strbuf *pattern);

I think that flag no longer makes sense. I added it just to allow
'--decorate-refs' work with "exact patterns". And since that has the
ugly side effect of losing the ability to use "shortcut patterns" like
'tags' to refer to 'refs/tags/*', I believe it's a good idea to remove it.
