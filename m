Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AE231F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751685AbdFJBzf (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:55:35 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:36808 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751562AbdFJBze (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:55:34 -0400
Received: by mail-pg0-f67.google.com with SMTP id v18so9060031pgb.3
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=a+DOZRj4dfUjCjWh+ivSHG/zGFnP8SXhzrYtsEP6eaM=;
        b=umep4OkEODfJsGROEKBxC9cFZ5xBTmI71PC66id8BZ0pzuODIiljzBCl4xINsyZXux
         1ABAcbrWvcU6tL+lbEi7gVm1TrZvg8w94reF18AhjSQzS8CUbK5d+DuDONEeLYP+NEaY
         LXDuQhJ0Lslyad0h+ercUcovplt1t/MXOv6LJ+L0/4387Ors7Jw+77YhCLBXvFRC5Wac
         4Bkd69C/IcqxKlVHwuvGRSCs0jMOcMDsEZKY5mI45CvvTZwnn+1ar2pzAbn/NDVo0/R7
         oUE14x1tetjCbcxVovYa0sAfj8j+/IArg61sA3yYyO50maEbjWZyKSYtvrpsDTLUzBEj
         KRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=a+DOZRj4dfUjCjWh+ivSHG/zGFnP8SXhzrYtsEP6eaM=;
        b=J/ujHL1tMzRCaGAnDaigCCj1YHwR5zkuxgV2Cwm4/vipT/xdIRTNWPBpo0dmMQ7Ul2
         DoVGtEp7hJcrqnsOE8FXUJggyD3zxMSuex2BNOJhOoPlUt8C4yTs2DO3TtC99kEHOQRI
         oGlXr8rTa9kNodgSFfd/0ZhAcwPt1hvz08qU5yHpo3o0BtqjmzgCh2HB8Fax4bz9dQ4O
         WIwiXXTIxjPDPL4HhdTeVCvrCAXHvqsV1MWcifjkJq3pDe8VHHj5liUhwf4ZZ9/GSSuZ
         TkSsNLclMEpsFc+LZA7u/jNcODhFu8XxDjUNIFizc75BqSjDRDg3Yd1l7DCKCW4tg5h+
         05/g==
X-Gm-Message-State: AODbwcAiAdUi0t7T1aovKa7hmLB90dJTbN4khsvdnz8KxUiTgISe3y8N
        Dfl3GiUkl0XTSA==
X-Received: by 10.84.175.67 with SMTP id s61mr44414104plb.151.1497059733971;
        Fri, 09 Jun 2017 18:55:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id j6sm7741314pgc.1.2017.06.09.18.55.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:55:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] wildmatch test: cover a blind spot in "/" matching
References: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com>
Date:   Sat, 10 Jun 2017 10:55:32 +0900
In-Reply-To: <0102015c492e27c6-669f7ca8-e7c6-484f-9c5b-7cb9358ee966-000000@eu-west-1.amazonses.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sat, 27 May
 2017 09:13:00
        +0000")
Message-ID: <xmqqlgp04ne3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> Add a test which covers a blindspot in how these tests should assert
> that negated character classes are allowed or not allowed to match "/"
> in certain circumstances.

Please make this a bit more explicit, something like

	A negated character class that does not include '/',
	e.g. [^a-z],

        - should match '/' when doing "wildmatch"
	- should not match '/' when doing "pathmatch"

	Add two tests to cover these cases.

Thanks.

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  t/t3070-wildmatch.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/t3070-wildmatch.sh b/t/t3070-wildmatch.sh
> index ef509df35160..65ea07b68356 100755
> --- a/t/t3070-wildmatch.sh
> +++ b/t/t3070-wildmatch.sh
> @@ -82,6 +82,7 @@ match 1 0 'foo/bar' 'foo/**/bar'
>  match 1 0 'foo/bar' 'foo/**/**/bar'
>  match 0 0 'foo/bar' 'foo?bar'
>  match 0 0 'foo/bar' 'foo[/]bar'
> +match 0 0 'foo/bar' 'foo[^a-z]bar'
>  match 0 0 'foo/bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
>  match 1 1 'foo-bar' 'f[^eiu][^eiu][^eiu][^eiu][^eiu]r'
>  match 1 0 'foo' '**/foo'
> @@ -226,6 +227,7 @@ pathmatch 0 foo/bba/arr 'foo/*z'
>  pathmatch 0 foo/bba/arr 'foo/**z'
>  pathmatch 1 foo/bar 'foo?bar'
>  pathmatch 1 foo/bar 'foo[/]bar'
> +pathmatch 1 foo/bar 'foo[^a-z]bar'
>  pathmatch 0 foo '*/*/*'
>  pathmatch 0 foo/bar '*/*/*'
>  pathmatch 1 foo/bba/arr '*/*/*'
>
> --
> https://github.com/git/git/pull/362
