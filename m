Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FB0C433EF
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4C7860C40
	for <git@archiver.kernel.org>; Sun, 31 Oct 2021 17:15:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhJaRSK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 Oct 2021 13:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhJaRSK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 Oct 2021 13:18:10 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1B8C061570
        for <git@vger.kernel.org>; Sun, 31 Oct 2021 10:15:37 -0700 (PDT)
From:   Eli Schwartz <eschwartz@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635700534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEKGndkZw8jIDOxjgqYFfVQFSBvGc0i31hvUlSBWeFg=;
        b=hzJoGZ5ZJ3/JLfG6g3sReNGo3iPBsTSdyiJl9QgE+ZS2Hd7l3e1TJLlMayCfLbK2SmYkeI
        z598J8GAnsWL9/+EcwMKYZg75xwhtUu4aSvcYwyNOIphli+LPBAGYoSmYR7eLJxDdi9Bwo
        dcISaWFzgdKDoc7lkkiTJvNfS63W+QT3nLaSDab0/VIMzV9rKWv3o6pPd0PcUSBvnQcpMT
        XNBWOZlQRz4Dl0ypj4qONXVTprxK9pDhdciNuMNWfZPoINGsyP7Pb5xpwMkWErk9RgU04S
        dfiBV+jE2j81Bh7euJIw+B/aOIbF5VFojPuvDghulKIAFU2TgSoZUuNnUnJRAX3b/NcTGv
        R7ZQoeLplkEKWQzpMScdxk/qrEaZtqjs+diqQ3LpWEFRKHw0rK8rmqvIxhWrzTEFXb9qcZ
        KCWGbFkgHa6CPLhE4D7MGtPkJ7a5bsyGK37b5bNb04D+jf0aq63OwlA+J7jqIB3kiaKafe
        wMX/S47C258jJ+V+aDSXZ0SLz7WRv3nxTCw9et5BlUYWEtI9eukaGa78QSOaP5DQZUYlOR
        AjdbPUmhJ/+PxC/ynO7tID56jKrKoFDdvp1NQxdfa7enDkCb/ccucnSqk/QoX1LMjpOAmM
        YOj+oC8YwSjcfFtPCCRHwA82xQhcllkxRh2HQgageDM+Rm++r4Jt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635700534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eEKGndkZw8jIDOxjgqYFfVQFSBvGc0i31hvUlSBWeFg=;
        b=tDMo9fFsuWJcYzhaS3rz0DCiJJXRMGIescdDGiO1GKy8yxwIodqHyCdsrowEv/OOOzF7Kv
        zU0S0fLMzMnqQuAg==
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 0/3] Add some more options to the pretty-formats
Date:   Sun, 31 Oct 2021 13:15:07 -0400
Message-Id: <20211031171510.1646396-1-eschwartz@archlinux.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029184512.1568017-1-eschwartz@archlinux.org>
References: <20211029184512.1568017-1-eschwartz@archlinux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Renamed enum values. OPT_ -> DESCRIBE_ARG_
Doc fixups.

Eli Schwartz (3):
  pretty.c: rework describe options parsing for better extensibility
  pretty: add tag option to %(describe)
  pretty: add abbrev option to %(describe)

 Documentation/pretty-formats.txt | 16 ++++++---
 pretty.c                         | 58 ++++++++++++++++++++++++++------
 t/t4205-log-pretty-formats.sh    | 16 +++++++++
 3 files changed, 75 insertions(+), 15 deletions(-)

