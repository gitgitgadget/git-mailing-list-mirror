Return-Path: <SRS0=Lnee=43=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440FCC10DCE
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 06:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BD4E2467C
	for <git@archiver.kernel.org>; Tue, 10 Mar 2020 06:03:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbW6QS3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJGDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:03:35 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42888 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgCJGDf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Mar 2020 02:03:35 -0400
Received: by mail-yw1-f65.google.com with SMTP id v138so12632841ywa.9
        for <git@vger.kernel.org>; Mon, 09 Mar 2020 23:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LxlEtfgB9OXfnSwSGmc4iU6xvGJ2O04W8HsCd0+plKE=;
        b=HbW6QS3FMB3hN6kFqEVZdRitAfJIQv9UheDHgrHS95vIeQFb2G0nx/Gq+tra8WKFep
         +u4OuoGvU0LN8EOHcaO5jH+aeTDaEAF7hPwTLY7YLKYHhZCUgyV1NhzBoZHlZO9ls/kc
         48LrZ2ioVBdX9BuT+OsRCowVJLeSj1pFytYgsylxLaV3vL2taiSJxR4l79TaZaiRagYW
         ua9ZKLXUNSZqrwrc9cZURR7DW3TnhHA5NI6HSHBIzGrjSlmllMCKN/PZxBH58fBOMjDS
         n6+fzYWBevpFfa5WobM+WcINBweW3g/Wha/X7psSu8WGuQPWKJsG8xFrioHdVWFJWmC2
         +NbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LxlEtfgB9OXfnSwSGmc4iU6xvGJ2O04W8HsCd0+plKE=;
        b=gT5SYPXGZpHYxuvJDZr1ax1GoF5SsCLCISmY4MgqedwlThFVmrafuwjk2e2Hu3uKgp
         kAP2T1wD+HRlhHyvdDwSV9jyJAg6GSN8OAoTkU6n2QC/AA78EYT3sfMPraGpRUY9s4WN
         K8VWVP+1GqZBlAHmrhWP1c8QsKy22EMclEwplQtKxOLd51Ckx9Il+f7Meay5sekkSLW/
         yqscd2M/M7MY+b6vPPEXeqjyCWHwp8tw4rRn9ZBApnBCdaQNRzW8fbvD4FCgRmmMq0CT
         j8QHbdZpzvA3QhB2dQ8Y5YAXwNBAfUe7aKdBx+AxeaGVZH6paEKIyXGTyyZHYk8UUNjH
         HQDA==
X-Gm-Message-State: ANhLgQ0+pVlZYlg8067WdWm3+hkuT8NoUNcT+LnLjW3zExUTJl9I7Tz/
        unobR9gJOs4iYpzkh2/7nEeir5AXiXIORzdACHSQGTLEF2Xr4w==
X-Google-Smtp-Source: ADFU+vv7Lp710kqVPAhfvHp5/IuxoCfEZLy5ZXBwZoWIb/OSRa0pr0dHJ6mHoLGduUi4Evgg84yGoQP6WDCCDxbaYmQ=
X-Received: by 2002:a0d:f582:: with SMTP id e124mr17926560ywf.238.1583820214092;
 Mon, 09 Mar 2020 23:03:34 -0700 (PDT)
MIME-Version: 1.0
References: <CANYiYbE2V3bLfEgH-aRDv4Y5V+_BTZn-oUN7fOVpARm+_14BdQ@mail.gmail.com>
 <20200308145631.64040-2-zhiyou.jx@alibaba-inc.com> <xmqq7dzt1mhi.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7dzt1mhi.fsf@gitster-ct.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 10 Mar 2020 14:03:22 +0800
