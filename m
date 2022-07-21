Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6538C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbiGUS6q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiGUS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:58:37 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BAD38C163
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:58:36 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e69so4343988ybh.2
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9ZkzTVnJm2Hlwc2t0MC2C+KWgU2ngIi9MX9Lu13hxDg=;
        b=oUnDi6JIZN5TpIQDpJaCNVSKUza7o0YXX+/klh/TNnUyz57P3ExSk+48cFhhpTkT4f
         1scRCy1bZV1wMkzAroBAPgJtHaElTjClMKC64DQXzix5jGIz7OACXaTS7xbZKAgLACCB
         rH9M3ZaMVX/GSOV4suK+CiOiNyABNBQFqIrC21n3jU3EAl6boGebwhKelgTUmalHLgOt
         Bkj6RP4i+xzVCUDjIduNEJphYyawB1odrRUN4GsOGkojTv1m2FbWIkUBMMgXkJOKc7/x
         veTqa593469HEhuWozrxVKueMEDzJuZzYWbtJt3qQDhwM3G5n9lRcwGtN6R3NWbgamAN
         iKdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9ZkzTVnJm2Hlwc2t0MC2C+KWgU2ngIi9MX9Lu13hxDg=;
        b=FLlplzL3sFCY3dyribL+aFb6B/XApKkBGnimLv9Zp+MPNmz4ZEn/l0tItxKpod+Bfj
         0md4gdJhZnb1qe9sUCPNbgBQ8LjjT277546dpY7bhIrqiyZ1Ylfljosq9MK/JEQAHXQM
         0g7IykZ/NF+/ZULSmXwuXEYI4DgPcehY0uac52/Co1dnCs+MZARBrz0/eYedWghVU/Co
         +LBG5nOXXHRoityLfffprjhD2FktRtk4QSOfh22pxNOpuf23bI0XUMKd8FbRe5l1zO2t
         FR3jLzrOI13iSzd47SeXDPntsdUFPyohYplKGGSRKPbgnf7D54SaCRfi0R8khLNxp+0l
         sSdw==
X-Gm-Message-State: AJIora/g2Z5U8AT6TW82LBR983mTTfKK+7X4C0rlo4sCvTSKMp9Qnqys
        pu7M9QfVHSZv44CIYQH/Y0c/fUIMFibzw61ttey2KCkw
X-Google-Smtp-Source: AGRyM1sde/lgvrw43Pirc9OXw/0SMA4bNk6zHco9vLPQ7lQ/y/bKeN4d0BmxOUWONW5WaXcbJzezq3Hu6Wt959TwUZE=
X-Received: by 2002:a25:6a57:0:b0:66e:c1bf:4a2 with SMTP id
 f84-20020a256a57000000b0066ec1bf04a2mr40864219ybc.263.1658429915490; Thu, 21
 Jul 2022 11:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru>
 <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com> <87a692e8vj.fsf@vps.thesusis.net>
In-Reply-To: <87a692e8vj.fsf@vps.thesusis.net>
From:   Hilco Wijbenga <hilco.wijbenga@gmail.com>
Date:   Thu, 21 Jul 2022 11:58:24 -0700
Message-ID: <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
Subject: Re: Feature request: provide a persistent IDs on a commit
To:     Phillip Susi <phill@thesusis.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 21, 2022 at 9:39 AM Phillip Susi <phill@thesusis.net> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > This has come up a bunch of times. I think that the thing git itself
> > should be doing is to lean into the same notion that we use for trackin=
g
> > renames. I.e. we don't, we analyze history after-the-fact and spot the
> > renames for you.
>
> I've never been a big fan of that quality of git because it is
> inherently unreliable.

Indeed, which would be fine ... if there were a way to tell Git, "no
this is not a rename" or "hey, you missed this rename" but there
isn't.

Reading previous messages, it seems like the
after-the-fact-rename-heuristic makes the Git code simpler. That is a
perfectly valid argument for not supporting "explicit" renames but I
have seen several messages from which I inferred that rename handling
was deemed a "solved problem". And _that_, at least in my experience,
is definitely not the case.
