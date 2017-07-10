Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D27692035A
	for <e@80x24.org>; Mon, 10 Jul 2017 02:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbdGJCKL (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jul 2017 22:10:11 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36517 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753343AbdGJCKK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jul 2017 22:10:10 -0400
Received: by mail-pg0-f67.google.com with SMTP id u36so10860012pgn.3
        for <git@vger.kernel.org>; Sun, 09 Jul 2017 19:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=2u6cKM9XPV//ZuuZqKGigqkQO1cTnsY22rHALeZukBc=;
        b=P+jb963jyoZLhAapFL8sLel9UcfxgX1lo3D6IFVLtD0LbfHzMi8FEjSne5dt4UvUd9
         Qp+PMKywMOtxD8IY98O56+5vioi0RKSfRjk4jnYaqVh0fKUMDh6ckIUMqJLbi3grX9cm
         BfPp02iBhVQurMWpX5sJPiSHM4URMUDKzxi5Q9K8ndjkG3biuFUKgFfWI9HHlMEsmB4l
         CWamJgo3yl0KxWWncYcx3PZoVZUU06iPmeKMBd8js2Up7kjJ2D1XSgq6P21LmG7ifILu
         llekpNjP7NG7dN30EdIOMWb0NR/efcnQtaKMhSG4/Vl0dUvo86MPK0+CATQfeByyrTA5
         9IwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=2u6cKM9XPV//ZuuZqKGigqkQO1cTnsY22rHALeZukBc=;
        b=I7jpfhjQTT8CpeiD+puahgxe2LhUOCQS5vXs2OLmKZLZ/gig80XQnwDWWiQKjkXy13
         9ilD+Pjn9HJSMAVWE1NdaUrNAfR4LhLz8LMdWJ66pwUPbx1xuuWU1uSBFPzLlGTdiCa1
         EcltcKZsA7TfnLGrvVLOAnbv56jZqjicl1Ups038FpKOlcRGQj2eIWgXr0OCnWfD4CbV
         liIoqnVli8davHcBWiasp0wnFO29mA4gqxhM/3NtZB+zAEPwtm4ENTcViVyKyMN2F3I6
         HyFvsqdC88mZtI4jxsXzjr1d22SFqBsrQn1yyTSPZT/N09z2JgYXV+CzXZhTGui8nbFh
         Vvxw==
X-Gm-Message-State: AIVw113TJrUaa0b5iZ7QDmqZVFSdB3K1DSY50m/Wh9vdm4WnCRZW7h6q
        iybnSUAliQVjeQ==
X-Received: by 10.84.217.11 with SMTP id o11mr15331037pli.177.1499652609781;
        Sun, 09 Jul 2017 19:10:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:dc1e:60e1:7751:9c92])
        by smtp.gmail.com with ESMTPSA id v62sm20197647pfa.6.2017.07.09.19.10.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 09 Jul 2017 19:10:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] sha1_file: add slash once in for_each_file_in_obj_subdir()
References: <f59c8256-716b-9305-2a4f-d4fe49f666ff@web.de>
        <20170709110016.nusy62u2morqvwmm@sigill.intra.peff.net>
        <xmqqy3rx8svk.fsf@gitster.mtv.corp.google.com>
        <20170710000638.p7foedomfmdakyww@sigill.intra.peff.net>
Date:   Sun, 09 Jul 2017 19:10:08 -0700
In-Reply-To: <20170710000638.p7foedomfmdakyww@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 9 Jul 2017 20:06:38 -0400")
Message-ID: <xmqq8tjx82kf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... And you could even drop origlen by
> replacing it with "baselen - 3" at the end. But somehow doing the
> computation on the fly actually seems more complicated to me (from the
> perspective of a reader who is trying to make sure all is correct).

True enough.  I personally do not mind any of the three variants
(including the original) and would rather not spend too much time
micro-optimizing this codepath, lest the next clever person starts
to turn the loop in for_each_loose_file_in_objdir() to a nested loop
that runs 16 times each to avoid copying the same leading byte again
and again ;-)

