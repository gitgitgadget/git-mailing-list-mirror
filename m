Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98B4720A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbeLMQUV (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 11:20:21 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:43606 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeLMQUU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 11:20:20 -0500
Received: by mail-yw1-f67.google.com with SMTP id l200so1025336ywe.10
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 08:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GdZL1777pq+Tymu7fK6XcS6GSv93zDmzL/hxgXq20jg=;
        b=XLS0fyKTKTZ6YPTs1jdrw4jfkF7Hw/is6cGn8jnKPS1zXBLXBWP7MEVu7yP1e2PgEj
         0T3Ljvi5rDQohdlPoJkTQyHv3GGRY4RjCZZhAh1GwTODzunCeujOccZuTCDecdNhlp29
         7i5O+yd+B3zQhGDlJB9lkWDxGDope4HGaTAFqqXhhmJCxDY30lEW3wN7Phmmm2SH+Ejw
         AfmhBmq6V9FZGsMWdH3kGsHlXeN6eQqUn2E3hpwBPncINb4sHHNqibNjw0ciC4KhbTKG
         lFlViLmoAQiHQRssGFDz2NugeWT5ao11v5lMisFG3rCiQaT385CwuQk91heQP5aqireR
         EP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GdZL1777pq+Tymu7fK6XcS6GSv93zDmzL/hxgXq20jg=;
        b=S8msZwU+3WWswC3/CukGCq3Rvub9XWQSSVXfhv5GjzfQseoCrlvR8Sze+F+LR+mi1D
         H+JSvriZrkFzl6zo0HDjNvANu+Mr6+dY+KPcFx6+w/aAj4XZDj8TIFvOE5IrwsPs8fVI
         5CWrRl/F6dbuSGkd+Ai0WBqkYZc/Qp6d4ZWkXEQP6Gjf7qJetEfJ2Nx+WsIzn9LMn+V4
         RhGjPByS/21eYagif6Ekwab28a2AhcfjfhAMHlWYe2aK26MIV4JgXc4mnVNt8bl2z/1Z
         sTWiGhsV2B8lT0H5kCw31a3sObUpf+/13bwLe7jK+TJ3grPjEk6z5qQJy89D3p+8a9hz
         yF8g==
X-Gm-Message-State: AA+aEWZq8qVVoPmuubkN1WUwpxrb63LEufJCxfFW9PtmOKJ+EfiFUOZu
        8FOhaCg8TPhpSwZlj/oMeDn9RxT+
X-Google-Smtp-Source: AFSGD/X+tIp2UzZPC/zzivwy+2ExrDwVgbVC5/dsdYUufYPhki4jl0Tmoa/qLAsa2ChKE4XjSltOTg==
X-Received: by 2002:a81:6c90:: with SMTP id h138mr25026259ywc.379.1544718019391;
        Thu, 13 Dec 2018 08:20:19 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id a72sm705120ywh.42.2018.12.13.08.20.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 08:20:18 -0800 (PST)
Subject: Re: [PATCH on master v2] revision: use commit graph in
 get_reference()
To:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org
References: <20181211105439.GA8452@sigill.intra.peff.net>
 <20181212195812.232726-1-jonathantanmy@google.com>
 <20181213012707.GC26210@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f1d40014-0e05-5fcb-cedc-e07a22c80628@gmail.com>
Date:   Thu, 13 Dec 2018 11:20:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181213012707.GC26210@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2018 8:27 PM, Jeff King wrote:
> On Wed, Dec 12, 2018 at 11:58:12AM -0800, Jonathan Tan wrote:
>
>>> Yeah, this was the part that took me a bit to figure out, as well. The
>>> optimization here is really just avoiding a call to lookup_commit(),
>>> which will do a single hash-table lookup. I wonder if that's actually
>>> worth this more complex interface (as opposed to just always taking an
>>> oid and then always returning a "struct commit", which could be old or
>>> new).
>> Avoidance of lookup_commit() is more important than an optimization, I
>> think. Here, we call lookup_commit() only when we know that that object
>> is a commit (by its presence in a commit graph). If we just called it
>> blindly, we might mistakenly create a commit for that hash when it is
>> actually an object of another type. (We could inline lookup_commit() in
>> parse_commit_in_graph_one(), removing the object creation part, but that
>> adds complexity as well.)
> I was thinking we would only do so in the happy path when we find a
> commit. I.e., something like:
>
>    obj = lookup_object(oid); /* does not auto-vivify */
>    if (obj && obj->parsed)
> 	return obj;
>
>    if (we_have_it_in_commit_graph) {
> 	commit = obj || lookup_commit(oid);
> 	fill_in_details_from_commit_graph(commit);
> 	return &commit->obj;
>    } else {
> 	return parse_object(oid);
>    }
>
> which is more along the lines of that parse_probably_commit() that
> Stolee mentioned.

This approach is what I had in mind. Thanks for making it more concrete!

-Stolee

