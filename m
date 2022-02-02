Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B770C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 09:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245578AbiBBJvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 04:51:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbiBBJvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 04:51:09 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E0AC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 01:51:08 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id c24so41118110edy.4
        for <git@vger.kernel.org>; Wed, 02 Feb 2022 01:51:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DSzWsapHTA8GotfbHY8tpvJtU2Op7hkqeP/py1Y7DE8=;
        b=LywgkAL7P2syTUR1xQowpSSVI5yd1V1qwB37idC/OZVDQSbXu+M/nDzcCKPaDLFK6A
         QF4aOQCrKeR0H1FAx6Wqki6q73782os2aYP90gjTeudKlyZSr8GcApnJ3raJLVTnc0uj
         T5oxADJl5WPPnKm/MlcTkHwqK9ZOMe6prguLbgoF2emP97rzyesj5qnxVvcg39WkFnbw
         zMfRA6uTSFYzzAMxvYtoQJLUbeWBLMAfWp6153FtI6k5GRGQyMoXmGUu+/O7Pvh5uJam
         MtM4r9W5gVNRv4lVNAwOJXbeL09P2B3rsbUbKuAvWj7q+gZtANCjvCO5f5WNRSJFK8IX
         A7kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DSzWsapHTA8GotfbHY8tpvJtU2Op7hkqeP/py1Y7DE8=;
        b=GOcA8Au9qpip6LY7NUJ/3hrXG/q7ipN0pbh0u0BnmyKMA556H7CS4SvT5+cEIZLNp/
         C6ZGIQkDPgRSLYsohvHDEq3edUZvv7+dMntPAX6S4eZ8ANzaUOyi8J7FUJfqU55zMlJp
         moOLemqjjg5YdZRAbXrzxb2YOE0H4HIo+S8/RHB6yV3k7ZsiT0S6nWR5nrpvON6EDli5
         CFESFYnoq7eRykKKoeTW1xoX2KuSIJKFQh880ct+U3/L8vgG7dt07Z0ACNrxQlIYfIg2
         1OsvQc/RlcdmRPBIx+hzEW0TlK7HSwFZzyyywG4kTUNPmEEmm6rJuS3lzSEZm4lEisQ7
         Ad6w==
X-Gm-Message-State: AOAM531CAO0f2ndsSS4riAPrIZx9XiFGxHJag7gXMFzqBZCM5JBTwvUH
        7H1PQhSDupImjZNxD+fR87IMFPuPc/WTcw==
X-Google-Smtp-Source: ABdhPJzoPuqR2KNYkz6k3WO3GVj+EJu7iIJCXNJsIl2jR4vYaCoYLWD4K7knfb8+kG5y4IT3SaBuGg==
X-Received: by 2002:a50:ec0d:: with SMTP id g13mr8075075edr.427.1643795467206;
        Wed, 02 Feb 2022 01:51:07 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id rh25sm15271423ejb.196.2022.02.02.01.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 01:51:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nFCI5-004U5D-N5;
        Wed, 02 Feb 2022 10:51:05 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <stolee@gmail.com>, meta@public-inbox.org
Subject: Using public-inbox+lei+Emacs+mu+mu4e (was: Large delays in mailing
 list delivery?)
Date:   Wed, 02 Feb 2022 10:34:23 +0100
References: <CABPp-BF_xsOpQ6GSaWs9u9JcnPQT_OXP-gCsAuxPtMj-X1tgOg@mail.gmail.com>
        <211203.86sfv9qwdm.gmgdl@evledraar.gmail.com>
        <20211203202427.o575sgrx4auqkmjp@meerkat.local>
        <211206.867dchr9nt.gmgdl@evledraar.gmail.com>
        <20211206163626.GA4714@dcvr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211206163626.GA4714@dcvr>
Message-ID: <220202.86leyt8uly.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 06 2021, Eric Wong wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> wrote:
>> On Fri, Dec 03 2021, Konstantin Ryabitsev wrote:
>>=20
>> > On Fri, Dec 03, 2021 at 09:02:48PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0=
 Bjarmason wrote:
>> >> When I've experienced delays (sometimes of half a day or more) both
>> >> https://public-inbox.org/git/ and https://lore.kernel.org/git/ have b=
een
>> >> updated.
>> >
>> > Btw, you can source lore.kernel.org straight into your gmail inbox. :)
>> >
>> >     https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-sta=
rted
>> >     https://people.kernel.org/monsieuricon/lore-lei-part-2-now-with-im=
ap
>> >
>> > Or, you can read it via nntp://nntp.lore.kernel.org/.
>>=20
>> [CC'd meta@public-inbox.org, probably best to move this thread over
>> there sooner than later, but CC'ing git@ still in case this is
>> interesting to others]
>>=20
>> I poked a bit at setting this up but couldn't find from building
>> public-inbox.org & trying to page through the docs how I'd get from an
>> existing public-inbox.org/git/ checkout to a local Maildir.
>
> Existing, public-inboxes can be set as "externals" and managed
> via {add,forget,ls}-external sub-commands:
>
> 	# for locally-cloned inboxes:
> 	public-inbox-index /path/to/existing/inbox
> 	lei add-external /path/to/existing/inbox
>
> 	# relies on curl, memoizes data downloaded for each search:
> 	lei add-external https://yhbt.net/lore/git
>
> Local externals will be included by every "lei q" invocation;
> HTTP(S) ones require "lei q --remote"
>
> If you only want to use an external as a one-off without adding
> it, the -I/--include and -O/--only flags are useful:
>
>   lei q -O https://yhbt.net/lore/git -o /tmp/results SEARCH_TERMS
>
>> If you could share some recipe or a pointer to the right docs for that
>> that would be much appreciated. Thanks!
>
> lei-overview(7) manpage documents some things, at least:
> https://public-inbox.org/lei-overview.html  Patches welcome :>
>
> IMHO lei still kinda sucks, and I probably won't have time to
> work on it for a bit :<

