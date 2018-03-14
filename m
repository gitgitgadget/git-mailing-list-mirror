Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 741DB1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 20:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751357AbeCNUnm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 16:43:42 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33847 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750950AbeCNUnl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 16:43:41 -0400
Received: by mail-wr0-f194.google.com with SMTP id o8so6172363wra.1
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 13:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=HImR9nmrUfON7Cb6DfiTlb/PgDPjb06Jsh25ftQhwoI=;
        b=sePBZcWlnix7HHuDJu8uPURnhyYWg8C7mF7/BEcDpFsRfPrzy1YPIQKgcr491s9J7x
         3lpHggCadvWP1XePZeayNym8jnl5avg12gKm7+ggbnCWSqoTXD1TiBnVlTFxWmmJCUJx
         WkugPzQ4GJHcj5dC8tCU2ZoKf2nRr2pVWhgFgnfmmkQsy9OYF2VW40aWeTMwlFR/6pD/
         zz5j8sW8m+XRo8ICePoQOQWqkzgeA60Ynjy8VTYlj46vfhD/JWCDWsEg4ugHmzu2BRWt
         x65N/hcLg2viZ6uDzRqZj20d5yPyet/8dR+InWCPKp/HyZdMdySuQmA8QMOLhT8YrFM+
         fpdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=HImR9nmrUfON7Cb6DfiTlb/PgDPjb06Jsh25ftQhwoI=;
        b=Z2kLDUX3Jkk802/p63DUxxcrjmmK2TyF6r04krpdybQVGx6PHYKhjrs0nyzLT/uIky
         nprG0WoypUs0KqZYOJZ5U1PdSb1EAQrMUwiJH01nF7cMkipfm+ahbNgX856Zge46aC+f
         YEnp7K1TGGixkp/C5Q8jBHSOHi6Yr7iZ4dduDv+dUH/MQYyxdaa0tAF95ovvHi/Bs9o7
         V/HxzoFhjI9Kbpr4GB4SUBFZHHNFxa7egrgWQRa3dZIuLsNeeF2AC7Mj1+CcMR14KqaA
         oNz0INzqXT5V/jooL+bblzNwYKWIcNLldTODtepVtTv5pFrMJQMa/5KBKPTmPiocLivb
         Gz5g==
X-Gm-Message-State: AElRT7Gxfnj3TmBP6pNpvNxdwvTByZdcqL/pRdQt+e7qCfroMPHmh6X2
        3Nkxu+uiUmoYIOCwkt+IM1o=
X-Google-Smtp-Source: AG47ELsW1foYaOM31EHIiRf1bfs98n+Euc9jKDzdwJY7+wSJYjuGjFG5w68RipMIbWUJaNQjRtmisg==
X-Received: by 10.223.134.12 with SMTP id 12mr4827899wrv.193.1521060219290;
        Wed, 14 Mar 2018 13:43:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 59sm3612714wro.57.2018.03.14.13.43.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 14 Mar 2018 13:43:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v6 00/14] Serialized Git Commit Graph
References: <1519698787-190494-1-git-send-email-dstolee@microsoft.com>
        <20180314192736.70602-1-dstolee@microsoft.com>
Date:   Wed, 14 Mar 2018 13:43:37 -0700
In-Reply-To: <20180314192736.70602-1-dstolee@microsoft.com> (Derrick Stolee's
        message of "Wed, 14 Mar 2018 15:27:22 -0400")
Message-ID: <xmqq605yz8ue.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> This v6 includes feedback around csum-file.c and the rename of hashclose()
> to finalize_hashfile(). These are the first two commits of the series, so
> they could be pulled out independently.
>
> The only other change since v5 is that I re-ran the performance numbers
> in "commit: integrate commit graph with commit parsing".

Thanks.

> Hopefully this version is ready to merge. I have several follow-up topics
> in mind to submit soon after, including:

A few patches add trailing blank lines and other whitespace
breakages, which will stop my "git merge" later to 'next' and down,
as I have a pre-commit hook to catch them.

Here is the output from my "git am -s" session.

Applying: csum-file: rename hashclose() to finalize_hashfile()
Applying: csum-file: refactor finalize_hashfile() method
.git/rebase-apply/patch:109: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: commit-graph: add format document
.git/rebase-apply/patch:175: new blank line at EOF.
+
warning: 1 line adds whitespace errors.
Applying: graph: add commit graph design document
.git/rebase-apply/patch:42: new blank line at EOF.
+
.git/rebase-apply/patch:109: new blank line at EOF.
+
warning: 2 lines add whitespace errors.
Applying: commit-graph: create git-commit-graph builtin
.git/rebase-apply/patch:323: space before tab in indent.
 	fd = hold_lock_file_for_update(&lk, graph_name, 0);
.git/rebase-apply/patch:334: space before tab in indent.
 		fd = hold_lock_file_for_update(&lk, graph_name, LOCK_DIE_ON_ERROR);
.git/rebase-apply/patch:385: new blank line at EOF.
+
.git/rebase-apply/patch:398: new blank line at EOF.
+
warning: 2 lines applied after fixing whitespace errors.
Applying: commit-graph: implement write_commit_graph()
.git/rebase-apply/patch:138: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:144: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:154: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:160: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:197: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
warning: squelched 6 whitespace errors
warning: 10 lines applied after fixing whitespace errors.
Applying: commit-graph: implement 'git-commit-graph write'
Test number t5318 already taken
.git/rebase-apply/patch:346: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:356: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:366: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:374: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:384: indent with spaces.
        cd "$TRASH_DIRECTORY/bare" &&
warning: 5 lines add whitespace errors.
Applying: commit-graph: implement git commit-graph read
Applying: commit-graph: add core.commitGraph setting
Applying: commit-graph: close under reachability
.git/rebase-apply/patch:302: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:310: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:321: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:331: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:341: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
warning: squelched 2 whitespace errors
warning: 7 lines add whitespace errors.
Applying: commit: integrate commit graph with commit parsing
.git/rebase-apply/patch:224: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:227: trailing whitespace.
	graph_read_expect "9" "large_edges" 
.git/rebase-apply/patch:234: indent with spaces.
        cd "$TRASH_DIRECTORY" &&
warning: 2 lines applied after fixing whitespace errors.
Applying: commit-graph: read only from specific pack-indexes
.git/rebase-apply/patch:196: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:209: indent with spaces.
        cd "$TRASH_DIRECTORY" &&
warning: 1 line applied after fixing whitespace errors.
Applying: commit-graph: build graph from starting commits
.git/rebase-apply/patch:148: indent with spaces.
        cd "$TRASH_DIRECTORY/full" &&
.git/rebase-apply/patch:158: indent with spaces.
        cd "$TRASH_DIRECTORY" &&
warning: 1 line applied after fixing whitespace errors.
Applying: commit-graph: implement "--additive" option

