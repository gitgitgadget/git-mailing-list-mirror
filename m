Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D0320195
	for <e@80x24.org>; Fri, 15 Jul 2016 17:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751473AbcGORYT (ORCPT <rfc822;e@80x24.org>);
	Fri, 15 Jul 2016 13:24:19 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:33489 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353AbcGORYS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2016 13:24:18 -0400
Received: by mail-io0-f182.google.com with SMTP id 38so110236801iol.0
        for <git@vger.kernel.org>; Fri, 15 Jul 2016 10:24:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T5gM0hn+W62LH8rF7sjxliw+G5mQ05BdZ/ExZgcgxYE=;
        b=lOyi/ovtcNKK3313K269A8U3yC5IarwAxzFPkGMyanqDVWY+PzGYvZDQt9L/01KwwV
         9z1rEO09noITTnHNXQydi74TZwNAxo1nL1a8dJ00m7n0krLtoStc1jlLwmT8hG3NJQHA
         1PjaMGvwOxfJFNspGa5Fp76jLQ9h64DTVdzIz4Sj/aVsIAY/4IkpORxJ5C3qbvbzXjZm
         aPb0jgnXk0Q/9aTy0wkiFkO1AV1D7Du2LPjRbIXJPqUHiM6F6aS8SbsHLOjsxfzst0vy
         xM6X3XiQAPYLad3Df5ZHFle6SU0truj+uRGn2BY93XzUEHHK63kdqjoqhkKJiHHQ4/Mo
         FgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T5gM0hn+W62LH8rF7sjxliw+G5mQ05BdZ/ExZgcgxYE=;
        b=YZ05DwzsFoN5AInzK1OmuqN51HAeJEWquEtq0hIIgSNtDz0AlQ7jMZT/Cs1wTU3rUd
         i3g8l7wz0orlFb4T5cAGLB1tKNeILGr2zMvxB552KiCI4cTniRLZr2MInTw1vgHYXuJM
         1n+L5s+c6164FeDPaues3oQECJ7BF/tPugdZv5/V7vuaAGF38Qp2xwvUm6pkC5eFX1iv
         01muReXkL1xj108QXbUYd7n9vyFjzodOHjVnHv1p5nSKpdf2L7lbcA/ITn/ldoAEVNi6
         BPJpuhSjnu5wW3YJXtL8pZenpCKKC4hrlEC+lSg0XdAfbjyl3ouHFe2YSwacoC5ZNOSe
         YtOQ==
X-Gm-Message-State: ALyK8tJfaAdglAiGCL4pIKHbh5UINuTJMFL1i0w1havT22QX7sBolquzSB/zQFRbO0TEazjX24hhITsHRbPZyzbW
X-Received: by 10.107.178.129 with SMTP id b123mr22424011iof.83.1468603456938;
 Fri, 15 Jul 2016 10:24:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 15 Jul 2016 10:24:16 -0700 (PDT)
In-Reply-To: <20160715104347.GL19271@sigill.intra.peff.net>
References: <20160715102506.GA23164@sigill.intra.peff.net> <20160715104347.GL19271@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 15 Jul 2016 10:24:16 -0700
Message-ID: <CAGZ79kbernZHx9SUG-_vbxy-g77_3ki1uc-21LCviwrH=aXp6w@mail.gmail.com>
Subject: Re: [PATCH 12/12] receive-pack: send keepalives during quiet periods
To:	Jeff King <peff@peff.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 15, 2016 at 3:43 AM, Jeff King <peff@peff.net> wrote:

>
> Signed-off-by: Jeff King <peff@peff.net>

Read-entirely-by Stefan ;)
Thanks!

> @@ -319,10 +331,60 @@ static void rp_error(const char *err, ...)
>  static int copy_to_sideband(int in, int out, void *arg)
>  {
>         char data[128];

While looking at this code, do you think it is feasible to increase the
size of data[] to 1024 ? (The largest that is possible when
side-band, but no side-band-64k is given).

> +       int keepalive_active = 0;
> +
> +       if (keepalive_in_sec <= 0)
> +               use_keepalive = KEEPALIVE_NEVER;
> +       if (use_keepalive == KEEPALIVE_ALWAYS)
> +               keepalive_active = 1;
> +
>         while (1) {
> -               ssize_t sz = xread(in, data, sizeof(data));
> +               ssize_t sz;
> +
> +               if (keepalive_active) {
> +                       struct pollfd pfd;
> +                       int ret;
> +
> +                       pfd.fd = in;
> +                       pfd.events = POLLIN;
> +                       ret = poll(&pfd, 1, 1000 * keepalive_in_sec);
> +
> +                       if (ret < 0) {
> +                               if (errno == EINTR)
> +                                       continue;
> +                               else
> +                                       break;

The method was short and concise, this adds a lot of lines.
Remembering d751dd11 (2016-07-10, hoist out handle_nonblock
function for xread and xwrite), do you think it would be reasonable to
put the whole poll handling into a dedicated function, maybe even reuse the
that function?

    if (keepalive_active) {
        if (wrapper_around_poll(&data_in) < 0) // handles EINTR internally
            break;
        if (!data_in)
            send_keep_alive();
    }

I am not sure if that makes this function more legible, just food for thought.


> +                       } else if (ret == 0) {
> +                               /* no data; send a keepalive packet */
> +                               static const char buf[] = "0005\1";

and the \1 is the first sideband. Why do we choose that sideband?

> +                               write_or_die(1, buf, sizeof(buf) - 1);
> +                               continue;
> +                       } /* else there is actual data to read */

"If there is data to read, we need to break the while(1), to actually
read the data?"
I got confused and needed to go back and read the actual code again,
would it make sense to rather have a loop here?

    while (1) {
       while(keepalive_active) {
        if (wrapper_around_poll(&data_in) < 0) // handles EINTR internally
            break;
        if (!data_in)
            send_keep_alive();
        else
            break;
        }

               sz = xread(in, data, sizeof(data));
                 if (sz <= 0)
                         break;

        turn_on_keepalive_on_NUL(&data);
     }

> +               }
> +
> +               sz = xread(in, data, sizeof(data));
>                 if (sz <= 0)
>                         break;
> +
> +               if (use_keepalive == KEEPALIVE_AFTER_NUL && !keepalive_active) {
> +                       const char *p = memchr(data, '\0', sz);
> +                       if (p) {
> +                               /*
> +                                * The NUL tells us to start sending keepalives. Make
> +                                * sure we send any other data we read along
> +                                * with it.
> +                                */
> +                               keepalive_active = 1;
> +                               send_sideband(1, 2, data, p - data, use_sideband);
> +                               send_sideband(1, 2, p + 1, sz - (p - data + 1), use_sideband);
> +                               continue;

Oh, I see why the turn_on_keepalive_on_NUL doesn't work as well as I thought.
I wonder if we can use a better read function, that would stop reading at a NUL,
and return early instead?
