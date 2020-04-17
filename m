Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C088CC352BE
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD44208E4
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OokahVA8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730347AbgDQJmC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgDQJmC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 05:42:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C76C061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:42:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id n4so1102338ejs.11
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R8rVddOXxY32MBpypJS28bQWRMCv/o3ToFqWsuqbWzw=;
        b=OokahVA8IW91Qvn4szkrReauHF0y2X9VjgFWnU8488V+3kd3k0E4GxnzeM04awmPkK
         MYrDOLuzd/q+DW6TE76FZqzxWSqPwqkZJhJrzQKuNIrhrQ5BO1/zXRbFMRX6WXO6sb10
         K9k2UmuCHws8ro5UDEaRgSxnmDnFzG6Pxp/JxRa9PpaMMJOA0FCQhfKJwm2bv17L9cJf
         oGJGPRq/OpzHniSj+1AtBdKvtReM51TGQTygos0LxtIzpo7X6w9l0JG5x0325FTiFxjh
         2XUiG6atp6E+LPpyaGGyuEplkqhpUfI+ehfTWW6SXdDw9b01PQPH9VfkT+GOPFv3uHpr
         H3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R8rVddOXxY32MBpypJS28bQWRMCv/o3ToFqWsuqbWzw=;
        b=HXmMsaW4JXZDDXYhh0H0rlmVDvyDuO9fZS2H51gImf8yYpjir4jFAMj70mR+cSkpId
         VRjuCI6QM65kXRByyJqngGiD86Fqf5iPnsUe6YIy2iRcvNEK7lXCp3Chl5TYOOnBSd42
         vWlcOv7OB63emL12GGpxy4Nthjr0aCVwOXGERrZ7GZ4i2QyAqyA4eYswIJe0bU1l+1D1
         oMZBtXdXgLdEUwArf9eURBYbL/kf94PYbrEZuMCJFp8t5Ex9RgZFH31RhdtU216PtzPo
         vpTvxDEDXpzzFvKZMGI/TifWA+NFCD8BAdWQr2ip8zJnkyz7i31+OY9i5kwDqtpx8MdS
         alwg==
X-Gm-Message-State: AGi0PuZIIPehmpplPhshTQkoEc+dVvU+9TzVnc5xOTJ4cKRNr4ud5m6K
        XW5S6jURSyYsZNSr4KEOStSIkZ0Qj0e9Ldl35V0=
X-Google-Smtp-Source: APiQypKGsEJWfH34Ue6t07keZXfHVQv1Yxdnecxo2R5Gf8sMnPagWDQYAQkxFa2OEBbybvfh0gnSM8zcLspQjQxxLHk=
X-Received: by 2002:a17:906:eb90:: with SMTP id mh16mr2151010ejb.201.1587116520041;
 Fri, 17 Apr 2020 02:42:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD0wJo4onz0_Vw4-bcX1h61=J=ZiKfM-fMXLj4B9q0aveg@mail.gmail.com>
 <cover.1584477196.git.me@ttaylorr.com> <20200318101825.GB1227946@coredump.intra.peff.net>
In-Reply-To: <20200318101825.GB1227946@coredump.intra.peff.net>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Fri, 17 Apr 2020 11:41:48 +0200
Message-ID: <CAP8UFD3v_J3zGqHKa94d71QB82hTsX0MZasERB-jOnY3Ya-uJw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] upload-pack.c: limit allowed filter choices
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git <git@vger.kernel.org>,
        James Ramsay <james@jramsay.com.au>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor and Peff,

On Wed, Mar 18, 2020 at 11:18 AM Jeff King <peff@peff.net> wrote:
>
> On Tue, Mar 17, 2020 at 02:39:05PM -0600, Taylor Blau wrote:
>
> > Of course, I would be happy to send along our patches. They are included
> > in the series below, and correspond roughly to what we are running at
> > GitHub. (For us, there have been a few more clean-ups and additional
> > patches, but I squashed them into 2/2 below).

Thanks for the patches, and sorry for the delay in responding!

> > The approach is roughly that we have:
> >
> >   - 'uploadpack.filter.allow' -> specifying the default for unspecified
> >     filter choices, itself defaulting to true in order to maintain
> >     backwards compatibility, and
> >
> >   - 'uploadpack.filter.<filter>.allow' -> specifying whether or not each
> >     filter kind is allowed or not. (Originally this was given as 'git
> >     config uploadpack.filter=blob:none.allow true', but this '=' is
> >     ambiguous to configuration given over '-c', which itself uses an '='
> >     to separate keys from values.)
>
> One thing that's a little ugly here is the embedded dot in the
> subsection (i.e., "filter.<filter>"). It makes it look like a four-level
> key, but really there is no such thing in Git.  But everything else we
> tried was even uglier.
>
> I think we want to declare a real subsection for each filter and not
> just "uploadpack.filter.<filter>". That gives us room to expand to other
> config options besides "allow" later on if we need to.
>
> We don't want to claim "uploadpack.allow" and "uploadpack.<filter>.allow";
> that's too generic.
>
> Likewise "filter.allow" is too generic.
>
> We could do "uploadpackfilter.allow" and "uploadpackfilter.<filter>.allow",
> but that's both ugly _and_ separates these options from the rest of
> uploadpack.*.

What do you think about something like:

[promisorFilter "noBlobs"]
        type = blob:none
        uploadpack = true # maybe "allow" could also mean "true" here
        ...
?

> > I noted in the second patch that there is the unfortunate possibility of
> > encountering a SIGPIPE when trying to write the ERR sideband back to a
> > client who requested a non-supported filter. Peff and I have had some
> > discussion off-list about resurrecting SZEDZER's work which makes room
> > in the buffer by reading one packet back from the client when the server
> > encounters a SIGPIPE. It is for this reason that I am marking the series
> > as 'RFC'.
>
> For reference, the patch I was thinking of was this:
>
>   https://lore.kernel.org/git/20190830121005.GI8571@szeder.dev/

Are you using the patches in this series with or without something
like the above patch? I am ok to resend this patch series including
the above patch (crediting Szeder) if you use something like it.

Thanks,
Christian.
