Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28D3E20281
	for <e@80x24.org>; Tue, 23 May 2017 22:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936261AbdEWWff (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 May 2017 18:35:35 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35959 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933846AbdEWWfe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 May 2017 18:35:34 -0400
Received: by mail-pf0-f196.google.com with SMTP id n23so30287112pfb.3
        for <git@vger.kernel.org>; Tue, 23 May 2017 15:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V/t5JsnQGAqCJ8Ep0CTYZQX2+DXO/6GBY648O4Sv9DQ=;
        b=RV+hcTbgZ0E0jz7EAuOwJYfJy90xReQ+7uEOZOiNcXlwSMLnLoje4C1YrrYWhE//JP
         EK2rh8mpUhbxJNhfzxRcQDnfEdc7nAkUb4V6sO/ZkDpmZc01CtE0965+i+fJoduWEPFW
         QF1VklvwPhWtj5k+KX0MOSOreyrwZY+uVFuIYgYcwBrqGLtEgAdE9LWIzIREeZdnV3s7
         GqRUFPImaSCgi74kKfOdL2AH3evIHzJhNpluRfP41sbbceDI00QhP1eNHoz6SV3BMs8P
         d0QurogvnE4mQQXpLjU3uTpGCpCb9z5WhzvVgX/Qkz68SI2ZCaTKJOjnCIdBYfDUKlYQ
         w8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V/t5JsnQGAqCJ8Ep0CTYZQX2+DXO/6GBY648O4Sv9DQ=;
        b=K31GR/zn/xcIR9HqA+a4+dD5blHmS25NE6Q2SF0Rqusm5Cs4q1ZhK14cTdsfwAl9vf
         PT+Mao9vKK2n5fSoiLxSn5ClzvuoSBBU3VftDyHOSTY3gsgidoCsvojuGsFZcRqLMxuk
         FNGJtFjO4TjM/A8ilhJXU2Bm/wc5BsDZN8/OHIGBh2kFyJ2qLFNoODu/OwizR5OiKAya
         hKjppy5qu7YgyxRM5LDsqIYCZ4caBGIczpazsLCmnno8Q5AqqOzlZq0HHKCfj4k0ImTT
         fV99gTbE7T8IXi5AKHX+FDdxqEqo/gQB3/HpOUk+PZ7ceA1v/gokon5GqkDpEoIdfS2H
         deXA==
X-Gm-Message-State: AODbwcAw0AnmC7BALyqFjh/SgeLy2tii3ixheIfN081HCYrYBf3v0xrA
        Hza51SMidHHvBNt2ivYwdw==
X-Received: by 10.84.130.7 with SMTP id 7mr38651841plc.35.1495578934234;
        Tue, 23 May 2017 15:35:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b9c2:d2d1:97c0:9dab])
        by smtp.gmail.com with ESMTPSA id k79sm3801405pfj.6.2017.05.23.15.35.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 23 May 2017 15:35:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v6 6/6] clean: teach clean -d to preserve ignored paths
References: <20170523100937.8752-1-sxlijin@gmail.com>
        <20170523091829.1746-1-sxlijin@gmail.com>
        <20170523100937.8752-7-sxlijin@gmail.com>
Date:   Wed, 24 May 2017 07:35:31 +0900
In-Reply-To: <20170523100937.8752-7-sxlijin@gmail.com> (Samuel Lijin's message
        of "Tue, 23 May 2017 06:09:37 -0400")
Message-ID: <xmqqefvfjj64.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> There is an implicit assumption that a directory containing only
> untracked and ignored paths should itself be considered untracked. This
> makes sense in use cases where we're asking if a directory should be
> added to the git database, but not when we're asking if a directory can
> be safely removed from the working tree; as a result, clean -d would
> assume that an "untracked" directory containing ignored paths could be
> deleted, even though doing so would also remove the ignored paths.
>
> To get around this, we teach clean -d to collect ignored paths and skip
> an untracked directory if it contained an ignored path, instead just
> removing the untracked contents thereof. To achieve this, cmd_clean()
> has to collect all untracked contents of untracked directories, in
> addition to all ignored paths, to determine which untracked dirs must be
> skipped (because they contain ignored paths) and which ones should *not*
> be skipped.
>
> For this purpose, correct_untracked_entries() is introduced to prune a
> given dir_struct of untracked entries containing ignored paths and those
> untracked entries encompassed by the untracked entries which are not
> pruned away.
>
> A memory leak is also fixed in cmd_clean().
>
> This also fixes the known breakage in t7300, since clean -d now skips
> untracked directories containing ignored paths.

Nicely explained.  Will replace the previous 6/6 and my squash on
top that were queued on 'pu'.

Thanks.
