Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA8EC433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 19:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352783AbhLAUA2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 15:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352706AbhLAUAS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 15:00:18 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB90C06174A
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 11:56:56 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id v19so18533434plo.7
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 11:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iJHla7XA6n48Jr7oVOx6sAMPmhD+uJGrxHuCTebsW04=;
        b=FM9LDQol4zkqMLBSrxiX2LVbkLQhvbi1DsOIzJ8xm+8R4b9u4MB94E+WHaNflPgXr0
         aEyarb4CGb4s8CjaFATmHAgVmKyFh15hq/U9p1nWVctfrJhRv/WIYM8DL13O4zNy37Nn
         VxG1Ucd9vQ/YyxEFRbK210tI80SRGl5xPRDJAxtuuPV2yr07heXK3u2q5NK9fAcQAUZe
         1jJhltL/ZwXkO335hMr18q+xbLWoQRHpH6Ikb3L2l36+p/cEeVBSNljUP4or7F+Qxpgy
         cK6vZwKOrUQeqwzesycEm/FQZKIDV1Rv/FIJ4MKIxAPzmXz/zU5g8BWLwmhw4bwVcsuD
         nDvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=iJHla7XA6n48Jr7oVOx6sAMPmhD+uJGrxHuCTebsW04=;
        b=lJOkbcZS8gisIi5GpQoHoFJvaBfyaC5XZ0aaXpmMQW4jhHwlhrwCjEVfaak5i7eRMk
         apqI0F3T1Xe7j9UhMmJ7ZYZdyjhC70iQbjnc/PIC3efqLsseh76u3yuQf0QuuK2OWS4Q
         XtIW2XuqBgtwsQl99e7claQlMc6SL+SCSS3ajAqPPNASECdu35EdHZbZpyLIr6D+yMgq
         3rH/qMR9/wTiz9oqXepcdlaKrPqT/Fb3j7jPr0KpgtVn8xNREQOB9LOLU7wlBJ5tpsqL
         pQS5NSj/mDGiwXd2YAOdhtKchNFVDVRMVA5Lr6UCnvYZbWY/Of1IbSK0Fn+g8c3YoS7k
         1pLg==
X-Gm-Message-State: AOAM5333D2DdzoRMrndD1qAmOiF2km49nKPSz1MRzqPFfbLA/Vo9Zy7S
        F57YwMmG7ZTy3SVSEC+4CMqaKA==
X-Google-Smtp-Source: ABdhPJwb4QzByg4UVIB7ONB8sZWiiwT9j/K7fcWcyJHAHo6VCLik/0iN7F3XcAJBYqCHizA1JaYXpA==
X-Received: by 2002:a17:902:d88b:b0:142:8acf:615b with SMTP id b11-20020a170902d88b00b001428acf615bmr9940371plz.62.1638388615607;
        Wed, 01 Dec 2021 11:56:55 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:9644:87fb:4e19:db06])
        by smtp.gmail.com with ESMTPSA id q17sm721080pfu.117.2021.12.01.11.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 11:56:54 -0800 (PST)
Date:   Wed, 1 Dec 2021 11:56:50 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH] trace2: increment event format version
Message-ID: <YafTgiNl53FeWH+Q@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        Emily Shaffer <emilyshaffer@google.com>
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
 <xmqqh7cijnwx.fsf@gitster.g>
 <YY2h5lO90vo3Dy42@google.com>
 <xmqqczn6jlvu.fsf@gitster.g>
 <211112.867ddduhly.gmgdl@evledraar.gmail.com>
 <9ce9c989-5a8c-1d5c-cc7e-9447760ed110@jeffhostetler.com>
 <211201.86zgpk9u3t.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211201.86zgpk9u3t.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.12.01 16:57, Ævar Arnfjörð Bjarmason wrote:
> [...]
>
> IOW I think this would make more sense as a version bumping criteria:
> 
>     The version should be incremented whenever an existing consumer of
>     trace2 data might want to act differently based on the new data.
> 
>     An exception to this is that any new event types do not merit
>     bumping the version number. E.g. we have a top-level event type
>     "error" now, but might hypothetically add a new "warning" type.
>     Such an addition won't require bumping the version.
> 
>     Likewise adding new mandatory fields to existing events doesn't
>     require bumping the version. E.g. the "error" type has (as of
>     writing) a "fmt" and "msg" field. Let's say a future version adds an
>     "id" (as in unique id for the error) field, such an addition won't
>     require bumping the version.
> 
>     In other words, consumers of the trace2 JSON format are expected to
>     walk the structure and only pick those things that they know about.
>     Any unknown fields the consumer doesn't know about can be safely
>     discarded. This won't apply if the version is bumped, then all bets
>     are off, and the meaning of existing fields may or may not have
>     changed.
> 
>     The idea is to encourage additive changes over changes to existing
>     fields, and to reduce the work in maintaining the consumers of the
>     format.
> 
>     As long as consumers ignore new unknown data they won't need to
>     be updated every time the format changes in any way, only for
>     potentially backwards-incompatible changes.
> 
> Wouldn't this be a saner policy for version bumping? AFAICT the only
> thing you wouldn't be getting that you're getting now is the trivial
> optimization of being able to say cheaply route trace2 payloads based on
> version number alone (but even that is iffy now due to the subjectivity
> of "significant change").

No objections from me, this sounds like a good improvement.
