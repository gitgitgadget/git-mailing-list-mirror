Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A50F208B5
	for <e@80x24.org>; Wed,  2 Aug 2017 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbdHBR0i (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 13:26:38 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34595 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751162AbdHBR0g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 13:26:36 -0400
Received: by mail-pg0-f44.google.com with SMTP id u185so23729277pgb.1
        for <git@vger.kernel.org>; Wed, 02 Aug 2017 10:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XIix+JRdToSOiajGWGz9a+swAjPzpImzLJC+zk9yi3o=;
        b=gQPtsNTRuifedqWkPHhV+S0Ew7frofq/TfgHgjJkdOU7UfWhMNi9JBp4V9EQPDkAOo
         N133apLUb8hsd93EZbOAFg3q3HEO5qToFpC1ccf6qQLqsBX6RBfJ17Hr1vVSUecMFg5j
         +UP4iFcIQTs6JnrkEO/nFCED/1kWZj3iD7xCD0ybuw2Dv31yGcXdwAtlaBY5O+Milhod
         ErjoksMk9oPUowZKxNb59zRGqTuIPKqfWzJHj3MLZZLGIgEkMU2/Bg9FDQDyFlh9J8eL
         PEJngG6QM8V/a10Jeox/cUnALZcshC/2YBXu1Is+CuX/2S7VnmWXAQG9UGeCZBpS4g96
         PU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XIix+JRdToSOiajGWGz9a+swAjPzpImzLJC+zk9yi3o=;
        b=JkhvR0KVnGdDiXH+P/vyREx4K8yBNSnq0qsrNZoRlB3OS5nl0AndxooNy/FdBUM6ch
         FN8J8rcvA8LMzm+pVFSU2YXLOiN63EPftbJphO43r7wlHxznXTC+NKsVsJhzgupSO2td
         tvY0/HvMp4wGd51q3Vxl918izrIoAXcPYUfI4z7X4Xt1/oE3dcNuUQnYTpdo5ue7ZRMk
         XH9QGHDdoVkCe/H0TKtO2huFl8c9EqHVwR6T2kbr1R8SfEVpE5OMzaAwHTNFaB171L7/
         UoVduwVUs/e472Co3083KKxuUOeDRwKYghTh3OSlHq5g91fvVsoYd6xYdJB9UdQm893O
         9IrQ==
X-Gm-Message-State: AIVw112rY73NxRSU+BCRjtbxmhnu92doy9GdknUugAUSfuBKEbUEkewJ
        gVF4WoGwsD4Px7Qy
X-Received: by 10.98.42.205 with SMTP id q196mr23898867pfq.176.1501694796055;
        Wed, 02 Aug 2017 10:26:36 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:5415:3cb1:21dc:39fd])
        by smtp.gmail.com with ESMTPSA id v1sm25241004pfi.52.2017.08.02.10.26.34
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 02 Aug 2017 10:26:34 -0700 (PDT)
Date:   Wed, 2 Aug 2017 10:26:33 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] convert any hard coded .gitmodules file string to the
 MACRO
Message-ID: <20170802172633.GA36159@google.com>
References: <20170718190527.78049-4-bmwill@google.com>
 <20170731231142.15053-1-sbeller@google.com>
 <413e4f55-5f8b-a80f-775b-b456c4de8a46@jeffhostetler.com>
 <CAGZ79kY-H7rWW_h-k4fHXkwqfMJvd8MtGBooNH8J7PaA2Gj1Yg@mail.gmail.com>
 <xmqq4ltrf30q.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4ltrf30q.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/01, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
> >>>   @@ -233,18 +233,18 @@ void gitmodules_config(void)
> >>>                 strbuf_addstr(&gitmodules_path, "/.gitmodules");
> >>
> >>
> >> Did you mean to also change "/.gitmodules" ??
> >
> > Goog point. We should pick that up as well. However as we do not have
> > a macro for that, we'd have to have 2 calls to strbuf API
> >
> >     strbuf_addch(&sb, '/');
> >     strbuf_addstr(&sb, GITMODULES);
> 
> Ehh, doesn't string literal concatenation work here?  I.e. something
> like:
> 
>     strbuf_addstr(&gitmodules_path, "/" GITMODULES_FILE);
> 
> 
> >>>                 if (pos < 0) { /* .gitmodules not found or isn't merged */
> >>>                         pos = -1 - pos;
> >>>                         if (active_nr > pos) {  /* there is a .gitmodules
> >>> */
> >>
> >>
> >> It might also be nice to change the literals in the comments to
> >> use the macro.
> 
> The reason you want this patch is not like we want to make it easy
> to rename the file to ".gitprojects" later, right?  The patch is
> about avoiding misspelled string constant, like "/.gitmdoules",
> without getting caught by the compiler, no?

Yes, it was mostly about preventing mistakes and having the compiler
help you out a bit, so changing the comments isn't really needed.

> 
> Assuming that I am correctly guessing the intention, I think it is a
> bad idea to rename these in the comments.
> 
> 

-- 
Brandon Williams
