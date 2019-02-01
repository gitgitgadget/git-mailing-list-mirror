Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3273B1F453
	for <e@80x24.org>; Fri,  1 Feb 2019 17:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfBAR5v (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 12:57:51 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40212 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbfBAR5u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 12:57:50 -0500
Received: by mail-wm1-f67.google.com with SMTP id f188so7077853wmf.5
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 09:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QB36Wv7UqKhhOQcTtaRLwoqaFdvFUL9mLCZv29ZBuJQ=;
        b=tBgWPF4OajJxLqMpL37j3nmHgWoIHNTWO+9UZ9mbMtfKDxrz4pGnrukbcbnpCf87BZ
         2x0BeS6cnSGASjG0uVbO0ii2sfh08RPUjMmHYQ44je4iJX7JnFUB8nJtMfrD1Lu8G4sQ
         218fjjcZEcdNP4aIl8XFzzI9rjg4Ug37jl2F/1XRpFthTnxHgWHOoLBiq4MK794r1tmO
         14Ynb/o/4qZATicy2li4PSso9AGojAEqeHP59Be+r7G5OLu5cy2IGqZcZTwxLIKSkymR
         SB94fU7WHyXkpjhv/ChLyapx3JbUrq3O7PK6XuYoZP/D9jjOE/QT3Yj2hs9DxPtZfsmZ
         O5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QB36Wv7UqKhhOQcTtaRLwoqaFdvFUL9mLCZv29ZBuJQ=;
        b=bOmHfqMHzJ9xAfMsN1DNiQ5Gy3Wj/p2RlDxTyx3DWRDVIIxZNvm4vstWTEf3urcV2V
         NF9Jd4Zy+sf7Lk71acVHUrMd1AQqwNyek+grrf3p1etSkGPOzynmkhaulTCoXzinNjqo
         ytqYAtVJi6oFOFDW0K2T+YVKwU64Sr6C9miAmgskOYYu3AyElFYJ1kfsezon2rnCJVLd
         /n2fPHSjaC4oeOVbiw8nq2yTln0q3e6hNckd2QuU0WgwNtTuhmN+Ch+ysO2Y5rJpi2PB
         NKD9Nv6BBiHI4qNeoR9hB5nDlmRCfU7ZOTJS0n0P2WltlUZuwgTMRiw0YgsMtLUw8zDQ
         AVBg==
X-Gm-Message-State: AHQUAuanOoKGcSUFZFfp55WSPXlphaRdKFioyhneRcngAVWqdmbMMB61
        5atGpNDmXk6Pp9BNXOFcsQw=
X-Google-Smtp-Source: AHgI3IbIxkXWRUAAkb59YwklZFOdVspGr7dv0iRxUNJp8hGMWepm4SRF7ePJy+Lb4MFk/Fk/nqQswA==
X-Received: by 2002:a1c:410b:: with SMTP id o11mr3446244wma.109.1549043868709;
        Fri, 01 Feb 2019 09:57:48 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o8sm10714852wrx.15.2019.02.01.09.57.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:57:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] checkout: add --cached option
References: <20181209200449.16342-1-t.gummerer@gmail.com>
        <20181209200449.16342-7-t.gummerer@gmail.com>
        <CACsJy8CfgJ4NAnbMjBFGhRWscZxJCgxtx0QwSMw7MTjeMT4gDw@mail.gmail.com>
        <xmqqva40lps2.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGQwtok1T3WmY3ndBG6RjbESSOgmbZxkWiN-avqfUjDVg@mail.gmail.com>
        <CACsJy8AxUxYCO7bzb98EVvO5DU62ukZQNrF-sEktrdR9m6tfvg@mail.gmail.com>
        <CACsJy8Bk=wbgzsE+Vo4w_u0E63PdUxxcvG-7e6Hq-8_jrmSErw@mail.gmail.com>
        <xmqq7eek3ax7.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
Date:   Fri, 01 Feb 2019 09:57:46 -0800
In-Reply-To: <CACsJy8CHHT=9e9ti7VA4X4h3FrZcUKvLuzkL56mXLgjk4c5Qcg@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 1 Feb 2019 13:48:56 +0700")
Message-ID: <xmqqlg2zz90l.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Of course we could just do --index and --worktree, each option
> restores the respective part. Then it's combinable (and extensible in
> the future). But then "git restore" means "git restore --index
> --worktree" and typing "git restore --index" effectively removes the
> default "--worktree", which seems a bit twisted.

Or "git restore --no-worktree" (essentially, instead of saying
"keep", say "no" to mean "negation").

Incidentally, "git restore --no-index" does not have a counterpart
in "git checkout", but I think it is probably a good thing to add;
as it has to do far more than "git cat-file blob $tree:$path >$path"
these days.
