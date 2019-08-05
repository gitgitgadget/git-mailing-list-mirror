Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D0F1F731
	for <e@80x24.org>; Mon,  5 Aug 2019 10:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHEKOM (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Aug 2019 06:14:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38956 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbfHEKOM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Aug 2019 06:14:12 -0400
Received: by mail-wr1-f66.google.com with SMTP id x4so30628970wrt.6
        for <git@vger.kernel.org>; Mon, 05 Aug 2019 03:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=WHn5qj7j02v7RQeq1qUZvHH5RfyJGaeug/9OA5TrOKs=;
        b=pK4cRuouyyvem/mFYH3o6yZVKKih8A8Tfp6GTf5NxYUle+ookfYkA1Q0aBWqexqeg9
         raGNz2dOaR8ifqEQufJjCrBYtNDhTe4wVsWTYwS33uCahmPpF7XgKhMuHlVyNKvFqrYL
         yv/r2kShpPNTh7HcfPkw45FjUgELt+OK0ysdeDey0SD4mkv2pdiPyQoQrZvaPRdUpOqn
         OmKv2sjZ07OheUKlXI6irFj/qIQ0mbqBQoVMVrLze8H0CwI8xWn/HXdjkjNKVMBFXxbz
         BM6KEoSK0Gbtq7L8iDaRCJqLz9hD4vvNswbSQZcM4O5oqUdjeGBUuqqmFZItQm9X8C2P
         sRUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WHn5qj7j02v7RQeq1qUZvHH5RfyJGaeug/9OA5TrOKs=;
        b=PuQAGXqAn6GTwsowgAHtMV4yqU6JSqMgHbO9/NPl03b2ngh8/HgaRPGWNAvQxxmqtX
         tmuf71G3OnMSKhzhVrkTH8Tj4XSflhqEYi+ucriq/+asnf0FaoYUUbW18fFt7gP1krCG
         u48qllRGrGwMV53SUvBmyk5xRcF6luuou6PIbVD+Adw+WwREJCt38Vd4l0VvHvsj7Cme
         wWO9Rvmfoh2GpC4cqtYWhK3l7r2FavfQNaIvQ5H0MnvWxG5hpdQWARl4CciDMIPEKTOR
         FtgYmYgvyr84aRKPefMZ/0WFrNmgnktGlCS6n9uZRU6EtssX+WRJCOtQVywLug2DiUKG
         IcnQ==
X-Gm-Message-State: APjAAAX/ar6NzvZrrUBBqLmr3YlgIAiqHkLFHKIqguqOxUfGhen0mScX
        MKr7J+W2HkPFzWWqYnLC1m4=
X-Google-Smtp-Source: APXvYqxwYn4qeOcToWCie+8W4pvHEPwt5Mjcho4urlUY3GkKkei0se4PpIFda8xWmoNLzFSR4QavNw==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr65392826wrn.165.1565000050087;
        Mon, 05 Aug 2019 03:14:10 -0700 (PDT)
Received: from szeder.dev (x4db4a28a.dyn.telefonica.de. [77.180.162.138])
        by smtp.gmail.com with ESMTPSA id g12sm119070883wrv.9.2019.08.05.03.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 03:14:09 -0700 (PDT)
Date:   Mon, 5 Aug 2019 12:14:07 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/3] commit-graph: error out on invalid commit oids in
 'write --stdin-commits'
Message-ID: <20190805101407.GB20404@szeder.dev>
References: <20190805080240.30892-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805080240.30892-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 05, 2019 at 10:02:37AM +0200, SZEDER Gábor wrote:
> While 'git commit-graph write --stdin-commits' expects commit object
> ids as input, it accepts and silently skips over any invalid commit
> object ids, and still exits with success:
> 
>   $ echo not-a-commit-oid | git commit-graph write --stdin-commits
>   $ echo $?

Oh, messed up the copy-paste; this prints 0.

>   $ ls -l .git/objects/info/commit-graph
>   ls: cannot access '.git/objects/info/commit-graph': No such file or directory
