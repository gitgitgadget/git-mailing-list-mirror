Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65701C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF21722201
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 13:46:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgJNNqA convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 14 Oct 2020 09:46:00 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37117 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726459AbgJNNqA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 09:46:00 -0400
Received: by mail-ed1-f66.google.com with SMTP id o18so3197489edq.4
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 06:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kmyePOEh1ckNBfdKFtpsongt8jCXy2jMuoIYqGa2WKw=;
        b=dlCdKPnCwFGYxv3w+TaP8vgbE1feCHdq6YtvSCnB++kwLYTo3XHUTuCVTWfs3MKUtZ
         gqkEzkKrzzQx9Vi2Cs+WHRgwiJi6exz8kQbDvcE3QxcI0hRuwX73lfqMDIkDLee9KGcA
         i+jbfHzJbbrCkE4W8GcKbQgRFHnQvZWbgVFOf56jjwpebusoGuN2PS+HHF0FXOG4w4Kt
         8v03eALgRl4zk2h8AHFIXC3KxOqwEERBvFXcn87mNaDj3ILEh+9giSWkYwKTmBLxB/Ye
         8T5uT2DjWp2PozFrEq6QQnfJm7iaG8uXkXKv1oHIA3jQBHPNGCGyLPzWertwh0xvRUcI
         9C6A==
X-Gm-Message-State: AOAM5314wV59fuH851UNppPdrdsfhafrz9Qume99DECd24HfiaDHdYbq
        Ox+soo7iX63yDx6tmM6wyFRgi1Up2NLah0bHJJFw6iOP
X-Google-Smtp-Source: ABdhPJz+K/fc1/Xv+eykUcfHciW8fzkFVPr3c9PLi4d4GIFw8s1/0DqYlSF5Lle7h1huR4aM5OqUcj4h2nLII/uFgeU=
X-Received: by 2002:a50:cdd1:: with SMTP id h17mr5412643edj.94.1602683158468;
 Wed, 14 Oct 2020 06:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
 <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
 <20201012224706.GA4318@flurp.local> <CC87B74C-5EC2-4129-82A5-2CD0C81188B9@gmail.com>
In-Reply-To: <CC87B74C-5EC2-4129-82A5-2CD0C81188B9@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Oct 2020 09:45:44 -0400
Message-ID: <CAPig+cR3gsqmyM9k1F4waBc8R5Tqj0thw2_7E8Sun-FGV8b1SQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages
 containing CRLF
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>, Alex Henrie <alexhenrie24@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 9:20 AM Philippe Blain
<levraiphilippeblain@gmail.com> wrote:
> > Le 12 oct. 2020 à 18:47, Eric Sunshine <sunshine@sunshineco.com> a écrit :
> > This is somewhat onerous to digest and compose. Have you considered
> > making it more automated and easier to read? Perhaps something like
> > this:
> >
> >    create_crlf_ref () {
> >        branch=$1
> >        cat >.crlf-message-$branch.txt &&
> >        sed -n "1,/^$/p" <.crlf-message-$branch.txt | sed "/^$/d" | append_cr >.crlf-subject-$branch.txt &&
> >        sed -n "/^$/,\$p" <.crlf-message-$branch.txt | sed "1d" | append_cr >.crlf-body-$branch.txt &&
> >        ...
> >    }
> >
> >    create_crlf_refs () {
> >        create_crlf_ref crlf <<-\EOF
> >        Subject first line
> >
> >        Body first line
> >        Body second line
> >        EOF
> >        ...
> >    }
>
> I did not try to do that because I did not think of it.
> However, I think it's clearer using printf, this way '\n' and '\r'
> appear clearly on all platforms, whatever editor is in use
> and whatever settings this editor is using to hide or not hide
> control characters.

Sorry, I'm not sure I understand what you are saying about editors and
hiding or not hiding control characters. There are no hidden control
characters in the example code I posted.

The code I proposed is very explicit about using CRLF terminators. The
here-doc fed to create_crlf_ref() contains only the normal LF, but
then create_crlf_ref() explicitly converts those to CRLF by calling
append_cr().
