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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E2681F462
	for <e@80x24.org>; Wed, 24 Jul 2019 22:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbfGXWiF (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jul 2019 18:38:05 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43411 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfGXWiF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jul 2019 18:38:05 -0400
Received: by mail-pg1-f194.google.com with SMTP id f25so21907724pgv.10
        for <git@vger.kernel.org>; Wed, 24 Jul 2019 15:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KZWawZ3aa2Ya0hZnV5mfr+hKM7dkKw5d2s1ADvXss2A=;
        b=A986pas0HbdUwS1PKkbyHIZLW/Z230/s0g0IOm3+rPV3wHLl7xW7EaFd1qKNrFTLMZ
         qYnh1g91iu2WkoClqnNNxZ+DqyV6w27sU5Sdss5duzRVvl5ng+0CjndAuTBlCZ2gGK5c
         P7QO29I3F1ocu7v0SI3TgPs4oWdHY9O5R6rjsmipk9Uy/cPiHIsfYiJayco0BMd43cOF
         JK9E5qns2Qwq5hPSsQceuSP2OdQ7c0WHESUOhTsKrKS8g0NTNUKAaw10gaZwR7OBGwRF
         I/yaScYpbvHRFHjqdmd16LXjmxyPmvxiztBvEJd1ZxMqsemjdI/eJBxiNVVhO6W+RgIB
         LkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=KZWawZ3aa2Ya0hZnV5mfr+hKM7dkKw5d2s1ADvXss2A=;
        b=OJMPJ6f9V4Ul6X3i4cZ9PoBYblpl+cP/Av70v9bD/v1QH3hRUobA+Hmb1RZCzmDpwa
         xsKzU2ZM3SBHeG7c0/pLy+VNE6xpt4Le8jrFf7BZvGM1ug1ftr6JJMQJ8LJ0xIzQm3yJ
         J1td5hQ0r2tTuVL2nNjXUWYLsogAj/j4/jFgwUDXEvoRGYOQIzrAX59Z/w94DqByzhaO
         66ydOIOkuM9My+cOgZJFPJUamGRQladupK9UkBwbyGNXyCbxQeGs0yfLa1vOCiCnXhli
         AbJfIgRpysgZufOuBTxKTIqRb3D9mspLEsQjq3p+PyIjHbm+R8HQljNnR+I4zvRnZojz
         KfSw==
X-Gm-Message-State: APjAAAXnK5g7lmzRq4SwAmy+71DmicsAxQtcf0ANhp6JIg4oCgynT6uP
        T+e7chvC7YOEkHEpmRJHlDCM6Q==
X-Google-Smtp-Source: APXvYqzQ1f5jnfDt4KqubR6j8SUIN6vGOGYJ4q2w0AxzdBNxysTzUIzCB9xmuPcI8Rw04nj9GxfWAg==
X-Received: by 2002:a63:60c1:: with SMTP id u184mr79496866pgb.275.1564007883571;
        Wed, 24 Jul 2019 15:38:03 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4264:e2f7:27a:8bb2])
        by smtp.gmail.com with ESMTPSA id o130sm78685884pfg.171.2019.07.24.15.38.02
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 15:38:02 -0700 (PDT)
Date:   Wed, 24 Jul 2019 15:37:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Jakub Narebski <jnareb@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, git@jeffhostetler.com,
        avarab@gmail.com, peff@peff.net
Subject: Re: [RFC PATCH v2 1/3] trace2: Add a JSON schema for trace2 events
Message-ID: <20190724223753.GB43313@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net
References: <cover.1560295286.git.steadmon@google.com>
 <cover.1562712943.git.steadmon@google.com>
 <a949db776c77e5c97c78055f1bb0f2101096f861.1562712943.git.steadmon@google.com>
 <86wogp68q0.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wogp68q0.fsf@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019.07.10 20:32, Jakub Narebski wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Define a JSON schema[1] that can be used to validate trace2 event
> > objects. This can be used to add regression tests to verify that the
> > event output format does not change unexpectedly.
> >
> > Two versions of the schema are provided:
> 
> Actually, four versions of the schema are provided, as you have written
> in the t/trace_schema_validator/README file.

Thanks for the catch, will be fixed in V3.
