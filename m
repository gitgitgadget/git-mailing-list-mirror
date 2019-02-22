Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7358520248
	for <e@80x24.org>; Fri, 22 Feb 2019 23:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbfBVXNn (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Feb 2019 18:13:43 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51678 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVXNn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Feb 2019 18:13:43 -0500
Received: by mail-wm1-f66.google.com with SMTP id n19so3344892wmi.1
        for <git@vger.kernel.org>; Fri, 22 Feb 2019 15:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=729w7X+B5kyEFQ489tDifj0iERiZEQC1T1Cv0RNkV0Y=;
        b=RYMAVXFhhzk0ctWUKokTjaklNhVIwmSZHYHRjswjisAOU/QkGP81bIjWh/V0AYMeje
         0HkNsr7/I38sFLnVAGoHG/GWaQ77yMIoUKZr4kfQu0Lwj10uimYk6Kyr1MbB6G1jBY1X
         l4/yWVI8dGEe1tJdpIVZJXDYRWcYtxVGBaO4zW7X1eSOJxB/KPChIwwQHpXJ4AyxitAc
         KnDSZDO0Ep0rUs/mRvYzbaKu+eeXhl9LDzaseO6BB+nLDQyld462IqS4NQ96to3RSOlJ
         6ynqUW+rNS5y/Wgm2gcDoNPrHChPnRCFjqFsW+IJPnFDz4U9M27vXD5SQbLZcU0VsDxb
         aOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=729w7X+B5kyEFQ489tDifj0iERiZEQC1T1Cv0RNkV0Y=;
        b=mC9NSgWNsmIXQQfq44mHLDAc2+4NviGxOuKbduq8c94PgfSh0Xgo3Zn2YOiCJYeK/H
         xP30mlNWBKaZknZSlPvQTOzZTObD34iZdR32WPdll5xYhjryXZTH26n1pplrzo6Hx1Pi
         l8mleQizhtajDwzTCh+hYRqjJGPDZePjMWgUBP2QcOrq/5qF/Eqwg8vEwNeG4kbw8bii
         2xOjwXM1/vqN+n8Rvpk7PbmGgCRlZU5klUsShZxX1jy5zqJgl6mYnQ168vEP/t89Bjtp
         0pF8nRwFTlk0ZFPmKUVNbT8oDVibXv7gwAS2+xQL1OrdM/Y7aQmAKfn6RKZcVzRQmtYh
         cWiQ==
X-Gm-Message-State: AHQUAuYi1MRuKn4KPdQ4t8rPV9ehldGj+JREfoOq7YlLKquEjsVuUarh
        4Ekf5Crr+TDpoMgo7k54qE0=
X-Google-Smtp-Source: AHgI3IbP/FpsiPFqReSttPkfobk2RSqnUp/jCTTOA8StNJykQwUhWZxRhseynHBUpr6tVSsJBexYuQ==
X-Received: by 2002:a1c:5fc5:: with SMTP id t188mr3766818wmb.86.1550877220585;
        Fri, 22 Feb 2019 15:13:40 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a1sm3767922wrq.96.2019.02.22.15.13.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 15:13:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 7/8] commit-graph write: don't die if the existing graph is corrupt
References: <20190221223753.20070-1-avarab@gmail.com>
        <20190221223753.20070-8-avarab@gmail.com>
Date:   Fri, 22 Feb 2019 15:13:36 -0800
In-Reply-To: <20190221223753.20070-8-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 21 Feb 2019 23:37:52 +0100")
Message-ID: <xmqqzhqno1r3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> When the commit-graph is written we end up calling
> parse_commit(). This will in turn invoke code that'll consult the
> existing commit-graph about the commit, if the graph is corrupted we
> die.

Irony ;-).

> Change the "commit-graph write" codepath to use a new
> parse_commit_no_graph() helper instead of parse_commit() to avoid
> this. The latter will call repo_parse_commit_internal() with
> use_commit_graph=1 as seen in 177722b344 ("commit: integrate commit
> graph with commit parsing", 2018-04-10).

That may slow down writing the graph but would be a sensible way to
prevent an error in the existing commit-graph from spreading.

> This might need to be re-visited if we learn to write the commit-graph
> incrementally.

Probably yes.  If we were doing "repack -a -d (without -f)" style of
"incremental", then we do need to revisit this, which is a moral
equivalent of saying "do not reuse delta" to "repack", and it would
make it impossible to be incremental.

Hopefully a true "incremental" shouldn't even have to touch existing
data, perhaps similar to "repack (without -a)", in which case the
equation may be different.  If we'd be computing reachability for
only new things, there is nothing gained by allowing parse_commit()
to peek into existing commit-graph file (by definition, these new
things are not in there---that's the reason why we are incrementally
extending the commit-graph by computing the reachability for them).
I dunno.

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 1ee00fa333..6db658ed66 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -377,7 +377,13 @@ corrupt_graph_verify() {
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err &&
>  	test_i18ngrep "$grepstr" err &&
> -	git status --short
> +	if test -z "$NO_WRITE_TEST_BACKUP"
> +	then
> +		cp $objdir/info/commit-graph commit-graph-pre-write-test
> +	fi &&
> +	git status --short &&
> +	GIT_TEST_COMMIT_GRAPH_DIE_ON_LOAD=true git commit-graph write &&
> +	git commit-graph verify
>  }
>  
>  # usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
> @@ -408,7 +414,7 @@ test_expect_success 'detect permission problem' '
>  	# "chmod 000 file" does not yield EACCES on e.g. "cat file"
>  	if ! test -r $objdir/info/commit-graph
>  	then
> -		corrupt_graph_verify "Could not open"
> +		NO_WRITE_TEST_BACKUP=1 corrupt_graph_verify "Could not open"

This would not work as you think it would; corrupt_graph_verify is a
shell function, so you cannot VAR=VAL prefix to export an environment
variable only for the duration of the command.

>  	fi
>  '
>  
> @@ -528,6 +534,7 @@ test_expect_success 'git fsck (checks commit-graph)' '
>  	git fsck &&
>  	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
>  		"incorrect checksum" &&
> +	cp commit-graph-pre-write-test $objdir/info/commit-graph &&
>  	test_must_fail git fsck
>  '
