Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5F5B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 16:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeHJSnW (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 14:43:22 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34314 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbeHJSnW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 14:43:22 -0400
Received: by mail-wm0-f66.google.com with SMTP id l2-v6so1876955wme.1
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RyfnGggIRSOXRDTOs8A+fnqmWcJlKHPL6w1sUZL+10U=;
        b=t2Tgv+6UTGVYIjKeLrlYG2mAWobrDu8KqU0iJgVAiYQKhgQcSZGE9hfiFdt6my9mbp
         YdaqN7W7Ydz/s/GP1PwfC4gjLyu7VWLyf7BnkVLHySV7FJUdddR9NQvm7QpgNa03XQES
         qSQWzDUAXTsNwjBlbea/7/WaOCBY8CojYE6nkUctNDkcpGFmHP5eQRgiuWGL6xgZHzMA
         lsQbpg34VDdiX8ZGiLZMLURmSDjXhYxC+FMCSv6cWtrUFBRe+UEjmlpeoa+4kH/2QqId
         iSCnrR/4bpMzj7p4aPcGfiNlDuyeP2yPtfpifPn6NmANydWerQPlGMgzCVQDpMJfjq4d
         BlJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RyfnGggIRSOXRDTOs8A+fnqmWcJlKHPL6w1sUZL+10U=;
        b=O72RCYYJF8IxKx5sQe8rXc2FodnJr3TedIubf2dB70A+AjWzkIUuY+V0w+Ls6VBfYw
         qAqjpBkmxFhEE3LhwM/3h1EsMeb5AdQI9PDQ1DNhw/eX8p+zx+5gWO9JvLCVVoF150Nk
         IMcg6LuXFWh4tJWuMepDYjpnA7gmGkjWbUG2bDnNsrG/CbhfIlBRPEclbR07TTX18pWS
         dykC2SVG4hNBsLPpocqm1buUk2mV0Oy4pMI+YRFUJwbBthmDM2Fg5tCDi3kKlYmS7lsn
         eX1wK0nqOYFyNiifCAN99ezdBbkDKVPHj/Ohaiyv2Q3yzzJ19Es26Qv0vd8P9kRqUZ40
         Fkrw==
X-Gm-Message-State: AOUpUlEJOQsHYPEv7FWVpIYo08/PxwVwMlcdShX33NK/yTPhyhHEWw7v
        /85Qw9BcYw839S0oi6AQXOP4FyLM
X-Google-Smtp-Source: AA+uWPy2F9X9glwiDdAN9L09a1A8XrCMdOtJri7R/3rolDShmWEVvllfBWcq7V/XEJg3KMsU2+ZxqA==
X-Received: by 2002:a1c:f516:: with SMTP id t22-v6mr1847874wmh.103.1533917570732;
        Fri, 10 Aug 2018 09:12:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a184-v6sm3020410wmh.41.2018.08.10.09.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 10 Aug 2018 09:12:50 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de
Subject: Re: [PATCH v3 0/1] clone: warn on colidding entries on checkout
References: <20180807190110.16216-1-pclouds@gmail.com>
        <20180810153608.30051-1-pclouds@gmail.com>
Date:   Fri, 10 Aug 2018 09:12:49 -0700
In-Reply-To: <20180810153608.30051-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 10 Aug 2018 17:36:07 +0200")
Message-ID: <xmqqr2j68ake.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> There are lots of suggestions on optimizing this stuff, but since this
> problem does not affect me to begin with,  I'm reluctant to make more
> changes and going to stay simple, stupid and slow. I could continue to
> do small updates if needed. But for bigger changes, consider this
> patch dropped by me.
>
> v3 now uses inode on UNIXy platforms for checking colliding items. I
> still don't try to separate colliding groups because it should be
> quite obvious once you look at the colliding list (and most of the
> time I suspect we only have one or two groups).

I think that design decision is fine.  We can extend it later if
needed, but I would not be surprised if what you have here is
sufficient.

Another possible follow-up in the future may be to encapsulate the
"I have a cache-entry 'dup', and stat data 'st' taken for a path
in the working tree.  Does it look likely that the latter is the
result of checking out the former?" logic, which you currently has a
hard-coded if() statement condition, into a helper function and
make its implementation platform dependent.

