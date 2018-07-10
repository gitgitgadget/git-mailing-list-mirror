Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E62401F85A
	for <e@80x24.org>; Tue, 10 Jul 2018 18:19:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbeGJST2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jul 2018 14:19:28 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:40646 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732266AbeGJST2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jul 2018 14:19:28 -0400
Received: by mail-wm0-f67.google.com with SMTP id z13-v6so25341356wma.5
        for <git@vger.kernel.org>; Tue, 10 Jul 2018 11:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BWMxjIRbR9GTLcsq3E/SrpQ1RhK3pruz3QA0/1tN3tI=;
        b=ks+wx8os+GX11BhujWbpvydkLG5hRowhM1DfzxekX9D/I4TQzCBG0RXVjOCxegzyu9
         VIRNhHo6CslfdCvfDbIZeLWsaHj0PWnYGctdk3uBvk9PzfyWHU3G2KFLFdy99zgbGApr
         COgKh36qjA3LERoCx6O6OEAgck2uv1ZBR3wIW6ryhEiO48C1mkOLJIiQnTW0Q2modj1Q
         /0zn7etBNNnWIifD8pe2uQxHY1jN5EpWupRC+zlxCf+MGIQjlI6JiTf643AS2n3c17xy
         Rm4PyXG0OF3g8Qoyy7x4pm51ak1OHBNNcDXRKDG8juVc0LX0DlydVWk8gFcMLvxb1HWn
         xPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BWMxjIRbR9GTLcsq3E/SrpQ1RhK3pruz3QA0/1tN3tI=;
        b=nKrEf+iA59A7EvaqcA5JHT3Vj71pFKy/5o2IioX/bmTuDoYdVCcyJa+Pbq+Ose43cq
         60cK4fbjexBDC8e105uyauxWaZTAeX2Hu4h7AGkW7eop14Y0i/cdyL+nV791uGjGMIRq
         ivKUJGHI/YnMp2D7X5VTPAdOdGOfXiuKsTScsWDMSfbZi/Z5W9JorvYI2ZpfHiTXVo2J
         m/y/x5SzBFOVsNLAzTtzBlJlv3kFuK1YcYhH4rR4s7V1FsCXg9/I/5+uLFYnR7yH4ao0
         f+CEceFeckepQzxnYJvamDbWDRacl2gI2x+pzxqVLfclEvFiOljIGMOCT5Eaf0HzlQfK
         jA0A==
X-Gm-Message-State: APt69E3XeoWRntwXhtS+AiwIrm5HXWVZyiNHyJS82MKrXZFYAQ/ahUqL
        B+Y4poOx7xNteUJuccn9UC8=
X-Google-Smtp-Source: AAOMgpfACzjj2YmtMUhXRbRa83nctXHSfyqgg5omQatckk9wG9NPYefqulHN5ao1v+rP+F5+0Hxoig==
X-Received: by 2002:a1c:c501:: with SMTP id v1-v6mr16724029wmf.112.1531246409587;
        Tue, 10 Jul 2018 11:13:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t10-v6sm29441880wre.95.2018.07.10.11.13.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:13:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Pratik Karki <predatoramigo@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Subject: Re: [GSoC][PATCH v3 05/13] sequencer: add a new function to silence a command, except if it fails
References: <20180702105717.26386-1-alban.gruin@gmail.com>
        <20180710121557.6698-1-alban.gruin@gmail.com>
        <20180710121557.6698-6-alban.gruin@gmail.com>
Date:   Tue, 10 Jul 2018 11:13:28 -0700
In-Reply-To: <20180710121557.6698-6-alban.gruin@gmail.com> (Alban Gruin's
        message of "Tue, 10 Jul 2018 14:15:49 +0200")
Message-ID: <xmqqpnzv6jsn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> This adds a new function, run_command_silent_on_success(), to
> redirect the stdout and stderr of a command to a strbuf, and then to run
> that command. This strbuf is printed only if the command fails. It is
> functionnaly similar to output() from git-rebase.sh.
>
> run_git_commit() is then refactored to use of
> run_command_silent_on_success().
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  sequencer.c | 51 +++++++++++++++++++++++++--------------------------
>  1 file changed, 25 insertions(+), 26 deletions(-)

Looks good to me; it seems to cover the glitches pointed out in the
previous round well.
