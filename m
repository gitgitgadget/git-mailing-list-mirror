Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F3772031F
	for <e@80x24.org>; Tue, 28 Feb 2017 21:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdB1V7f (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:59:35 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35585 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751460AbdB1V7e (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 16:59:34 -0500
Received: by mail-pg0-f44.google.com with SMTP id b129so10987967pgc.2
        for <git@vger.kernel.org>; Tue, 28 Feb 2017 13:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=TOcFiQvAwfOpgFlMtOEy9l9puVWEM5ctZ6ZzctPZH6I=;
        b=UxH2qdE8SWrhawinsLQS8l1gGo7IyPOC5UJQn/PEt4OOuqe6QLYvf9PZ5FOYpj89Il
         8V0heqINUFpS5bl+tDHdvCztXOnNX47XIDAGGE4N2F4KL0G51k9038oUap2cdKXc327z
         nrtfBuJGWRN2JBJp4Nl+wTPNjYBWPHr1pKiJ1mWE0uB4uw0Dcoq5COqDdkkmfy4kVePv
         a7EclhxNrEufZFPms58ZY4bFt0kkVjdcNSOFd73j4+ZxWVPqSXvKg2exQKpHE9FQ90y3
         noxh+BDUr8A0137JIaFNYRSAlJ1HZHRp9zX1yq0gcVTYqzo/Cz0hLKgF5UEpD7gzfXcH
         ZhrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=TOcFiQvAwfOpgFlMtOEy9l9puVWEM5ctZ6ZzctPZH6I=;
        b=iCYK3a1JYJUPORf044on9Xu9XM4qbufamYSlAueAFCII/inabNWUTviCGyyhYGOC7U
         uY+sRM5ZyXUD+9KSXK1zTvFak87IvC2BoqRPeWXSPH8qP87RtMfAJi7p9xgrVFVeOeGg
         9a/82M0AmjKJ1ZSUy7pLBhOgl+qrWBsHc/odqbe0RhC6KTb2bN8e8h3zaMEgXVMGWNJV
         ozh2eukiUV7GeqEs7lz+WP0HpCRm4RNzooqsecPHR18PKETbP2ZZ7aChwgWnhUarXBxV
         suniyiYWb3lw5TxQK2BbdbMfFL0rIfr3WbHNo3NmKEn2cD6P14/7yTnrcHZJgFq8bb1E
         Kt3A==
X-Gm-Message-State: AMke39kcMezZl1Me7Q0Me7ItkLSSHKTSjgML/qbgHjYXj+illiqVvl2eiF+JXIVd2wD2qQ==
X-Received: by 10.84.208.227 with SMTP id c32mr5663444plj.71.1488318614604;
        Tue, 28 Feb 2017 13:50:14 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:e0d7:55f8:67f2:62dd])
        by smtp.gmail.com with ESMTPSA id w131sm4858896pfd.34.2017.02.28.13.50.13
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 28 Feb 2017 13:50:13 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     git@vger.kernel.org, Mike Crowe <mac@mcrowe.com>
Subject: Re: git diff --quiet exits with 1 on clean tree with CRLF conversions
References: <20170217212633.GA24937@mcrowe.com>
        <xmqqr32wqxr6.fsf@gitster.mtv.corp.google.com>
        <20170217221958.GA12163@mcrowe.com> <20170220153322.GA8352@mcrowe.com>
        <xmqqlgt0imhe.fsf@gitster.mtv.corp.google.com>
        <20170225153230.GA30565@mcrowe.com>
        <xmqqefyjwfql.fsf@gitster.mtv.corp.google.com>
        <d98aa589-3e08-249d-0c88-72dbcee1a568@web.de>
Date:   Tue, 28 Feb 2017 13:50:13 -0800
In-Reply-To: <d98aa589-3e08-249d-0c88-72dbcee1a568@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 28 Feb 2017 19:06:44
 +0100")
Message-ID: <xmqqshmyhtnu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> On 2017-02-27 21:17, Junio C Hamano wrote:
>
>> Torsten, you've been quite active in fixing various glitches around
>> the EOL conversion in the latter half of last year.  Have any
>> thoughts to share on this topic?
>> 
>> Thanks.
>
> Sorry for the delay, being too busy with other things.
> I followed the discussion, but didn't have good things to contribute.
> I am not an expert in diff.c, but there seems to be a bug, thanks everybody
> for digging.
>
> Back to business:
>
> My understanding is that git diff --quiet should be quiet, when
> git add will not do anything.

Yes, I think that is a sensible criterion.  What I was interested to
hear from you the most was to double check if Mike's expectation is
reasonable.  Earlier we had a lengthy discussion on what to do when
convert-to-git and convert-to-working-tree conversions do not round
trip, and I was wondering if this was one of those cases.

