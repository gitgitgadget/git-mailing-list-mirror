Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C2A20A1E
	for <e@80x24.org>; Wed, 12 Dec 2018 07:37:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeLLHg7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Dec 2018 02:36:59 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43200 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbeLLHg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Dec 2018 02:36:59 -0500
Received: by mail-wr1-f68.google.com with SMTP id r10so16561736wrs.10
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 23:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1eF4JJyhGBD4/wdeyTg+3Dc8gLGiqS4I4vovxTxYf7M=;
        b=jsXJCGAY+6o9VZcUzS/9fQh21kF9ci3Ig+A46Nst3sD3+DiyOn2EX6jnvj5JcPItzz
         Is4fa4aHQqZyKMTqWKonr8aOd6CmwnYqYDNRaMZv4bL3mIn2WYI6zMMR5cObIA6xzlg5
         LM6e1oJVyq8xScdwJx29O957UJGKkwlPitobzm4W6ubbrKkxcZ1Jw+huIP4MqVZL9i3l
         w2itYy04bPx6ktR9J9lAJxLvpzMB999x8E/93krC9TQx+4WlM2TKdpNgYNXCJNVRFEcC
         T6N1lDmGtLUL0r7ebR4rC4UCuRtW52AOR2/AmiuvR5LjAEzUTmP/jO9sRP83xgbZ32OZ
         y0wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1eF4JJyhGBD4/wdeyTg+3Dc8gLGiqS4I4vovxTxYf7M=;
        b=mFDIbN/z9c94VnW++y1Fh6CRLikcRjFvJs2vZFkTYJ6/ajf9hsCaDcFdMmRERUZQVK
         LW+nf/vJyDVjdq2sHTwIcQUdwy2f718q68EzJ2X+mqSNAyeZSRdt8La/MC7ViZjaEbEy
         igiDso+Zii87YJG3UfxyO0tyMUSStNZ7xn1jTMlRCo0l4ut11suv2OGkSZQQkaiw3laC
         1e4TxD5lqFScdu1xR4RWGxfGYqrHqwHpcFdv8hVCPpCMrcYSY9loWutRpqYm5Ax7Gnj6
         CpOLf8Q45peXc5QStzIX8VJiqwqzjyxTOjAAZFjV/wqMwgqJmhN9nJFNpIXGmwjpXpbe
         NPfA==
X-Gm-Message-State: AA+aEWbR2vcJUBwl8b1JuaCMjzyxqSdQdzbSkv+EUAMp/kjMdWyGPDBJ
        y8YPsNJEJz80fraGFYRRj4s=
X-Google-Smtp-Source: AFSGD/UE7dKEcgxomEbrxHl7/Rvs3cxF9CvbBE6SbRcvFsYt7a9SLUMKcI0byH7Fs5fpKePzjZFnrw==
X-Received: by 2002:adf:dbcb:: with SMTP id e11mr17210837wrj.58.1544600217165;
        Tue, 11 Dec 2018 23:36:57 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id h16sm44956876wrb.62.2018.12.11.23.36.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 23:36:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/8] entry: support CE_WT_REMOVE flag in checkout_entry
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-4-t.gummerer@gmail.com>
        <CACsJy8DQd_DcuogF2Wnj47F6ef26L1dea7M2Yi-ESZ_naQZ=kw@mail.gmail.com>
        <xmqqbm5sn6f6.fsf@gitster-ct.c.googlers.com>
        <CACsJy8C6VuH=hr9JE+AXeqU5V9RwouzZSb5+jV++GHU3myoDTA@mail.gmail.com>
Date:   Wed, 12 Dec 2018 16:36:55 +0900
In-Reply-To: <CACsJy8C6VuH=hr9JE+AXeqU5V9RwouzZSb5+jV++GHU3myoDTA@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 12 Dec 2018 07:16:02 +0100")
Message-ID: <xmqqftv3jiw8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Although we could make it clear by saying "5 paths updated, 2 deleted"
> (but that may make us say "3 paths added" as well, hmm). Or maybe just
> "%d paths updated" where updates include file creation and deletion.

Yeah, the last one is the simplest and good.
