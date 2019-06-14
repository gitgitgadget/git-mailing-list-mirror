Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A125D1F462
	for <e@80x24.org>; Fri, 14 Jun 2019 23:29:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbfFNX3x (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 19:29:53 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34947 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbfFNX3w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 19:29:52 -0400
Received: by mail-pl1-f193.google.com with SMTP id p1so1600215plo.2
        for <git@vger.kernel.org>; Fri, 14 Jun 2019 16:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NIz84EZGaZQ+f8NDA3uQpARnzGluv7C/tfOA3qGPDRQ=;
        b=axfb4hDjjZ1nYopurvPGURnQQ0MXqNenE7e/vTkWfRkE9vjlat2t/M2PgfcFcqw22z
         N1HLirin0hcjCQ/pA/mCkJnG/ajfVuYQ5Na9kDYnmuLt3c2FvvLAvGP9Dsfnk8AKyY11
         ju5u1d1YYnqJsXfYrWhutnPWyHjxsAaJtap73QnKbwMibSVUQq3EOmERfyB0N+mGnSSf
         9BC12CUXX+Dmvrm2gdQDuZ1H/VP+ZzbrP8Mq0yrSgLDtvpszNBZy0aW/Kzd5d88F+2i/
         UdMZRIvJRC8KxmOUmG1envVXiyyRkQRyC9AkFu9L+PJf1btEYwKyPKNudEUo2dVLaB7n
         5Rng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NIz84EZGaZQ+f8NDA3uQpARnzGluv7C/tfOA3qGPDRQ=;
        b=ZbH5lqPKn1VBCm7JlYamSD84rL4aLyThPyAVo9KsD4f0SC96kkK4ClzYGTpwkt7z6Q
         CgM3/oJ/IZawoqdc4qRzV6qVqwDCGXYAinIFkKbAZu4zq3PoMYcj04S0NeM9eJ0gyYsM
         5WdMD6RUkaJZLgvqyK7w3u2Iq6hh6YHO/OWOqx4GKK4/vEP8WwUIkRfXe9xmHgtIdlZi
         HPAP+gjDEWR4kalr21zh3TiuJJY+ubr8GafnlV5r9eNeDFxxg/jnNYx0f6BiJc7jfWUh
         vfAfzdxQNZ0F7BlU48jFt55oLSwGvIaYDN2Rtlth0y0+A8d6tTN3vqWlS0oIHrnMl7QZ
         qr8A==
X-Gm-Message-State: APjAAAVXTp6NiwLCXmt7Hynv7NCZrUNTtNHPigz/+Cdh8AZckyzV/JJ7
        B9Bp8PqiKQNPHEky3cMJOCqi1g==
X-Google-Smtp-Source: APXvYqytWUS9ImRX1idvgF4ufR+Oe/4z4rO/5LNV8sJ1qvMi/YHqdr42UNLgIq1atTQqDYa6MPFT1w==
X-Received: by 2002:a17:902:2847:: with SMTP id e65mr89604633plb.319.1560554991800;
        Fri, 14 Jun 2019 16:29:51 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:b186:acdd:e7ae:3d4c])
        by smtp.gmail.com with ESMTPSA id l7sm4492973pfl.9.2019.06.14.16.29.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 14 Jun 2019 16:29:51 -0700 (PDT)
Date:   Fri, 14 Jun 2019 16:29:46 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2] rev-list: teach --oid-only to enable piping
Message-ID: <20190614232946.GF233791@google.com>
References: <20190607225900.89299-1-emilyshaffer@google.com>
 <20190613215102.44627-1-emilyshaffer@google.com>
 <20190614160728.GA30083@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614160728.GA30083@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 14, 2019 at 12:07:28PM -0400, Jeff King wrote:
> On Thu, Jun 13, 2019 at 02:51:03PM -0700, Emily Shaffer wrote:

> > +test_expect_success 'rev-list --objects --oid-only is usable by cat-file' '
> > +	git rev-list --objects --oid-only --all >list-output &&
> > +	git cat-file --batch-check <list-output >cat-output &&
> > +	! grep missing cat-output
> > +'
> 
> Usually we prefer to look for the expected output, rather than making
> sure we did not find the unexpected. But I'm not sure if that might be
> burdensome in this case (i.e., if there's a bunch of cruft coming out of
> "rev-list" that would be annoying to match, and might even change as
> people add more tests). So I'm OK with it either way.

My (newbie) opinion is that in this case, we specifically want to know
that cat-file didn't choke on objects which we know exist (since they
came from rev-list). I have the feeling that checking for the exact
objects returned instead (or a sample of them) would be more brittle and
would also make the wording of the test less direct.

So if there's no complaint either way, I'd prefer to leave it the way it
is.

By the way, rev-list-misc.sh has a number of other existing "! grep ..."
lines.

 - Emily
