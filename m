Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA6D21F461
	for <e@80x24.org>; Fri, 17 May 2019 11:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbfEQLLu convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 17 May 2019 07:11:50 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46526 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727975AbfEQLLt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 May 2019 07:11:49 -0400
Received: by mail-ot1-f65.google.com with SMTP id j49so6306240otc.13
        for <git@vger.kernel.org>; Fri, 17 May 2019 04:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=4VUQPGDDOGeN/hxyYnmJ1Q9deecBdIRMCBwtSO78/nw=;
        b=k1J4Kys11wajEESWob12p4xwLa9hrk72Hhh+Oh/fwgbzbqnn/LGgB9FFHggaupUDNw
         +sTk1hMEGFsZ624Likj5pIQZNmAJSptTYRBYLYz1GxpOAkw6Mvw3/07qQ/CEUOkJXqpM
         7XR0NyrdP6w56YUgO5G3Vhmn+x6oBXOsaaO9OAPNCXlxQraIqPEydG8y9sPKaZ8jDGVa
         nyoMAz5ZEqoVddQ/CC2v9r3iWxJCl/H08jQjKP/uc/nEAxXDEjkYyuO1+KK78NaOW4Hb
         dHTVyP0TFzloo/02GT90bLvZrf44QrO4ANWdsDDMsoeClbiv76QDOL7QSF6QwPxSd8AJ
         XwOw==
X-Gm-Message-State: APjAAAWM1Nw5CUzAGdmsFE+ik+M7s+wjd8cRz4FNI/E3edz4aG2FZMri
        SOem74jmEnsYDZSU9HlBy7Nx4Vc8p0EAKT2FKFqO+vRuKjA=
X-Google-Smtp-Source: APXvYqy5uNvgZTTCvYg0GLsGjHHAzYMs9hGgXpG50TnGM0Vknf3/WnOlQN3vMW7nrB2+JAFVZsuvM7N/5qqLCwrBkh0=
X-Received: by 2002:a9d:5618:: with SMTP id e24mr5085197oti.38.1558091508981;
 Fri, 17 May 2019 04:11:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190516235815.13886-1-marcandre.lureau@redhat.com> <1bc4ff0c-4283-a7ff-311f-6415e71bce92@kdbg.org>
In-Reply-To: <1bc4ff0c-4283-a7ff-311f-6415e71bce92@kdbg.org>
From:   =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date:   Fri, 17 May 2019 13:11:37 +0200
Message-ID: <CAMxuvawvoHMSBiGU0kPMF3E4b+63G4KYUAX5a3iVMQh9c6ftnA@mail.gmail.com>
Subject: Re: [PATCH v2] userdiff: add built-in pattern for rust
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Fri, May 17, 2019 at 8:26 AM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 17.05.19 um 01:58 schrieb marcandre.lureau@redhat.com:
> > From: Marc-André Lureau <mlureau@redhat.com>
> >
> > This adds xfuncname and word_regex patterns for Rust, a quite
> > popular programming language. It also includes test cases for the
> > xfuncname regex (t4018) and updated documentation.
> >
> > The word_regex pattern finds identifiers, integers, floats and
> > operators, according to the Rust Reference Book.
> >
> > Cc: Johannes Sixt <j6t@kdbg.org>
>
> In this code base, Cc: footers are disliked.

Noted

>
> > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > ---
>
> > diff --git a/t/t4018/rust-trait b/t/t4018/rust-trait
> > new file mode 100644
> > index 0000000000..ea397f09ed
> > --- /dev/null
> > +++ b/t/t4018/rust-trait
> > @@ -0,0 +1,5 @@
> > +unsafe trait RIGHT<T> {
> > +    fn len(&self) -> u32;
> > +    fn ChangeMe(&self, n: u32) -> T;
> > +    fn iter<F>(&self, f: F) where F: Fn(T);
> > +}
>
> You mentioned that 'unsafe' is commonly used for blocks, and these cases
> should not be picked up. Can we have a test case that demonstrates that
> this is indeed the case?

Ok, I am adding:

unsafe fn RIGHT(inc: u32) {
    unsafe {
        // don't catch unsafe block
        ChangeMe += inc;
    }
}

>
> > diff --git a/userdiff.c b/userdiff.c
> > index 3a78fbf504..8d7e62e2a5 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -130,6 +130,13 @@ PATTERNS("ruby", "^[ \t]*((class|module|def)[ \t].*)$",
> >        "(@|@@|\\$)?[a-zA-Z_][a-zA-Z0-9_]*"
> >        "|[-+0-9.e]+|0[xXbB]?[0-9a-fA-F]+|\\?(\\\\C-)?(\\\\M-)?."
> >        "|//=?|[-+*/<>%&^|=!]=|<<=?|>>=?|===|\\.{1,3}|::|[!=]~"),
> > +PATTERNS("rust",
> > +      "^[\t ]*((pub(\\([^\\)]+\\))?[\t ]+)?((async|const|unsafe|extern([\t ]+\"[^\"]+\"))[\t ]+)?(struct|enum|union|mod|trait|fn|impl(<.+>)?)[ \t]+[^;]*)$",
> > +      /* -- */
> > +      "[a-zA-Z_][a-zA-Z0-9_]*"
> > +      "|[-+_0-9.eE]+(f32|f64|u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
>
> This pattern did not change. Doesn't it still mark "+e_1.e_8-e_2.eu128"
> as a single word?
>
> > +      "|0[box]?[0-9a-fA-F_]+(u8|u16|u32|u64|u128|usize|i8|i16|i32|i64|i128|isize)?"
>
> I still think that you should reduce the complexity of these patterns.
> They do not have to be restrictive to dismiss wrong syntax, just liberal
> enough to catch correct syntax. Let me try again:
>
>         "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"

That seems to be pretty good. It misses 12E+99_f64, but I am not sure
it is worth the trouble of having a second rule for floating for this
case.

>
> > +      "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::")
> -- Hannes

Thanks!
