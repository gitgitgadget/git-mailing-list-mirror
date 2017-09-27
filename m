Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2712B20281
	for <e@80x24.org>; Wed, 27 Sep 2017 03:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968113AbdI0Dh1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 23:37:27 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:46602 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965646AbdI0DhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 23:37:25 -0400
Received: by mail-pg0-f43.google.com with SMTP id i130so7037505pgc.3
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 20:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eixM2K8B18w2ncPuyYJjAuHsoTSYpv9TI6lIjzzOU+k=;
        b=OAYW1hiRE6z7MFq5IkTWSOCZ5rLx2ktsOywn+ShnClOHfwN/TvUmlWNFss2z2/0EMZ
         yIM+JGR6sIryAIixf2hW2oJ7fGcrvMol2yFUynC+G5lUA35dHTb0tS1wzDUrwZIK4FZU
         ugfBi80NwRAVwaOjh2xuhhrhvQ7gnl5delK7gUcLwZLCeD2Ine9qRZjcUSGX6c7uYldk
         r3mry2u0ZWLtD3+aPfP2Mz4oAjMxatmuSkRoO18Ous9AW4AqZAPZufC1LPx+G1jpRZIz
         DYJwIA+JTjeSO3A++DZ9VTLnEmD0y0EuMgm8/qZPq64UyCSZqsUVYO4SANM45cnIVrmy
         aOLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=eixM2K8B18w2ncPuyYJjAuHsoTSYpv9TI6lIjzzOU+k=;
        b=qJIEt7yQ7eQctSCT2sVq/+NuxhkJJiwhf/Os65FMUoNxC7Tgzz2/WoKJonHQYQt7VL
         2N0eHLMRiqdlWt3N+fnYc4nhlC/NDR5xc0Vk9CyyPmlKU9v+aWLVgC8VpHD/9pB2pgix
         w2m9VD+Ti6x4o0bJ2XEe7OEYGGSYzqFYq4DqLgYoP3vpI2Zyctf86Q2hlhpDAa2bUUz6
         P4akQFw0nG4z3uLtPeDF/PsgtDICWkinGj8t9r/7gJqJgljzsZCbGjHvoZJPVjrfevZ+
         70gsbSbs+9kmATgVHDcAGqwko75tI4B6apd9S+zGCBqNrF3yhrMBzlTJNAqCEGNgzK/e
         /sRg==
X-Gm-Message-State: AHPjjUhaIK2YjyqEVKNRSLChrRBaV3HmzGXe770Pdug5tKEsMdbySuwZ
        W3zq2i3eSSBmW91kbLP7uz8=
X-Google-Smtp-Source: AOwi7QCNFJfikbJ3r9WTc/13Xf2NzkbMoysQCtV2eIY0+75ArzMSRh4XXdI5S1PR/spkfoHynVt2+Q==
X-Received: by 10.159.208.5 with SMTP id a5mr37572plp.436.1506483444787;
        Tue, 26 Sep 2017 20:37:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:a541:226f:6d4c:7f7a])
        by smtp.gmail.com with ESMTPSA id y1sm1168597pgp.15.2017.09.26.20.37.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 20:37:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric Rannaud" <e@nanocritical.com>
Cc:     git@vger.kernel.org, jeremy.serror@gmail.com,
        "Shawn O . Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/1] fast-import: checkpoint: dump branches/tags/marks even if object_count==0
References: <xmqqr2uuaxy1.fsf@gitster.mtv.corp.google.com>
        <eedb545ccb43a14820802bab10f59ab8ab9557a0.1506419307.git.e@nanocritical.com>
Date:   Wed, 27 Sep 2017 12:37:23 +0900
In-Reply-To: <eedb545ccb43a14820802bab10f59ab8ab9557a0.1506419307.git.e@nanocritical.com>
        (Eric Rannaud's message of "Tue, 26 Sep 2017 02:53:04 -0700")
Message-ID: <xmqqefqs7qx8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Eric Rannaud" <e@nanocritical.com> writes:

> Any comments on the testing strategy with a background fast-import?
>
> To summarize:
> - fast-import is started in the background with a command stream that
>   ends with "checkpoint\nprogress checkpoint\n". fast-import keeps
>   running after reaching the last command (we don't want fast-import to
>   terminate).
> - In the meantime, the test is waiting to read "progress checkpoint" in
>   the output of fast-import, then it checks the testing conditions.
> - Finally, the test ensures that fast-import is still running in the
>   background (and thus that it has just observed the effect of
>   checkpoint, and not the side effects of fast-import terminating).
> - After 10 sec, no matter what, the background fast-import is sent
>   "done" and terminates.
>
> I tried to make sure that the test runs quickly and does not (typically) sleep.
> Upon failure, the test may take up to 10 sec to fully terminate.

Hmmmm, it certainly looks a bit too brittle with many tweakables
like 10, 50, 55, etc. that heavily depend on the load on the system.

Sorry for asking you to go through the hoops.

> diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
> index 67b8c50a5ab4..b410bf3a3a7a 100755
> --- a/t/t9300-fast-import.sh
> +++ b/t/t9300-fast-import.sh
> @@ -3120,4 +3120,121 @@ test_expect_success 'U: validate root delete result' '
>  	compare_diff_raw expect actual
>  '
>  
> +###
> +### series V (checkpoint)
> +###
> +
> +# To make sure you're observing the side effects of checkpoint *before*
> +# fast-import terminates (and thus writes out its state), check that the
> +# fast-import process is still running using background_import_still_running
> +# *after* evaluating the test conditions.
> +background_import_until_checkpoint () {
> +	options=$1
> +	input_file=$2
> +	( cat $input_file; sleep 10; echo done ) | git fast-import $options >V.output &
> +	echo $! >V.pid
> +
> +	# The loop will poll for approximately 5 seconds before giving up.
> +	n=0
> +	while ! test "$(cat V.output)" = "progress checkpoint"; do

Micronit.  Just like you have if/then on different lines, have
while/do on different lines, i.e.

	while test "$(cat V.output)" != "progress checkpoint"
	do

> +		if test $n -gt 55
> +		then
> +...

> +background_import_still_running () {
> +	if ! ps --pid "$(cat V.pid)"

"ps --pid" is probably not portable (I think we'd do "kill -0 $pid"
instead in our existing tests---and it should be kosher according to
POSIX [*1*, *2*]).

> +test_expect_success 'V: checkpoint updates refs after reset' '
> +	cat >input <<-INPUT_END &&

It is not wrong per-se but we quote INPUT_END when there is no
interpolation necessary in the body of here document to help
readers, like so:

	cat >input <<-\INPUT_END &&

> +	reset refs/heads/V
> +	from refs/heads/U
> +
> +	checkpoint
> +	progress checkpoint
> +	INPUT_END

> +test_expect_success 'V: checkpoint updates refs and marks after commit' '
> +	cat >input <<-INPUT_END &&

This we do want interpolation and the above is correct.


[Footnotes]

*1* http://pubs.opengroup.org/onlinepubs/9699919799/utilities/kill.html 
    lists '0' as an allowed signal number to be sent, and defers to the
    description of the kill() function to explain what happens.

*2* http://pubs.opengroup.org/onlinepubs/9699919799/functions/kill.html
    says """If sig is 0 (the null signal), error checking is
    performed but no signal is actually sent. The null signal can be
    used to check the validity of pid."""
