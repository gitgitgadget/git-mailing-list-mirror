Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 592371F404
	for <e@80x24.org>; Tue, 27 Feb 2018 21:10:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeB0VKz (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 16:10:55 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54776 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751518AbeB0VKy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 16:10:54 -0500
Received: by mail-wm0-f67.google.com with SMTP id z81so1157961wmb.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 13:10:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=5afsCJDuPCt821NRVaQl0+1yOeC5IfxSzGSUQNIfk1w=;
        b=AoZkirWZoEZ5XPzq2oK21kWJNckMOhdbPUlwV1RIGhkG7K7EnY8xjw0pUG4sZlH/0D
         XgL4k0ikveMs4JlK4KtUYaAMYkMziSzTvJ5F5Rx4IYxLGQjbkShRcAFll0O08kh8ONGZ
         h0HlpLVElndU7ICFkRo6TMrpfTLMZdVYSuSPDOCWzhepWONHPOyzziWSN5LIrSfECcN9
         jEywlYy+LtIM8rHlYX0I4LoRklTxIEEaZlwct9JdWdPp8fAhVpt4IquBQMHZj8BFCihr
         bRREbf9hmL7arv4/85bEayNMlD2//PZvqCdzjReCNNSpD4OgS6mksLMfeDzDTHRhx8Mh
         /w0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=5afsCJDuPCt821NRVaQl0+1yOeC5IfxSzGSUQNIfk1w=;
        b=tDLLlef3U/oFBwEvFh3ZXay8xFGS6+CAUf/o2gQ+66ZEnDpzn2YifzF5lvQ2QXKWzC
         /lmDmb9Q8Dt4N1C8U9SeHN7l8VjtlAb6r5Bv8jYwchG6a2vWOfQR605UZac8D9sA2FzA
         Hhx9jrIBKuj8aVXi9PbalxCD1qY4n4ar9GRiua5OOSVS/4AmJbnE+fGzgoIiC4G9x+Gs
         syb+9Q4iGIE60UQ2Ttg7kPhdfYZlVpGCptuZsra/lIScLOdmEekui8npuINFQc+7uFEI
         jkpg/WDPaWyF/bgGy5r0euLp78Zipdsn/onjibhm1o7E2QzVm3DQJpgbDCNKR6izvJqe
         V6tw==
X-Gm-Message-State: APf1xPDOSCWI2qGiASu8/SgM8oQ7oljh416cipCl4KaV6eexvXUxM6qG
        mAihZ0UcsIzd7J2gTOJsfLg=
X-Google-Smtp-Source: AG47ELvfJcoTEuK0B7i7voyKKGxhAcNWB8uSFJ5zG0RW1BUbshUWoWPWTpoR1YgdVXW2rd06tDI/vQ==
X-Received: by 10.28.74.217 with SMTP id n86mr13271989wmi.93.1519765852890;
        Tue, 27 Feb 2018 13:10:52 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id z72sm523208wmc.2.2018.02.27.13.10.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 13:10:52 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
References: <20180223233951.11154-1-szeder.dev@gmail.com>
        <20180223233951.11154-5-szeder.dev@gmail.com>
        <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 27 Feb 2018 13:10:51 -0800
In-Reply-To: <xmqqtvu2p2kx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 27 Feb 2018 13:03:42 -0800")
Message-ID: <xmqqpo4qp290.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER Gábor <szeder.dev@gmail.com> writes:
>
>> The two test checking 'git mmerge-recursive' in an empty worktree in
>> ...
>>  		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
>>  		export GIT_INDEX_FILE &&
>>  		mkdir "$GIT_WORK_TREE" &&
>> -		git read-tree -i -m $c7 &&
>> -		git update-index --ignore-missing --refresh &&
>> -		git merge-recursive $c0 -- $c7 $c3 &&
>> -		git ls-files -s >actual-files
>> -	) 2>actual-err &&
>> -	>expected-err &&
>> +		git read-tree -i -m $c7 2>actual-err &&
>> +		test_must_be_empty expected-err &&
>> +		git update-index --ignore-missing --refresh 2>actual-err &&
>> +		test_must_be_empty expected-err &&
>> +		git merge-recursive $c0 -- $c7 $c3 2>actual-err &&
>> +		test_must_be_empty expected-err &&
>> +		git ls-files -s >actual-files 2>actual-err &&
>> +		test_must_be_empty expected-err
>
> Where do the contents of all of these expected-err files come from?
> Should all of the test_must_be_empty checks be checking actual-err
> instead?


And the reason why your pre-submission testing did not catch may be
because test_must_be_empty is broken?  I wonder if this is a good
way forward to catch a possible bug like this.

Of course, if somebody was using the helepr for "must be either
missing or empty", this change will break it, but I somehow doubt
it.  A program that creates/opens and writes an error message only
when an error is detected is certainly possible, and could be tested
with the current test_must_be_empty this way:

	rm -f actual-err &&
	git frotz --error-to=actual-err &&
	test_must_be_empty actual-err

but then the last step in such a test like the above is more natural
to check if actual-err _exists_ in the first place anyway, so...

 t/test-lib-functions.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 37eb34044a..6cfbee60e4 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -772,7 +772,11 @@ verbose () {
 # otherwise.
 
 test_must_be_empty () {
-	if test -s "$1"
+	if ! test -f "$1"
+	then
+		echo "'$1' is missing"
+		return 1
+	elif test -s "$1"
 	then
 		echo "'$1' is not empty, it contains:"
 		cat "$1"
