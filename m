Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF48C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 21:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5F97224BE
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 20:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgLSU7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 15:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727487AbgLSU7n (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 15:59:43 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49E81C0613CF
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 12:59:03 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id s2so7095210oij.2
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 12:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=WmoKtqDQMcCdW1YcneeHROiqFAGWk+7wekUGI1uEgM8=;
        b=CckxdQhNYyiw+UptC7Xildas8bfxzniqbYMP4fLwpCnRsQYVIgVbAXBG7jdu4Ta4nW
         YTuyGChmav2vw+c06232krgciLtvY4urHEbPqbuxVcPVFI1xvpHnZnNg1yNS4R6+mdXM
         mehEdCqF84d3g2RWLL0TCtCDS/OKPJu9c+wrBZlPfnwddMB2Wdw5GcDkQ+sOd26E/ixN
         9SM5mM3VlcV7XK84PYwnd8DpfKQp9KTg25EoDjhNJQFoz7Ab5Ldifter9vgiCGCNWRYS
         gp/XKa9zaAhU21VViwtC6OD2+KChku0CrOAqeeahEHkH3kt4b13f66DXrZGViho/FxW0
         qXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=WmoKtqDQMcCdW1YcneeHROiqFAGWk+7wekUGI1uEgM8=;
        b=GAH6FiPGncm4f1rV05ftYpYrTyq4xpcRIcPNaaVW3PVTRFpaQzDkBDae0Ct6YBa/xP
         gFAX3kU0D1RU+rc2ZpjqjMiPgdZ3aAy3dqcRZWiXlrUYfmPNp0EW/mRydcjKpWQVNM1M
         ZLhxgcOmsYsTRW3dwjF4R6Aa+4RQnovIFrkYZu+6rWTgusZ41Mx/AEnr/kXB+D8QBmIT
         sEzG8m8J1sDbb2y+qar8U0XNWB+7EIXzKd8fGJh0zXBWPlwprdDprm7lmodWWVwPpy68
         j40LNXFR8T4ibR7+lrlEwnLQuCG9iZntl6jKS1doztMuSNklO1qXL/DxtP5ELnaZ78NQ
         iKYA==
X-Gm-Message-State: AOAM530p5xlg08fpO8BBGzAOd8ObUPhltL7uffa/fGTYBg2vRadSxi4a
        rAq52p8gN9US/MUCeujN7nJzzBCygHuVYg==
X-Google-Smtp-Source: ABdhPJySPLK3Y5Ls+mDUonpDd+vtNbPws7l/is256HFKtkEsRhrpv5YO+3fUR7i6XNw5IMOygSrE8g==
X-Received: by 2002:aca:b06:: with SMTP id 6mr6660940oil.74.1608411542242;
        Sat, 19 Dec 2020 12:59:02 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id i1sm2852016otr.81.2020.12.19.12.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 12:59:01 -0800 (PST)
Date:   Sat, 19 Dec 2020 14:59:00 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fde69944fe4d_1e50c7208f@natae.notmuch>
In-Reply-To: <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
References: <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <xmqq3603v3a0.fsf@gitster.c.googlers.com>
 <5fdc998216c89_104e15208da@natae.notmuch>
 <xmqqlfdtoch2.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> Another reason why allowing users to disable the feature per tool is
> >> important is because as far as I know we have kept the mergetool
> >> framework to allow adding a tool that can merge binary data, and
> >> leaving these three files pristine was one ingredient for that.
> >> With only a single knob, we would be making a decision to declare
> >> that such a tool is unwelcome, which is not quite acceptable.  I
> >> expect that users would want the new feature most of the time
> >> because they would be managing text files more of the time, and
> >> having only a single knob would force an unnecessary choice on those
> >> who want to use such a binary-capable tool as well.
> >
> > I can't imagine what that binary data could look like, and how any tool
> > could represent that to the user.
> 
> What I had in mind are use cases like merging "comment"-ish part of
> media files (e.g. exif in jpeg, id3 in mp3---things like that), as
> I've heard some people do use Git to manage their photo collection.

Right. They can do that with a text editor.

> Of course, I can imagine that a cartoonist first draws a background
> picture, cop es it twice, and then draws a dog on top of the
> background in one copy while drawing a cat in the other.  You should
> be able to merge the resulting two pictures cleanly by following the
> three-way merge idea (take what got changed on only one side plus
> what did not change--anything else is a conflict) as long as these
> animals do not overlap.  You probably can even do an equivalent of
> -Xours (not --ours) to essentially say which object is closer to the
> viewer in a conflicting case.

The whole point of separating the background from the foreground is that
the foreground can be animated on top of the background, so they would
always be two different files.

Even if we force the issue and make two graphic artists work on two
different branches, what they would inevitably end up doing is work on
different layers, which for all intents and purposes are like two files.
No mergetool is going to help them integrate their changes.

> > But either way "git merge-file" fails on those cases, so we can just
> > check if the file is empty, and bail out.
> 
> Catching failures from merge-file and reverting back to the original
> behaviour would be an improvement, if the code in the earlier
> iteration was not checking errors.  But I would prefer not count on
> the tool always to fail, as there are image file formats that appear
> to be text that are unreadable to humans (like pnm),

git would not add conflict markers on the part of a pnm file that did
not change, so in fact, a person merging pnm files might in fact desire
automerge.

> and my primary reason for configurability is as an escape hatch to be
> used in cases where we do not anticipate here.

Once again: "mergetool.automerge=false" is a thing.

> Listing "what about this case, it does not break" million times would
> not help us here.

This is the philosophical problem of induction: a million white swans
doesn't prove all swans are white.

The only thing we know for certain is that there is no known problem.
And that if and when such a problem occurs, we would need to think about
the proper solution.

> With per-tool enable/disable option, the users do not have to rely
> on failure from merge-file anyway.

They don't have to rely on that failure, they can just turn off
mergetool.automerge.


But fine. Let's the perfect be the enemy of the good. That seems wise.

-- 
Felipe Contreras
