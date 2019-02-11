Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B0DC211B5
	for <e@80x24.org>; Mon, 11 Feb 2019 20:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfBKU46 (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 15:56:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36231 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbfBKU46 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 15:56:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id j125so690425wmj.1
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 12:56:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=1gQzyHRzu8TnkiYkzMNUQEXmu+hOA/Pu217ZnpkO/kU=;
        b=pkX07eTNPvMkqZEbXzWHqTClhHmIswz4V8oamD2hjiD3nGb1Woba1gvXz68OrKn2F4
         RLiPFLWuFMyhwlST4jTpqwtWYEusB12BpXNG+1pDi8xHrxAdXobaVUPtb9p85AzHTp2B
         tx+CViP4CKo8Tx4XJjJi7G6Qla5lowanzFIt3+Tiivw25BCtCRzVN4sMJJoYpiIvo4ND
         aDZLBY8fukOL1gCogMaI95BQUnLE70rwHc8VrMjWOXIdzxRcTqsk2IGJC00r2+aSmPLJ
         Z2y+js2M9VI1U9PDFhITOWN5SXOjF8Q73+aIy59XnsQFW1qUwqTi7fhjNQBulffuyDLy
         vU3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=1gQzyHRzu8TnkiYkzMNUQEXmu+hOA/Pu217ZnpkO/kU=;
        b=jU2YG8o5ZDXE/gy8YMa9Y0lwyJjPCQK4N+R9Xpym/lKOnvugu3AFoaD2o+dM4si03w
         MuzzkQgSenMY/5nD83UEs8WWbbrjmatsiR3Zulz7aBGq1En4xnppgGN69ScQr+8gZMrd
         +ikYaoJu4Uz/YZlNWG4/vP78IQKXaIpeq8FSAYhpCzltJWTZYmih0svZuVNYWgQAxWtd
         04mAXyjJ0mxpEyf/CzDJvGpK+Q4jRftqKUSyxcJkaEMir+YKhVBvYyMQICLKryaIObjz
         /R5yH/FbRYDOql48S25AGI26cm7E/DLFMEOY2F8F8apd61bKIvkxeRJFl2Yhhy3ve1RT
         MsMA==
X-Gm-Message-State: AHQUAuYMkxpDuelZaOokL219k8I7bTtxbjLiZVWA+pk4a3oBbWf6DD1Q
        dvh39PNAYcowjaxli5RbhbaqrnAE
X-Google-Smtp-Source: AHgI3IY0y9kPM3JIe8RcBSI8OvwVJmV1PBuYX3cB5I76H+Uh5T98YsyTbEhrzHoVOu8KANqPA6m5LA==
X-Received: by 2002:a1c:48d:: with SMTP id 135mr110870wme.1.1549918615192;
        Mon, 11 Feb 2019 12:56:55 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p5sm250321wmh.16.2019.02.11.12.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 12:56:54 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Proposed Fix] daemon.c: not initializing revents
References: <000901d4c0b1$1ea15160$5be3f420$@nexbridge.com>
        <000a01d4c0b1$9ef9ea70$dcedbf50$@nexbridge.com>
Date:   Mon, 11 Feb 2019 12:56:54 -0800
In-Reply-To: <000a01d4c0b1$9ef9ea70$dcedbf50$@nexbridge.com> (Randall
        S. Becker's message of "Sat, 9 Feb 2019 14:56:55 -0500")
Message-ID: <xmqqsgwugi21.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> Hi All,
>
> I found this while trying to track down a hang in t5562 - this isn't the
> fix, but here it is something that could be considered a code-inspection. If
> there have been random unexplained hangs when git runs as a daemon, this
> might be the cause.
>
> According to many systems (other than Linux), the revents field is supposed
> to be 0 on return to poll(). This was the cause of some heart-ache a while
> back in compat/poll/poll.c.

I am having a hard time grokking "supposed to be 0 on return to",
but do you mean "the caller must clear .revents field before calling
poll()"?

http://pubs.opengroup.org/onlinepubs/9699919799/functions/poll.html
has this 

    In each pollfd structure, poll() shall clear the revents member,
    except that where the application requested a report on a condition
    by setting one of the bits of events listed above, poll() shall set
    the corresponding bit in revents if the requested condition is
    true. In addition, poll() shall set the POLLHUP, POLLERR, and
    POLLNVAL flag in revents if the condition is true, even if the
    application did not set the corresponding bit in events.

and I am also having a hard time interpreting the "except that".  If
we asked to report (e.g. we set POLLIN in the .events field), poll()
does not have to clear .revents but just set whatever bits it needs
to set to report the condition in the field?  

If that is the case, it makes it a bug not to clear .revents before
calling poll; the sample code snippet on the same page in EXAMPLES
section does not, though, so I am puzzled.

In any case, no matter what POSIX says, if clearing .revents before
calling poll() helps on platforms in the real world, the patch is
worth taking as a fix, I would think.

> I am not certain whether that copy of poll() is
> used in daemon, but I wanted to point out that the value is being returned
> to poll, outside of compat/poll/poll.c and may present a potential for poll
> returning an error on that FD due to random values that might be in revents.
>
> Please see 61b2a1acaae for a related change/justification.
>
> diff --git a/daemon.c b/daemon.c
> index 9d2e0d20ef..1e275fc8b3 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1194,6 +1194,7 @@ static int service_loop(struct socketlist *socklist)
>                                 }
>                                 handle(incoming, &ss.sa, sslen);
>                         }
> +                       pfd[i].revents = 0;
>                 }
>         }
>  }
>
> Regards,
> Randall
