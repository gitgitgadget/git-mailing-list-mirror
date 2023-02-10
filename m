Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55EBC05027
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 11:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbjBJLUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 06:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjBJLUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 06:20:36 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7592D5274
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:20:35 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id w11so7763973lfu.11
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 03:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f30C/cEDv1WLwAVrne1IWhMrV3ZcIYrXNZNEdpavMU0=;
        b=kFO/p9si4C4jjIvcpZVpc0GcVy3mgLmGvwvohCyBBs6T9P/MTrv1BiDemzv2TS+Ur6
         0pSpKyJu27Mkfdo5sW3P01daXhImJiZbxMqBqIGfG4hFjApmIMW9a1clFX3OwfJF+GOn
         yahktZBxAkwkrpWP0y2NnJpheSas2/yqkaGWkN0GyMu9bfhtUsq7Qz72AUzsV5BBfA40
         3Q6qOtpMcTxfHuHOPEk1l8bZJRhkAQaCvXIMmNAj1mYzKYe+5pXBk1c/DD14hfA0ReUy
         ttj5rQDUrc1iTY+/43qtU3/yr6WCVvnwgeam5f2quu57lPOoCZNBP8ONv0xXjmRASq9q
         evgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f30C/cEDv1WLwAVrne1IWhMrV3ZcIYrXNZNEdpavMU0=;
        b=wnj1VvP9IpMV86w5rob38c2Ue1MC+eqBPNgZgM6Cqs9uG476wb4FsgjW8OYXwqIZ3n
         i/wev0AAFH38K0i3Bf+sEYmKTPhUytVMY5r1Mz2mtJ8lgQYllNq4R52otijYzW2rhCnm
         LqyYw2BTfKf/kO13WZDxQ3RHLDYdTOImYBimAcH+8mWgBeaYphHQsaKTa5Is3cH3F7MD
         9sSlRmmqVaeFEvc9Rvv0qKKSMW3kRtSwBCrDzP+uN+cLEPhVorzN3ay2qr2BPsO6P9fp
         66H6Cxm70hIp3U3uvst0xA/gXbUMUWxQpt3G1MnRg8mCwiyfjiDFaS2Qc4NtWvk8L8rg
         Chwg==
X-Gm-Message-State: AO0yUKVtsOnleMh7UMrJ+1++RZkihb7vHIcpgNjQ1pH74wfHtY/oJd36
        a59RSvjLUEagftgH+qOD9DaFq+SoUy+sMvDbB83kK6SXYQw=
X-Google-Smtp-Source: AK7set86r/82gz7iKn+pFWoeyTFQmSo+xtCRLztA8WLnCDaO/fHGLt7t8tGmm9+ilO9DdCz1lHt0S1h5G2t55MJvV8U=
X-Received: by 2002:ac2:4f8d:0:b0:4d8:696d:6ab0 with SMTP id
 z13-20020ac24f8d000000b004d8696d6ab0mr2792967lfs.152.1676028033594; Fri, 10
 Feb 2023 03:20:33 -0800 (PST)
MIME-Version: 1.0
References: <20230209164552.8971-1-vinayakdev.sci@gmail.com> <CAPig+cT1EtPO2FLvTsw3SjgCgk=ovNwY77hsX6p7ETKiq8aNog@mail.gmail.com>
In-Reply-To: <CAPig+cT1EtPO2FLvTsw3SjgCgk=ovNwY77hsX6p7ETKiq8aNog@mail.gmail.com>
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
Date:   Fri, 10 Feb 2023 16:50:21 +0530
Message-ID: <CADE8NappDSaZrMLeqak4is59oL=X1wJOj2eCLLjaCKyrnoK9PQ@mail.gmail.com>
Subject: Re: [GSoC][PATCH] {apply,alias}: convert pre-processor macros to enums
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 10 Feb 2023 at 16:15, Eric Sunshine <sunshine@sunshineco.com> wrote:

Thanks a lot for replying!

> On Thu, Feb 9, 2023 at 12:00 PM Vinayak Dev <vinayakdev.sci@gmail.com> wrote:
> > {apply,alias}: convert pre-processor macros to enums
>
> Thanks for submitting a GSoC microproject. Let's take a look...
>
> > Groups related #define macros into enums in apply.c and alias.c .
>
> s/Groups/Group/

Thanks for pointing this out. I will keep note of removing the /s/ in
further patches.

