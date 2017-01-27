Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A3981F437
	for <e@80x24.org>; Fri, 27 Jan 2017 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750762AbdA0X0w (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 18:26:52 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36079 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750741AbdA0X0u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 18:26:50 -0500
Received: by mail-pf0-f170.google.com with SMTP id 189so76487748pfu.3
        for <git@vger.kernel.org>; Fri, 27 Jan 2017 15:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding;
        bh=K4GQ0OxMB34LC322QI1VBChxwVoExX0hEVqXWC8yVTM=;
        b=gP5GctpHDcO8mrv6iHl+i9YD6QpLQlHrG7YNwN0aMBwptKe2ajYeNqH4PLSZov9w1X
         WEwmt9CASumA5jfE8vx5Kt5Gzc5HYtCZ8ZGeX7PzZC6hxTzEfZFcenGL3JzrAU+bTr3Q
         KZLuc4YROerL5x95LSiLAUI5EL+0pI0foatSmw2GlNSUQwrx4QLQbUsBFlic1H3urfGE
         +Hyuh8LHk3m8+h4XXL1w9+Rb7X1g4wLEbOXPUV62rzB6BisY+iZFErH0bNsXwsv8r0UX
         CXoLNBoY4cD13bhOdxhBR3aLi8RBKS/AmQuikuc1MjxKCD75wTXV59BYg829ZP/sJSyN
         M37w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=K4GQ0OxMB34LC322QI1VBChxwVoExX0hEVqXWC8yVTM=;
        b=f9YN5rPL4vBdIvqppy+MbejKdECvEeAM2F8KSyjMM+BRQ8Ilr3TQo0dVq34b74+wtO
         0ycCPoJdOi09imyARd6sBWECGKB0cpeggzvf7/XCzwHZKISnyh1NRyw8qvAiGr3SurTY
         X/qempDb/rVyTs01lJrvCk84dzajot4KU0YnqyfKTXZOICrJ8A0T92WBX2eC6pDs/cer
         k0tJkJE97mSMdHy0DpbzCsFAgeez/9K3ykpOXoS+WA8aLabNglatugAtTW/AAxfV/b4P
         ID0GkSwHapS2+z/uThvQl61fXBMVd2EWe8p2WtQo1VO4IseKBnajfo2YUudsy0yGsdmJ
         gl9Q==
X-Gm-Message-State: AIkVDXL5bAdOR8zq/xmJDrQzkVO9nDn8b6ZXIVqnQDO2moqX4ptgFK5oaIP8n/LOZNZH3zYO
X-Received: by 10.99.37.135 with SMTP id l129mr12087179pgl.206.1485559169374;
        Fri, 27 Jan 2017 15:19:29 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:7c02:2cc:ed2:b536])
        by smtp.gmail.com with ESMTPSA id o18sm13789977pgn.36.2017.01.27.15.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jan 2017 15:19:28 -0800 (PST)
