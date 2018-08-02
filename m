Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2D521F597
	for <e@80x24.org>; Thu,  2 Aug 2018 20:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732222AbeHBWwk (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 18:52:40 -0400
Received: from avasout07.plus.net ([84.93.230.235]:43789 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732156AbeHBWwj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 18:52:39 -0400
Received: from [10.0.2.15] ([80.189.70.183])
        by smtp with ESMTPA
        id lKhEf108XjlDzlKhFfeDJE; Thu, 02 Aug 2018 21:59:46 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=6SF67mWK+VR8hB1Kjo6y2g==:117 a=6SF67mWK+VR8hB1Kjo6y2g==:17
 a=IkcTkHD0fZMA:10 a=Xv5iQGVRkRqp_QMkjjUA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/6] add, update-index: fix --chmod argument help
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
 <87k1p9u860.fsf@evledraar.gmail.com>
 <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
 <87h8kdu3ay.fsf@evledraar.gmail.com>
 <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
 <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
 <20180802165457.GC15984@sigill.intra.peff.net>
 <ad2d8f99-07a3-0191-88a2-c43081657988@web.de>
 <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <4b6fa9ca-97ad-74e8-f252-cc62470f5946@ramsayjones.plus.com>
Date:   Thu, 2 Aug 2018 21:59:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bc31a96-1d1a-3b71-59cc-47a3a2e29e16@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfAGkGI36XH9Ngp5AireHnonwpxW8g2pLfwlaz0EL8cuUiChAmB6Sq5ddkipg6k4uHZnnGfkjxu0URrvN5HkXebtElK8J6Xlw38J57IeiU4QdnCxQO0iI
 DErjjeDzpOcqmtYKztRZ56qdRsL/XvIAUPuQIemCKLeTDz7K3zCQBUHN
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 02/08/18 20:17, René Scharfe wrote:
> Don't translate the argument specification for --chmod; "+x" and "-x"
> are the literal strings that the commands accept.
> 
> Separate alternatives using a pipe character instead of a slash, for
> consistency.
> 
> Use the flag PARSE_OPT_LITERAL_ARGHELP to prevent parseopt from adding a
> pair of angular brackets around the argument help string, as that would
> wrongly indicate that users need to replace the literal strings with
> some kind of value.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  builtin/add.c          | 4 +++-
>  builtin/update-index.c | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/builtin/add.c b/builtin/add.c
> index 8a155dd41e..84bfec9b73 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -304,7 +304,9 @@ static struct option builtin_add_options[] = {
>  	OPT_BOOL( 0 , "refresh", &refresh_only, N_("don't add, only refresh the index")),
>  	OPT_BOOL( 0 , "ignore-errors", &ignore_add_errors, N_("just skip files which cannot be added because of errors")),
>  	OPT_BOOL( 0 , "ignore-missing", &ignore_missing, N_("check if - even missing - files are ignored in dry run")),
> -	OPT_STRING( 0 , "chmod", &chmod_arg, N_("(+/-)x"), N_("override the executable bit of the listed files")),
> +	{ OPTION_STRING, 0, "chmod", &chmod_arg, "(+|-)x",

Am I alone in thinking that "(+x|-x)" is more readable?

ATB,
Ramsay Jones

> +	  N_("override the executable bit of the listed files"),
> +	  PARSE_OPT_LITERAL_ARGHELP },
>  	OPT_HIDDEN_BOOL(0, "warn-embedded-repo", &warn_on_embedded_repo,
>  			N_("warn when adding an embedded repository")),
>  	OPT_END(),
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index a8709a26ec..7feda6e271 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -971,7 +971,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
>  			PARSE_OPT_NOARG | /* disallow --cacheinfo=<mode> form */
>  			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>  			(parse_opt_cb *) cacheinfo_callback},
> -		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, N_("(+/-)x"),
> +		{OPTION_CALLBACK, 0, "chmod", &set_executable_bit, "(+|-)x",
>  			N_("override the executable bit of the listed files"),
>  			PARSE_OPT_NONEG | PARSE_OPT_LITERAL_ARGHELP,
>  			chmod_callback},
> 
