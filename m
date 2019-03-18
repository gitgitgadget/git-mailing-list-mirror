Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F0120248
	for <e@80x24.org>; Mon, 18 Mar 2019 07:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbfCRHCr (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 03:02:47 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53091 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbfCRHCr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 03:02:47 -0400
Received: by mail-wm1-f65.google.com with SMTP id f65so11781875wma.2
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 00:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=S+5/hRGff/mrXbcIWGlKs6MwwExUbaUyEOd+l/Zjc5w=;
        b=OHgaAf6NqYh8jbuNmjnKSBOpJ5eCypmld7KECYLkvL/ihEjA6LRtbYQzpeGCWpmnrT
         a7AjR8T0WevGDYzQqmvyPE/hyOtsmoTUQEXLFJE17TfwnpJhkQQ/AM82isSk+k5CvQUG
         ++tSquDdvyyx3bPy8Cwq5xsq8qS1QYDtbk8HUOOH74KKwbI/4PhlfxS+z27CJYFAOk2U
         XK893joLhW+sFwMMwQ9tLInLAi3DtWa3/o9RUadgcSCl7faVDcjULrTMIl0H/6/h/fym
         sg+90/nZCtd1vz2CA30Yh62oOLtJepArSfokBZJZs3F47TIdzA8NDXo1377OVDhD5h39
         DXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=S+5/hRGff/mrXbcIWGlKs6MwwExUbaUyEOd+l/Zjc5w=;
        b=KnyYjgjGzWW8aBVEZaEDEWUvYjyGjhs2PI1CG5hEgfveOmtWn+MCQlJa1hOm+SkyH7
         WJO91lqM7Di7C9Nr1yU+LBDI3DW5i1BlWZelytloD2HoHawUxdwzlORTBgTZcjZ/N8wG
         oyox6NinGN2RRxx80qJ3dub9Jj/ZEmSLFGqJd5byK2DDkD+1wduf2AtbuIaPpOTXDmio
         XG6by+ElwOxWkgXrdB/uDZlG64f4xcys9o/Q1n/fivNO7p42Ut9+qV3U4oXQM/WRmAOi
         zP9/UQsukAWxP4ATklXG5fhfEQGPn3UWuTIzxIDSjTZLUK4HXbVedipQaCWYnFRHgVe+
         zFvQ==
X-Gm-Message-State: APjAAAWtL58kmM/D85JIgPvQVIE4qYS5cDuB0FZMumgxRjIonklOkiTn
        k8o0ERrrJKVGyo26TYqFBKU=
X-Google-Smtp-Source: APXvYqzreozsGQS5TcSpbtAzIDgtahwt2MiKLC1vg6lg3LLfazXyoua4oOLwrHomseOc/DBv5VSbFA==
X-Received: by 2002:a1c:f011:: with SMTP id a17mr9533258wmb.89.1552892565677;
        Mon, 18 Mar 2019 00:02:45 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x17sm28571198wrd.95.2019.03.18.00.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 00:02:44 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] stash: handle pathspec magic again
References: <pull.159.git.gitgitgadget@gmail.com>
        <xmqq5zsukuyj.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903081709220.41@tvgsbejvaqbjf.bet>
        <xmqqva0rmtrg.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1903111714430.41@tvgsbejvaqbjf.bet>
        <xmqq8sxc6bjt.fsf@gitster-ct.c.googlers.com>
Date:   Mon, 18 Mar 2019 16:02:44 +0900
In-Reply-To: <xmqq8sxc6bjt.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Mon, 18 Mar 2019 13:39:34 +0900")
Message-ID: <xmqqlg1c1x7v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
>> Fine. But in that case, I would appreciate not being reminded of the
>> messiness. Not unless you let me do something about it. Don't put me
>> between a rock and a hard place, please.

Perhaps your attitude is coming from a fundamental misunderstanding
of the process.  Don't be unnecessarily defensive, as nobody is
being hostile or attacking you.

It's not like this is a competition to see if your taste as a
developer is better or worse than others (including me).  It is a
cooperative process and everybody involved is "at fault" if we made
a mistake.  Ending up with a suboptimal history in 'next' is not
creditable solely to you.  I am as much to blame, so are others who
advocated to merge it to 'next' even it were not ready.  Or those
who did not speak up before it was too late, for that matter.

> Gagging me won't change the fact that the history we ended up is
> messy.  Without getting reminded of our past mistake(s) ourselves,
> what else encourages us to do better the next time?
