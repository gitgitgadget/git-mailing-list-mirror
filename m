Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D30BAC433DB
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 04:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A27F723A5E
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 04:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbhAPEWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jan 2021 23:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbhAPEWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jan 2021 23:22:09 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEEA3C061757
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 20:21:28 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id y4so7073970ybn.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2021 20:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ydLOKTvCEqlMmQ0/NvLpw+qMxYvp+3+ZSbNlsPog1HE=;
        b=Q5l0QpqsWkqU5T9iOhB6atW2AZgstiYO+qDZsj3eONpLVrBe1NhNGMXTvaXtpLJjwC
         EWJQTfQjadCesBecWiOLyOVjgkaEpP0SAfZwT7sMSrgJEl6vkCEsZyVfE46vylHKwciW
         E0R2LjNs3rwG44UDHeyNyfMLsS+ChSOauXGE5gL/ol9Jz4QXZI1GrjAIDF8bltt+o13W
         YhXc29yWKberYAEJLwl1Z3sa2Oyswc+kmr+OJcwEo32Ea5mlhCdROe8kk8E+fpbauFp6
         c4+brQhPiAj3/342g8jlff4zVR6gKaG70B7VF5SwPmdi9JV7fG1ooUPyQEvSjSiAEwNX
         KqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ydLOKTvCEqlMmQ0/NvLpw+qMxYvp+3+ZSbNlsPog1HE=;
        b=nBhW7Y/HRdt0s+GKag1DiFLMpPjaWjcgCaNmbCWSdE7QoRBwwvzAYIbLEA4fqhr30U
         hJB0sRh3IE287GdKHVs70wbLxHE4pwC7gd9JG4iSJnSN1W0lDeH0l6kZ3g+TBSGLT4uF
         TnbiFdAQWksXvOOo0GzZ8lEcoQ+awr93RLS3kZA+d02jFyyBadcqsrqFz2ZF+n6B4iYw
         P8FPli5bdvZez6+UYxI3DM/1R8hP7pLKMjv2ChBcx4f0t+ktwpTrVhhgBGydeen6I3gB
         W3J+oCDnrw0IrWAJm0ugM4g6xxepphh9+TOGdk2CShgO9dw+RMTCQMgHRrkIrhK3syOw
         lBGw==
X-Gm-Message-State: AOAM532xd+Fs5BR8IyUKS8OxQqIxjoI4qF8soXrpPAGo50aQJqTlLdWL
        oo6vYJksL2Ht9ZWmH5w6Pio/QMDOvs6zo5SU0tnCIaQK
X-Google-Smtp-Source: ABdhPJxkTcj1CbyDkc+lnTZgXEH8ipL0NrzqhoRJ9S1SlWpgS/tgukWFxdcpTB1sfeHBDx9kQIsYmMM1d6aKC2g+qwI=
X-Received: by 2002:a25:9906:: with SMTP id z6mr21462135ybn.238.1610770888155;
 Fri, 15 Jan 2021 20:21:28 -0800 (PST)
MIME-Version: 1.0
References: <xmqqbldpr90k.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqbldpr90k.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sat, 16 Jan 2021 12:21:16 +0800
Message-ID: <CANYiYbGxFt_Yxyk83-rSzXdUMHuK9+tRBtf3BTU8HnmzGrGudQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #03; Fri, 15)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B41=E6=9C=8816=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=889:02=E5=86=99=E9=81=93=EF=BC=9A
> * jx/bundle (2021-01-11) 3 commits
>   (merged to 'next' on 2021-01-14 at 749a907dd2)
>  + bundle: arguments can be read from stdin
>  + bundle: lost objects when removing duplicate pendings
>  + test: add helper functions for git-bundle
>
>  "git bundle" learns "--stdin" option to read its refs from the
>  standard input.  Also, it now does not lose refs whey thy point at
>  the same object.

s/whey thy/when they/

--
Jiang Xin
