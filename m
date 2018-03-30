Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24AB1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 16:00:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751345AbeC3QAJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 12:00:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50635 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751147AbeC3QAI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 12:00:08 -0400
Received: by mail-wm0-f65.google.com with SMTP id l201so16212171wmg.0
        for <git@vger.kernel.org>; Fri, 30 Mar 2018 09:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=5URJoF4NPCtdAhzrdUdgaSxA2xSxKCVFLD9pLjkle1Q=;
        b=bGQlcv8CVWAfyrX3GJTXmpCSI/X+24UsG8G3+rPMcMEwG6k5loenD6P7GA6+sWZT29
         qSJ7EQvUlAnukp3pr2dLD49QIwy+yE0ZOkVweJFashAlgj5FzAyt7So5hHvkojR6powd
         QZw/a4rOmvg8R4lDHKNcJnPI4kWAM/+NWuAJVovpOfZ+KJ2NZe5WkVjfRhFOft70xZt2
         A3ERDNNrlgefdt2UgX0L1QJdQgT8OmAzNxAax1qtcY0sEFzwS8fpNgGN588mdyCnpKV8
         iJM3xFMtdBnTVjJehR3JwzEdytbBMlDV74i/c1IgsoXBvDQssyyeyoyjfvie7+Hp9jYv
         B80A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=5URJoF4NPCtdAhzrdUdgaSxA2xSxKCVFLD9pLjkle1Q=;
        b=eBV3D6Fm4ELbtRN04ln4Ll5Rq0S4DWWjDaIS/wQD77X3CKclBKjjZhiobXj8oQQLp+
         6BvN9XcOdFQ13072cMxxNBcN4GAYm89uBOKr6Q/eIZ+OxRJRgAkq1CuIL2g01CoMi+4E
         xtMQE2l44K68FJMeC/+MlQ1bbDzueyJPe2HD5cx0VJGY0WouCjcVAVRWBXj860x+2wce
         po5p31doVyHx/yXH9eq2TtuMVSpklGdJRgjQtoR0Kjn0c7dZaI1dq9DlteKF0ll/S76P
         meN7wPPx6IKqSi0nkIMZGgutGXZAWadJm75eypLH/IJQDssJz+8VwznJ0AcSOwXw4qqw
         Sv9Q==
X-Gm-Message-State: AElRT7G5ALVfAgbuHn7jCmiIM6O9xyiQP03jPuXYk1WrebP/JPQMPkAn
        ecYfP9ZsWcKsi5TyfA60LBs=
X-Google-Smtp-Source: AIpwx48Y6oU+mfk6+Jtfe3wQ5g/RNl9G2BJh1CTbKVJQHH4AKIq1WQA5BxF0k6RVqoZzQRRRDFKrAA==
X-Received: by 10.28.155.66 with SMTP id d63mr2505373wme.144.1522425607087;
        Fri, 30 Mar 2018 09:00:07 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z16sm12544905wrc.70.2018.03.30.09.00.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Mar 2018 09:00:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH] builtin/config.c: prefer `--type=bool` over `--bool`, etc.
References: <20180328234719.595-1-me@ttaylorr.com>
        <20180329221122.GL2939@sigill.intra.peff.net>
        <20180330052719.GA6628@syl.local>
        <20180330135315.GE29568@sigill.intra.peff.net>
Date:   Fri, 30 Mar 2018 09:00:05 -0700
In-Reply-To: <20180330135315.GE29568@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 30 Mar 2018 09:53:15 -0400")
Message-ID: <xmqqmuyp4kqi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ... But actually, last-one-wins applies only
> to a _single_ option, not necessarily unrelated ones. Many other
> multi-action commands actually have a series of separate boolean flags,
> and then complain when more than one of the flags is set.
>
> So maybe it's not such a good idea for the actions (I do still think
> it's the right path for the types).

If this were using command verbs (e.g. "git config get foo.bar") as
opposed to command options (e.g. "git config --get foo.bar"), it
wouldn't ahve allowed multiple command verbs from the command line,
and last-one-wins would not have made much sense because there is no
way to trigger it as a desirable "feature".

Just like the topic of the discussion unifies --int/--bool/etc. into
a single --type={int,bool,...}, perhaps the existing command options
--get/--list/etc. can be taken as if they were a mistaken historical
way to spell --action={get,list,...}.  I of course am not recommending
to add a new "--action" option.  I am suggesting it as a thought-aid
to see if actions are all that different from value type options.

I agree that a-bit-per-type that is checked with HAS_MULTI_BITS()
for error at the end does not make much sense.  I also think what
you did in this patch for actions is a good clean-up for the above
reason.
