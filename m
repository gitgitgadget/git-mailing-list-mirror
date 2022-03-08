Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8DEEC433EF
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 12:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230337AbiCHMy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 07:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiCHMy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 07:54:57 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4069047053
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 04:54:01 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id b24so1704225edu.10
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 04:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=GDkc4piU/1Q/IjcE942SfcDteViTaGoWKqGAu927BvI=;
        b=RtJK1f4f+T5OZkWH4yj3b46SH5g2yd0r6lCQN6S6PnBOTeOk2MK5BTUuOyJVnXEqs6
         jzeRi+1ddJtzgO9XGan2G5F0D3RO4fPwJrQBctXeIyiCNUawasmDwQo01GBQ5i0HzvSy
         hYDCMYhlmPOWccYJBxGjD5HtyFtrhL0TvdCC2NHz0fTaWOOkF1La5lyFHqJNfcHj6SGQ
         hZPanwGv0WOOyb89+sEFDO+Ijs8oKIniOGwXXn1PKqr9OVr4KqZRPbQOTx3+2kaHq8JB
         D5Syu20Eg7u4EGu5Li+/3laATa2Zc8qmAyvrfIxxyZOU7hrZAr4Z+E1GsBIJdrb6ZLR+
         ngng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=GDkc4piU/1Q/IjcE942SfcDteViTaGoWKqGAu927BvI=;
        b=PZGgMDF3No5gRcOtOsfM2kBjgWzTQK/brwNEoHTvyu0GvAOFFs12KA1XKHPUWisZzw
         30MvIo35A8+lRTgGFa4IQLagJM8PacqoFb70+YN2sTtz6WUp9LaOW99WBOWAd4gfQcAs
         AkUUp59ZCCK9bL78vEtosCWdxJCgRUd5P4ZmdxVdF1KUIP1djIkR+L4WWLXi3RHSo56H
         khckv3SUcvlERB45aPbs8GmqPNqbP6Yy1LgkXOxWvhk2HjgyjTwKIQYJ+whWUCtmFSeE
         E82B4iKlKH304u6tgh7YXREXufIGwTTxhNMnKnk9DUsU9RYPyZVL0n3ip8lhxhKiVxcE
         3xJA==
X-Gm-Message-State: AOAM530IteUyq7WmAkNnT20BLTG1X9QanD55bAHZk6HMcgOvD5QWiZys
        YdiCyl2BlGB24Gv8zr38/zatsAKbytE6Fw==
X-Google-Smtp-Source: ABdhPJzHDoi2QazlmMxW40x6SXwOuFxK5QYjsudj+2JtXVOLGeFzpnqUUU486h7LWsKVbcffefQrJA==
X-Received: by 2002:a05:6402:1387:b0:416:2747:266e with SMTP id b7-20020a056402138700b004162747266emr14347844edv.409.1646744039569;
        Tue, 08 Mar 2022 04:53:59 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f15-20020a50e08f000000b004134a121ed2sm7813108edl.82.2022.03.08.04.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 04:53:58 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nRZLi-001tQT-4v;
        Tue, 08 Mar 2022 13:53:58 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Jason Yundt <jason@jasonyundt.email>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] gitweb: remove invalid http-equiv="content-type"
Date:   Tue, 08 Mar 2022 13:44:35 +0100
References: <20220307033723.175553-1-jason@jasonyundt.email>
 <20220308010711.61817-3-jason@jasonyundt.email>
 <Yia2Y2zoOjvVdJ9O@camp.crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <Yia2Y2zoOjvVdJ9O@camp.crustytoothpaste.net>
Message-ID: <220308.86cziwy595.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 08 2022, brian m. carlson wrote:

> [[PGP Signed Part:Undecided]]
> On 2022-03-08 at 01:07:11, Jason Yundt wrote:
>> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
>> index fbd1c20a23..59457c1004 100755
>> --- a/gitweb/gitweb.perl
>> +++ b/gitweb/gitweb.perl
>> @@ -4225,7 +4225,7 @@ sub git_header_html {
>>  <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
>>  <!-- git core binaries version $git_version -->
>>  <head>
>> -<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
>> +<meta charset="utf-8"/>
>
> I don't actually think this is an improvement.  I don't think it's
> necessary, considering we have an XML declaration and the HTTP header,
> both of which already say it's UTF-8 and will take precedence over this.

Ageed. I was a bit surprised per Jason's
https://lore.kernel.org/git/109813056.nniJfEyVGO@jason-desktop-linux/
that the removal wasn't kept.

I.e. he was replying to a question of mine asking whether we didn't need
this data at rest, e.g if you save the page. I didn't notice the "<?xml
version..." we emit, which seems to be enough.

I.e. this seems to have always been redundant going back to c994d620cc8
(v220, 2005-08-07), or rather, the character set part of it.

Maybe I still don't understand this, but the commit message seems to me
be conflating whether we send the *right* http-equiv with whether we
send it at all, i.e. if the problem is that XML documents shouldn't be
text/html isn't this correct?:
	
	diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
	index fbd1c20a232..c1c5af0b197 100755
	--- a/gitweb/gitweb.perl
	+++ b/gitweb/gitweb.perl
	@@ -4049,7 +4049,13 @@ sub get_page_title {
	 	return $title;
	 }
	 
	+sub get_content_type_xml {
	+	return 'application/xhtml+xml';
	+}
	+
	 sub get_content_type_html {
	+	my ($want_xml) = @_;
	+
	 	# require explicit support from the UA if we are to send the page as
	 	# 'application/xhtml+xml', otherwise send it as plain old 'text/html'.
	 	# we have to do this because MSIE sometimes globs '*/*', pretending to
	@@ -4057,7 +4063,7 @@ sub get_content_type_html {
	 	if (defined $cgi->http('HTTP_ACCEPT') &&
	 	    $cgi->http('HTTP_ACCEPT') =~ m/(,|;|\s|^)application\/xhtml\+xml(,|;|\s|$)/ &&
	 	    $cgi->Accept('application/xhtml+xml') != 0) {
	-		return 'application/xhtml+xml';
	+		return get_content_type_html();
	 	} else {
	 		return 'text/html';
	 	}
	@@ -4214,6 +4220,7 @@ sub git_header_html {
	 
	 	my $title = get_page_title();
	 	my $content_type = get_content_type_html();
	+	my $content_type_xml = get_content_type_html();
	 	print $cgi->header(-type=>$content_type, -charset => 'utf-8',
	 	                   -status=> $status, -expires => $expires)
	 		unless ($opts{'-no_http_header'});
	@@ -4225,7 +4232,7 @@ sub git_header_html {
	 <!-- git web interface version $version, (C) 2005-2006, Kay Sievers <kay.sievers\@vrfy.org>, Christian Gierke -->
	 <!-- git core binaries version $git_version -->
	 <head>
	-<meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
	+<meta http-equiv="content-type" content="$content_type_xml; charset=utf-8"/>
	 <meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
	 <meta name="robots" content="index, nofollow"/>
	 <title>$title</title>

Of course we might then *also* decide that <meta http-equiv> in this
case isn't needed at all, but isn't that a seperate change?

And won't conforming browsers treat application/xhtml+xml differently
when the page is saved? A long time ago (Idid some web development)
using it would enable pedantic strictness in browsers, i.e. unclosed
tags etc. would be a hard error, but I can't reproduce that locally in
either Firefox or Chrome now (with just the gitweb output as-is with
that http-equiv tweaked).

So maybe it does nothing, or maybe it's just those browser...
