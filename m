Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F01AC201A8
	for <e@80x24.org>; Fri, 17 Feb 2017 01:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755303AbdBQBwS (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 20:52:18 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:36012 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754985AbdBQBwR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 20:52:17 -0500
Received: by mail-ot0-f173.google.com with SMTP id 32so23466106oth.3
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 17:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z1Z3oFJJTFCENJzJbWBCEk/zpAp4eQSlylPHqUSaJfI=;
        b=D0eHUZ5O2rAMxCDa3TBA5cXVPE+P7d5EyFXjeqkeizZX157pXW22Xh2DONA0QN32Ux
         QjjqGaaa1SmC5TMRt/kk/V2BZiF/tTwggScyoc7lfIYnO+LeaHiU2SRJU8XHwxs+zofR
         HQZ3iVlE/VETXz7j/FGaJtWLNZEwSdgO4epsrYFszUawTmeKC0GgNZ5/VKOjvSUHsSZP
         roN0fMV3FV9ZU1BaYHo/1YGkUJf79cDSRrdIEAWBgqu8aMVeGbFm8tgdsVZ6rEW+/kA7
         GRYCkHZjd0HjaSLD35VH6qFtsXD7MIFlRDWNV+UBfBBFJmHqNnLNgWUk0F8Z4XneiWdr
         zibA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z1Z3oFJJTFCENJzJbWBCEk/zpAp4eQSlylPHqUSaJfI=;
        b=IuEaTr5/54+MIYCbh5WK3S4OMYBy2erVoBjx+ynDzVNYsZT81wGfn9rOwHl9RuR3/n
         yQSTB7ik3usjziTAwxen8uP/4rj7XaNVZxUOaISaMTD7z6MItdw2EMGcbofoVHI+wCsK
         dodq6JTZa9Yqic8Mh1yopArXxT6CeBw026/F4B4O/HJEtag/OMn+iTbijMJA0F9HfZJ6
         zVLMCH7d26zKyzrxzkLNgTp1Etmqi4PvDQ5aGtB8aeZNdj8BIIaqVoaRDGC/6lG3Gj9p
         NSjUcJ75XmKAOK1qFcwENrpnLCnf+71mv4Qt6nkTtM4g2sJnWNw50b235sAA4XkQidwF
         xCow==
X-Gm-Message-State: AMke39kBxX5XmoKYZUGduSTDaUmgKFCqP7n2LtjO0suTDnHmTkfP6hl8p2BOaGHdTfKJjsuXJPgoS9vWoQJsbQ==
X-Received: by 10.157.48.47 with SMTP id d44mr3393150otc.111.1487296336685;
 Thu, 16 Feb 2017 17:52:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.50.225 with HTTP; Thu, 16 Feb 2017 17:51:36 -0800 (PST)
From:   Luna Kid <lunakid@gmail.com>
Date:   Fri, 17 Feb 2017 02:51:36 +0100
Message-ID: <CA+-W3ctdRtLpziJ9TX2hqk7RagMyJpHsrfwj=rN7oXQ8EeUPnw@mail.gmail.com>
Subject: `git show --oneline commit` does not do what's intuitively expected
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

tl;dr; --> Please add --no-diff (or --msg-only) to git show. We'll
love you for that. :)

Expanded:

(I've been a casual git user for 2-3 years; "casual" means using a
small subset, nowadays daily, with some less trivial things at times,
like per-commit patching for post-hoc auto-versioning, or
push-deploying (the old way), so not 100% newbie; doing SW for 25+
years. I'm telling this, because I'm probably a representative sample
of a huge number of experienced professionals, who are relatively new
to git (compared to their age...), but already routinely use it in
"survival mode", learning it gradually, on-demand.)

Today I bumped into this issue, which I then tried googling for, and
found it kinda' hanging:
http://stackoverflow.com/questions/17226117/git-show-commit-oneline-not-showing-oneline

The source of the confusion is that git show --oneline insists on
showing the diff, no matter what, while the man page is misleadingly
subtle on that, as illustrated best by a comment on that SO page,
exactly matching my case, too:

    "the answer does not however explain why git show HEAD --oneline
    does not produce an output as stated in the documentation:
    <sha1> <title line> This is designed to be as compact as possible."

Note: I do understand now (after 5-10 minutes of googling in vain,
mucking around with git, re-reading the man page a few times, and
considering the fact that a bug like that in such a feature couldn't
exist for this long -- in fact, this clue helped me more than the docs
+ googling together), that it's indeed, not a bug, but our lack of
intimate familiarity with git and the terseness/wording of the man
page together cause the confusion.

(BTW, just realized: on the git show man page, also the strangely
implied "log of a commit" concept (i.e. in "Pretty-print the contents
of the commit logs") is partly responsible for the confusion. The term
"log" doesn't mean a single event-like item, but a series of entries,
a running record of events. In VCS lingo the established concept is
that "a log is a list of commits", and that's even the case with git,
too, of course. So, readers of the git show man page will have an
impedance match there, and unnecessary difficulties understanding what
is actually going on. My overloaded brain, for example, apparently
opted for just filtering out that part without warning, upon the first
(two) reading.)

Assuming that we (the SO guy + his upvoters + me) are not the only
ones, I'd suggest that instead of perhaps changing the man page,
there's an other easy, also backwardly compatible, and quite
straightforward way to address this: actually implementing that
"unexpectedly missing" feature people intuitively look for.

Please note that "show" is such a profoundly generic command verb,
probably also used heavily in git, especially to show commits, that it
comes to mind as second nature, without thinking, as the primary (or
even as "the only") choice for showing various items in various ways
-- which, in fact, it already properly does, indeed.

Forcing us to use a different command (git log) for a minor sub-case
of the main "show me a commit" scenario (of git show), is highly
unnatural.

Also, --oneline (as all the other formatting options) look and feel
global to the entire context (result) of the show command, so people
who have not yet unlearned to expect that, will be surprised
(unpleasantly).

However, simply adding --no-diff to the git show command (and the man
page) would help a lot. (Something like --message-only or --only-msg
etc., would be more correct (than the "potentially leaky" complement),
but I'm not familiar with the general use of the "only" modifier in
git options and cannot comment on that, but I've certainly seen the
--no-... form at least.)

Thanks a lot, and have a nice next message! :)
Szabolcs
