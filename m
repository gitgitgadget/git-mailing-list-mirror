Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409D3C433ED
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:44:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E59796136A
	for <git@archiver.kernel.org>; Sun,  4 Apr 2021 05:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbhDDFoT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 4 Apr 2021 01:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhDDFoS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Apr 2021 01:44:18 -0400
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D6CC061756
        for <git@vger.kernel.org>; Sat,  3 Apr 2021 22:44:14 -0700 (PDT)
Received: by mail-il1-x12e.google.com with SMTP id c18so1203411iln.7
        for <git@vger.kernel.org>; Sat, 03 Apr 2021 22:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgZet7Ulv+L5Oy7/e1ajou030xHDe+tqEol3ISTRVt4=;
        b=AX3v+w2Xlv/VmpCyAy+Gfj/decJPlXuJD5NKk1Cpy77CewCFcPa/aOv3KkToYrDVyA
         jg1hSZQfwWE5gUfh+kdo1Ypn2omADjq6GgDjve6X5/wQyd2O2CsrNuPiMNOBhOjvxbm5
         ejhy9S/Q55P2GKhKO70TSAYXM1GWp6pJYVH8Q5M8E12f3hF7tuqv5FWhz94bLjYqfMEE
         MlwbNvpux0mm2jxue6qKKEU8Uk+OPdEMr4wAzsX5bv0KIboKD+8Y7qXuoLmsAgABEVy7
         3q5Zb/m69l7xFxeqPDtPPjtYvwNKdcmUHApMb1MwSfkch5wDqTS90RMcgh7/FerCl2Sw
         vHDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgZet7Ulv+L5Oy7/e1ajou030xHDe+tqEol3ISTRVt4=;
        b=brfhG/R/VjwDABfjJ6WXsYa8h6Ifs2DnG4+dwBTDoSeWqTQeyPdso+8cruXDsk/8RR
         FZ5KlNxPdy5h+fJ55jJeYVEPaUNWvm7w5aukiTf2GiJenEoLUv9YV01NJN2Sz1/tV2in
         lF/OYGXrak1HtYjc+b9FlP2kI3rMw8TZwjRkvXbB3nnxi0fx4CXRscQ7o1wlhmijHfNh
         aL+PNPgkQd0NPf/kWGJhchSxzu2Q/uiN58fJZvf7ZzR4it9lBk2aqNPJkP9adB7UE33Y
         ar1Bwn+f+850XOt/c3xFgag4nCagwIoBM/0uMgjiFLhvBZs837pGis7KaPmUuCvepwGM
         eilQ==
X-Gm-Message-State: AOAM5320p7IYYbzGaqUTf7iCSVnZuIIGjSPj9nLO/PB9mnR/hYtrNCMx
        zq065Cm5GUSAHt/tejHwBT3W/bIXMGfzXeGEbNg=
X-Google-Smtp-Source: ABdhPJwuGULt9F/I2CNs3c5+iQIUJB1PD2y6h8C1yhR7FkiucGx6LW8wYjTlk8l11zIy6ael4ZDibCGnhTe8+60/TW0=
X-Received: by 2002:a05:6e02:f41:: with SMTP id y1mr14976170ilj.259.1617515054308;
 Sat, 03 Apr 2021 22:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <pull.913.v5.git.1617185147.gitgitgadget@gmail.com>
 <pull.913.v6.git.1617369973328.gitgitgadget@gmail.com> <xmqqim544dl4.fsf@gitster.g>
In-Reply-To: <xmqqim544dl4.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sun, 4 Apr 2021 13:43:58 +0800
Message-ID: <CAOLTT8QvPPJ4jYXjch+RhdHDnvDT6Woh2oQoX2LcoiVX_t7jZQ@mail.gmail.com>
Subject: Re: [PATCH v6] [GSOC] trailer: add new trailer.<token>.cmd config option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, Junio and Christian,

> > +------------
> > +$ cat ~/bin/git-one
> > +#!/bin/sh
> > +git show -s --pretty=reference "$1"
> > +$ git config trailer.see.key "See-also: "
> > +$ git config trailer.see.ifExists "replace"
> > +$ git config trailer.see.ifMissing "doNothing"
> > +$ git config trailer.see.cmd "~/bin/git-one"
> > +$ git interpret-trailers <<EOF
> > +> subject
> > +>
> > +> message
> > +>
> > +> see: HEAD~2
> > +> EOF
> > +subject
> > +
> > +message
> > +
> > +See-also: fe3187e (subject of related commit, 2021-4-2)
> > +------------
> > +
> > +* Configure a 'who' trailer with a cmd use a global script `git-who`
> > +  to find the recent matching "author <mail>" pair in git log and
> > +  show how it works:
> > ++
> > +------------
> > +$ cat ~/bin/git-who
> > + #!/bin/sh
> > +    git log -1 --format="%an <%ae>" --author="$1"
>
> Unusual indentation here.  But more importantly, I am not sure if
> having both 'see' and 'help' examples is worth it---they are similar
> enough that the second one does not teach anything new to those who
> studied the first one already, aren't they?
>

This may be an off-topic question:
I wanted to use `shortlog -s` instead of the document example,
But I found a very strange place:
Here we have two shell scripts:

$ cat ~/bin/gcount
#!/bin/sh
if test "$1" != ""
then
git log -1 --author="$1"
else
echo "hello there"
fi

cat ~/bin/gcount2
#!/bin/sh
if test "$1" != ""
then
git shortlog -1 --author="$1"
else
echo "hello there"
fi

If I use them in the terminal, there is no problem with them,

$ ~/bin/gcount gitster
commit 142430338477d9d1bb25be66267225fb58498d92
(interpret-trailers-command-arg, abc5b)
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Mar 22 14:00:00 2021 -0700

    The second batch

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

$ ~/bin/gcount2 gitster
Junio C Hamano (1):
      The second batch

if I use .cmd to run these scripts, the situation is totally different:

$ git config -l | grep trailer
trailer.cnt.ifexists=add
trailer.cnt.key=Cnt:
trailer.cnt.cmd=~/bin/gcount

$ git interpret-trailers --trailer="cnt:gitster" <<EOF
EOF

Cnt: hello there
Cnt: commit 142430338477d9d1bb25be66267225fb58498d92
Author: Junio C Hamano <gitster@pobox.com>
Date:   Mon Mar 22 14:00:00 2021 -0700

    The second batch

    Signed-off-by: Junio C Hamano <gitster@pobox.com>

And if I turn to use gcount2:
$ git config trailer.cnt.cmd "~/bin/gcount2"
$ git interpret-trailers --trailer="cnt:gitster" <<EOF
EOF

Cnt: hello there
Cnt:

It looks like `shortlog` does not write to standard output.
Note that in `short_log.c`, log will be output to `log->file`.
Does it make the above behavior different?
Is there a good solution?


> > +$ git config trailer.help.key "Helped-by: "
> > +$ git config trailer.help.ifExists "replace"
> > +$ git config trailer.help.cmd "~/bin/git-who"
> > +$ git interpret-trailers --trailer="help:gitster@" <<EOF
> > +> subject
> > +>
> > +> message
> > +>
> > +> EOF
> > +subject
> > +
> > +message
> > +
> > +Helped-by: Junio C Hamano <gitster@pobox.com>
> > +------------
> > +
> >  * Configure a 'see' trailer with a command to show the subject of a
> >    commit that is related, and show how it works:
> >  +