Thanks. I finally got around to setting this up.

The above instructions didn't quite work for me, but here's what I did
(in the form of a script lifted from a screen(1) config I've
got). Indented with un-indented comments. The "stuff" is screen's way of
"run this command" (or well, input these characters):

I had a ~/g/git-ml clone already, but this makes one:
=20=20=20=20
    stuff "cd ~/g/git-ml || git clone https://public-inbox.org/git ~/g/git-=
ml^M"

The initial index:

    ## This will create a .git/publici-inbox in ~/g/git-ml. Takes a while
    ## the first time.
    stuff "time public-inbox-index -v \$PWD^M"

I fiddled with this for a bit because it refused to work, turns out it
was missing the .git at the end, i.e. it expected a bare repo[1]:

    ## When we add the lei external it *must* have the ".git" part,
    ## because it'll try to find the "public-inbox" folder at wherever we
    ## point it.
    stuff "test -d ~/.config/lei || lei add-external ~/g/git-ml/.git^M"

A bit of a UX wart not to be able to specify no --limit, or maybe I'm
missing a way:

    ## The one-off massive import of the Git ML. TODO: No way to specify
    ## an infinite limit? Not --no-limit or --limit=3D0.
    stuff "test -d ~/Maildir/lei-q-git-ml || time lei q --limit=3D999999999=
 -v -o ~/Maildir/lei-q-git-ml l:git.vger.kernel.org^M"

The initial indexing:

    ## After the one-off import this will take forever *the first time*
    ## (or around 20m), but subsequent invocations will be fast:
    stuff "time lei up ~/Maildir/lei-q-git-ml^M"

Runs an ad-hoc script to keep it up-to-date, which is quoted below:

    ## Run it in a loop
    stuff "public-inbox-lei-pull-index^M"

That script (which I whipped up just now. Is there a better/more
standard way? to keep a public-inbox+lei pair up-to-date with
sleep/backoff etc?
=09
	#!/bin/sh
	set -xe
=09
	repo=3D~/g/git-ml
	while true
	do
		oid=3D$(git -C $repo rev-parse HEAD)
		git -C $repo pull
		noid=3D$(git -C $repo rev-parse HEAD)
		if test "$oid" =3D "$noid"
		then
			echo Nothing to update
			sleep 60
			continue
		fi
		(
			cd $repo &&
			public-inbox-index -v "$PWD"
		)
		lei up ~/Maildir/lei-q-git-ml
		sleep 1
	done

I use Emacs+mu4e for my E-Mail. And since I index ~/Maildir having these
files dropped in there will be added to its index. Then I just changed
my saved search to also look through that maildir (I guess the entire
first condition could be dropped, but whatever):

    "(maildir:/personal-gmail/* OR maildir:/lei-q-git-ml/*) AND list:git.vg=
er.kernel.org OR recip:git@vger.kernel.org OR recip:git-packagers@googlegro=
ups.com"

Because "mu" is generally good about de-duplicating stuff I've now got
an inbox with mixed messages I can sync from GMail (including my "Sent"
folder), and I get up-to-the-minute ML traffic now (it's bee 10hrs-4day
delayed for 3-4 months at least).

So new messages are generally from the "lei" directory, but when I send
one it'll be dropped in the personal-gmail.

I still need to check if it's doing the wrong thing with e.g. "read"
flags if I read a mail synced via lei that later arrives in GMail. But I
mostly don't use "read" statuses anyway...

1.  Maybe this "I only tested if it complied" patch would make sense to cat=
ch that?

diff --git a/lib/PublicInbox/LeiXSearch.pm b/lib/PublicInbox/LeiXSearch.pm
index 2958d3f9..be49621f 100644
--- a/lib/PublicInbox/LeiXSearch.pm
+++ b/lib/PublicInbox/LeiXSearch.pm
@@ -613,7 +613,7 @@ sub add_uri {
 	}
 }
=20
-sub prepare_external {
+sub _prepare_external {
 	my ($self, $loc, $boost) =3D @_; # n.b. already ordered by boost
 	if (ref $loc) { # already a URI, or PublicInbox::Inbox-like object
 		return add_uri($self, $loc) if $loc->can('scheme');
@@ -638,6 +638,14 @@ sub prepare_external {
 	push @{$self->{locals}}, $loc;
 }
=20
+sub prepare_external {
+	my ($self, $loc, $boost) =3D @_;
+	my $ret =3D _prepare_external($self, $loc, $boost);
+	warn "W: we got nothing from $loc, did you mean $loc/.git?"
+		if !$ret && -e "$loc/.git";
+	return $ret;
+}
+
 sub _lcat_i { # LeiMailSync->each_src iterator callback
 	my ($oidbin, $id, $each_smsg) =3D @_;
 	$each_smsg->({blob =3D> unpack('H*', $oidbin), pct =3D> 100});