Range-diff against v3:
1:  55a20468d3 ! 1:  be35fee252 pretty.c: rework describe options parsing for better extensibility
    @@ pretty.c: int format_set_trailers_options(struct process_trailer_options *opts,
     -	const char *options[] = { "match", "exclude" };
     +	struct {
     +		char *name;
    -+		enum { OPT_STRING } type;
    ++		enum {
    ++			DESCRIBE_ARG_STRING,
    ++		} type;
     +	}  option[] = {
    -+		{ "exclude", OPT_STRING },
    -+		{ "match", OPT_STRING },
    ++		{ "exclude", DESCRIBE_ARG_STRING },
    ++		{ "match", DESCRIBE_ARG_STRING },
     +	};
      	const char *arg = start;
      
    @@ pretty.c: int format_set_trailers_options(struct process_trailer_options *opts,
     -				matched = options[i];
     +		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
     +			switch (option[i].type) {
    -+			case OPT_STRING:
    ++			case DESCRIBE_ARG_STRING:
     +				if (match_placeholder_arg_value(arg, option[i].name, &arg,
     +								&argval, &arglen)) {
     +					if (!arglen)
2:  c34c8a4f7f ! 2:  5830c69d4d pretty: add tag option to %(describe)
    @@ Documentation/pretty-formats.txt: The placeholders are:
      			  inconsistent when tags are added or removed at
      			  the same time.
      +
    -+** 'tags[=<BOOL>]': Instead of only considering annotated tags,
    ++** 'tags[=<bool>]': Instead of only considering annotated tags,
     +   consider lightweight tags as well.
      ** 'match=<pattern>': Only consider tags matching the given
         `glob(7)` pattern, excluding the "refs/tags/" prefix.
    @@ Documentation/pretty-formats.txt: insert an empty string unless we are traversin
      decoration format if `--decorate` was not already provided on the command
      line.
      
    -+The boolean options accept an optional value `[=<BOOL>]`. The values
    ++The boolean options accept an optional value `[=<bool>]`. The values
     +`true`, `false`, `on`, `off` etc. are all accepted. See the "boolean"
     +sub-section in "EXAMPLES" in linkgit:git-config[1]. If a boolean
     +option is given with no value, it's enabled.
    @@ Documentation/pretty-formats.txt: insert an empty string unless we are traversin
     
      ## pretty.c ##
     @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *args)
    - {
      	struct {
      		char *name;
    --		enum { OPT_STRING } type;
    -+		enum { OPT_BOOL, OPT_STRING, } type;
    + 		enum {
    ++			DESCRIBE_ARG_BOOL,
    + 			DESCRIBE_ARG_STRING,
    + 		} type;
      	}  option[] = {
    -+		{ "tags", OPT_BOOL},
    - 		{ "exclude", OPT_STRING },
    - 		{ "match", OPT_STRING },
    ++		{ "tags", DESCRIBE_ARG_BOOL},
    + 		{ "exclude", DESCRIBE_ARG_STRING },
    + 		{ "match", DESCRIBE_ARG_STRING },
      	};
     @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *args)
      		int found = 0;
    @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *ar
      
      		for (i = 0; !found && i < ARRAY_SIZE(option); i++) {
      			switch (option[i].type) {
    -+			case OPT_BOOL:
    ++			case DESCRIBE_ARG_BOOL:
     +				if (match_placeholder_bool_arg(arg, option[i].name, &arg, &optval)) {
     +					if (optval)
     +						strvec_pushf(args, "--%s", option[i].name);
    @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *ar
     +					found = 1;
     +				}
     +				break;
    - 			case OPT_STRING:
    + 			case DESCRIBE_ARG_STRING:
      				if (match_placeholder_arg_value(arg, option[i].name, &arg,
      								&argval, &arglen)) {
     
3:  b751aaf3c6 ! 3:  032513150d pretty: add abbrev option to %(describe)
    @@ Commit message
      ## Documentation/pretty-formats.txt ##
     @@ Documentation/pretty-formats.txt: The placeholders are:
      +
    - ** 'tags[=<BOOL>]': Instead of only considering annotated tags,
    + ** 'tags[=<bool>]': Instead of only considering annotated tags,
         consider lightweight tags as well.
    -+** 'abbrev=<N>': Instead of using the default number of hexadecimal digits
    ++** 'abbrev=<number>': Instead of using the default number of hexadecimal digits
     +   (which will vary according to the number of objects in the repository with a
    -+   default of 7) of the abbreviated object name, use <n> digits, or as many digits
    -+   as needed to form a unique object name.
    ++   default of 7) of the abbreviated object name, use <number> digits, or as many
    ++   digits as needed to form a unique object name.
      ** 'match=<pattern>': Only consider tags matching the given
         `glob(7)` pattern, excluding the "refs/tags/" prefix.
      ** 'exclude=<pattern>': Do not consider tags matching the given
     
      ## pretty.c ##
     @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *args)
    - {
    - 	struct {
      		char *name;
    --		enum { OPT_BOOL, OPT_STRING, } type;
    -+		enum { OPT_BOOL, OPT_INTEGER, OPT_STRING, } type;
    + 		enum {
    + 			DESCRIBE_ARG_BOOL,
    ++			DESCRIBE_ARG_INTEGER,
    + 			DESCRIBE_ARG_STRING,
    + 		} type;
      	}  option[] = {
    - 		{ "tags", OPT_BOOL},
    -+		{ "abbrev", OPT_INTEGER },
    - 		{ "exclude", OPT_STRING },
    - 		{ "match", OPT_STRING },
    + 		{ "tags", DESCRIBE_ARG_BOOL},
    ++		{ "abbrev", DESCRIBE_ARG_INTEGER },
    + 		{ "exclude", DESCRIBE_ARG_STRING },
    + 		{ "match", DESCRIBE_ARG_STRING },
      	};
     @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *args)
      					found = 1;
      				}
      				break;
    -+			case OPT_INTEGER:
    ++			case DESCRIBE_ARG_INTEGER:
     +				if (match_placeholder_arg_value(arg, option[i].name, &arg,
     +								&argval, &arglen)) {
     +					char *endptr;
    @@ pretty.c: static size_t parse_describe_args(const char *start, struct strvec *ar
     +					found = 1;
     +				}
     +				break;
    - 			case OPT_STRING:
    + 			case DESCRIBE_ARG_STRING:
      				if (match_placeholder_arg_value(arg, option[i].name, &arg,
      								&argval, &arglen)) {
     
-- 
2.33.1

