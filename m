Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F57820281
	for <e@80x24.org>; Thu, 28 Sep 2017 06:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbdI1Goq (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Sep 2017 02:44:46 -0400
Received: from mail-ua0-f193.google.com ([209.85.217.193]:38567 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbdI1Goq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2017 02:44:46 -0400
Received: by mail-ua0-f193.google.com with SMTP id l40so175198uah.5
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 23:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanocritical.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8WQHPbeO5kZdrvOi63eDDyLUOY6qw4yg9AlnFkJeX0g=;
        b=SZEpsUYNI745vZj6rYmZo8gZVpdOPI/TviGjdmKIlsvwxMC6nLRie946lrtxd9FPoV
         g338m66IZYhQXw+scgAJpW77U4YJP8+0JaiDjNTBpfMGsE4WvEUIHvC2UipSdJadp5Fi
         hJLZiZkn8FXarq49/Se+NC9R5Xqa/21AtcsRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8WQHPbeO5kZdrvOi63eDDyLUOY6qw4yg9AlnFkJeX0g=;
        b=A+UhX71YB72Fqx0BNqC+nJv7rhOomfttP2o7kGgR0kYpZyR6mVQGDKIdSR2AOGy14U
         xrvFCTeoP2SVUf9UxIZIwguhdsT88lHXY92QRNkbuyUlzjJ+VPl+WYtt50yGqhFgkV2j
         xnU3RQMc4BmzvWXFbw7aP8mBFsm8pDWZ1c/oDGeVfCUlPp6wI0q6xWsiZT4eEtR/NZz/
         gHB/WFaHTQHZ/mpq8mAhKLnRg4luSGrXZsQ5lvE7dbHOCbRjuz9dxPgHrUOLsXN6ZwDu
         Yeh4enYn02Zs8xI1SDJ9TquvCA3j7LVdWUHpBQh/uxM15X39slwYzpqICQeQM7zw2K/C
         KliA==
X-Gm-Message-State: AHPjjUjMkt3jrYzFafykdB11Y1HUqXm1D3tM05n41j7IpZS7Np1h9yAa
        QXx03913KNhw46YxgUiH4ZgH/LKNNGoWyG3qxqN4fw==
X-Google-Smtp-Source: AOwi7QBzcVkOUIaGVyPLZfelWFwJaTNosJliKA20TnQkLoZrEBxi2zSAg1tKw8dhfE3MpDA/r98Ot2u357od4mGPQVg=
X-Received: by 10.176.81.46 with SMTP id e43mr2525359uaa.157.1506581085149;
 Wed, 27 Sep 2017 23:44:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.146.1 with HTTP; Wed, 27 Sep 2017 23:44:24 -0700 (PDT)
In-Reply-To: <xmqqvak31hts.fsf@gitster.mtv.corp.google.com>
References: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com> <cccb06b75df3cad9f013d5a9ab0371f0a2d9c2ce.1506541322.git.e@nanocritical.com>
 <xmqqh8vn32mn.fsf@gitster.mtv.corp.google.com> <CAH_=xoZfuJDE515zZbry1DdGV+YeySy+5T9QOBefO-MMTSvXSA@mail.gmail.com>
 <xmqqvak31hts.fsf@gitster.mtv.corp.google.com>
From:   Eric Rannaud <e@nanocritical.com>
Date:   Wed, 27 Sep 2017 23:44:24 -0700
Message-ID: <CAH_=xoaQKf2NUaFdqnMPejbj4e_cXQ9CkVVRJYtwGEBFPqca3Q@mail.gmail.com>
Subject: Re: [PATCH] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeremy SERROR <jeremy.serror@gmail.com>,
        "Shawn O . Pearce" <spearce@spearce.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 27, 2017 at 11:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eric Rannaud <e@nanocritical.com> writes:
>
>> Doesn't fast-import get a copy of 8 (open for both reading and
>> writing), as a child process, and exec 8>&- only closes the copy of
>> the file descriptor in the parent shell, so the named pipe remains
>> open for writing somewhere (in the fast-import process itself, in
>> fact), therefore fast-import will not find EOF on its stdin?
>
> AHHHHhhhh.  If that was done intentionally, well, I really have to
> marvel at the cleverness of the solution!  It makes sense now to me.

I plead the Fifth.
