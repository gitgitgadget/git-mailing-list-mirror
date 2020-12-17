Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31FAC2BB40
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 10:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F3023899
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 10:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbgLQKgO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Dec 2020 05:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgLQKgO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Dec 2020 05:36:14 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031CFC061794
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 02:35:33 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q25so31644146oij.10
        for <git@vger.kernel.org>; Thu, 17 Dec 2020 02:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=6tz786PhWKhVCKF6qc2frhe7jt8fis7jpP3rr90a8dY=;
        b=bFuppVNVrQkA1RE0nvqaV53QQyvIYiCzya5l+kt9wycPVaoeGPBmlx7vRz8Pyj5O3e
         d1nF/KPn4Ufiatbnhu32+jLf5skvY7ms90/uCWFtmdpUSVG3rWfTJkgeJhFa/YnKqpaH
         JNhzb1Mta1F1Au/dC7uJ6o8u+08ocQi4XkHUiX2k++8Ge9BvM+s+beC5EFAaswjagvF2
         GyazaFwrcGj1tC1gCldG3F53OhKVJdx3hBJ+iiVOqkUGBzj6EFotd2NEf5D9V2s21Gl1
         JB41W88dWAcsCi3lu5mKGlgEHvr+vIjdyXCq38zLZzFzrRt7D/XLYgLE3QhG7rW8f/sV
         Zd3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=6tz786PhWKhVCKF6qc2frhe7jt8fis7jpP3rr90a8dY=;
        b=Omwu+Hp3e4g+o9Roc5V2+oat2xeUan8J7DyEyz/m6uUux1JuHL8DlS7Li8gwvEt++R
         RTWqcFdiD/jx2CxXBMr5wEwF+vQoQgatposwNaZrs8RJRRByhDNHIPl5SJEyaOH/VKb7
         mOcRjcAXonOZ97sm42+lgrzfz8/Qi+SUvU1zvoIzrGkji2xB8KLUdt7hJ8fQd20sqXn/
         1rn755yQfWEvrfVT8RTggQgWFjXHx8vkyolQb9OI6c4UTrHcOURNWAl5D6K2x8tKXCQt
         RK0lOI+oe8X1al6uPWN/3HUKUEm8fkwF/zrVsDMPekbUMaVBIDUtte+vd/0sdw1Jb8Jt
         KuiQ==
X-Gm-Message-State: AOAM5336UbVnYfym6LIe6myvDSwieMz73Cd48ezKWSlEzKyaBUEa3OVI
        cQ+pDEVZQbzfPvJ2gSTltKkhWvCO1210ZA==
X-Google-Smtp-Source: ABdhPJzIyoaYu1vmpYxxW5X//mK8sP7ZILiqkn3sIzEu+Q6NitJE4EFu7aKKNUI9/lK4eBxePKqNbw==
X-Received: by 2002:a05:6808:1a:: with SMTP id u26mr4396460oic.77.1608201332263;
        Thu, 17 Dec 2020 02:35:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id p81sm986401oif.30.2020.12.17.02.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 02:35:31 -0800 (PST)
Date:   Thu, 17 Dec 2020 04:35:29 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <5fdb3471c6bb7_d6d032087@natae.notmuch>
In-Reply-To: <20201217094424.GA75257@ellen>
References: <20201216174345.28146-1-felipe.contreras@gmail.com>
 <xmqqa6ud2xuw.fsf@gitster.c.googlers.com>
 <105041520.23756286.1608159189934.JavaMail.zimbra@eseth.com>
 <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> On Thu, Dec 17, 2020 at 08:35:21AM +0100, Johannes Sixt wrote:
> > Where's WinMerge in your list?
> 
> Added. Thanks for the suggestion; I wasn't familiar with it. Let me know
> if I missed anything in my (quick) assessment. The "auto-merge" function
> does indeed produce similar results to Felipe's patch.
> 
> > I would say that this is a hint that post-processing should
> > be moved to the tool drivers, and should not be done at the proposed level.
> 
> That was my thought as well and it didn't occur to me to raise
> a discussion here. However Felipe made the good point that adding this
> functionality in upstream Git would have immediate downstream effects
> for most tools. Almost every mergetool I've surveyed so far simply
> blindly shows a diff betweeen LOCAL and REMOTE (and sometimes BASE and
> sometimes MERGED) and Felipe's patch would have an immediate benefit for
> all those tools.
> 
> There are a few notable exceptions that have their own, internal
> conflict resolution logic -- tkdiff, WinMerge, and (I think) IntelliJ.
> And only two tools make direct use of the conflict resolution that Git
> already performed to produce MERGED -- Emacs+Magit, and diffconflicts.
> Those tools would have to make a decision whether to opt-in to the
> autoMerge flag or not.

Each tool would have to be evaluated individually, but at least from
what I can see your tool--diffconflicts--shows exactly the same diff
with or without my patch, and the `mergetool.automerge` configuration.
It's only the DiffConflictsShowHistory command (which is secondary
functionality, that you didn't even mention in your blog) that gets
affected.

So, yes; *some* behavior is affected, but in my opinion not in a
negative way.

In my view the whole point of "git mergetool" is to resolve conflicts,
so if git can resolve conflicts *before* launching the mergetool, it
should (whether it's rerere or automerge).

> I did not initially like Felipe's patch because I personally want my
> mergetool to use all five of LOCAL, REMOTE, BASE, _and_ the two split
> halves of MERGED. However the pragmatism of it is growing on me. Because
> so many mergetools do simply diff LOCAL and REMOTE this one, simple
> opt-in would positively benefit all of them.

Yes. But other people may want to see the secondary functionality of
your DiffConflictsShowHistory command with simplified conflicts, and
those people can enable the option.

If you want to see the original LOCAL, REMOTE, and BASE, you can turn
off that option (or simply never turn it on).

With the option everyone can have what they want.

I for example can keep using `gvimdiff3`, except with simpler diff
chunks, thanks to your idea.

And for the record; "git mergetool" is one of of those things that you
setup once, and forget about it. My fingers have been trained for more
than a decade (maybe two) on exactly the same configuration, and I
initially didn't think you were onto something.

It's really good that you did setup a test repository with a merge
conflict that showcased the different situations one might encounter. It
immediately became clear to me that you were indeed onto something.

So I give you full credit for the idea, and explaining it succinctly,
that's in the commit message. I just found a way to shove it directly
into "git mergetool".

Cheers.

-- 
Felipe Contreras
