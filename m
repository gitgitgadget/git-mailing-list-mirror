Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1A881F954
	for <e@80x24.org>; Thu, 23 Aug 2018 15:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbeHWS6i (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 14:58:38 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:36569 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbeHWS6i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 14:58:38 -0400
Received: by mail-wm0-f43.google.com with SMTP id j192-v6so5978759wmj.1
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=YXyH9Qg2cBiiqdBhMYfc2Sivxh7HYtTNYVCFUsHoRP4=;
        b=uD3EQ+BntOzIk20q1k/ZHW7H94vtXuNjOIDizChiuKgSLH4KDzRks+M4n7hywVXb9M
         Ah8BVsKnCnoYBgRAsYGkxHLQUvh5SzulCdV3N8vBD2UPB2xRF2bnsiVQfpG+0rzCpng8
         OUQjNzEvUYOYXZ43A6VQwsN1rzaczKXTLLNuAQ1eQ69TnZG04j5nfLidkqFSiNYs0+Xf
         KBgOMa4rL+tcxpY6ZTeseOv+jGOE/yhwSN/Po7YakPB4NjXk/zhWJXEkljdjkrXidUcA
         ms5CaEUHsHZsUYFFYxUaT+M4faME2Z9K/UFos7YNHCaLh3AD9QNO3aUJGoTPmr8aAZtE
         i/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=YXyH9Qg2cBiiqdBhMYfc2Sivxh7HYtTNYVCFUsHoRP4=;
        b=KUUXLWw4CCIGZwixjoUrXOo7txQU+ZF7048YkAxZvbnTcoSC3SMw4pps5SoVWVLKd0
         q1EGMLmiolxzz3k95bSbuidu+oXso4a3FN75147mQWgj7ERxSAiV5FrC1/0H/Z/uYeCR
         u28Jhwj3IwjqXABGgLyeZK8EVuOzKrbyQrL8xghnyAaan2IbY5aF9GPi5iZYsd/KbyqD
         jRnl0Jst8gMfaQBRyV9EZqzbNoiNWqaaSj3so9OwGJ0ribj+xFl8EzylpKtZPpo6BvPc
         PDGEqEePusfp8g+HrpK1HPcC4B1H52ZRujE4mvCAHk/FY9ZJu62q5m8XalLK5nKzaHIj
         wHYA==
X-Gm-Message-State: APzg51CBLxTR3aNBHj6EZXF/9VsYOuAJueWSJCxI05H9//qQSXCnSK7f
        YIM8OkUdpNQlpV8HFf4epe8=
X-Google-Smtp-Source: ANB0VdYIDQA0cTS0rUy+yKrGoUeaUGB14iiu+9uD/1vECi4B1ARBBPTEgZOGgxlgvEgAaSgvL5GpjA==
X-Received: by 2002:a1c:1203:: with SMTP id 3-v6mr5914159wms.46.1535038107092;
        Thu, 23 Aug 2018 08:28:27 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d22-v6sm3209106wra.80.2018.08.23.08.28.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 08:28:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] commit: new option to abort -a something is already staged
References: <20180820154120.19297-1-pclouds@gmail.com>
        <20180820193007.GB31020@aiede.svl.corp.google.com>
        <CACsJy8DsEhV6p=cE6FC6Ka4=E0c-8JG0LRU_DEq-Ser5PqMcGw@mail.gmail.com>
        <20180823021156.GD92374@aiede.svl.corp.google.com>
        <20180823021547.GE92374@aiede.svl.corp.google.com>
        <CACsJy8DdZLxdA4XSVVBSpeZaF+q6=81LxecYea2JtJ6-Krnk-A@mail.gmail.com>
Date:   Thu, 23 Aug 2018 08:28:25 -0700
In-Reply-To: <CACsJy8DdZLxdA4XSVVBSpeZaF+q6=81LxecYea2JtJ6-Krnk-A@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 23 Aug 2018 16:49:34 +0200")
Message-ID: <xmqqr2ipje5i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Aug 23, 2018 at 4:15 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>> > The remaining question becomes scripts.  A script might do
>> >
>> >       ... modify old-file and create new-file ...
>> >       git add new-file
>> >       git commit -m "some great message"
>> >
>> > which would trip this error.  For that matter, humans might do that,
>> > too.  Could the check detect this case (where the only changes in the
>> > index are additions of new files) and treat it as non-destructive?
>>
>> (where the only changes in the index are additions of new files *that
>> match the worktree*)
>
> I don't think my change would affect this case. If "git commit" does
> not change the index by itself, there's no point in stopping it.

I think the above example forgets "-a" on the final "git commit"
step.  With it added, I can understand the concern (and I am sure
you would, too).

The user is trying to add everything done in the working tree, and
"commit -a" would catch all changes to paths that were already
tracked, but a separate "add" is necessary for newly created paths.
But adding a new path means the index no longer matches HEAD, and
the "commit -a" at the final step sweeps the changes to already
tracked paths---failing that because there "already is something
staged" will break the workflow.
