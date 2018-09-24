Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410DC1F453
	for <e@80x24.org>; Mon, 24 Sep 2018 19:15:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731532AbeIYBTA (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 21:19:00 -0400
Received: from mail-yw1-f48.google.com ([209.85.161.48]:34248 "EHLO
        mail-yw1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbeIYBTA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 21:19:00 -0400
Received: by mail-yw1-f48.google.com with SMTP id m129-v6so2552169ywc.1
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cPmWjnmeTcp8OFVCUo1hAXuaKZKIWjm1Gic5DV/mZ7k=;
        b=YQbCoKImtwp2LCb/HV9T3QtIhVHtLQXVeWjHdg5v5pZ9HmaQXHstg1SpdsUfvBO4pj
         KxnmZSq2mKzNE9AFMs/XHmFf6Eom0BEzPHXxUruhKEbIIBW/cQqA7W8bP3+KqJP5bPh6
         tOje4+POdBWXDFH40vMz2YoGYvO6DjpzbRaEcL8Yz7THEsoUbAaDINF9NiqraA0P159q
         ubkXklAf8a0y7s2ruHbpofe1839bbcnH+c1FpLqRgA2QzPsx9KmbZJS/6sG4UVEXVoKW
         JEA+0lD2xp/V5JkoSIaBtawMkIlihJcu5dtxcFkfxquHsOx7DA+wYNJeGMpqpsnSSPGQ
         XPgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cPmWjnmeTcp8OFVCUo1hAXuaKZKIWjm1Gic5DV/mZ7k=;
        b=fCLvAHj/LGSenb57x5nUItRJEru32hnPS77Q+A6+K7rtgjGLKw/POMdLDHEjSLR2md
         lb0puyxzRwVPM66sYJeB9Sc2dylP8uOxWSU/KFjn/j64AUQCRURB7SifpjibjGNdgfiJ
         CU3qiGOWHxtDIjGtqJJiA1tDWCOp15ll2uDxis3iK5vUEF3NPNBZ8xsGZHyEmdbGs2/Y
         khbOLdCjFIZkPv46jNZtP6TqgutG7tPV2Ci1DwTWW/8KU6Rc6a/fYO5QdKwX+uUppBsf
         wHMUEKXHE7MjYpCLyVXfXCFDSSplpf+dr92SkXBjKMmTxP61zHIj6q5SPlYRRlHEKtd1
         DMXw==
X-Gm-Message-State: ABuFfoj7M9Yf7X1e8dCLRZjUhjTV8/2qJKX/D9WNQUw7vAHezvydflEk
        s7CnO5x1/WwqER2sC/ezjVq1wpW3tZmbLSvrVhe3YQ==
X-Google-Smtp-Source: ACcGV60xRz9NNKrjzDJu7f8qGZMHW3uk5aeFBAEJgVGUoKTRW05xJy2h1/a1KNBGoCIbIYhG/oiFXtVF7v8oLVSH2is=
X-Received: by 2002:a81:5710:: with SMTP id l16-v6mr122068ywb.3.1537816521902;
 Mon, 24 Sep 2018 12:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <EE3D88E4-EF86-44E2-811D-535C8F19C51A@gmail.com>
In-Reply-To: <EE3D88E4-EF86-44E2-811D-535C8F19C51A@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 24 Sep 2018 12:15:10 -0700
Message-ID: <CAGZ79kZg8YLhNBoYJsB4ksbBtEMj3JvHs-qH7w930FiBDeVekQ@mail.gmail.com>
Subject: Re: "git rev-parse --show-superproject-working-tree" fails with
 "fatal: BUG: returned path string doesn't match cwd?" if supermodule has
 unmerged changes of the submodule reference
To:     sammck@gmail.com
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 24, 2018 at 10:59 AM Sam McKelvie <sammck@gmail.com> wrote:
>
> I experienced this problem using git 2.17.1; however, from inspection of =
the next branch, function get_superproject_working_tree() in submodule.c ha=
s not changed in 2 years.
>
> I believe the problem is related to the fact that when a merge of the sub=
module reference is in progress, "git --stage =E2=80=94full-name <submodule=
-relative-path>=E2=80=9D returns three seperate entries for the submodule (=
one for each stage) rather than a single entry; e.g.,
>
> $ git ls-files --stage --full-name submodule-child-test
> 160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1       submodule-child-t=
est
> 160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2       submodule-child-t=
est
> 160000 e6178f3a58b958543952e12824aa2106d560f21d 3       submodule-child-t=
est
>
> The code in get_superproject_working_tree() uses the =E2=80=9C-z=E2=80=9D=
 option on ls-files, so it expects null-byte termination between entries. H=
owever, the computation of super_sub_len:
>
>                 super_sub_len =3D sb.buf + sb.len - super_sub - 1;
>
> will only work when there is exactly one entry returned. If this line is =
changed to:
>
>                 super_sub_len =3D strlen(super_sub);
>
> then only the first returned entry is used, and the bug is resolved.
>
> strlen() should be safe to use here because strbuf_read ensures the resul=
t buffer is null-terminated.

This is good analysis of the issue. Thanks for writing it up!
Would you also mind to send a patch fixing the problem?

I agree that using strlen should work. I do not recall why I
did not use it at the time of writing it.

Thanks,
Stefan
