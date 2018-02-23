Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F8291F404
	for <e@80x24.org>; Fri, 23 Feb 2018 18:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeBWSIu (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 13:08:50 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32844 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751632AbeBWSIt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 13:08:49 -0500
Received: by mail-wm0-f68.google.com with SMTP id s206so7980327wme.0
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 10:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NWdQ2t/QCjelKgTLCAapxeBaU996ZDV/s5snjvri8+Y=;
        b=e4gjASct9qj4ytR3Q1guqE9kxd1qleDRHztI6g+CtYd/c5TStcyVgldeH7sOalXH76
         bnf8odhYMl9YvfoTiukAmRut68fLxRWFts9885vgu0DuVQhytgcSbeTP9OSiYPAgpoJ0
         0hk+LWjRZgGwTiDt7hMe1dQUaSxu/oZYKej3L+EccDVHO9DfZpQ8LQZ0PBg45MNnEkjp
         krE1xgiZgJObV7OHRLVHmFa14eWq5N/4Tp8PamjV+anozNaX70evvZjINJ17wapPVoMz
         jlqxkQQth4oX8DoXdSeCfb4hHEa/GMuz5fCmyao+YyL6IJ9P1ZOxFvTNez6evY9iCRCS
         IjHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NWdQ2t/QCjelKgTLCAapxeBaU996ZDV/s5snjvri8+Y=;
        b=Ag/qWEL0xEnXj8LtSCMg4UKArMUPuXl9C70S+qcLYzWday+R5IO0DTaH1j25pn+w3z
         pPLwLVo39UCprIKJAV06FX//O0RlSO18n4gRJ9W0sOnzNRG4kkgEJIY9ME5gCD+n4Fat
         e60BmJDxirESlI9MIZ37wRAVWh5KK78Og9WeG75I2rBr1G8VgnaJZ49A5w++c/BzoKz9
         0TScRPK7Q8qBo3lMiyJQH7djCcnmG/0w489hnf4QIpBy9QIhJctM+m8IUw7Om7MORXR+
         o3cm55CQWw4Fex5BAstKyHojhe7X0tQ8U37I3L/LZfXs2QTaq47uQCKyVPVfAzJ6sPfb
         LROQ==
X-Gm-Message-State: APf1xPDxHEHKZWDBxCJdDOKHdjA0O0qOHpL6SeD6d1NmXSvDeiuhFflr
        i23WQNrIEEU98Xl18va058Po/JmD
X-Google-Smtp-Source: AG47ELsG7illL4zP1k2iewIKx3+Kt85e33XMAaLpYL7dA5pyOrOmpZf667urnXrfaRatHeBD0fRGQA==
X-Received: by 10.28.231.10 with SMTP id e10mr2523000wmh.125.1519409327669;
        Fri, 23 Feb 2018 10:08:47 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y6sm2153563wmy.14.2018.02.23.10.08.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 10:08:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 06/42] completion: use __gitcomp_builtin in _git_am
References: <20180131110547.20577-1-pclouds@gmail.com>
        <20180209110221.27224-1-pclouds@gmail.com>
        <20180209110221.27224-7-pclouds@gmail.com>
        <CAM0VKjmFEyr4qHdc1qfW0M_RZ7cM9bCfsn-M4Rapzt6CPhZE1g@mail.gmail.com>
        <CACsJy8CWdJJigQSEjGuhoH1URGY8=YSAHiqhaGBZK7Zr8GZUGg@mail.gmail.com>
        <xmqqsh9sx4xk.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DWwOezWpTVmpndhvhujzGV79uT2RqpZJxcp7oLr7G+-g@mail.gmail.com>
Date:   Fri, 23 Feb 2018 10:08:46 -0800
In-Reply-To: <CACsJy8DWwOezWpTVmpndhvhujzGV79uT2RqpZJxcp7oLr7G+-g@mail.gmail.com>
        (Duy Nguyen's message of "Fri, 23 Feb 2018 17:17:33 +0700")
Message-ID: <xmqq1shbvas1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Fri, Feb 23, 2018 at 1:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> Now that you mention it, the only command that completes
>>> --rerere-autoupdate is git-merge. Since this is "auto" I don't think
>>> people want to type manually.
>>
>> Sorry, but I do not quite get the connection between "since this is
>> 'auto'" and the rest of the sentence.  Is it just it is so lengthy
>> that people do not want to type and are likely to use completion?
>
> Well, if it is to be done automatically, I should not need to tell it
> manually (by typing the option on command line). Granted it's a weak
> argument.

Perhaps I am not reading what the option does correctly, but my
understanding is that merge operations:

 - always allow rerere to intervene and auto-resolve in the working
   tree, as long as rerere is enabled;

 - by default they however do not add the rerere-resolved result to
   the index, so that the combined diff output from "git diff" can
   be used as a way to sanity check the result; but

 - if the user says --rerere-autoupdate, they add the
   rerere-resolved result to the index, letting the user blindly
   trust it, so that such a trusting user can even commit the result
   without looking at it by merely making sure there is no path
   remaining in the "git ls-files -u" output.  

The "autoupdate" could be somewhat dangerous depending on your
workflow, and that is why the user can selectively enable it via the
command line option (when known to be safe) even if the user does
not set rerere.autoupdate to true.

So I am not sure I understand "an option to allow something to be
done automatically should not be given manually" as a valid argument
at all, whether it is weak or strong.

Or am I grossly confused?
