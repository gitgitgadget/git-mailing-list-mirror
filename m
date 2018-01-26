Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CF341F404
	for <e@80x24.org>; Fri, 26 Jan 2018 18:39:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751465AbeAZSjJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 13:39:09 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33169 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751291AbeAZSjI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 13:39:08 -0500
Received: by mail-pg0-f67.google.com with SMTP id u1so790033pgr.0
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 10:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=dLdjuCc1STgUOlCSAqf/1dbFPnJmvcGZYkUJgi7iuao=;
        b=GiIzUyVnXppFylFq6y1sYUAitJgTCqqTAcPLHNb4RCT/p4CMJIWrbuFeLvdAJVNcO1
         mVwwxBKUo1OeedfLnLzhcmzHPN6oWvj7VB45J0PDXwy4x3xs00HGAweMeoG0So84Wzvt
         phTt7Yutb1Nhipsbx6jKdlNnEOpTjUazzgSw/nLQjBDsfflcG+mHPEzLmfhQj3HOIG65
         ZS1V37JrAp+YPUlKn25qxsdQks9uIDed2MH+EtV1s3DspYx6A0VVsMzLVi4G/2pBz6Qf
         1pmzONS9EgYXgWjYRvX5ppyblMPJUqUIjXWvsdgGHjLuHvWZ1JJ31PxQWj28Z1pOXLDx
         jGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=dLdjuCc1STgUOlCSAqf/1dbFPnJmvcGZYkUJgi7iuao=;
        b=NlUNMqsOdHWWbJAcWlSlIIGCWxCjEnhX+8sF2/qCid9MHhr/PrX3SIaW3JlgBbCWPq
         F05ifxDlPBkVa/SGUGvdciW76/nv2A9oW+fBlVVhJ4dm/GjQRMIJnDgS+2PeATUTXCnp
         RcFjuDBcwKXRuVaw7H86o6M99WCa9uBsOTW9btw2qTAjSTt9LTr7cpeDpHTSKZDEABc5
         ZJ+ra+1COjEvtuSCxJBZ9PUF7YHtOaa5C2YcuVpSi2+I2tTkW8gNz89YMTziUUrmTYMo
         FUrS+76KKQ12mKrtP2dP6aGTZNgqqQWabIajfa3RUNxDcZA+A8CZATFksYZGUmIP1tMw
         Y0dw==
X-Gm-Message-State: AKwxytcUhbHYdt+Jk7NaLkhWm2fTtgs1vkw6Kybhsjhan/CEst81ldNE
        2VpHFMTy4sMjj2MTOqy9P+s=
X-Google-Smtp-Source: AH8x225XHS9F2LYW7SNrfUH0uzIH8241CeBeKHZtBotBAI6VYNEmgwOdKsvpl2F5sHOJc3n+cgjMFg==
X-Received: by 10.98.246.8 with SMTP id x8mr19746870pfh.234.1516991947688;
        Fri, 26 Jan 2018 10:39:07 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3d49:4bb2:1738:a537])
        by smtp.gmail.com with ESMTPSA id b8sm18446749pff.31.2018.01.26.10.39.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 26 Jan 2018 10:39:07 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 08/10] t: forbid piping into 'test_i18ngrep'
References: <20180126123708.21722-1-szeder.dev@gmail.com>
        <20180126123708.21722-9-szeder.dev@gmail.com>
        <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com>
Date:   Fri, 26 Jan 2018 10:39:05 -0800
In-Reply-To: <xmqq1sic8omp.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Fri, 26 Jan 2018 10:24:14 -0800")
Message-ID: <xmqqshas79di.fsf@gitster.mtv.corp.google.com>
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
>> See two of the previous patches for the only such cases we had in our
>> test suite.  However, reliably preventing this antipattern is arguably
>> more important than supporting these cases, which can be worked around
>> by only minor inconveniences.
>
> I am not sure if that inconveniences will be minor.  Is this too
> contrived an example, for example?
>
>   check () {
>         pattern=$1 file=$2 script=./runme
>
>         test_i18ngrep "$pattern" "$file" &&
>         write_script "$script" &&
>         test_expect_success "check $pattern" '
>                 "$script"
>         '
>   }
>
>   check foo file <<-EOF
>   ... test script comes here ...
>   EOF

Is there a case where test_i18ngrep (after your clean-ups in this
series up to 06/10) needs to read from more than one file?

I actually think that the kind of inconveniences we *can* work with,
without risking breakage to legitimate test, would be to allow and
require test_i18ngrep to name and read only from one file that
appears at the end of its command line.  IOW, instead of doing a
probing "read" that you cannot undo and break legitimate test, I
think it is OK to see if the last token names a file that is on the
filesystem, e.g.

	test_i18ngrep () {
		eval test -f \"\${$#}\" ||
		error "bug in the test sript: test_i18ngrep must" \
		      "name a file to read as the last token on the command line"
		...

