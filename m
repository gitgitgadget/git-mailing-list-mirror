Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 674CD1F97E
	for <e@80x24.org>; Sat, 13 Oct 2018 07:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbeJMPc4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Oct 2018 11:32:56 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34135 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbeJMPc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Oct 2018 11:32:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id l6-v6so15271144wrt.1
        for <git@vger.kernel.org>; Sat, 13 Oct 2018 00:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=f5fJ6R5wzauubSRkAXYu5t95jzf8a9MPedfg0c5kkZM=;
        b=Qe3BkJbxmD8RZKhachrGNn1ocT7BhMzfnTM7W/VGJNYKWTE3RQT1OrmD3vvopRo8XY
         Czf6FF+nFP1h6JwITisJAkL7vbDFzOtdUD0UMjudn2ikJzXoqKT/5dduoKk4LfLu34dj
         ev0s9w6FJxbB1RaGBKHVdZtMaFVp0pfDcvtE80JOUpioT9NDPknHnYTr8lK5BKhoAjq/
         JTOJbbmWvbbatPwJeplS0I5iHMYNvu71LmYOdE7scoUxzU1FeG4lphv6WNVsZ7TIZ/aO
         llu645eMVb/tVXXboyU6ooqI+8UXuoyQPwAbXKIPK9t1Or/teHY1Lqx3jGlCjmsUYfk6
         hWUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=f5fJ6R5wzauubSRkAXYu5t95jzf8a9MPedfg0c5kkZM=;
        b=JqbSvobj7Gaj9R/fBQp30Fyd5lkNEdS0sbsUzoVAkpw3DeuPQwiUDeQiuB3cFs6ERL
         BC3a5OgSz313r6kn8HjAlVtnYO9lvAV8jwuLq8c6D0ohd5JZE47/NFtOg/wvdu18tflv
         kjbCHP/oHXSykycC7igTp9vpKFsi8A0DCquBxeoMYFA8ILxydKAH/1ZXe0VFd8Zwe5Ir
         uraYmIyreGd1Eth7eX78Ki5FKiupiCFB9jgfhmFcLS6u+JIyqULBcTDTv1mjQp4gfqji
         Up7h2nbvCNW0FeZc6BpsYTUVxGv3taacoVrIq8VJTJJ1iSxYhIx3q1Rb7atb5Zz0txZA
         +IXQ==
X-Gm-Message-State: ABuFfojFH4Vske7vie+CFvKj7YW/luRlN5m7eX2XXvUHD0sQX5ehqxxf
        YQNJvnyctleH2Kx5PnQbVRA=
X-Google-Smtp-Source: ACcGV61XRuXdE53Xqc7Jm13PG+qnzO/gkG+XN6vreYVrFj4OqD08dNoCGMzTt9HcjF7UO9xMR0BKUw==
X-Received: by 2002:a5d:4208:: with SMTP id n8-v6mr7296271wrq.260.1539417404528;
        Sat, 13 Oct 2018 00:56:44 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t194-v6sm3996026wmd.48.2018.10.13.00.56.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 13 Oct 2018 00:56:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Brandon Casey <drafnel@gmail.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] gc: remove redundant check for gc_auto_threshold
References: <20181010193235.17359-1-avarab@gmail.com>
        <CA+sFfMeOpj4V+KszboVVQSoaW2yDgpfDNGwK9ZrNfGmOOAhPtQ@mail.gmail.com>
        <xmqqk1mpjru2.fsf@gitster-ct.c.googlers.com>
        <87h8hsexdm.fsf@evledraar.gmail.com>
Date:   Sat, 13 Oct 2018 16:56:41 +0900
In-Reply-To: <87h8hsexdm.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 11 Oct 2018 09:49:25 +0200")
Message-ID: <xmqq8t329t52.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Yeah, that's me :) I have some WIP gc cleanup, but want to sit on it a
> bit before I submit it to think about the best way to do things.
>
> So in the meantime I was sending out a few WIP bits that I expected
> could be reviewed stand-alone.

I dunno.  Unless the real body of the changes that "depend" on this
small change comes before people forget the connection between them,
I think it is detrimental to churn the codebase like this.  If the
real body of the changes do not conflict with other topics in flight
when it materializes, then having this small clean-up as a
preparatory step in that real series would cost us nothing---that
clean-up would not conflict with other things either.  If the real
thing would conflict and need to be adjusted to play well with other
topics before submission, having this small clean-up as a
preparatory step in that real series would cost us nothing, either.
