Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C3FC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236135AbiCGMaO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235518AbiCGMaN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:30:13 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C0185955
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:29:18 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id yy13so22706719ejb.2
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=c2efJgp2Eo6cgol7WpS9XkAzL9RxKCqphoIzj/31KR8=;
        b=PAok5bMLrO+BUYw19bs3yEzqDmCsht9+DOJ1S1qlmfJFGZy1Pi9AFAwA4nBUbdisbZ
         VTsZSO9x5y8ePutI96ervRLDqUbZarmOQ2hby+f7D4qxDTJPaNBEghrLDAAIfBHdJjqU
         B/nkEum1uw0NZZNvHznPuMD5SO/vLRwHZ5r7hNn++v8Ic5+dwxA/kn/EMHGYAScGW88S
         6RlEtqoA3hRWqn9ip9Bp2wbqwLAAMcut2upGGvPoMZlUBQPfz1oN+2th1HEf6EBwyCy9
         LP7W0TXcDCAyyHf0aMzoJZy0bCx9sc+SNEKGeAwuCV5VqtbDSCvj/GeKzeBI9wn6gdaT
         hDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=c2efJgp2Eo6cgol7WpS9XkAzL9RxKCqphoIzj/31KR8=;
        b=bslV5BwSREAgnFdt9J9JAXkm7EHpfEmKOzF983sTowVVD8GpC1jwec6TYoRSPx9ipX
         ojs/ThcaXxHRUKWH7m0yHpKnPLlCZMfAUguRWA1Cv9oa5WpCXGZQOhd4rib8fT0FOba9
         Dpu7bqopM5fH1Rgk4OIqcsEMkRjdctsEkQyov0pIvJ9AQ4jpat7ylCDhF+vYt0TljiYL
         7LdtMjykvyblW+71x8wq7EsYfmA7j1ddyp4T/wE1kXOLjckZXZ1JqA8mYK5eO8b7CZB6
         rwyw8t7h/DFGpKPU6/1eIo3eo5PxtHzuYcQmkwOUlo7pHxjFhu3P2tkWmKbSP6wy/oUK
         mckw==
X-Gm-Message-State: AOAM530IcsIju8T5eZrlMIZ8mNcSt34HUmqPxszUcOMIyUQHekP0ndLv
        ig4JH86/b0zA82Dh9/18UcA0JBr2BiF00A==
X-Google-Smtp-Source: ABdhPJy9r91c7mwAd1khWceJGo2gn/Dm0hYTvyiuQBb5NWD3ejZe28HDbzUkpL8WNh3YMYnYlW0QNA==
X-Received: by 2002:a17:907:97cc:b0:6da:a8fb:d1db with SMTP id js12-20020a17090797cc00b006daa8fbd1dbmr9107470ejc.267.1646656156484;
        Mon, 07 Mar 2022 04:29:16 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id qb30-20020a1709077e9e00b006d6f8c77695sm4610011ejc.101.2022.03.07.04.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:29:15 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRCUE-001UAS-W6;
        Mon, 07 Mar 2022 13:29:14 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jason Yundt <jason@jasonyundt.email>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] gitweb: remove invalid http-equiv="content-type"
Date:   Mon, 07 Mar 2022 13:23:49 +0100
References: <20220307033723.175553-1-jason@jasonyundt.email>
 <20220307033723.175553-3-jason@jasonyundt.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220307033723.175553-3-jason@jasonyundt.email>
Message-ID: <220307.861qze0wv9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Mar 06 2022, Jason Yundt wrote:

> Before this change, gitweb would generate pages which included:
>
> 	<meta http-equiv="content-type" content="application/xhtml+xml; charset=utf-8"/>
>
> A meta element with http-equiv="content-type" is said to be in the
> "Encoding declaration state". According to the HTML Standard,
>
> 	The Encoding declaration state may be used in HTML documents,
> 	but elements with an http-equiv attribute in that state must not
> 	be used in XML documents.
>
> 	Source: <https://html.spec.whatwg.org/multipage/semantics.html#attr-meta-http-equiv-content-type>
>
> This change removes that meta element since gitweb always generates XML
> documents.
>
> Signed-off-by: Jason Yundt <jason@jasonyundt.email>
> ---
>  gitweb/gitweb.perl                        |  4 +---
>  t/t9502-gitweb-standalone-parse-output.sh | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index fbd1c20a23..606b50104c 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4213,8 +4213,7 @@ sub git_header_html {
>  	my %opts = @_;
>  
>  	my $title = get_page_title();
> -	my $content_type = get_content_type_html();
> -	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
> +	print $cgi->header(-type=>get_content_type_html(), -charset => 'utf-8',

I think it would be better to just skip this hunk, no behavior will
change if it's left in.

>  	                   -status=> $status, -expires => $expires)
>  		unless ($opts{'-no_http_header'});
>  	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
> @@ -4225,7 +4224,6 @@ sub git_header_html {
>  <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
>  <!-- git core binaries version $git_version -->
>  <head>
> -<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>

..with this being the only behavior change (yeah the variable will now
be used only in one place, but that's fine)

I'm not sure I understand this change really. The result in always XML,
so application/xhtml+xml is redundant, text/html, or both?

But aside from that: I have seen browsers get the lack of encoding=""
"wrong" with data at rest, don't some still default to ISO-8859-1?

So won't this result in badly decoded data if you save the web page &
view it locally?

>  <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
>  <meta name="robots" content="index, nofollow"/>
>  <title>$title</title>
> diff --git a/t/t9502-gitweb-standalone-parse-output.sh b/t/t9502-gitweb-standalone-parse-output.sh
> index e7363511dd..25165edacc 100755
> --- a/t/t9502-gitweb-standalone-parse-output.sh
> +++ b/t/t9502-gitweb-standalone-parse-output.sh
> @@ -207,4 +207,17 @@ test_expect_success 'xss checks' '
>  	xss "" "$TAG+"
>  '
>  
> +no_http_equiv_content_type() {
> +	gitweb_run "$@" &&
> +	! grep -Ei "http-equiv=['\"]?content-type" gitweb.body

Nit: Should we skip the "-i" here since we're testing our own output,
and not http standards in general (i.e. we don't have to worry about the
case of http-equiv?)
