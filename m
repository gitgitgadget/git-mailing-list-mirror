Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1FDC20193
	for <e@80x24.org>; Sat, 13 Aug 2016 06:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752433AbcHMGfF (ORCPT <rfc822;e@80x24.org>);
	Sat, 13 Aug 2016 02:35:05 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:34718 "EHLO
	mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751894AbcHMGfF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Aug 2016 02:35:05 -0400
Received: by mail-yb0-f194.google.com with SMTP id e141so174580ybf.1
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 23:33:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=DmDYPqWXILVrjAiwAIjX3EAkgMzJ3M2COkBUuFlZRuA=;
        b=I9GO8VwDMbiGLX5H1dXkScgiUF1v8EVXJQRuVSsKbmB3GsL/bnDPYm19PGN6jeN2DL
         xmAuogRcw5EHoD0Zb2OZkj6d4okISccQRCVLovJAJooKAiY8uyW5LORHpFekgyGjjDOi
         p6+HMSmtLQu4o11qCzD2zFsZ4TPCoAjB/3TGWvE8h6a1OlILDhmC1OllGBUoEfvmFgNW
         ld6Y+Ywfry3vawhSB0BqwymeL4VhN2F1gND386UU7buEux34uBRqvT97hdzOLlbNINXa
         lcWAaOg6TA1Fnp6XEi7/63ZeGeD2KJ/tl0XjWolhbVzpQDadBo9pQil74IB+47UNwNc0
         62fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=DmDYPqWXILVrjAiwAIjX3EAkgMzJ3M2COkBUuFlZRuA=;
        b=MMAxuzFnsi1IJPA/KlAbCpEEgGog4y9466FHXNOv4acCyIgKmi0hA2F1kT6wQwwdwo
         5vFtPVGI7yApvMjLZ5g3r2aC/3ReIlWCWqIMv6rI+oawv+5Fi8k40rx56aOSn6/9zuqN
         aj0mm5fthPEG2Km47Xbdz54jTPsjo1wdqfBfG0DJzlB2Yw+XrH2dcAAC76rFhTZp8pPg
         egxAzQt5HQcS+4CVyXNS+EA4ASYzJjtznW/2b1jugn3N+v9Lp/efoqjhuZ3CTqbukzHx
         OAHdf6Lal8AAok6VsIBBdo9C7Y36phn6jLLTUB2pExWwCvkynr2jKgINzdlp8BQiDRY4
         q4Jw==
X-Gm-Message-State: AEkoouvRKnwMMQeuLWHff+2H7LIVdC7Sw8Q4BT9NQbZyjPDYndh3eQMPmksBdRARzmU8e/LuP75Wj0OR7BWWlg==
X-Received: by 10.37.216.23 with SMTP id p23mr12743974ybg.53.1471070015926;
 Fri, 12 Aug 2016 23:33:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Fri, 12 Aug 2016 23:33:35 -0700 (PDT)
In-Reply-To: <xmqqh9apx00v.fsf@gitster.mtv.corp.google.com>
References: <010201567675adc1-17e27495-6b36-40d1-836d-814da029fcc4-000000@eu-west-1.amazonses.com>
 <010201567675ae72-0e0eeb11-e488-4562-8837-2443cbfe0792-000000@eu-west-1.amazonses.com>
 <xmqqh9apx00v.fsf@gitster.mtv.corp.google.com>
From:	Pranit Bauva <pranit.bauva@gmail.com>
Date:	Sat, 13 Aug 2016 12:03:35 +0530
Message-ID: <CAFZEwPMoAi9aPYOrE8bk23yB=bC2rjCM8fAXwBFBTvOtbE+uAg@mail.gmail.com>
Subject: Re: [PATCH v12 13/13] bisect--helper: `bisect_start` shell function
 partially in C
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hey Junio,

On Sat, Aug 13, 2016 at 12:55 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Pranit Bauva <pranit.bauva@gmail.com> writes:
>
>> + ...
>> +     /*
>> +      * Write new start state
>> +      */
>> +     if (write_file(git_path_bisect_start(), "%s\n", start_head.buf)) {
>
> I think this function has changed its signature recently.  I am
> planning to tag 2.10-rc0 this weekend, and it may be a good time to
> rebase the series on to an updated codebase.
>
> Thanks.

Yes sure will do that and send an updated version.

Regards,
Pranit Bauva
