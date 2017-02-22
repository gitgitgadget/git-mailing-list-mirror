Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20BF3201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 20:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934477AbdBVUpI (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 15:45:08 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:37412 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934463AbdBVUpE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 15:45:04 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id gdmXc9tE446SJgdmXc6Weq; Wed, 22 Feb 2017 20:45:02 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=CItoZljD c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=Q9fys5e9bTEA:10 a=pGLkceISAAAA:8
 a=MvFm9Y9nhOFzsLT7f6IA:9 a=PUjeQqilurYA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <F71515D0E29940CA9C421D18480AD726@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Andreas Heiduk" <asheiduk@gmail.com>
Cc:     <git@vger.kernel.org>
References: <2b0ce702-60de-534b-8a86-5c7ae84060de@gmail.com> <xmqqh93nfeyj.fsf@gitster.mtv.corp.google.com> <e55b3cb7-65bf-1609-2e8d-823b4336e07a@gmail.com>
Subject: Re: [PATCH] Documentation: Link git-ls-files to core.quotePath variable.
Date:   Wed, 22 Feb 2017 12:21:22 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-15";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfFkctenP/5qH3N7lHNYN/kXWqPVVdKCqa1UD00ja8p6yfOvgZyeK/jDzF2fVLTVK7W5JpXeLQuUCDKgxZ6acVn10YT8h8B3ba6EDT7wdpbt8NoC5aV+Y
 +SmNSx97Zn0/8IMqH6Yvdp/K9ZQgehBLvI8AQ3smpty5ehaI+shd1di2uyOJ1C2CaoXdmZdzWY2Lp2r4rz5yjvonKBDTpFt7J1V/mlcyIfFV5L5XmyD/8/G/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Andreas Heiduk" <asheiduk@gmail.com>
> [PATCH] Documentation: Clarify core.quotePath, remove cruft in
> git-ls-files.
>
> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> ---
>
> I have merged the best parts about quoting into the core.quotePath
> description and cleaned up the text in git-ls-files.txt regarding the
> control characters.
>
>
> Documentation/config.txt       | 22 ++++++++++++----------
> Documentation/git-ls-files.txt | 11 ++++++-----
> 2 files changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f4721a0..25e65ae 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -340,16 +340,18 @@ core.checkStat::
>  all fields, including the sub-second part of mtime and ctime.
>
> core.quotePath::
> - The commands that output paths (e.g. 'ls-files',
> - 'diff'), when not given the `-z` option, will quote
> - "unusual" characters in the pathname by enclosing the
> - pathname in a double-quote pair and with backslashes the
> - same way strings in C source code are quoted.  If this
> - variable is set to false, the bytes higher than 0x80 are
> - not quoted but output as verbatim.  Note that double
> - quote, backslash and control characters are always
> - quoted without `-z` regardless of the setting of this
> - variable.
> + Commands that output paths (e.g. 'ls-files', 'diff'), will
> + quote "unusual" characters in the pathname by enclosing the
> + pathname in double-quotes and escaping those characters with
> + backslashes in the same way C escapes control characters (e.g.
> + `\t` for TAB, `\n` for LF, `\\` for backslash) or bytes with
> + values larger than 0x80 (e.g. octal `\265` for "micro").  If
> + this variable is set to false, bytes higher than 0x80 are not
> + considered "unusual" any more.  Double-quotes, backslash and
> + control characters are always escaped regardless of the
> + setting of this variable.  Many commands can output pathnames
> + completely verbatim using the `-z` option. The default value is
> + true.
>
> core.eol::
>  Sets the line ending type to use in the working directory for
> diff --git a/Documentation/git-ls-files.txt 
> b/Documentation/git-ls-files.txt
> index d2b17f2..88df561 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -76,7 +76,8 @@ OPTIONS
>  succeed.
>
> -z::
> - \0 line termination on output.
> + \0 line termination on output and do not quote filenames.
> + See OUTPUT below for more information.
>
> -x <pattern>::
> --exclude=<pattern>::
> @@ -192,10 +193,10 @@ the index records up to three such pairs; one from
> tree O in stage
> the user (or the porcelain) to see what should eventually be recorded
> at the
> path. (see linkgit:git-read-tree[1] for more information on state)
>
> -When `-z` option is not used, TAB, LF, and backslash characters
> -in pathnames are represented as `\t`, `\n`, and `\\`,
> -respectively. The path is also quoted according to the
> -configuration variable `core.quotePath` (see linkgit:git-config[1]).
> +Without the `-z` option pathnamens with "unusual" characters are

s/option pathnamens/option, pathnames/    # comma and spelling.

> +quoted as explained for the configuration variable `core.quotePath`
> +(see linkgit:git-config[1]).  Using `-z` the filename is output
> +verbatim and the line is terminated by a NUL byte.
>
--
Philip 

