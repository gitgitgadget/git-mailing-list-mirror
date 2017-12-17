Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B7A31F404
	for <e@80x24.org>; Sun, 17 Dec 2017 18:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757306AbdLQSD0 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Dec 2017 13:03:26 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33205 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757207AbdLQSDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Dec 2017 13:03:25 -0500
Received: by mail-wr0-f196.google.com with SMTP id v21so1423618wrc.0
        for <git@vger.kernel.org>; Sun, 17 Dec 2017 10:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IBEVJEiK+RgVbZb/m1PUGTlNT280LRJMdB2nMCizLAg=;
        b=TOv22g77s+u54AhVHksO6jjdfh+I8D+Ir5adAPToW4dLaVoonA2YxlSflN7pHmq9b+
         /69ech8t5TmdEnAcBrXjMpdraCaZwEpHplEYsONMdb6gMZYxbvGv18/AHT1xYFnArw2C
         SBiaUVYuck5FvnJ1JPYc2cU0Tex88eZ/1Ra7EN+VRh2yyiwyt9FJ5RtUlEX3N18bHC8+
         Hgeq5LIzVD6YDcqxbcI39UQ5MZO1YLLyTiectjvEZHhIbEdjt083eKghkTjwpHZXa03z
         g5W9DH+W7NYiptQlCctHOcE/Kvk9JUVgH+Qml7IXMSarA36gvgHNLdauCq81xhDAP02c
         byEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IBEVJEiK+RgVbZb/m1PUGTlNT280LRJMdB2nMCizLAg=;
        b=JY6Z+tys7DAqX9fAN1SlJ+FWhKlTkYnDQ4YqFk9BmhM7wX0uWFZc0TtNBQAQ4ZEVci
         MIV/o5lm9QKgWHvYuogj5SaQQ7qDQ4rRM0luV6z0DXpA5Kj6NoFtvX5S9vDDWoT9gBiN
         evUJqVpP7u9RySHPLpzQgr0vhJeKZthsQgj1jJz2+jznYcBpnwXT0m2j0vQXUgqQshyK
         xC1IboJJEe8jZDQsbXdJpTBl0BNBMVxToJhK82eNKpqrKNpaIeGCsyaWGbTe53+5RJvC
         1QGRUCtt39j0RekUshQn9++Ij3de6oZk5SO8loESS9hZfLrbFkhQvAdzNltUeAM+f9Ot
         dFfg==
X-Gm-Message-State: AKGB3mIZRYubodIW28moK4mPHom2z5K+f70QhS7Q3Qg/1xzktNvMe4aI
        frPiyMSuyV6Mu4AJJlceOZ0=
X-Google-Smtp-Source: ACJfBovv/NGYObgwkVQW6xBzGOnXfk9DWFgHixokvc49CJzgcvavk1JBmxZQBZc/6SPaj6yP9vLGzw==
X-Received: by 10.223.163.133 with SMTP id l5mr16334998wrb.83.1513533803954;
        Sun, 17 Dec 2017 10:03:23 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id 59sm5017907wrs.41.2017.12.17.10.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Dec 2017 10:03:22 -0800 (PST)
Date:   Sun, 17 Dec 2017 18:05:11 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Reid Price <reid.price@gmail.com>, git@vger.kernel.org
Subject: Re: Apparent bug in 'git stash push <subdir>' loses untracked files
Message-ID: <20171217180511.GA2641@hank>
References: <CA+HNv10i7AvWXjrQjxxy1LNJTmhr7LE4TwxhHUYBiWtmJCOf_A@mail.gmail.com>
 <20171213230547.GC24597@hank>
 <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4loqplou.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/16, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Maybe the best solution would be to introduce 'git reset --hard --
