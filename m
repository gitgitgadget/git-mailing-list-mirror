Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3CD1F597
	for <e@80x24.org>; Mon, 23 Jul 2018 21:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388171AbeGWWbh (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 18:31:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35728 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388077AbeGWWbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 18:31:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id e6-v6so1275084pgv.2
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LpLg8JhyDVzwc4WzHoPMzodeDbW6XlqQwRFD8tduCak=;
        b=WtPEU5QgLPfZLARzY2T8f+3tvbBoPJ8ZXsZdNoHFgcOYG3UI6/VE+3Dm+C9w82Qf0y
         bEyOQk7vBMUxYao5Rh8YbEa8U7gKnJZ0YUaNfWrrDZ+X1QLDcIiAaJ1goj6lMSizO6ZJ
         Fgcyndc0zas9BmpI6P9w9RgIFUvO1/yFe+TdHbhewQ8fXu+C1MSLIcF939HVY2y7thYS
         3/eLhgs19cEcrv/ZRTtg4jYZjjvreuX69P9zHyrR1u8j53ISs+l9fm3Z1UR/MbDB0pB6
         tkXUKXqBJo9nmXVx6YuABHF/W2IxlnQmCtqeatfqCjmjxwmiumbdoyXxMQIYI+JBLgJH
         VH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LpLg8JhyDVzwc4WzHoPMzodeDbW6XlqQwRFD8tduCak=;
        b=iCT0dwQdU1ikLz6UBF5YmjtQBTxMT3o8sZc3k9ktV1sjIWjBp82cLFI9J4oYtmKbVM
         91S+OoFWXPajmGIaHneC7AoTuJNHm6GefL4DIoYTw2Pog+4l6TqDzEMGawt3D1qCFjzb
         RTsstSSsZVxSPQEFMjV4yZ7AVV1G0AoEURFhy9tJP2VQ8jaO3CgUe1SjqYglT4Jxgtse
         qakObRcbO6vyOy3cbjG9IlXNris9C17Zz0ACQK4FQ8GJfKGHtGBH8B6NJXIU9YXsaEga
         EiMjiYuVhKOb6ai84gbZ4MH8oeu20w0aY9wTD5M1dccYhsbERZO6LgCILDiJPt/uZAg9
         E1Hw==
X-Gm-Message-State: AOUpUlFIBeHVtvJYZuhkJ7FZHHHo454qbw+UZcMiCaYmhyrlB+aBg3M+
        V/3rn1PfQ4FOeqAi4gZll+A=
X-Google-Smtp-Source: AAOMgpeJXAxAmbj635NBUPbM+v2pWCmDwF45PA+YIZQycnrhYXOJW3cxeSyh/KSKyK6h57Z8qZNFKA==
X-Received: by 2002:a62:4898:: with SMTP id q24-v6mr14674389pfi.58.1532381309944;
        Mon, 23 Jul 2018 14:28:29 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f5-v6sm17801725pga.58.2018.07.23.14.28.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 14:28:29 -0700 (PDT)
Date:   Mon, 23 Jul 2018 14:28:27 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v6 8/8] fetch-pack: implement ref-in-want
Message-ID: <20180723212827.GC9285@aiede.svl.corp.google.com>
References: <20180626205438.110764-1-bmwill@google.com>
 <20180627223023.49659-1-bmwill@google.com>
 <20180627223023.49659-9-bmwill@google.com>
 <CACsJy8CJG5RCL40vCbNnQMHmtjQmch9qntxeh_Pt6ZUfnRN9uA@mail.gmail.com>
 <20180723175318.GB25435@google.com>
 <CACsJy8COu2zmWWuodww=ZdURZBw6CVx9ibbfeAJ0Q4pQ-ng_uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACsJy8COu2zmWWuodww=ZdURZBw6CVx9ibbfeAJ0Q4pQ-ng_uA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Duy Nguyen wrote:
> On Mon, Jul 23, 2018 at 7:53 PM Brandon Williams <bmwill@google.com> wrote:

>> What criteria is used to determine if something should be translated?
[...]
> Besides drawing the line "benefit from (not) being translated" varies
> from one developer to another. I think it's just easier and more
> consistent to stick to "if it's not machine-readable (or really meant
> for devs, like BUG()), translate it" and leave it to translators to
> decide.

Yup, this is my understanding too: everything user-facing (as opposed
to machine-facing) that isn't a "this can't happen" local assertion
error (BUG) should be translated.

Protocol and format errors aren't BUG (assertion error) because they
reflect something that shouldn't be possible to happen due to someone
*else* behaving badly.  BUG is for errors that shouldn't be possible
due to the version of Git that produces the message behaving badly.

po/README says

 - Don't mark everything for translation, only strings which will be
   read by humans (the porcelain interface) should be translated.

   The output from Git's plumbing utilities will primarily be read by
   programs and would break scripts under non-C locales if it was
   translated. Plumbing strings should not be translated, since
   they're part of Git's API.

I kind of wish we had a rule that was less fuzzy, since then we could
enforce it.  For example, JGit has a rule that *all* strings should be
translatable unless they have a comment explaining why they shouldn't
be (which goes a little too far --- there are those comments all over
the place).

Thanks,
Jonathan
