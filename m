Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B8DC433DB
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 11:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ACD227BF
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 11:18:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgLULSN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 06:18:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgLULSN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 06:18:13 -0500
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00670C0613D3
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 03:17:32 -0800 (PST)
Received: by mail-ot1-x32f.google.com with SMTP id x13so8498536oto.8
        for <git@vger.kernel.org>; Mon, 21 Dec 2020 03:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=H4FJLZtGajbBy8a7u/it13oH/nAhL/26QltoqawNnDo=;
        b=izaxyvwYydAtWjSdsDW6kGpE4mjVEfe4XIsRJNxUohYrLymoiKBVGOgDb/UbR7pQzc
         U6mpJGeFHGkTjR0Z85Y3tBfGYop4S6kYNH2TB5WwulH0yFzPwc7wxIwGLEg0inRbjYxx
         eFphLnvWucX2MWDq0iiZKUfQIQW3qqrsWpFQwyXVV5iWWBXAZ1xTzHkFbcVhq94EW4n6
         wsxMnQ4Ce+L/OifUalebhoKvRSnsIKY62SshWA/JA9aomKhReErcQs63yc+rLHfGo3zX
         e9oI8YLTbhSHKBqToPpnK28ecTMwViJxlW02RsT2MGt3b6HtnvO37ATQiv4h9G+9+b7F
         VHHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=H4FJLZtGajbBy8a7u/it13oH/nAhL/26QltoqawNnDo=;
        b=OFc8YVJixeZxklHHbiaKonyqaAhwL4PqHQJpdwDHVtN3w4pVZESp36zo2r2ppsCWhH
         rdymdFe2I0RFhAY6/H36gQNgD8xVJHaTMV2C1Mu5MPZb3EvKZZNw4Ka1wbBu6ZkfM2Cl
         ij3YohiczShuDN2uneMw45XT8eFyUMJnRu497OCNC8OvEzYwsmNs0k7fQTfwgHqExfxa
         xUkCMzrWVsp5AZ9I3gSjLx0Ym1+iQlbppGvJxxdF01ElHOlyNyMF/Mo9W5fdL02KmYGZ
         eA/0+dM1iZ7E8+jC1YdUaIpLrDoJBvbfhn1PKEQpUVvBuMoBxFyfG8Cu5JRy8QIElWM2
         SdEA==
X-Gm-Message-State: AOAM5316NVCECoRuN9CCGV1SE4uPWKVVoxBSxbkd9LOrKtEOW+XCfdTA
        r7p9EZB300A3fb8Uo1Cqvnk=
X-Google-Smtp-Source: ABdhPJyz3YT51d59isLABFuOFD0K3LCpdq8/Z/P1Gsb6AXgaRpclygwevBI0vRoWW8tmmeuN2qMbXQ==
X-Received: by 2002:a05:6830:1398:: with SMTP id d24mr12130380otq.199.1608549452257;
        Mon, 21 Dec 2020 03:17:32 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 8sm3865958otq.18.2020.12.21.03.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 03:17:31 -0800 (PST)
Date:   Mon, 21 Dec 2020 05:17:30 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Seth House <seth@eseth.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        git@vger.kernel.org, David Aguilar <davvid@gmail.com>
Message-ID: <5fe08449f3bd1_9b3120865@natae.notmuch>
In-Reply-To: <20201221073633.GA157132@ellen>
References: <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
 <20201221042501.GA146725@ellen>
 <5fe033e0ec278_96932089d@natae.notmuch>
 <20201221073633.GA157132@ellen>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Seth House wrote:
> On Sun, Dec 20, 2020 at 11:34:24PM -0600, Felipe Contreras wrote:
> > I disagree. It's fine if you don't want to participate, but the fact
> > remains that the position that some tools would want to turn this off
> > hasn't been properly defended.
> 
> If you are _genuinely_ interested in the answer to this question,

It's not about an answer to any specific question, defending a position
requires for you to answer any subsequent questions, like the one I made
here [1], which you never answered.

> please read the section in my post titled "Conflict Resolution"
> followed by the sub-section "Custom Merge Algorithm", and finally
> "Merge algorithms" [1] on Wikipedia.
> [1] https://en.wikipedia.org/wiki/Merge_(version_control)#Merge_algorithms

I had already read your blog post, and OK; I read that section in
Wikipedia.

