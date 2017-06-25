Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 200D62082F
	for <e@80x24.org>; Sun, 25 Jun 2017 22:12:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751361AbdFYWMX (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Jun 2017 18:12:23 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35945 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751349AbdFYWMW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2017 18:12:22 -0400
Received: by mail-pg0-f68.google.com with SMTP id u36so305088pgn.3
        for <git@vger.kernel.org>; Sun, 25 Jun 2017 15:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dgDrci/Rvu/g4pJDM9Cv1CPRTgWUpx3W/QcxJ0UAWF8=;
        b=s1bTthhpRUD2VH/V157egyQgpsojKhtu5hU9ynoX2O1LYuMIRMChNOomyYLftwc84n
         4/gt1C6GPoRFxQ5A8VXt+BGgHSdOXXyueLbyfun6sr0NRWb+p0Mbrn8sDaGcT3igZAGR
         7POmIjuaLMMrrt3CRM0ztF4G8TVzVx0cztc9ax0mZDcPt4s4lRS1vpQ+kXwLuyoCk8H8
         lciIyx94Topfe72osJ79ONuqyRg7ZgZr97GubEV7ia2MiK01KkuP4VxrPVHZHA/o+gQ8
         z85dKn6VuHD8Y4/tb8cOo/t1Vr5LtLIsSsDJ3d8e38pOHfRqtf4v7gRSfTS17K7lDRBD
         nS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dgDrci/Rvu/g4pJDM9Cv1CPRTgWUpx3W/QcxJ0UAWF8=;
        b=YyG/NJIX/JGumx/oO+HosqqcttqXny1mwrRfzIUHnVdfXrh+lDk1RKfAu9xHp1M3bR
         zZOHWamwsYLUhR1LUdfMttZproGx+OBlXhOiANtoQbTTPT/Ht2cL3VlEWBrmAmHJ80iF
         KZFnlCmVCwsAmZd6uqO7gEoPYy4L7M1J7F1xjVDTKhqcDQoNiUaZS4/uHb4c0QdVjkXJ
         SUgdGSAI25Ao7N0YnsIj3Fr/ILf/6HHnZ1FTNvK4zg8Bi+E8okD5JqibueqmVIK7zpYC
         SKGCuNcqyh5r/XH4egHykr3N0k4d5HQTXn87/+r+4yeO7356nCC0J13PXAtaOBDeHyxH
         CO5g==
X-Gm-Message-State: AKS2vOyLkL4yRBXjhoocqqGtGjAjN5KD4mna33yk1OKxzAIr6K1SbFK8
        p2qt4JUI89Fv47S+G+g=
X-Received: by 10.84.228.207 with SMTP id y15mr20855692pli.13.1498428741852;
        Sun, 25 Jun 2017 15:12:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:644d:1257:a024:dc49])
        by smtp.gmail.com with ESMTPSA id i5sm2104384pgk.61.2017.06.25.15.12.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 25 Jun 2017 15:12:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, tboegi@web.de, e@80x24.org,
        ttaylorr@github.com, peartben@gmail.com
Subject: Re: [PATCH v6 1/6] t0021: keep filter log files on comparison
References: <20170625182125.6741-1-larsxschneider@gmail.com>
        <20170625182125.6741-2-larsxschneider@gmail.com>
Date:   Sun, 25 Jun 2017 15:12:20 -0700
In-Reply-To: <20170625182125.6741-2-larsxschneider@gmail.com> (Lars
        Schneider's message of "Sun, 25 Jun 2017 20:21:20 +0200")
Message-ID: <xmqqtw337m4b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> The filter log files are modified on comparison. Write the modified log files
> to temp files for comparison to fix this.

The phrase "to fix this" implies that it is _wrong_ to modify after
comparing it, but it is unclear _why_ you think is wrong.  After
all, the purpose of this comparison helper is to see if these two
are the same with cruft removed, and once the helper finds the
answer to that question, the current users of the comparison helper
do not reuse these files, so from _their_ point of view, there is
nothing to "fix", is there?

It would become a problem _if_ we want future users of this helper
to reuse the same expect (or actual) multiple times and start from
an unmodified one.  There may be some other reason why you do not
want the comparison to smudge these files.  Please state what that
reason is before saying "fix this".

Thanks.

>
> This is useful for the subsequent patch 'convert: add "status=delayed" to
> filter process protocol'.
>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
> ---
>  t/t0021-conversion.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 161f560446..ff2424225b 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -42,10 +42,10 @@ test_cmp_count () {
>  	for FILE in "$expect" "$actual"
>  	do
>  		sort "$FILE" | uniq -c |
> -		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp" &&
> -		mv "$FILE.tmp" "$FILE" || return
> +		sed -e "s/^ *[0-9][0-9]*[ 	]*IN: /x IN: /" >"$FILE.tmp"
>  	done &&
> -	test_cmp "$expect" "$actual"
> +	test_cmp "$expect.tmp" "$actual.tmp" &&
> +	rm "$expect.tmp" "$actual.tmp"
>  }
>  
>  # Compare two files but exclude all `clean` invocations because Git can
> @@ -56,10 +56,10 @@ test_cmp_exclude_clean () {
>  	actual=$2
>  	for FILE in "$expect" "$actual"
>  	do
> -		grep -v "IN: clean" "$FILE" >"$FILE.tmp" &&
> -		mv "$FILE.tmp" "$FILE"
> +		grep -v "IN: clean" "$FILE" >"$FILE.tmp"
>  	done &&
> -	test_cmp "$expect" "$actual"
> +	test_cmp "$expect.tmp" "$actual.tmp" &&
> +	rm "$expect.tmp" "$actual.tmp"
>  }
>  
>  # Check that the contents of two files are equal and that their rot13 version
