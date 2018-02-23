Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D8D41F404
	for <e@80x24.org>; Fri, 23 Feb 2018 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751882AbeBWVmz (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 16:42:55 -0500
Received: from mail-yb0-f181.google.com ([209.85.213.181]:34484 "EHLO
        mail-yb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWVmx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 16:42:53 -0500
Received: by mail-yb0-f181.google.com with SMTP id e3-v6so3398989ybk.1
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 13:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AI17NJGGZ5wSFX9/PEPu0O8EfRyNbqOJNGQnAWlqqHQ=;
        b=IC6/4x0Hh8bfgCn4W/7cbLf4lSKXlIPs22cbjmTZK3k/W64TZqxKFx6tel2S8YxTEZ
         mYudEik7At+IRKXU3Z8bpDRw1z32kbg+CA11v5tbrsPGefOJ82TUfFQdfubqO7tl4dmB
         sK2wVfqJq3ja+YuybNX520GMFKy1nqvtfigZMb+OASH87Jp7EB7qzm6YCUdNAu7hJzS/
         3XS4g/rp2WdOTLgbW6ouIu80mSqIoKNikOazlAqLFxlXX0n1EeoQV7ETjz109Z0tTv5t
         p+tpFNqxcIYmZ6+Ihl1fwOjllvXcy9RYBWGcWNmMAUDBiyfrb67BMJQqNctAnldK0+1L
         /5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AI17NJGGZ5wSFX9/PEPu0O8EfRyNbqOJNGQnAWlqqHQ=;
        b=Wa2M1jO/fTGmXqQxchxBzvLoa0pwVEBUQd4pQDS3/+QfQ29+GvQs86rf2AWaHuDzgf
         17+3LqI9vX6D6fC4nwl/inLPSFhDfeZKV4zEeCwyGhQkp1Me5w+kdMNxxB7+4oJH+fKp
         Pw+MRz4ibrrx8Yyv3uSzzTWxUNoXO+uraYa6bi8kvg46TiLwSqoa/ELNFXbSvW82cqE1
         HfX/QQ6n5VPcw1xLkkeuAV/dl5P8ok4F67d6PM1bs0hOhJycB0l3TbPN9c6oS1ARn6wJ
         HQqwzc4EB9Kyf4cnal+x0i7uveLuQOvraO8zwa4CUvcPWWbvjL4donUiyONVoV5UhPwE
         Jt2w==
X-Gm-Message-State: APf1xPC0/Dk98jOXqmaSZvkY5Lj+n93RpwxPbqyXfRNmb76L7jbyjrdD
        kzvnExPt3dosUKYbHX1OJ7Ae2bmh2vt7v253io8m/w==
X-Google-Smtp-Source: AG47ELuwpCsfF+rm5CCx4fhGB+T9F+yJRyUavzpZvphz/AOE/hBpXWT4YEqVYJL2u00jYpYhzkWC0gvT/1KaJlWA/0E=
X-Received: by 2002:a25:f40e:: with SMTP id q14-v6mr2149019ybd.334.1519422172831;
 Fri, 23 Feb 2018 13:42:52 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a25:cfcb:0:0:0:0:0 with HTTP; Fri, 23 Feb 2018 13:42:52
 -0800 (PST)
In-Reply-To: <20180222064423.GD133592@aiede.svl.corp.google.com>
References: <20180216174626.24677-1-sbeller@google.com> <20180221015430.96054-1-sbeller@google.com>
 <20180221015430.96054-6-sbeller@google.com> <20180222064423.GD133592@aiede.svl.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 23 Feb 2018 13:42:52 -0800
Message-ID: <CAGZ79ka=6V-eicuQ=ZUrX7AE4iOWfwKJqeyLxp7bQs9z2sd95Q@mail.gmail.com>
Subject: Re: [PATCH 05/27] object-store: move packed_git and packed_git_mru to
 object store
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>>  2. Applying the semantic patch
>>     contrib/coccinelle/refactoring/packed_git.cocci to adjust callers.
>>     This semantic patch is placed in a sub directory of the coccinelle
>>     contrib dir, as this semantic patch is not expected to be of general
>>     usefulness; it is only useful during developing this series and
>>     merging it with other topics in flight. At a later date, just
>>     delete that semantic patch.
>
> Can the semantic patch go in the commit message instead?  It is very
> brief.

done

>
> Actually, I don't see this semantic patch in the diffstat.  Is the
> commit message stale?
>
>>  3. Applying line wrapping fixes from "make style" to break the
>>     resulting long lines.
>>
>>  4. Adding missing #includes of repository.h and object-store.h
>>     where needed.
>
> Is there a way to automate this step?  (I'm asking for my own
> reference when writing future patches, not because of any concern
> about the correctness of this one.)

no, for several reasons.
(a) I don't know how to write it in coccinelle, because
(b) I have not figured out the order in which we include headers, apart from
  "cache.h goes first", the rest of the includes sometimes looks like a random
  order, because different patches add new includes at different places.
  I have the impression, that (1) some add the include after all other
  existing includes or (2) try to figure out where to add the include to make
  sense in the existing include order or (3) sort alphabetically or (4) put it
  randomly, so the chance for a merge conflict with other series in flight
  decreases.
(c) I did it in a semi automated fashion:
    while make fails:
        add another include

The mess with including repository or object-store comes from the fact that
I had v2 based on object-store, not the repository and cherry-picked this patch
over to v3. Fixed all of the includes now.

>> @@ -59,10 +83,25 @@ struct raw_object_store {
>>        */
>>       char *objectdir;
>>
>> +     struct packed_git *packed_git;
>> +     /*
>> +      * A most-recently-used ordered version of the packed_git list, which can
>> +      * be iterated instead of packed_git (and marked via mru_mark).
>> +      */
>> +     struct list_head packed_git_mru;
>
> I don't understand the new part of the comment.  Can you explain here,
> for me?

cherrypicking error, fixed.

>> -#define RAW_OBJECT_STORE_INIT { NULL, NULL, NULL }
>> +
>> +/*
>> + * The mru list_head is supposed to be initialized using
>> + * the LIST_HEAD macro, assigning prev/next to itself.
>> + * However this doesn't work in this case as some compilers dislike
>> + * that macro on member variables. Use NULL instead as that is defined
>> + * and accepted, deferring the real init to prepare_packed_git_mru(). */
>
> style nit: '*/' should be on its own line.
>
> More importantly, we can avoid such an issue as described by Junio. :)

See reply to Junio, I am not quite sure I like that.
