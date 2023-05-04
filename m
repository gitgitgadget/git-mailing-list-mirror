Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FB9C7EE21
	for <git@archiver.kernel.org>; Thu,  4 May 2023 13:59:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbjEDN7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 09:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjEDN7h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 09:59:37 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A091982
        for <git@vger.kernel.org>; Thu,  4 May 2023 06:59:36 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-55a8e9e2c53so4250827b3.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 06:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1683208776; x=1685800776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MeHgA4QildFd6/592TGtvPnwhJXw7ivJAPqIQv1npPE=;
        b=M1bBzhZzi204bijau7UARR8obg3pVLEjEoh5Ik5cBHJCY6zoU8JC/5mh0Apatsl2Nn
         whEjHlnKD+jEdRE2K6rO4m3ETCLVK1yut+HNuLDiG3qWIYtgtCJW7vYU5wcvYnqzje5M
         y+aT4AKfdNqQiRSeXEJL9225wZQR4m6jdZLcJlfrRzw4v/bzbX5x6i5P1pKe3e2amdQP
         gH1hWLkObQWD3Vce5fcI5KxMMXbCbB21APTvuQMtpcTcUGNClS8kSYFEdMa0laYMt7CL
         B2KOWToBS0Xr5teVVNZe+fQYwF+eJHzjffOft/EsITUOQ3DlFOXGyUcsni+SASbWDK7V
         Mr3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683208776; x=1685800776;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MeHgA4QildFd6/592TGtvPnwhJXw7ivJAPqIQv1npPE=;
        b=dSzWV+Is9cm7ru0ObxTi3EBxdhR+5VMiTbowDOLzAaQ07Upqab/wDhLY0EIyQxU5PO
         pcstsfy6c1coQWb0cQ2EQFgaeRYRgm+vvbrcDB4y80tem2Nd/pztZNVbnnLtNR79vs+6
         3b3O0tUWKESyNJBuPPsksgcmkIidoAVPj8ykV+/F23H66TlM17j/6UlifoasWs8Y8KoW
         HLqrOuwxkSeBQby6roL8UQG5iMgGCtle0inUFAB0bPZRVZDkX0pmsuFaCl+q6YDR6uB5
         +i8QvbIAnhtbLsTPnVzigORqX1oucgthuolY/mX9dX3lubZEs0iLGYmyqruEPq+r7QEp
         ShvQ==
X-Gm-Message-State: AC+VfDyIU9XV9B04d7GjrDXVcq89aJ65bib9HLzYJa0DFBkeXHCnXUt1
        ptuCbpCk7JQ5Qvj11FldD55z
X-Google-Smtp-Source: ACHHUZ5ozHUdRHlJqQNJvf8kKLFwfmcVRXJQO+a/rdqU9AQDOWmbZqBkvls7jamr7JN3iriv78ydzQ==
X-Received: by 2002:a81:8453:0:b0:55a:9df1:9505 with SMTP id u80-20020a818453000000b0055a9df19505mr2462334ywf.8.1683208775830;
        Thu, 04 May 2023 06:59:35 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:8cb:9a54:52c4:914c? ([2600:1700:e72:80a0:8cb:9a54:52c4:914c])
        by smtp.gmail.com with ESMTPSA id c125-20020a0dc183000000b0054f8b1f21e5sm9342604ywd.85.2023.05.04.06.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 06:59:35 -0700 (PDT)
Message-ID: <7a0ea3d7-f67b-8f9d-f9ea-550fcc05108d@github.com>
Date:   Thu, 4 May 2023 09:59:32 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/3] revision: support tracking uninteresting commits
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
References: <cover.1682380788.git.me@ttaylorr.com>
 <a643678c0ff7d1a910b1d6c33a839166e2a6a7b2.1682380788.git.me@ttaylorr.com>
 <0b8884ea-f37b-b7d4-6edb-825ca935a893@github.com>
 <ZFLbXTKOK6KTEy7q@nand.local>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZFLbXTKOK6KTEy7q@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/2023 6:08 PM, Taylor Blau wrote:
> On Tue, Apr 25, 2023 at 02:15:49PM -0400, Derrick Stolee wrote:
>> I know that the walking code in builtin/pack-objects.c does
>> this same computation, but it's muddled with other checks and
>> the trees are marked as UNINTERESTING at the same time. It
>> doesn't seem like we can reuse anything directly out of there,
>> but it did give me the idea to try a callback.
> 
> Interesting idea. When you say callback, do you mean a function that we
> invoke in place of where we currently call `add_object_array()`? Or do
> you mean something else? Curious.

I was talking about passing a callback into the revision walk
instead of having the revision code create a list, as you
replied to in this response:

>> But could we also do this at the caller's end by passing a
>> callback that checks each walked commit if it is UNINTERESTING
>> and adds it to a set?
> 
> I think I remember trying this when I originally wrote this code, and
> ended up discarding the idea because it walked over more commits than we
> needed to consider.
 
It's interesting that it walked more commits than you wanted. I
suppose it's somehow related to the boundary condition you're
implying by enabling the construction of this list.

Could you describe the situation where more commits are walked
than you want? I imagine we can't actually stop at the boundary
because we need to know that certain commits are actually reachable
from those boundary commits.

Here's an example (assume horizontal levels are equal generation
number for the sake of the walk's stopping condition).

  1 (UNINTERESTING)  2 (INTERESTING)
  |\_____       ____/|
  |      \     /     |
  3       4    5     6
  |       |\__ |     |
  |       |   \|     |
  7       8   [9]    10
  |       |    |     |
  11      12   13    14
  |       |    | ___/|
  |       |    |/    |
  15      16  [17]   18
  |       | ___|____/
  |       |/   |
 (19)    [20]   21

Here, 9, 17, and 20 are the boundary, as they are UNINITERESTING
but reachable from an interesting commit (5, 14, and 18,
respectively). This is sufficient to provide a stopping point
for this single-directional difference "2 --not 1".

It's important that we didn't stop walking at 9, since its
UNINTERESTING bit needed to propagate through 13 to get to 17.

Note that 19 is reachable from 1 but not 2, so we would need to
keep walking if we were looking for the boundary of the symmetric
difference 1...2. But we don't need it here since everything at
that level is marked UNINTERESTING so the walk can stop.

Is this example sufficiently complex for you to describe what
causes the extra commit walking? In such a case, what does the
object array approach add to prevent the extra walking?

Thanks,
-Stolee