Message-ID: <CANYiYbHvqLX_OozgAXJ8MbuLipqUdj4CpbExe0oiCcyUyb=Osw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] receive-pack: add new proc-receive hook
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B43=E6=9C=8810=E6=97=
=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=881:12=E5=86=99=E9=81=93=EF=BC=9A
> Why do you even need "must-exist" in the first place?  In other
> parts of Git, when a hook does not exist, processing by that missing
> hook is simply not done.  Why does it have to cause an error?
>
> If there is a reasonable answer to the above question, then the
> concept that hooks can be marked as "must exist -- otherwise it is
> an error" would be independently useful and the support for that
> concept should be split out as a separate step before this one, I
> would think.
>
> Also, I am not sure why you have to have one single "special" ref
> hierarchy to be handled by the hook.  Why not feed everything and
> let the hook decide?
>
> I would have expected a design more along the lines of "if the hook
> exists, then feed all the refs to the hook, let the hook do whatever
> it wants and report what it did back to the receive-pack process, so
> that the client side can learn what got accepted and what got
> rejected (and possibly other things that may require protocol
> extension later)".  One of the possible things the hook can report
> may be "I did not do anything for this ref, please do whatever you
> normally do".  That way, you do not need to introduce "there are two
> classes of refs, normal and special"---that becomes an unused and
> unnecessary concept.  For whichever ref the hook considers "normal",
> it can use the mechanism to say "I want you to do the normal thing".
> And when it sees refs/for/ prefix (or whatever is considered
> "special" at the hook's discretion), it can do whatever it wants,
> and report "OK, I ate it" or "No, I reject it" (which are only the
> two things that can be returned back to the client within the
> current protocol, IIUC).  We may later want to extend the mechanism
> to allow richer response by the hook at the same time to extend the
> on-the-wire protocol and then it may become possible for the hook to
> take a push to refs/for/master, update refs/heads/master to the
> commit (or to some other commit), and report "OK, I accepted it and
> also updated refs/heads/master to this other commit".

In patch 3/5, I add a new config variable "receive.procReceiveRefs"
for developers to choose whether all of the commands or only a part of
them should pipe to the "proc-receive" hook. For example, a developer
may set the config variable on the server like this:

    git config --system --add receive.procReceiveRefs refs/

Then all commands will pipe to the "proc-receive" hook.

Think there may be thousands of commands in the initial stage for
setting up a new repository, and all of the commands are "normal"
(creating branches or tags). If the "proc-receive" hook has to handle
all of the "normal" commands by piping these commands to a "git
update-ref --stdin" process, or pass these commands back to
"receive-pack" by a new protocol, this will greatly impact the
performance. I think it's better to let the developer to choose by
using a config variable like "receive.procReceiveRefs".

Patch 4/5 (receive-pack: read env from proc-receive output) is
unnecessary, and extend the on-the-wire protocol is a good idea. The
protocol may using pkt-line format, and negotiation between
receive-pack (S) and the hook (H) like this:

    S: PKT-LINE(version=3D1\0side-band-64k ...)  # I'm not sure it is
necessary for the capabilities for all controllable server side
softwares.
    S: flush-pkt
    H: PKT-LINE(version=3D1\0side-band-64k ...)
    H: flush-pkt
    S: PKT-LINE(old-oid new-oid ref)
    S: ... ...
    S: flush-pkt
    S: PKT-LINE(push-option)
    S: ... ...
    S: flush-pkt
    H: PKT-LINE( sideband< progress... > )
    H: ... ...
    H: PKT-LINE(old-oid new-oid ref OK) # OK, I ate it
    H: PKT-LINE(old-oid new-oid ref error-msg...) # NO, I reject it
    H: PKT-LINE(old-oid new-oid ref)  # Back to receive-pack to handle it
    H: ... ...
    H: flush-pkt

After piping the "special" commands to the "proc-receive" hook,
receive-pack should discard the "special" commands, and add the
commands back from the output of the "proc-receive" hook. Then
"receive-pack" will continue to execute the internal
"execute_commands" function for the unexecuted commands.

In order to have performance similar to the vanilla receive-pack, it
is necessary to keep the config variable and the concept of "normal"
and "special" references. If the config variable
"receive.procReceiveRefs" is defined on the server, but the
"proc-receive" hook does not exist, it's better give an error instead
of fall back to the internal "execute_commands" function or doing
nothing.

--
Jiang Xin