> Then pretend you want to write your own conflict resolution algorithm
> for a new mergetool you've been dreaming up and ask yourself what
> versions of the conflicted file your tool will need.

I don't dream of writing my own conflict resolution algorithm, but if I
did it, would be to be used *before* the mergetool, before git makes the
decision to bother the user to resolve the conflicts manually, before it
decides there are actual conflicts, and before it writes the conflict
markers in the file.

In fact, it would work without any mergetool, that way the people that
like to edit the file directly (which you mentioned in your blog post
are actually the majority of your coworkers) can benefit from such
an algorithm.


I answered yours, now you answer mine [1]. What happens if you remove
the first paragraph of your make-conflicts.sh script?

Would a user have the chance to run "git mergetool" in those situations?

  echo "The frumious bandersnatch!" > BASE
  echo "The frumious bandersnatch!" > LOCAL
  echo "The frumious Bandersnatch!" > REMOTE
  git merge-file -p LOCAL BASE REMOTE

> Right now the algorithm Git uses is pretty best-in-class so it might
> seem unlikely that someone would want to write one of those.

And yet that's what Elijah Newren is doing with his merge-ort proposal
which is flying right now.

You want these algorithms to run in "git merge", not "git mergetool".

> However a whopping *seven* of the tools surveyed do just that.

Because they are used in other situations, like working with subversion,
not just in git merge conflicts.

> Some of them even do a pretty good job (I've tried to point those out
> in the reviews).

Better than git?

> You're preoccupied with identifying a specific "adverse effect" but this
> debate isn't about that -- it's about giving individual tools the option
> to choose how they are used.

Yes, individual *real* tools that either exist, or could actually exist.

> If people out there want to try and write a better algorithm than Git,
> I want to see them try.

Yes, and we want that algorithm to be used *before* the mergetool.

Moreover, if any merge algorithm hopes to do better than git, it would
require more than just 3 versions of the file; it would require to look
at the commit graph.

If you somehow managed to create such an algorithm that is better than
git, you certainly wouldn't give it out for free, and it wouldn't be on
a puny mergetool to be used only when git thinks there are conflicts; it
would be a solution to be used *at every merge*.

And that's what a *real* tool, Plastic SCM [2], does; it's a complete
solution that claims to have a better merge algorithm than Git.

> That's the point I've been trying to drive home and that's the point
> that David also made in his last reply to you.
> 
> On that note: you replied to David and said:
> 
> > [Y]ou spend your time implementing this on top of my patch. That way
> > it's clear who made the mistake.
> 
> I plan to start work on exactly that tomorrow. You made the initial
> patch so if you'd prefer to take it over the finish line yourself I'll
> defer. But if you're not interested then I would be happy to credit you
> and finish it.

It is already at the finish line (I just need to update the commit
message).

If you take my patch and add a bunch of unnecessary code, then remove my
'Signed-off-by' line, because I don't approve of those changes.

Better yet; add *your* changes on a separate commit on top of my patch.
That way it's clear who did the meat of the changes, and who did the
unnecessary ones.

> > Thanks for doing this, but unfortunately one of the most popular isn't
> > listed there: vimdiff2.
> 
> It's under the Vim section. Use the page search in your browser for
> "vimdiff2".

It says "The vimdiff, vimdiff3, and vimdiff2 mergetools are not
individually detailed because they're all variations on the same theme".
So yeah; no screenshots.

And I disagree; vimdiff2 looks completely different from vimdiff. If you
have to choose one, you should choose vimdiff2, which is what everyone
in the reddit thread you posted on r/git told you they use, not vimdiff.

You shouldn't deliberately chose the worst option that nobody uses.

Moreover, the main view of your mergetool can be considered a variation
also, I can replicate the behavior with the following vimdiff4:

  "$merge_tool_path" -f -d -c 'wincmd l | %d | read #1 | 1d | bd 1' \
    "$LOCAL" "$MERGED" "$REMOTE"

Does that mean diffconflicts shouldn't be listed either?

Of course not; just add vimdiff2.

Cheers.

[1] https://lore.kernel.org/git/5fdd4f22c473b_1d952220844@natae.notmuch/
[2] http://blog.plasticscm.com/2011/09/merge-recursive-strategy.html

-- 
Felipe Contreras
