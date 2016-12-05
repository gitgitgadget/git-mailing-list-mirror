Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 077191FBB0
	for <e@80x24.org>; Mon,  5 Dec 2016 19:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbcLETbz (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Dec 2016 14:31:55 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:35760 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751388AbcLETby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2016 14:31:54 -0500
Received: by mail-pg0-f50.google.com with SMTP id p66so139823344pga.2
        for <git@vger.kernel.org>; Mon, 05 Dec 2016 11:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J+b6TDRyKTbRsUHYJvHWVUjRerI+eyURwAbgsYKf22Q=;
        b=P6iq0EcmVplsBtWtNHvBGC/2au5jahtG1xXNsoPcjcXR0ZRrwFomr5C5Eds1l8FfRt
         SzFT6Kk2mxJN2UxmsEQzu2nfeTef/yvmLAxB55aUF54fiqD5KkEMynocbCJkdFzuC3oX
         b7LlWl7lxZLdjFtJS0Gj7sEq+IzptQy6JtnZt2pnX4eklwRBsBdz+7Z6uVRrO4kDa/bI
         szWh+IG5iGy5+S+Rg1HaGJDnMkTBNi/h6BDOwDeNQxBL0nYoQhYJnjCMhP0weHZtsptV
         g8RwZxCcKPaFiMO0SvHnEUdZbIW7vwqYu5vhnYHDCoXLaw34ien18wefSk+Pglp7B4Jo
         MmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J+b6TDRyKTbRsUHYJvHWVUjRerI+eyURwAbgsYKf22Q=;
        b=K7igZvLcSODHPWypaJ72YYLnRDgvRii2hGaJRxAMeKy7v0UgtvrySBn7JTdqrzqSQk
         xurdxRY4P4XssDAIVseueV4an/P33OOFHcaw8cwiQslesjqrEDnomYV9KTpFpZYigH+x
         RtxGbLCvrOAOphnIU1gneEInr3ZT8ExKHr5ReJc4Ceu66aNfmiJtP7EJSC6Ry0BrW+mU
         NBj/l6RYyapTrbL3u1wuTU2JkP2N01oFl0WK6wk9KxQChjq/7YRSwn/3bMcrJUrMqsoT
         zgANh84Bs7Bf3V/v1/W+LmV+RThwT573rQceAGho+DpZ6xNvc0zwKaA0Sr2/ky/igRhf
         1/BQ==
X-Gm-Message-State: AKaTC00odpA7UmRhGKfoGvT4rX7KElaJ6uNlZ0Mjpoe3eqJmAd6gcva1sUEKEIQl+t8FwkI+
X-Received: by 10.84.204.133 with SMTP id b5mr128274805ple.49.1480966313607;
        Mon, 05 Dec 2016 11:31:53 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:20ca:c78:1a67:9579])
        by smtp.gmail.com with ESMTPSA id j68sm29188849pfk.95.2016.12.05.11.31.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 05 Dec 2016 11:31:52 -0800 (PST)
Date:   Mon, 5 Dec 2016 11:31:51 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCHv2 15/17] checkout: recurse into submodules if asked to
Message-ID: <20161205193151.GC68588@google.com>
References: <20161203003022.29797-1-sbeller@google.com>
 <20161203003022.29797-16-sbeller@google.com>
 <20161205192527.GA68588@google.com>
 <CAGZ79kbEtR7_6ZvBsjkc=8q+nnq9FoPv9HNWdRyuR2CQGqQ2oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbEtR7_6ZvBsjkc=8q+nnq9FoPv9HNWdRyuR2CQGqQ2oA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/05, Stefan Beller wrote:
> On Mon, Dec 5, 2016 at 11:25 AM, Brandon Williams <bmwill@google.com> wrote:
> > On 12/02, Stefan Beller wrote:
> >>
> >>  test_expect_success '"checkout <submodule>" honors diff.ignoreSubmodules' '
> >> @@ -63,6 +70,260 @@ test_expect_success '"checkout <submodule>" honors submodule.*.ignore from .git/
> >>       ! test -s actual
> >>  '
> >
> > Should you use test_must_fail and not '!'?
> 
> We use test_must_fail for git and '!' for non git thigns (test, grep etc),
> as the test suite is about testing git.
> 
> The test_must_fail expects the command to be run to
> * not reurn 0 (success)
> * not segfault
> * not return some other arbitrary return codes
>   indicating abnormal failure (125 IIRC)
> 
> So in a way test_must_fail translates to:
> "I want to run this git command and it should fail
> gracefully because at this state, it is the best git can do"
> 
> The '!' however is just inverting the boolean expression.
> We assume test, grep, et al. to be flawless here. ;)

Ah, alright.  Thanks for the info :)

-- 
Brandon Williams
