Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8591FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbcLSXOw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:14:52 -0500
Received: from mail-qt0-f174.google.com ([209.85.216.174]:35361 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752849AbcLSXOv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:14:51 -0500
Received: by mail-qt0-f174.google.com with SMTP id c47so161825014qtc.2
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KGJkGhQrkU8aT1qpgivuQJRwvIdRua6olRmABtTglWI=;
        b=t5woNyU7avaJHk/jL7X2snkOhRNMHuFfiie/BJGLlQ2q/frDGVi/8BD2RqF55aMErC
         MtxUCzhdEwMSbpBgwcrp4oMx9Wvigo0W4a7ThWisV9u+FJb+b992QrxxSV/YWLATKDIE
         Mf9jYLBraZT+ZSZDFNWDu0VEiSKXmpQD8cFD98idY/U2nDlnksyR4jMDOiE8Cz0vMGU4
         OtSKJ/u/G7URd3JjwezgCY9DTl8K1rfVqLPcSRyltUOkwvn1s4O1EtxwwUs8lftnaCD3
         fYBx/cNWwIAwhjoJLDXoyUtxsydfOcfKgwwcxoXoL6EYQ/W62VkS0Jvh2MEQeG2RqQj5
         v3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KGJkGhQrkU8aT1qpgivuQJRwvIdRua6olRmABtTglWI=;
        b=SCRWfdQlrujRvDu97EAd7xL/h33RgdgAzAgY97zx0qpJGXf2+JMd1uwE6awhj2HZ5t
         nSX4QwfRPTeNuSmXnRFbCP7R2Wq62OBr+LC57UVR9DcEPwK8lZkh7GmDWKEqDXPvYtpo
         g/TFSd7ydnMqoVNcM0C4smJs5zrtYR/1OpNhzTnILRRVvwWxLrNAx5SS2cgTF17wn7Cg
         4qOu38UPw6PYafw0sKG43O230Dh2MnAKAgc17tWoqVhzjNNTFTgcrsIbbRGb/z1jCBi1
         PaY+OFyxX0GkCbWUZy3Ot/EZ04wIUKek0yKW3fMO/pBUGXffbh6zSI2V808Sf75TwNC2
         c68A==
X-Gm-Message-State: AIkVDXKZmZ5L+MKsCyaVWdFO+pxRtaXS4P12pc1dG5qk9454tvMM/V4E4agAUgDEAGdRAg4zF6coHmFhAM/vOhh8
X-Received: by 10.200.49.235 with SMTP id i40mr19555122qte.170.1482189290164;
 Mon, 19 Dec 2016 15:14:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.147.188 with HTTP; Mon, 19 Dec 2016 15:14:49 -0800 (PST)
In-Reply-To: <xmqqfuljmswl.fsf@gitster.mtv.corp.google.com>
References: <20161219215709.24620-1-sbeller@google.com> <xmqqfuljmswl.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 19 Dec 2016 15:14:49 -0800
Message-ID: <CAGZ79kZA1HxsdCAQxKiNMQrH9fLrhGKc8Um7x-R7u92ujVBigQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] improve relocate_git_dir to fail into a sane state.
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 2:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This goes on top of sb/submodule-embed-gitdir.
>> When the absorbing of a git dir fails, try to recover into a sane state,
>> i.e. try to undo the move of the git dir.
>
> Are these unconditionally good improvements?  I ask because the
> series is still not in 'next' and it is the last chance to fold
> these into existing patches if we wanted to.
>

Actually I forgot to mark these as RFC-ish as it is a response to
https://public-inbox.org/git/20161219053507.GA2335@duynguyen.vn.dektech.internal/
(which was the only review comment this round)

So I'd say these patches are rather experimental in my mind
unlike the absorb series, which I assume is ok as is already.

Thanks,
Stefan
