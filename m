Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1C2020357
	for <e@80x24.org>; Fri,  7 Jul 2017 21:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbdGGVWR (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 17:22:17 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34715 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751059AbdGGVWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 17:22:16 -0400
Received: by mail-pf0-f195.google.com with SMTP id c24so6027386pfe.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2017 14:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=wji5aGDu2w1i/dF6aJbe4Hzm1j03m9Q9VA6LrHNIHNA=;
        b=bTskt0FYOV/ERy9hGWdYNddb6MWIwDUmXN0y6/nfz0aGaeC9x9Ec5U55opxwzgIHI6
         5EFw1ewgufpshxkk+WNAGRdciWwt+ikr5bbsKwxUzSi2uhxaCIHBVltUMSXZHOt1O2s1
         guCsOWHobN+5EvUhU2zZ/oXa5EHzI71Sae6WXChaa3Pg1tU+isQXfz+tx5FoHnGdCEMU
         0gCNKeRsD3n+QbrObliG6xcVF3p2jEihvna1qNhjZfVpUVbg7OloRKqhvBIIRyVB+6Ng
         gXGohXc8VNa5pFqmGo54h1KU3mxvWP16DQ3U2Knd1It7oCApkfN4ioDdZyg6lecEDw+3
         Jirg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=wji5aGDu2w1i/dF6aJbe4Hzm1j03m9Q9VA6LrHNIHNA=;
        b=c69/FUXdhdNSNyTrqDI47qE2RySN9szJ5F45beaQaEiQLirk+Bh+F/nHO27eAEbXgz
         iBRpW/zXqYNRPkF8v04/uUuVcG1q4yn64zS4S/Rw8Jn/vvTh3uU3m2WziesuLzrWAS44
         3CXjccPNmMa7JbiucRQTDTTPpks+S8MIA7YPiI2TgLV3HOb03mMs71OrIu+z8ngqraav
         KWHlkXbyw3pNVWqlEshAxgVKvuoEDDdJuoDeKrSQmeV78MkFl+oDWERecqzbF+S0Ol4+
         2dCITyWF9Abj+Rg9l5YD3TnbIneoBkcPZrHcN1Am/37+oSsYRj1FP5RENp4M5cm/84re
         MOug==
X-Gm-Message-State: AIVw113Zv6i4EELKiZrsL3Ja9lHgzyKkH2Gz4GXsRDHsRGyz5wjYFKWp
        Mfm+40AsOgYfMkNR57E=
X-Received: by 10.99.44.81 with SMTP id s78mr3398122pgs.146.1499462535595;
        Fri, 07 Jul 2017 14:22:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ac1c:ce85:2088:9c06])
        by smtp.gmail.com with ESMTPSA id b7sm9992342pfl.44.2017.07.07.14.22.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 07 Jul 2017 14:22:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: bug during checkout of remote branch and uncommited changes ?
References: <20170707123727.dgd5rub2ycrg525y@ltop.local>
        <xmqqd19cckfw.fsf@gitster.mtv.corp.google.com>
        <20170707171300.kd5hqcujbvubw73q@ltop.local>
Date:   Fri, 07 Jul 2017 14:22:14 -0700
In-Reply-To: <20170707171300.kd5hqcujbvubw73q@ltop.local> (Luc Van
        Oostenryck's message of "Fri, 7 Jul 2017 19:13:01 +0200")
Message-ID: <xmqqshi89c3d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luc Van Oostenryck <luc.vanoostenryck@gmail.com> writes:

> At least here, the scenario I gave allow to fully reproduce the problem.
>
> Would you like any other information?

Not really.  Here is what I locally ran and its output

-- >8 -- cut here -- >8 --

#!/bin/sh

mkdir -p /var/tmp/x/lvo && cd /var/tmp/x/lvo || exit

rm -fr src dst

(
	mkdir src &&
	cd src &&
	git init &&
	>file &&
	git add file &&
	git commit -m 'initial' &&
	git checkout -b abranch &&
	echo abranch >file &&
	git commit -a -m 'abranch'
) || exit

mkdir dst &&
cd dst &&
git init &&
git pull ../src master &&
echo mine >file &&
git status -suno &&
git remote add aremote ../src &&
git fetch aremote abranch || exit

git checkout abranch

git reset --hard

git checkout abranch

-- 8< -- cut here -- 8< --

$ sh script
Initialized empty Git repository in /var/tmp/x/lvo/src/.git/
[master (root-commit) 8535bd5] initial
 1 file changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 file
Switched to a new branch 'abranch'
[abranch 32814d9] abranch
 1 file changed, 1 insertion(+)
Initialized empty Git repository in /var/tmp/x/lvo/dst/.git/
From ../src
 * branch            master     -> FETCH_HEAD
 M file
From ../src
 * branch            abranch    -> FETCH_HEAD
 * [new branch]      abranch    -> aremote/abranch
error: Your local changes to the following files would be overwritten by checkout:
	file
Please commit your changes or stash them before you switch branches.
Aborting
HEAD is now at 8535bd5 initial
Switched to a new branch 'abranch'
Branch abranch set up to track remote branch abranch from aremote.

----------------------------------------

As far as I can see, everything is working as intended.  The first
"git checkout abranch" stops due to the dirty local state before it
even tries to DWIM to create abranch, and then after resetting to
get rid of all the local modifications, the second "git checkout
abranch" manages to create the branch just fine.

Even with different variations (like making dst a clone of src to
force the "checkout" to see an ambiguity), I do not seem to get your
"the first one fails with an error message about Ambiguity, the
second does not", which indeed is a curious symptom.

Without knowing if this is an ancient Git, or what remote other than
aremote this repository has, what remote-tracking branches from
these remotes this repository has, if they share the same name
abranch that points at the same or different objects, etc., I simply
do not know what is causing you the symptom, and time I allocated to
look into this for now just ran out.


