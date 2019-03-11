Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661F420248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbfCKWTd (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:19:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35776 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfCKWTd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:19:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id t18so586220wrx.2
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 15:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RJFGn4pmdkCI6ctkAHrytQg4UA7QF27VIXDyN5GKpFM=;
        b=pqNI9wqaTdjTGJ3AvkHY11bPB3NA/a/sG/7d8/3rnr1L2/UXlKRBxsUhmkYuC8/n9D
         GWMwCSej6o8opTdUI/Ai1/woJs6wxilXROSVCXe302yPNzgU1I86/nPtWe8OtYUc4bKG
         RePTVb9wr/jU0ocHir6xjuG2ctGJZYIgbmOeWmwuHuYcv/WyZ+wc9bfOcsLf7Qjgh1uN
         4OCbmmSZV3Ez1JB5FBcqjcPKYQFkx6G674kyZ+AFbzm+1Zg/OSRuIfEd0uJcGElc8hvR
         Ny0yNfDMblr85QXmiUoNny2lt+ZYknzeOSGZcU84/CW4U6VXYmh0IuODAkNrwoL1fSRY
         bYNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJFGn4pmdkCI6ctkAHrytQg4UA7QF27VIXDyN5GKpFM=;
        b=PfL0Lasj55G+xzHH9Mfkqz7W21SURT/sQ5T2dAib92N9Oi9H7rXIGqUmJL+s4vdJyZ
         L0FUAJPhoPnxD2O24w6GNuI9ruzdDx25hz9kd96Lq9628jOklYn0N7uJDBdvcd0FoLdj
         6Qr+wITtkMki9Q9RDrrAsAF07S3UUXabhZAJasY6whIPfkuo+c4GHvNiwDxbL7nDW175
         CYGU/kcDAw0SARenpZ5XMUktfDbzQjjM9aQ0fnpLm4NbLcJ0lP3kF/UW7q2xAOTriLZD
         CgbV6Fu87zZKPHs6tLVjmqC/jiUJqSdcGnjBrHXZ2fQKnuTqkSnGSVoZ2bNyFIdXv4QB
         iYYQ==
X-Gm-Message-State: APjAAAX3ilV/6BgLoF17sMC4RKrf6C/SJlpgafgxLOtKIrDa+pranPFk
        JMX66J7JUrcCUaffuCvJnqK1LqG6
X-Google-Smtp-Source: APXvYqx0fJpPugBAx3u3KcwVpU5ChiT0zkLXiUzAxHTReTL3RnYYsrf+nYtUWZB4EuUqnewqxOvDPA==
X-Received: by 2002:adf:ffc2:: with SMTP id x2mr20477216wrs.157.1552342771287;
        Mon, 11 Mar 2019 15:19:31 -0700 (PDT)
Received: from localhost ([95.148.214.107])
        by smtp.gmail.com with ESMTPSA id z15sm332962wmi.46.2019.03.11.15.19.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 15:19:30 -0700 (PDT)
Date:   Mon, 11 Mar 2019 22:19:29 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] built-in stash: handle :(glob) pathspecs again
Message-ID: <20190311221929.GI31533@hank.intra.tgummerer.com>
References: <pull.159.git.gitgitgadget@gmail.com>
 <7b5cca61dea4f01f9bcdcb6d5d2a913d58a341d3.1551972571.git.gitgitgadget@gmail.com>
 <xmqqh8c9kgy6.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1903111726050.41@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1903111726050.41@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/11, Johannes Schindelin wrote:
> Hi Junio,
> 
> On Mon, 11 Mar 2019, Junio C Hamano wrote:
> 
> > Yup.  I think Thomas and Peff were also looking at the vicinity of
> > this code wrt the pass-by-value-ness of ps parameter.  Their fix
> > need to also come on top of this (or combined together).
> 
> I agree. How can I help?

I just sent an updated version of my patch, based on top of this at [*1*].
Would be great if you could review that :)

*1*: https://public-inbox.org/git/20190311221624.GC16414@hank.intra.tgummerer.com/
