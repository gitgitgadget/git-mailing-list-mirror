Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D8C41F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 17:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933619AbeGIRgq (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 13:36:46 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:43598 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933573AbeGIRgp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 13:36:45 -0400
Received: by mail-pl0-f65.google.com with SMTP id c41-v6so6353170plj.10
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4m2Bjr59vecJg5gAfvky00ZnPpGnGtbnuD5FM8LdLE4=;
        b=koK7J4/FeSr72vzwjd+byTo8eeDiCOqUCTZbEkGSJtkMbO9jWqNLvvTHkpSQZbK1Pn
         RNL1zmiCRTxAPDtWyy8/CJ/nn92X/gSCd4HWgSOXzQ/yQJz3tSOt6MXG6gSybl5hmIZL
         sqRNekN3BrFVoHXnAQAmL4UZ8QihaAe5aWRhTJNzl8CtRS2KPyzrVov3KVBnHPTOvwyO
         9acs2rGqQxgjEByT0lxno/ef5KfXN+/X+TDXtzxoiqHhnDalYCQ0rILYH39OQphD7pGj
         +ma0HTxTjg12J27VJdwkRM/Jm0ugSH68/vjkRrd211d8imzcRds9U7+5AhrxnSYziS8Y
         WQmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4m2Bjr59vecJg5gAfvky00ZnPpGnGtbnuD5FM8LdLE4=;
        b=r6hzTqbn1Z4kcxdU+22CCPgpjcrGOCMAp3cT02jtpJnnTh1QpfJ645aKIO/nzu8v2e
         NbJcEUicyFduFf5T9MaXNRa0k8dPBe5Tx827An/IzoMMykubYIurCLZRWqvbRDTLfk3U
         kPHoxUPZUdbdEGj6+DQg+X7FEwqNS5/LBw0ygmteK/9ItjnT+d1kM0m5V8QDZ4JunpMn
         rxIq85i1VBYTpHb2WvuyUH48YUPqSn/ui5WaN8MHyOJZZ/Q8emdzU6PJYnBKnGP9/qcU
         5iNJgf6/PM4Se2fiRqci4QQebrILdsmgVlknHRuybnKmZsjtm55zQCyHKE7ddlCAtPzd
         BeSQ==
X-Gm-Message-State: APt69E0xYomr01BKal4085Z4Hzjh9NRIhnepffgO5ZY/b4A7gPpga2yd
        uB7dvIeZk1ZBw0/m3Iw2RdBurg==
X-Google-Smtp-Source: AAOMgpf1pXTkp4RqKRWwsO310yLZhqYJJ0Fs0M802OY8f1r3yOX4z3lyaJwNai5jQAXwCShU3pa1bw==
X-Received: by 2002:a17:902:8549:: with SMTP id d9-v6mr21565915plo.81.1531157804827;
        Mon, 09 Jul 2018 10:36:44 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id o72-v6sm39181500pfk.76.2018.07.09.10.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 10:36:43 -0700 (PDT)
Date:   Mon, 9 Jul 2018 10:36:42 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/17] commit: increase commit message buffer size
Message-ID: <20180709173642.GB81741@google.com>
References: <20180708233638.520172-1-sandals@crustytoothpaste.net>
 <20180708233638.520172-8-sandals@crustytoothpaste.net>
 <4eb44f33-ac9c-7ce2-0e53-ec6fcb4560fd@gmail.com>
 <CAGZ79kaJKjWj9SY-cZYYcKShuooh3nuRqf26CzhCsusTXX42NA@mail.gmail.com>
 <20180709172716.GA81741@google.com>
 <xmqqzhz0e2k1.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzhz0e2k1.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/09, Junio C Hamano wrote:
> Brandon Williams <bmwill@google.com> writes:
> 
> >> > > diff --git a/refs/files-backend.c b/refs/files-backend.c
> >> > > index a9a066dcfb..252f835bae 100644
> >> > > --- a/refs/files-backend.c
> >> > > +++ b/refs/files-backend.c
> >> > > @@ -1587,7 +1587,7 @@ static int log_ref_write_fd(int fd, const struct object_id *old_oid,
> >> > >       char *logrec;
> >> > >
> >> > >       msglen = msg ? strlen(msg) : 0;
> >> > > -     maxlen = strlen(committer) + msglen + 100;
> >> > > +     maxlen = strlen(committer) + msglen + 200;
> >> > >       logrec = xmalloc(maxlen);
> >> > >       len = xsnprintf(logrec, maxlen, "%s %s %s\n",
> >> > >                       oid_to_hex(old_oid),
> >> >
> >> > nit: 100 is not enough anymore, but wasn't a very descriptive value. 200
> >> > may be enough now, but I'm not sure why.
> >> 
> >> That line was touched in by Michael in 7bd9bcf372d (refs: split filesystem-based
> >> refs code into a new file, 2015-11-09) and before that by Ronnie in 2c6207abbd6
> >> (refs.c: add a function to append a reflog entry to a fd, 2014-12-12)
> >> and introduced
> >> by Junio in 8ac65937d03 (Make sure we do not write bogus reflog
> >> entries., 2007-01-26)
> >> and it appears to me that 2*40 + 5 ought to be sufficient, but no
> >> comments or commit
> >> messages are found as to why we rather choose 100.
> >
> > Whats the reason for not using a strbuf here so that we don't have to
> > play with magic numbers?
> 
> Quite a legitimate question.  
> 
> I suspect that the reason is because the code (even though it now
> sits in a file that was relatively recently creted) predates either
> the introduction or wide adoption of strbuf.
> 
> Back when 6de08ae6 ("Log ref updates to logs/refs/<ref>",
> 2006-05-17) was done, we already had strbuf.c, but it only had
> read_line() and nothing else back then, so it wouldn't have been
> possible to use a strbuf there.

Fair enough, having never working in the code back then I don't know
what life was like without strbuf.

-- 
Brandon Williams
