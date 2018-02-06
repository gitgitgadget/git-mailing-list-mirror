Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 061761F404
	for <e@80x24.org>; Tue,  6 Feb 2018 18:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752682AbeBFSE1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 13:04:27 -0500
Received: from mail-yw0-f193.google.com ([209.85.161.193]:45655 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752481AbeBFSEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 13:04:25 -0500
Received: by mail-yw0-f193.google.com with SMTP id b16so1954867ywh.12
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 10:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=j+EhUU8INcN8M4MthKyPPtx8Q1PZTGQDUClT4JNp42k=;
        b=W3+ZDaPQJD/QtFa2jKyDQG8h9/0ThnbmgBTLFBY5EfbPvh7Ok56Bt6Xs4t1b95+4mQ
         vahntU+V7JqPmVTe3VH0C1uo1rh2mkz9IrMxRIiFhr7jA0sYQMPkyD9XXDyIH2zhvIrC
         OMc72GRyfo7+lpNbVlCNRbsSAW1PYFF4DhXF0wZfVPJlovvz1Vkyf+4aaqi20PuOD+oH
         s4IFMQllc908bQ+rgWalA5nPAI5gITvV3ZLUme8q8Akt22r8tUTg82QVQb/YTVo6PlHA
         1FJC7nvF1q4/UhKP47C04W2DHzkV+IpLaTZoeyhAm7Q5zC+46xR5It0F7lcx6jNmMbTX
         +23w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=j+EhUU8INcN8M4MthKyPPtx8Q1PZTGQDUClT4JNp42k=;
        b=EJrnDdpsPOrNra6vfic3ZfXtU1a8+e8yvlxGRlt9D18UttoxpjkM8BCoy4yEz8HkT7
         AdzBuaGhdayFgTQvL4RLT+Fct8dgb0hi2Gb7hnnC+FBdxGJSCrpPAeKzJIXUw2yK5c7h
         OTvfwDw6SiQWmwQo/DIVtmdXvkxy4RkWb1rNcghLhUsXLW13REzdoBFmj8GMxtQce+xt
         LqVrb33GoIvyXirmmEglVAkOeMlYczC0jG6sV4hyZDAnJw77GydYInqcjnLfmxN5KS3L
         y35U20NNVvkuXo9xDrV8//2ukfKwZnXNldURrAh90iu0AeZKvEQPasW2OtB/Ate18xNv
         ZOrA==
X-Gm-Message-State: APf1xPBEs2EvJ5f6klm2vO9lO/DQ5i22RyY07CHnLg08JhAAUB0njwwK
        oDGplaL8I5fSE7rPMunU+buUJ/gZF4mzvhl/UIATeA==
X-Google-Smtp-Source: AH8x2276EYssZA7HYLS5EJ+1+wt5kJh5mLgPNNL05mZGMwQJygVN62As4daSQnlnk2b1nqLVy04/yklZvGDCqfzejRU=
X-Received: by 10.37.180.65 with SMTP id c1mr2113957ybg.438.1517940264925;
 Tue, 06 Feb 2018 10:04:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Tue, 6 Feb 2018 10:04:24 -0800 (PST)
In-Reply-To: <CAPig+cT4=WA2PpovtG1M5hsrTxzDYdGjiYgvpp4Pbggc3Qo-Yw@mail.gmail.com>
References: <20180205235508.216277-1-sbeller@google.com> <20180205235735.216710-1-sbeller@google.com>
 <20180205235735.216710-72-sbeller@google.com> <CAPig+cT4=WA2PpovtG1M5hsrTxzDYdGjiYgvpp4Pbggc3Qo-Yw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 6 Feb 2018 10:04:24 -0800
Message-ID: <CAGZ79kYKJYemWaaco5wMexf8eiYSDZ06YuReBFykFypSMQNzEQ@mail.gmail.com>
Subject: Re: [PATCH 092/194] object: move grafts to object parser
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 5, 2018 at 8:07 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Feb 5, 2018 at 6:55 PM, Stefan Beller <sbeller@google.com> wrote:
>> Grafts are only meaningful in the context of a single repository.
>> Therefore they cannot be global.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
>> ---
>> diff --git a/commit.c b/commit.c
>> @@ -121,20 +120,22 @@ int register_commit_graft(struct commit_graft *graft, int ignore_dups)
>>                 if (ignore_dups)
>>                         free(graft);
>>                 else {
>> -                       free(commit_graft[pos]);
>> -                       commit_graft[pos] = graft;
>> +                       free(the_repository->parsed_objects.grafts[pos]);
>> +                       the_repository->parsed_objects.grafts[pos] = graft;
>> diff --git a/object.h b/object.h
>> @@ -4,9 +4,13 @@
>>  struct object_parser {
>>         struct object **obj_hash;
>>         int nr_objs, obj_hash_size;
>> +
>> +       /* parent substitutions from .git/info/grafts and .git/shallow */
>> +       struct commit_graft **grafts;
>> +       int grafts_alloc, grafts_nr;
>>  };
>
> Do items moved to object_parser need to get freed when object_parser
> itself is freed? Is that happening in some other patch?

No, this patch supposedly should free the memory via
repo_free (which either does it itself or calls some specific free
for the grafts)

Thanks for finding the mem leak!
Stefan
