Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20889C433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA035613D2
	for <git@archiver.kernel.org>; Tue,  4 May 2021 20:34:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbhEDUfK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 16:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbhEDUfJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 16:35:09 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C4FC061574
        for <git@vger.kernel.org>; Tue,  4 May 2021 13:34:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id x2so15212419lff.10
        for <git@vger.kernel.org>; Tue, 04 May 2021 13:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=oFe8Lgw6N2Y1u098XqO4UKtMlkHFUdyx1cNObc4e7Xs=;
        b=Va+teOVXRgqgo5Vs78g+qfmd+r/5q8yqswxJWF2fG6y6NFLdAdnOcp0251wZuOy55n
         MiPgu5m7QaxZhFexlCjtMGaEq4htn0qJE8S8o8CwWU0pbO4lG3Giqpv+YxY9LcsgJLay
         EQi7/v/sCzI+bmlDqsN/V3ZUv5NRmr0Kkk+CMV6zvVuxmyzSLDq0Ktg3hYcC8rDljGiZ
         fpiOCnRlS6o/mcvmunnIz6KswifbiwEw3ArfrI0K0e8ED8PJE5khgAwDyTeeb/f5bkss
         aplwVUe0Cx3/noZovLToVN/pCCfdXZSkBahCrSXCu+pagmz2sIytfCQHjzuX/xJyoQ3b
         5kTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=oFe8Lgw6N2Y1u098XqO4UKtMlkHFUdyx1cNObc4e7Xs=;
        b=myls4ltKPBgFNglpUe8NgkIN0TK9YFvFATxuZsIjaY62eufjhLtLz5Uaab5y11s0VL
         S7tWd2QeJyoDW3XfmhwIzhfNsk7LFEtQhSh7to+tEJSk/vftLbS/CMh55hHefSiPMs8g
         jIa7GHw+HexxiCGIwUc7JKQaN6+vPCp/NPO56KEex+/Qegi6Kd1/LvZQkecmiAYpJbZH
         isCm/Z04bP6n/60AUwp3yViAQV+5Gb/nxuYJsZLJJD9j/1sv2mJpB11fUBrt6XHSpffK
         Mq8gqLI8OjQPoF2OvxVl3DF1STpO7T3WZ7rD016tJXdJJb7jrZRc1gWgtTzwj/Y2fNh1
         q7jA==
X-Gm-Message-State: AOAM532qH+U/fDfMrpWUlQmX3zVytdF/Yi5j3zT92qt/w5HOAqSFWj/V
        sqCtZbyzyBmoiVlCf4DF4XfkgQlGTt4=
X-Google-Smtp-Source: ABdhPJxnamZiDBGry3FZCRP6SXz+p3xCyA2NMo4mgrLJ1DFD4ukcybRTlv1ZPrnO2cdeHGXMrzMF5Q==
X-Received: by 2002:a05:6512:acc:: with SMTP id n12mr18597799lfu.9.1620160449676;
        Tue, 04 May 2021 13:34:09 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id y14sm1838523ljy.18.2021.05.04.13.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 13:34:08 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <CAMMLpeS4pkP_xRw_qT3mCTP4hS3iLP9TwdDf8LV+3+an9aJ3Hw@mail.gmail.com>
        <6091aa0dee8f4_b34a8208ba@natae.notmuch>
Date:   Tue, 04 May 2021 23:34:08 +0300
In-Reply-To: <6091aa0dee8f4_b34a8208ba@natae.notmuch> (Felipe Contreras's
        message of "Tue, 04 May 2021 15:09:49 -0500")
Message-ID: <87y2cu5jcv.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Alex Henrie wrote:
>> On Wed, Apr 28, 2021 at 9:22 PM Junio C Hamano <gitster@pobox.com> wrote:
>> > Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> > It is best to move on, writing it off as historical accident, and
>> > embrace the new --diff-merges=m option, instead of wasting time on
>> > pondering "why", because accidents do not have to have a deep reason
>> > behind them ;-)
>> 
>> If the behavior is an idiosyncratic accident of dubious utility, let's
>> replace it with something that makes sense and is useful :-) If we
>> make -m imply -p then no alias is necessary, `git log` would display
>> the log without diffs and `git log -m` would display the log with all
>> the diffs.
>
> Indeed. Mistakes in the design of the UI should not be carried on
> forever.
>
> Either all --diff-merges={m,c,cc} imply -p, or none should.

None of --diff-merges imply -p, and none should, -- that's one of the
goals of introducing --diff-merges.

OTOH, -c/--cc do imply -p, and then -m doesn't. That's the historical
inconsistency, not anything about recently implemented --diff-merges,
and the natural way to fix it is to let -m imply -p.

Thanks,

-- Sergey Organov
