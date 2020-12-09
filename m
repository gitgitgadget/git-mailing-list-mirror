Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6F9C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC9B23B6B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 10:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgLIKaS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 05:30:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgLIKaS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 05:30:18 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E0C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 02:29:37 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id i9so1150944wrc.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 02:29:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FLrwIKfMfYSp7BDtPvO7zlxewcs7OabVMglXCv+046U=;
        b=GSQGGZQcdKM07OKk7166A3qPxwEdr1sezVwULChy9NBSzOtdWoXot5qW8sAgLdIJfM
         KOpwhHJ+gW3oFqK0fx41zjgDMBOazZlY8J5QfbnT2dXMoBfGhXHzIq/9sVB2pYHBNxp/
         v4ecRgg137uKUNWxoATK8lOGPVnDUYQkUwL46C+/6OIu0IspVKPUEAm20DFw9J0ELCqb
         +IOllA0fYCQMQq1WOSsh2LC9FkP+zXKyoePqQUV/o7UdG5vOWTGULVSy5j5TWI4HaWSq
         G7E981kLTLGhf2lu8ctEK68O39Tt9je4WbaVAtzHZSlil0DYJ2ItkYnpF3tlxBikDi2r
         rG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FLrwIKfMfYSp7BDtPvO7zlxewcs7OabVMglXCv+046U=;
        b=tWcS3KVnUobH9IDRFeamP/jzDjZACazGCyKHjoMuM7QdGIqeMbK1hzR78eaj19hEC/
         j+MbuUDl/jf8rq3ogpFqmZY/TjjBfKItfBGIWT35qlMZ7OtDwCKQY7AS/S0WxAm3nv7w
         cTufOcGjoF3+0zPFPOThk16a6xzD6P2zFZVzvJ4ZwhzJ9t7xZORNo+vajCes5FHYmIcR
         fVRtt6VIXbNxP9Y5YqW3AncKY+vM/Ph1rQ6YXHuruZ3vTSwviwHIWRebfSCtpucVefAX
         HpEiZmHuWX7wZNzcSUFzElmDMIOLSch1s/XIrz7IAEw/2sj4hWL1axawd846e9QImvP5
         uA+Q==
X-Gm-Message-State: AOAM5313svIiRxSSN/IOuMrE1mH2Np8Ai4mYGrK1SkPepraicaNKiWdK
        l6lCKfUFimcrHtbFaTYtldcgylyBx8E4L2FffBo=
X-Google-Smtp-Source: ABdhPJyZNnVBcwpPujwIDmA8yk6xVDNrPiKZ5PUIFtkYbxhi56TNhX5EAN0ziGNs2Hv3xSTf4m3/wRy4VT5fjdVYbg8=
X-Received: by 2002:adf:ce90:: with SMTP id r16mr1971234wrn.100.1607509776558;
 Wed, 09 Dec 2020 02:29:36 -0800 (PST)
MIME-Version: 1.0
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com> <20201209085356.GJ22416@256bit.org>
In-Reply-To: <20201209085356.GJ22416@256bit.org>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Wed, 9 Dec 2020 04:29:25 -0600
Message-ID: <CAMP44s18FMyJoHogud3QjWGya_9bAB7yAaYUb1aTQ12fYUTNxw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Wed, Dec 9, 2020 at 2:54 AM Christian Brabandt <cb@256bit.org> wrote:

> Felipe Contreras schrieb am Mittwoch, den 09. Dezember 2020:
>
> > +augroup git
> > +     au BufRead,BufNewFile */Documentation/*.txt set filetype=asciidoc
> > +
> > +     au FileType c setl noexpandtab tabstop=8 shiftwidth=0 cino=(s,:0,l1,t0
> > +     au FileType sh setl noexpandtab tabstop=8 shiftwidth=0
> > +     au FileType perl setl noexpandtab tabstop=8 shiftwidth=0
> > +     au FileType asciidoc setl noexpandtab tabstop=8 shiftwidth=0 autoindent
> > +augroup END
>
> This will set filetype specific options. So after this file has been
> loaded, it will set e.g. set tabstop and shiftwidth options for
> filetypes outside of the git project.
>
> Shouldn't this only apply to files inside the git code repository?

Yes. But this file can only be loaded if your cwd is inside this
repository. That is; if "git rev-parse --show-toplevel" shows the same
directory as this file.

> > +
> > +" vim: noexpandtab tabstop=8 shiftwidth=0
> > diff --git a/contrib/vim/plugin/gitvimrc.vim b/contrib/vim/plugin/gitvimrc.vim
> > new file mode 100644
> > index 0000000000..c3946e5410
> > --- /dev/null
> > +++ b/contrib/vim/plugin/gitvimrc.vim
> > @@ -0,0 +1,21 @@
> > +let s:gitvimrc_whitelist = get(g:, 'gitvimrc_whitelist', [])
> > +
> > +function LoadGitVimrc()
> > +  let l:top = trim(system('git rev-parse --show-toplevel'))
>
> trim needs at least vim 8.0.1630. Is this recent enough?

2018? I think that's good enough. If not I'd be happy to include any
other suggestion.

> Could also use
> systemlist()[0] which is available starting at vim 7.4.248 or just a
> simple split(system(), "\n")[0] which should be compatible with vim 7.

Yeah, in Linux. Will that work in Windows where carriage returns are "\r\n"?

> > +  if l:top == '' | return | endif
> > +  let l:file = l:top . '/.vimrc'
> > +  if !filereadable(l:file) | return | endif
> > +
> > +  let l:found = 0
> > +  for l:pattern in s:gitvimrc_whitelist
>
> You could directly use `get(g:, 'gitvimrc_whitelist', [])` directly, so
> the script local var s:gitvimrc_whitelist is not really needed.

True. It's just a force of habit to copy the global scope to the
script scope. That being said; the "for" would call the get() function
multiple times (probably). So I'm not entirely sure what is being
gained.

> > +    if (match(l:top, l:pattern) != -1)
>
> This uses a regex match. Perhaps do a string comparsion? If this is
> needed, consider adding "\C" to force matching case and perhaps also \V
> to force a literal match. Otherwise the options magic, ignorecase,
> smartcase etc are applied to the matching.

This was straight-up copied from another solution. I just checked :h
match() and didn't find any low-hanging fruit.

If you have a better proposal just type it out. I'm not overly
familiar with vimscript, I just know the above works.

> > +      let l:found = 1
> > +      break
> > +    endif
> > +  endfor
> > +  if !l:found | return | endif
> > +
> > +  exec 'source ' . fnameescape(l:file)
> > +endf
> > +
> > +call LoadGitVimrc()
>
> On the style: I personally dislike the `l:` prefix for function local
> variables, as this does not add anything. But perhaps this is just my
> personal preference.

I don't mind either way. I just add it for consistency since the
syntax sometimes doesn't identify such variables (e.g "if !found"),
but most of the time the syntax doesn't do it either way (which is
odd).

So just s/l:// ?

Cheers.

-- 
Felipe Contreras
