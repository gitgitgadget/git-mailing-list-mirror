Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F66C48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 07:56:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7304D60E0B
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 07:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbhFTH6d (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 03:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhFTH6c (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 03:58:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CE4C061574
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 00:56:20 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x73so11225002pfc.8
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 00:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KIeUxpcntLSQ8kfiEkOvQinso428IqZJtHElvH4obn8=;
        b=WqgGeKAtFVjBi0Ar+6zzg0WxT11dTNjXdMbgBsuGDqWOc+WOi9VTf3Ir0BduZ1vif9
         A+fptZuOtuU3PQWlfHtsc8vKsrWYWPOeVGjTz3d1pEptCKXpiWUki45/yyDhghQ1B7IT
         XEh1VezH7mZr8Rky8tUGJXEjyzfg6ZJSkFu+VnBMncVFimJMJFVyXwxUZN6MdMAHYexg
         puKfekLfhBNIdGW7Elsfv8xk/z1JAoWMpLtrRoUQpe0FbKsojuiAzGMlO8Iko6yVjrIO
         paunvnhZchSnS//otM+ZmrIGKCQ2aSayvXEYfzfmLy6mvzyYGZz1c+BUXirGNjXqyq3e
         w+Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KIeUxpcntLSQ8kfiEkOvQinso428IqZJtHElvH4obn8=;
        b=rJNFuVUDzU0X2URk638tOLnkAzbw5evs8SiqZgyKfsZ9k0l2La0/7Mh59hsBpDc7P2
         4GcZNZoPQISaqamyFtCRd2hbvOg9z98rLSwUKW9e50soAzyF8N/fUDd7zGPDNMCE+3t4
         ZVVEi7z0tTFteP9Rl/ZLqHXfvV/7iLwcY9Zx2++WA7BvYDd4EgVSJR6t8OJ5sBvaVgSc
         7vpd6ksjZa6v0anzZpcbpqyB0E8Ct67csCRGZ4il1ICiV2Q2GTKxMjeigoIj7MiM1RVz
         mLYUuU8bwVjuYsVK26QDBXDXhI9BOmpdESA6+C17rVheq7SMwBw8HI1xeh3x6+NB5XjQ
         Mmbg==
X-Gm-Message-State: AOAM533NrRrkYYcCePgY8AFYcRoOe5X0/plXoFBx+WJHs0ltJqM4iSUG
        VVBykqYFZtu/iflCXpwjK+s=
X-Google-Smtp-Source: ABdhPJwlhHeQ38h9UNePvktYA93uXnmKTnX1J6RlEQ8nWyy7Ag5B/Bb3Zegbqg3DrGLA/bUoP4aQVg==
X-Received: by 2002:aa7:8bd6:0:b029:2ec:7dc9:77e3 with SMTP id s22-20020aa78bd60000b02902ec7dc977e3mr13895918pfd.62.1624175780115;
        Sun, 20 Jun 2021 00:56:20 -0700 (PDT)
Received: from localhost.localdomain (122-116-111-188.HINET-IP.hinet.net. [122.116.111.188])
        by smtp.googlemail.com with ESMTPSA id p4sm5933556pff.148.2021.06.20.00.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jun 2021 00:56:19 -0700 (PDT)
From:   "dorgon.chang" <dorgon.chang@gmail.com>
X-Google-Original-From: "dorgon.chang" <dorgonman@hotmail.com>
To:     gitster@pobox.com
Cc:     dorgonman@hotmail.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH] git-p4: fix failed submit by skip non-text data files
Date:   Sun, 20 Jun 2021 15:56:07 +0800
Message-Id: <20210620075607.1228-1-dorgonman@hotmail.com>
X-Mailer: git-send-email 2.30.1.windows.1
In-Reply-To: <xmqq35tel5ad.fsf@gitster.g>
References: <xmqq35tel5ad.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> [On the Git mailing list](https://lore.kernel.org/git/xmqq35tel5ad.fsf@gi=
tster.g), Junio C Hamano wrote ([reply to this](https://github.com/gitgitga=
dget/gitgitgadget/wiki/ReplyToThis)):=0D
> =0D
> ```=0D
> "dorgon chang via GitGitGadget" <gitgitgadget@gmail.com> writes:=0D
> =0D
> > From: "dorgon.chang" <dorgonman@hotmail.com>=0D
> >=0D
> > If the submit contain binary files, it will throw exception and=0D
> > stop submit when try to append diff line description.=0D
> =0D
> OK, that explains how the program fails.=0D
> =0D
> > This commit will skip non-text data files when exception=0D
> > UnicodeDecodeError thrown.=0D
> =0D
> If there are changes in aText and aBinary file and you try to submit=0D
> a cl that contains both changes, you do want changes to both files=0D
> go together, no?  If you skip non-text, does that mean you ignore=0D
> the changes to aBinary file and submit only the changes to aText=0D
> file?=0D
> =0D
=0D
> I guess my confusion comes from not understanding what you exactly=0D
> mean by "append diff line description".  Whatever that means, if=0D
> that is purely informational and does not affect what is actually=0D
> submit in the resulting cl, then the patch would be an improvement.=0D
> If not, and if for example it loses changes to binary files, then it=0D
> is merely sweeping the problem under the rug.=0D
> =0D
=0D
The skip  will not affect actual submit files in the resulting cl,=0D
the diff line description will only appear in submit template, =0D
so you can review what changed before actully submit to p4.=0D
=0D
> In short the explanation of the solution does not build confidence=0D
> in the readers minds.  You'd need to explain why such a skipping is=0D
> a safe thing to do a bit better.=0D
> =0D
> Even if we assuming that what happens in the loop you threw in=0D
> try/except block is purely cosmetic and optional thing that does not=0D
> affect the correct operation of the program or its outcome,  I=0D
> wonder if we can do better.  When you get a decode error, you'd have=0D
> an early part of the change (which could be empty) before you hit=0D
> the error in newdiff, and that is returned to the caller without any=0D
> sign that it is a truncated output.  I wonder something like=0D
> =0D
> 	except UnicodeDecodeError:=0D
> 		newdiff =3D '<<new binary file>>'=0D
> =0D
=0D
I don't know if add any message here will be helpful for users, =0D
so I choose to just skip binary content, since it already append filename p=
reviously. =0D
=0D
> may be more helpful to the user.  Assuming that this is purely for=0D
> human consumption without affecting the correctness or outcome of=0D
> the program and we can place pretty much any text there, that is.=0D
> But because the proposed commit log message does not explain why=0D
> skipping is safe, I do not know if that assumption holds in the=0D
> first place.=0D
=0D
=0D
=0D
=0D
> Thanks.=0D
> =0D
> > diff --git a/git-p4.py b/git-p4.py=0D
> > index 4433ca53de7e..29a8c202399a 100755=0D
> > --- a/git-p4.py=0D
> > +++ b/git-p4.py=0D
> > @@ -1977,8 +1977,11 @@ def get_diff_description(self, editedFiles, file=
sToAdd, symlinks):=0D
> >                  newdiff +=3D "+%s\n" % os.readlink(newFile)=0D
> >              else:=0D
> >                  f =3D open(newFile, "r")=0D
> > -                for line in f.readlines():=0D
> > -                    newdiff +=3D "+" + line=0D
> > +                try:=0D
> > +                    for line in f.readlines():=0D
> > +                        newdiff +=3D "+" + line=0D
> > +                except UnicodeDecodeError:=0D
> > +                    pass # Fond non-text data=0D
> =0D
> s/Fond/Found/ I would think.=0D
>=0D
=0D
Just fixed the typo, thanks.=0D