Subject: Re: Deadlock between git-remote-http and git fetch-pack
To:     tsuna <tsunanet@gmail.com>, git@vger.kernel.org
References: <CAFKYj4cMSK5nQ1nS66c4Opz8y7x+xQH+OdW8PTi7LmCiGBP1ZA@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <460fae08-d5af-0e18-e2ed-faca2cfc8826@google.com>
Date:   Fri, 27 Jan 2017 15:19:28 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAFKYj4cMSK5nQ1nS66c4Opz8y7x+xQH+OdW8PTi7LmCiGBP1ZA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/27/2017 02:31 PM, tsuna wrote:
> Hi there,
> While investigating a hung job in our CI system today, I think I found
> a deadlock in git-remote-http
>
> Git version: 2.9.3
> Linux (amd64) kernel 4.9.0
>
> Excerpt from the process list:
>
> jenkins  27316  0.0  0.0  18508  6024 ?        S    19:30   0:00  |
>                \_ git -C ../../../arista fetch --unshallow
> jenkins  27317  0.0  0.0 169608 10916 ?        S    19:30   0:00  |
>                    \_ git-remote-http origin http://gerrit/arista
> jenkins  27319  0.0  0.0  24160  8260 ?        S    19:30   0:00  |
>                        \_ git fetch-pack --stateless-rpc --stdin
> --lock-pack --include-tag --thin --no-progress --depth=2147483647
> http://gerrit/arista/
>
> Here PID 27319 (git fetch-pack) is stuck reading on stdin, while its
> parent, PID 27317 (git-remote-http) is stuck reading on its child’s
> stdout.  Nothing has moved for like 2h, it’s deadlocked.
>
>> strace -fp 27319
> strace: Process 27319 attached
> read(0,
>
> Here FD 0 is a pipe:
>
> ~ @8a33a534e2f7> lsof -np 27319 | grep 0r
> git     27319 jenkins    0r  FIFO   0,10      0t0 354519158 pipe
>
> The writing end of which is owned by the parent process:
>
> ~ @8a33a534e2f7> lsof -n 2>/dev/null | fgrep 354519158
> git-remot 27317                jenkins    4w     FIFO   0,10      0t0
> 354519158 pipe
> git       27319                jenkins    0r     FIFO   0,10      0t0
> 354519158 pipe
>
> And the parent process (git-remote-http) is stuck reading from another FD:
>
>> strace -fp 27317
> strace: Process 27317 attached
> read(5,
>
> And here FD 5 is another pipe:
>
> ~ @8a33a534e2f7> lsof -np 27317 | grep 5r
> git-remot 27317 jenkins    5r  FIFO   0,10      0t0 354519159 pipe
>
> Which is the child’s stdout:
>
>> lsof -n 2>/dev/null | fgrep 354519159
> git-remot 27317                jenkins    5r     FIFO   0,10      0t0
> 354519159 pipe
> git       27319                jenkins    1w     FIFO   0,10      0t0
> 354519159 pipe
>
> Hence the deadlock.
>
> Stack trace in git-remote-http:
>
> (gdb) bt
> #0  0x00007f04f1e1363d in read () from target:/lib64/libpthread.so.0
> #1  0x0000562417472d73 in xread ()
> #2  0x0000562417472f2b in read_in_full ()
> #3  0x0000562417438a6e in get_packet_data ()
> #4  0x0000562417439129 in packet_read ()
> #5  0x00005624174245e0 in rpc_service ()
> #6  0x0000562417424f10 in fetch_git ()
> #7  0x00005624174233fd in main ()
>
> Stack trace in git fetch-pack:
>
> (gdb) bt
> #0  0x00007fb3ab478620 in __read_nocancel () from target:/lib64/libpthread.so.0
> #1  0x000055f688827283 in xread ()
> #2  0x000055f68882743b in read_in_full ()
> #3  0x000055f6887ce35e in get_packet_data ()
> #4  0x000055f6887cea19 in packet_read ()
> #5  0x000055f6887ceb90 in packet_read_line ()
> #6  0x000055f68879dd05 in get_ack ()
> #7  0x000055f68879f6b4 in fetch_pack ()
> #8  0x000055f688710619 in cmd_fetch_pack ()
> #9  0x000055f6886dff7b in handle_builtin ()
> #10 0x000055f6886df026 in main ()
>
> I looked at the diff between v2.9.3 and HEAD on fetch-pack.c and
> remote-curl.c and didn’t see anything noteworthy in that area of the
> code, so I presume the bug is still there in master.
>

I haven't looked into this in detail, but this might be related to 
something I discovered while writing my patch set. I noticed that 
upload-pack (the process on the "other side" of fetch-pack) can die 
without first writing any notification, causing fetch-pack to block 
forever on a read. A fix would probably look like that patch [1].

[1] 
<afe5d7d3f876893fdad318665805df1e056717c6.1485381677.git.jonathantanmy@google.com>
