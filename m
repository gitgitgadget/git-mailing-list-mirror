Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474AC6FD1C
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 19:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbjCXTnu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 15:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjCXTnt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 15:43:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39358166D1
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:43:48 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l7so2380693pjg.5
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 12:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679687028;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQQW+u9QPptxF2nShVl06jKLjVfxAvKbcIMtxCO8o68=;
        b=SMndBhFdtAX5boWtr8nlWe86aZXgVD05tI98095sJ8h6wieNcl7tAtZrZVpG2hvdWy
         vO6UsNk3ozgAk87EqZRHwTFzavsxcv2CmNRy2hJ+AeCauog8Uz7614cMPMkwc9AndYFK
         Jcym87MudWea19q9VWLQRCrCicGFqAVgVGiBtOOTO/VtiRvdZtRQ0xPZn3/Ia2VnMBQj
         dif0HstcuVsf7jyQK45cTnVp0Vrdph5lb1X+pmmT+3Egk5SeBqVxisbIpI3k4l8Q0l/v
         ldt8Nz7oSivl8GWU4DNTpRxP8x4Tja8d8CaL2NPsTqiwsThtUM1WbQEEWf1pY87AZaBd
         l9Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679687028;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jQQW+u9QPptxF2nShVl06jKLjVfxAvKbcIMtxCO8o68=;
        b=pvJE4oF6Plg/nKutmu1h4WiUAy7iAeAh0umqS0lnYra2BZ87mhUWyJamegKMBnSGDw
         VazOAFg066a99CQJTnb0nztV6yjHbYsllMm3deSJNeKD0rtd0tLA6nEx/YZO2ISCzIhS
         SVNKaqbiK09oCWVItRHpa3rm0eoTLYkQeDS3bXOXMcW3dgDeCnTMpJwyR190jkyw9uY0
         0VXdy0uGVb2x44f9Z4kycE+f1LdrwaJbRjX0BefdJVRuqhdSIrWarKj9OvgZ0Mcqsj5h
         BePKlc53UFWYS1+ndCJlJT4GYWNEFQWMDPFPZMyUj2G1AmVQ+Z6PCu7fcr1sFPe+wGDi
         3ofw==
X-Gm-Message-State: AAQBX9chXu8tOU/iaQ2xVrlEg1LnoDXHFzYQ+ijlzysLabVRvS66Ty92
        K1NoL5HjgeMoeJitiIxlmrM=
X-Google-Smtp-Source: AKy350ZSX4nhbYAJ04ExRL1kp/tH5ktEVRbTZsHJ2QQ2oZvuJGIffnjkVWmIvQinmOTACWCVFlXXgw==
X-Received: by 2002:a17:903:2806:b0:1a1:c3eb:af7 with SMTP id kp6-20020a170903280600b001a1c3eb0af7mr3053991plb.55.1679687027559;
        Fri, 24 Mar 2023 12:43:47 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902f7cd00b0019d1f42b00csm14560169plw.17.2023.03.24.12.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 12:43:47 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Subject: Re: [PATCH 5/6] pack-bitmap.c: use `bitmap_index_seek()` where
 possible
References: <cover.1679342296.git.me@ttaylorr.com>
        <9a3e45b78b7810e0116848f1de80096b04285a55.1679342296.git.me@ttaylorr.com>
        <20230321180525.GG3119834@coredump.intra.peff.net>
        <8a7cf287-421c-9a7f-0788-c5e219e6a8e3@github.com>
        <20230324183514.GB536252@coredump.intra.peff.net>
Date:   Fri, 24 Mar 2023 12:43:46 -0700
In-Reply-To: <20230324183514.GB536252@coredump.intra.peff.net> (Jeff King's
        message of "Fri, 24 Mar 2023 14:35:14 -0400")
Message-ID: <xmqqr0tedjf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Mar 24, 2023 at 02:06:43PM -0400, Derrick Stolee wrote:
>
>> >> +	bitmap_index_seek(index, header_size, SEEK_CUR);
>> >>  	return 0;
>> >>  }
>> > 
>> > Likewise this function already has bounds checks at the top:
>> > 
>> > 	if (index->map_size < header_size + the_hash_algo->rawsz)
>> > 		return error(_("corrupted bitmap index (too small)"));
>> > 
>> > I'd be perfectly happy if we swapped that our for checking the bounds on
>> > individual reads, but the extra checking in the seek step here just
>> > seems redundant (and again, too late).
>> 
>> I think it would be nice to replace all of these custom bounds
>> checks with a check within bitmap_index_seek() and error conditions
>> done in response to an error code returned by that method. It keeps
>> the code more consistent in the potential future of changing the
>> amount to move the map_pos and the amount checked in these conditions.
>
> Yeah, that's what I was getting at. But doing it at seek time is too
> late. We'll have just read off the end of the array.

Yup.  You illustrated it nicely in your response for the previous
step of the series.  If the typical access pattern is to check, read
and then advance to the next position, and by the time you are ready
to advance to the next position, you'd better have done the checking.

> You really need an interface more like "make sure there are N bytes for
> me to read at offset X". Then you can read and advance past them.
>
> For individual items where you want to copy the bytes out anyway (like a
> be32) you can have a nice interface like:
>
>   if (read_be32(bitmap_git, &commit_idx_pos) < 0 ||
>       read_u8(bitmap_git, &xor_offset) < 0 ||
>       read_u8(bitmap_git, &flags) < 0)
> 	return error("truncated bitmap entry");

Yeah, that kind of flow reads really well.

> But given that there is only one spot that calls these, that kind of
> refactoring might not be worth it (right now it just uses the magic
> number "6" right before grabbing the data).

Yeah, it seems most of the callers with SEEK_SET are "I find the
next offset from a table and jump there in preparation for doing
something".  I suspect callers with SEEK_CUR would fit in the
read_X() pattern better?  From that angle, it smells that the two
kinds of seek functions may want to be split into two different
helpers.

Thanks.