>
> > The changed #define macros are related constants, so it makes sense to group them.
>
> They already have a common prefix and are grouped textually, so it's
> obvious to readers that they are related, thus this isn't necessarily
> a good selling point for such a change.
>
> > This also makes debugging easier, as modern debuggers can identify enum constants and list them accordingly.
>
> This is a much better selling point for why such a change would be
> desirable. Unfortunately, though, the real situation is more
> complicated. The stated argument is only true if these enum values are
> assigned to variables of the enum type. However, this patch only
> defines the new enumeration type but never actually uses it to declare
> variables, so the benefit for the debugger is never seen. For
> instance, this patch defines:
>
>   enum binary_type_deflated {
>     BINARY_DELTA_DEFLATED = 1,
>     BINARY_LITERAL_DEFLATED
>   };
>
> but then the code only ever assigns the enum value to an 'int' variable:
>
>   int patch_method;
>   ...
>   patch_method = BINARY_DELTA_DEFLATED;
>
> at which point the enum value's type is lost; it's an `int` and that's
> how the debugger sees it, just as an `int`, so the debugger
> can't/won't show it as an actual enum value.

This is something that I missed, but shouldn't have. I will change the
type of the
variable to enum and run the tests again, as you have mentioned.

>
> To fix this, the patch would need to change the variable declaration, as well:
>
>   enum binary_type_deflated enum binary_type_deflated;
>
> Finally, please wrap the commit message so it fits in 72 columns.

I am really sorry for this error, I was looking to be more descriptive
in the commit
message, but it does seem unnecessary to be this verbose.

>
> > Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
> >
> > vinayakdsci (1):
> >   Change #define to enum in apply.c and alias.c
>
> There should be a "---" line just below your sign-off to tell git-am
> where the patch's commit message ends, but the "---" line is missing
> for some reason. If you didn't remove the "---" line manually, then
> you may need to adjust your patch-sending tool to not strip it out.
>

I will correct this error in further patches, it looks like I did
remove it erroneously.

> > diff --git a/alias.c b/alias.c
> > @@ -44,9 +44,15 @@ void list_aliases(struct string_list *list)
> > -#define SPLIT_CMDLINE_BAD_ENDING 1
> > -#define SPLIT_CMDLINE_UNCLOSED_QUOTE 2
> > -#define SPLIT_CMDLINE_ARGC_OVERFLOW 3
> > +/* #define SPLIT_CMDLINE_BAD_ENDING 1 */
> > +/* #define SPLIT_CMDLINE_UNCLOSED_QUOTE 2 */
> > +/* #define SPLIT_CMDLINE_ARGC_OVERFLOW 3 */
> > +enum split_cmdline_error {
> > +       SPLIT_CMDLINE_BAD_ENDING = 1,
> > +       SPLIT_CMDLINE_UNCLOSED_QUOTE,
> > +       SPLIT_CMDLINE_ARGC_OVERFLOW
> > +};
>
> Retaining the #define lines as comments serves no purpose once you
> have introduced the enum. It's confusing for readers, and there is a
> good chance that the commented-out #defines and enum values will drift
> out of sync over time.
>

I did not remove them in fear of making a mistake in the enum
fields(rookie mistake), but I should
have removed them, your point is absolutely valid.

> If we look at the code which utilizes these values, we see several
> instances like this:
>
>   return -SPLIT_CMDLINE_BAD_ENDING;
>
> which means that the value being returned from the function is not a
> valid enum value since it has been negated. Thus, in this case,
> converting the #defines to an enum makes the code less valid and less
> clear. Moreover, these constants are only used in `return` statements
> from the function, are always negated, and are always returned as the
> exit code of the program itself; they are never stored in variables.
> Thus, the debugger-related benefit mentioned in the commit message can
> never materialize.
>
> So, all in all, I'd say that this is one of those unfortunate cases in
> which conversion from #define to enum is unwanted since it makes the
> code less clear and less valid, and provides no benefit. If you reroll
> the patch, I'd suggest dropping these modifications to "alias.c".
>

OK, I will do so. These technical specifications related to changes in alias.c
are things that I did study about in C, but never actually saw them in
practice, so
I guess I just lowered my guard for such mistakes.

Further, I will change variable types from int to enum in apply.c, which,
as you correctly point out, are still integers.
I will amend these mistakes in further patches.

Thanks a lot!
Vinayak
