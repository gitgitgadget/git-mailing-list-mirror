Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E905202C1
	for <e@80x24.org>; Fri, 10 Mar 2017 04:59:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932538AbdCJE7I (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 23:59:08 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34195 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932097AbdCJE7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 23:59:06 -0500
Received: by mail-pg0-f67.google.com with SMTP id b5so9014439pgg.1
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 20:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=YTKMFa+Wj0LhUtPh39Iy3wjqrf009LEeDZ/X4xLFVHc=;
        b=lwHvg6oDLNBIqVJxtVyPK56ODX8AgnJVgv7O05EI6OR1DiQNGlEEutOFfx1eRyOCYI
         CjKyZgUQTR1ybT3Fy20d/LGwfb4TKqcwwwUFCaKhw1N8xaMrJC8wXjt0tIwuL0tLZ2Ez
         ufmXB1eskyom4EEOXvmUYSQniTFMLvQHjvOhuTk+kRf1jpi09vytKNxH8aM42TrklcR/
         ybzqeVM0klQm89xt3u9Z3sDMrWEbRsCTgMH44m1nwCQVX4JUEUkuZN/fizy2G2jcQg4R
         Df/nfAFa5JCDYwjjClt7HYFGysO50hDcIWUjn5HG1G6CZifdfPlNYiccq1n9+ejkHle+
         +z/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:user-agent;
        bh=YTKMFa+Wj0LhUtPh39Iy3wjqrf009LEeDZ/X4xLFVHc=;
        b=KzqI1rtFNJBe9MgwNA54DKqFN5ov+GRfQyXs0D87SZaiuMe0JCdv1FT4dXbk8KDcnt
         qCYbwZh/ZBynYf8DYS4+NvvY9C6cjCrSaWzQEQ2oZSNg3rihY19/IYsRu3pIrxGQKjM9
         yoRDyz2XDMWSwhOolz+vQW+ocy0Ye5Wr11nR9RXqj2o72IH9ATooiW0Tz5XQhWkAKP6W
         zZ4DuudUgfb0TcNxTdb/va8zrDV2D6CVdxs4TpJCJ4XrHhC1feEgYKRQbZXXIldzFOLB
         Zl2Wh1aJj5/no88BO8VndS2UTCG+OsekowDnxjVSbomYind+DpY1b0aYfITsST7r81kF
         Q2fA==
X-Gm-Message-State: AMke39kbJBeueY0dObO2DtN9bAfyRYdIcTbLWgvOKbIwUQdsY+Q4L0wT2xNQ1tX87WRPKw==
X-Received: by 10.84.216.17 with SMTP id m17mr22715611pli.158.1489121944879;
        Thu, 09 Mar 2017 20:59:04 -0800 (PST)
Received: from localhost (37.147.199.104.bc.googleusercontent.com. [104.199.147.37])
        by smtp.gmail.com with ESMTPSA id 23sm15392375pfz.127.2017.03.09.20.59.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Mar 2017 20:59:04 -0800 (PST)
Date:   Fri, 10 Mar 2017 04:59:03 +0000
From:   Siddharth Kannan <kannan.siddharth12@gmail.com>
To:     mash <mash+git@crossperf.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Vegard Nossum <vegard.nossum@oracle.com>, stepnem@gmail.com,
        Stefan Beller <sbeller@google.com>,
        Vedant Bassi <sharababy.dev@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: [PATCH v2 GSoC RFC] diff: allow "-" as a short-hand for "last branch"
Message-ID: <20170310045903.GA2417@instance-1.c.mfqp-source.internal>
Reply-To: 1cm4dm-0007OE-MZ@crossperf.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey, I have already worked on this, and I made the change inside
sha1_name.c.

The final version of my patch is here[1].

> Handling the dash in sha1_name:get_sha1_basic is not an issue but
> git
> was designed with the dash in mind for options not for this weird
> short-hand so as long as there's no decision made that git should
> actually have this short-hand everywhere it does not seem like a
> good
> idea to change anything in there because it would probably have
> unwanted side-effects.

Actually, this was discussed even when I was working on this patch.

I said [2]

> Making a change in sha1_name.c will touch a lot of commands
> (setup_revisions is called from everywhere in the codebase), so, I
> am
> still trying to figure out how to do this such that the rest of the
> codepath remains unchanged.

Matthieu replied to this [3]

> I don't have strong opinion on this: I tend to favor consistency and
> supporting "-" everywhere goes in this direction, but I think the
> downsides should be considered too. A large part of the exercice
> here
> is to write a good commit message!

From the discussion over the different versions of my patch, I get
the feeling that enabling this shorthand for all the commands is the
direction that git wants to move in.

Sorry about the time you spent on this patch.

[1]: http://public-inbox.org/git/1488007487-12965-1-git-send-email-kannan.siddharth12@gmail.com/
[2]: https://public-inbox.org/git/20170207191450.GA5569@ubuntu-512mb-blr1-01.localdomain/
[3]: https://public-inbox.org/git/vpqh944eof7.fsf@anie.imag.fr/

Thanks,
Siddharth.

P.S. This message was sent _before_ 1cmCXH-0000ND-9K@crossperf.com but
I didn't CC The mailing list in that message. I am sending it with the
mailing list cc-ed to ensure that the conversation makes sense.