> > <pathspec>', or maybe someone who knows shell programming a little
> > better than me has an idea? 
> >
> > diff --git a/git-stash.sh b/git-stash.sh
> > index 1114005ce2..01bf74015e 100755
> > --- a/git-stash.sh
> > +++ b/git-stash.sh
> > @@ -322,10 +322,15 @@ push_stash () {
> >  
> >                 if test $# != 0
> >                 then
> > +                       git ls-files -z >"$(git rev-parse --git-dir)"/stash-to-remove
> >                         git reset -q -- "$@"
> >                         git ls-files -z --modified -- "$@" |
> >                         git checkout-index -z --force --stdin
> > -                       git clean --force -q -d -- "$@"
> > +                       while read -r -d '' to_delete
> > +                       do
> > +                               git clean --force -q -d -- "$to_delete"
> > +                       done <"$(git rev-parse --git-dir)"/stash-to-remove
> > +                       rm "$(git rev-parse --git-dir)"/stash-to-remove
> >                 else
> >                         git reset --hard -q
> >                 fi
> 
> Hmph.  I personally did not care (nor use) pathspec limited stash
> creation, so I admit that I do not offhand know what this code
> (before or after the above fix) is trying to do, even though it has
> been in our tree for some time X-<.

Yeah unfortunately this has been broken for pathspecs that match
untracked files since I introduced it :(

> But judging from the fact that
> the other side is a mere "git reset --hard" (for the whole tree), I
> guess for each and every path in the index and/or in the HEAD that
> match pathspec "$@", you are trying to
> 
>  - remove it from the index if it is not in HEAD;
> 
>  - add it to the index if it is not in the index but is in HEAD; or
> 
>  - reset the index to the version in HEAD if it is in the index.
> 
> and then match the working tree version to that of the index?

That's correct.  That's how I would have imagined 'git reset --hard --
<pathspec>'.

> I am not convinced that "git reset --hard -- <pathspec>" is a good
> UI [*1*] but I agree that a low level facility that does these would
> be quite helpful to implement the then-clause of the above.

Thanks a lot for spelling this out below.  After reading that I
definitely agree that 'git reset --hard -- <pathspec>' wouldn't be a
good UI, and something like that would belong in checkout.

> But I suspect that you do not have to do shell "logic" nor low-level
> plumbing update in this case.  Would the attached work?

Ah interesting, what you have below looks good to me indeed, it
matches what I'd expect it to do and fixes the bug that was reported.
Thanks! 

I've taken the liberty to take what you have below and turned into a
proper patch, giving you authorship of it, as you wrote the code for
the fix.  Hope that's the appropriate credit for you for this patch.

[...]

--- >8 ---
From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] stash: don't delete untracked files that match pathspec

Currently when 'git stash push -- <pathspec>' is used, untracked files
that match the pathspec will be deleted, even though they do not end up
in a stash anywhere.

Untracked files should be left along by 'git stash push -- <pathspec>'
unless the --untracked or --all flags are given.  Fix that.

Reported-by: Reid Price <reid.price@gmail.com>
Test-by: Thomas Gummerer <t.gummerer@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 git-stash.sh     |  5 ++---
 t/t3903-stash.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1114005ce2..a979bfb665 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -322,10 +322,9 @@ push_stash () {
 
 		if test $# != 0
 		then
-			git reset -q -- "$@"
-			git ls-files -z --modified -- "$@" |
+			git ls-files -z -- "$@" |
 			git checkout-index -z --force --stdin
-			git clean --force -q -d -- "$@"
+			git diff-index -p HEAD -- "$@" | git apply --index -R
 		else
 			git reset --hard -q
 		fi
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 39c7f2ebd7..6952a031b2 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1064,4 +1064,20 @@ test_expect_success 'stash -k -- <pathspec> leaves unstaged files intact' '
 	test foo,bar = $(cat foo),$(cat bar)
 '
 
+test_expect_success 'stash -- <subdir> leaves untracked files in subdir intact' '
+	git reset &&
+	>subdir/untracked &&
+	>subdir/tracked1 &&
+	>subdir/tracked2 &&
+	git add subdir/tracked* &&
+	git stash -- subdir/ &&
+	test_path_is_missing subdir/tracked1 &&
+	test_path_is_missing subdir/tracked2 &&
+	test_path_is_file subdir/untracked &&
+	git stash pop &&
+	test_path_is_file subdir/tracked1 &&
+	test_path_is_file subdir/tracked2 &&
+	test_path_is_file subdir/untracked
+'
+
 test_done
-- 
2.15.1.390.ga48b24a585.dirty

