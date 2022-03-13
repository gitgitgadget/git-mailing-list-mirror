Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79335C433F5
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiCMPeC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCMPeA (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 11:34:00 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05CE82715
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 08:32:47 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id n16so8154511ile.11
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=d/RqeWmQfXs+NG90l4y0BqCvPsso/9RkuEsA8dFxT30=;
        b=Gy7EZ6X606QeMrN6pj54enHVoPF9xK5L/0D+19Oey833ug+TzNPEPGEivCdTfz/wxM
         PBfC0I3bwr1mGhc4iAHLll9TqofuaxaUXSgi0QJy00qU6srzRTtRV18E3l1HZcZh+76l
         hLyZ/6Fcl/Gil/7VgnWDrlCVTZWcgy+fG5gFilEQCQMftNruQeoovMMe7wkXOPyCvJbM
         Jejdu2F3sj08l1nwrK/JDdn93ohHDxdNgPMVtJoMpA+aHLr4tgaHzjxfbOFxY0DxfvoS
         LQSZE9kLbqWvxyO5LgQi5/RPV/f0/SRydKGPPTaw4/pT9buIWvpoJf0ZACQA8DhQmu18
         dC5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=d/RqeWmQfXs+NG90l4y0BqCvPsso/9RkuEsA8dFxT30=;
        b=WEir5V6aH2JsXtGhGlm14VH7/B3FY9dBsmutKb01WXvEE67ql1jAuTIQ1agVrKskRi
         24tRz13VpneAfEOAZKeq8uXUR7wuoJgNStfYvx9owmPnH4/p3cNq8m3JO+pmvWAV48Mv
         qBSMvyphn1W5YlyJTZdWBSLdHhJBryWil3Z1JdRfpL4MndYYrSKwfYYfnl8KAf0g6l0J
         JLT/i+BKT3LKL1+Y8YWaL5aB0Pw83Z+GwTxGcSLMKSU6TRP8spK0Be2Ag1QP+7wfugXs
         FgFKkOxFviPeUKjM36t1A6c7/yirxsN9gEVBBCGKskt8f7JExbx4qicEZ4KmvQ1DUJzU
         Ctfg==
X-Gm-Message-State: AOAM531qi172m/M+Hipies93oIfT7soswQIWqAFDaQIuQ4a346lBKRyr
        o4GJy7MOAHYQjyL+iVequD0=
X-Google-Smtp-Source: ABdhPJwIAqCDUEr7UqhdWA3tNtt6ogBP7yuxzXuAa0DJ0VU8aZekCXARcdHqkMODP/z4opGa5AUzWA==
X-Received: by 2002:a05:6e02:128b:b0:2c6:49a4:ad23 with SMTP id y11-20020a056e02128b00b002c649a4ad23mr15059375ilq.251.1647185567242;
        Sun, 13 Mar 2022 08:32:47 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id k4-20020a5e9304000000b00640dfe71dc8sm6921393iom.46.2022.03.13.08.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 08:32:46 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com> <xmqq4k42n2g8.fsf@gitster.g>
 <01cc01d83671$0acd4a20$2067de60$@nexbridge.com> <87zglu9c82.fsf@gmail.com>
 <01f201d836e5$89247c30$9b6d7490$@nexbridge.com> <87v8whap0b.fsf@gmail.com>
 <01f301d836eb$5c7a6810$156f3830$@nexbridge.com>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org,
        sallred@epic.com, grmason@epic.com, sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 10:21:04 -0500
In-reply-to: <01f301d836eb$5c7a6810$156f3830$@nexbridge.com>
Message-ID: <87r175amw2.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


<rsbecker@nexbridge.com> writes:
> I have another reluctant suggestion, but it depends on your industry,
> regulations, and other factors. In some sectors, there is a
> requirement to keep only some period of time worth of history. In
> fact, in some settings, keeping user identifying information beyond,
> say 7 years, actually is problematic. Pruning your history may be not
> only an option but required. An alternative is to use filter-branch to
> essentially tokenize the identities of past authors and keep those in
> a electronic vault somewhere. I have customers who are interpreting
> GDPR-like rules just such as situation, where employees gone 7 years
> ago and cannot be retained, by name, in the repos. I am not personally
> happy about that, because my own repo-OCD demands that I know exactly
> who did what until the end of time, but according to them, it actually
> violates the local regulations. I'm sure you have had conversations
> with lawyers, yes? =E2=98=B9

I don't believe we've involved our legal team here (I'll follow up with
them internally), but that might be a spin-off discussion for folks who
know they're affected.  It would seem that the design of Git makes
purging history on an ongoing basis problematic -- you would always have
at least one unresolvable reference to a parent commit.  If this is a
real requirement from GDPR-like laws, either 'reasonable' VCS metadata
needs to be a specific carve-out in those laws -- but who the heck knows
what is 'reasonable' -- or as a project, Git needs to have an answer to
this situation and an ability to truncate history without otherwise
altering it.

It's also worth noting that even in the last five years, at our scale,
we've definitely run into the email-recycling problem already.

Being based in the U.S. and not having seen pitchforks about this yet,
I'd like to assume for the purpose of this discussion that we're keeping
all our history.

I think if the topic of legal implications of keeping history in
perpetuity is valuable to continue, we should spin it off into a
separate thread.  Personally I'm not seeing what we (Git) could
realistically do about it other than provide recommendations and paths
forward -- which might require considerable development.

--
Sean Allred
