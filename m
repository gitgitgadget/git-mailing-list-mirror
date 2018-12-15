Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C8320A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbeLOAk7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:40:59 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]:40478 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726604AbeLOAk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:40:59 -0500
Received: by mail-wr1-f52.google.com with SMTP id p4so7025710wrt.7
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=OWm/2yJ7vFsC316hj/HBzVpd2rfnycu7MwDbTG3AmlA=;
        b=X+i0/bjk/zKqWUuW/uQI83gEPx51vilL0sU6PbZwmPi+YZ3ZFMGWWc5EQ/3CSq+f7v
         IEBC1F4/21EiSFvVX1VelWS1nDTWPEAf0gABVgYztrXzHQFnRzgTuUL2xrfyeVJwtotL
         cTGA4S5zh+YHo+o9DY0ZUytyIxDln9lphrMOSEJ2D3HfyBwD47j00Fe9uWgjSzvLhtwO
         CH7rrFqbqiunT+ItKaAQCv/2AM+/dyYetYIM1jJb88WTvnzeJyG6Byq9DSjMF4rnT4a9
         SWMxYdeRwT1bAULB7HDWM/HQaf/vL+2DbG9xzqr0fqRw55oOlJPkguFtcDOuw8kDgGiP
         V8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=OWm/2yJ7vFsC316hj/HBzVpd2rfnycu7MwDbTG3AmlA=;
        b=KHGU55i85xbka5Kcw2cQ7EN6zTz8SXT6zQdeee+HY+SX3lhaa98FKfl/uZ6sGeZ0LH
         5AWQLxaftXvaf1OLV+fHaSLN0TQcFl4c4QajVhVpyfYvcVNMbaVdaFA/eogtZzVQMfsw
         dphL5flPU9UoSKE8mbaguumRsJG1iSTsdzusfjyYi220uaVdgLf8dignSPe5N6hx1VUy
         le+sLAujLYNwAa1exP7nEZDTO8sVvVL1h7skX5G81fi4bm6jmfx8f2la7Ne52OMTv7m+
         4TaYmI2UFJ/Q0rLnCfjouic9ZQMVtfRwiKynbAHHYSvvY03J535GDlvQx9lnOHIs+4jE
         48EQ==
X-Gm-Message-State: AA+aEWbtPCKny25SHkivO4/v0d5s4DvtsRYHG8YaCs45prCTXdSgfBMh
        QhilxDQUX4ThLz2iQ94PENs=
X-Google-Smtp-Source: AFSGD/VdOKqBhHlrESV27maM+WUttDB4X1yP3pyYkVzTtCPexC9hL/ckABfX1P3cg5ItCrTWwmlr8w==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr4304411wrg.52.1544834456697;
        Fri, 14 Dec 2018 16:40:56 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e19sm10226809wrc.25.2018.12.14.16.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 16:40:56 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Halstrick <christian.halstrick@gmail.com>
Cc:     Git <git@vger.kernel.org>, thomas.wolf@paranor.ch
Subject: Re: git-apply working on an index with smudged entries
References: <CAENte7hRCk+3E+C4LYOjTzQKdqE1wN1=HX7YkR72H+HD-=mj5g@mail.gmail.com>
Date:   Sat, 15 Dec 2018 09:40:55 +0900
In-Reply-To: <CAENte7hRCk+3E+C4LYOjTzQKdqE1wN1=HX7YkR72H+HD-=mj5g@mail.gmail.com>
        (Christian Halstrick's message of "Fri, 14 Dec 2018 11:15:47 +0100")
Message-ID: <xmqqzht7bp0o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Halstrick <christian.halstrick@gmail.com> writes:

> Question:
> - is this because the index which jgit created is so corrupt that only
> special commands
> like "git status" can repair it?

No.

> - or is "git apply" not trying hard enough to consume a index with
> smudged entries

No.

Lower level "plumbing" commands like "git apply" want to see the
cached stat information in the index refreshed before they are
called, instead of having to refresh the index themselves before
starting to work, for performance reasons.  Higher level "Porcelain"
commands like "git status" on the other hand refreshes the index
before they start to work.

What you are seeing is a combination of

 * JGit not running its equivalent of "git update-index --refresh"
   before finishing and leaving the index file for you to look at.

 * "git status" running an equivalent of "git update-index --refresh"
   internally.

 * "git apply" not running "update-index --refresh" itself and
   instead expecting somebody else to have done so in the sequence
   of commands that it is a part of.

The latter two is working perfectly as designed.

I do not know what JGit wanted to do to leave the index in that
state, so I cannot judge if that is a reasonable thing to do or JGit
needs tobe fixed.

