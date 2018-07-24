Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5BA21F597
	for <e@80x24.org>; Tue, 24 Jul 2018 18:16:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388475AbeGXTYk (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 15:24:40 -0400
Received: from s019.cyon.net ([149.126.4.28]:51144 "EHLO s019.cyon.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388454AbeGXTYk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 15:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=drbeat.li;
         s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version
        :Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IwbTs0SEJttjC8UZKJlG3roC8uaTfkC0IPy2X3hSsh8=; b=qifT0OEpYgdb4EQGnrYwlo72xb
        s/oiTS2/q4oFlzvHq6TnrdKXeUfVLnbOetD3AXFA1okDBY8EsE5BUrwX8FztKIIhFL/PnuI7oLMA1
        IP5Ij6GawhjpLQAWZSHpAKcW7TgP3gDmlxdPSVMotKHSrxkYvc0n7g3C8ALEmYwKKPDLZc7yAe/fw
        T2pstChAwcVK3oWwHfY+9i6A8AKidOkG9xFccFPeVni8aNPUF/19Y6rwjBTEl+hXyU50Gz3DQal0f
        3zO5PA7zLz7fVscdBkxulMQAmvy8HpDe3won0LEWyEQCKiXb7HeRdgaiHqg4227r9QpUJcIvruK07
        Qo7/vCmA==;
Received: from [10.20.10.232] (port=52136 helo=mail.cyon.ch)
        by s019.cyon.net with esmtpa (Exim 4.91)
        (envelope-from <dev+git@drbeat.li>)
        id 1fi1rZ-00A0T9-Mc; Tue, 24 Jul 2018 20:16:50 +0200
Subject: Re: [PATCH v1] config.c: fix msvc compile error
To:     git@jeffhostetler.com, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, me@ttaylorr.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Newsgroups: gmane.comp.version-control.git
References: <20180724153010.6693-1-git@jeffhostetler.com>
From:   Beat Bolli <dev+git@drbeat.li>
Message-ID: <235ae68c-f764-ba3a-c641-ef5f99507564@drbeat.li>
Date:   Tue, 24 Jul 2018 20:16:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180724153010.6693-1-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff

On 24.07.18 17:30, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> In commit fb0dc3bac135e9f6243bd6d293e8c9293c73b9cd code was added
> to builtin/config.c to define a new function and a forward declaration
> for an array of unknown size.  This causes a compile error under MSVC.
> 
> Reorder the code to forward declare the function instead of the array.

This was already fixed (differently) in
<20180705183445.30901-1-dev+git@drbeat.li>.

Cheers,
Beat


> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  builtin/config.c | 79 ++++++++++++++++++++++++++++----------------------------
>  1 file changed, 40 insertions(+), 39 deletions(-)
> 
> diff --git a/builtin/config.c b/builtin/config.c
> index b29d26d..564f18f 100644
> --- a/builtin/config.c
> +++ b/builtin/config.c
> @@ -67,7 +67,46 @@ static int show_origin;
>  	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
>  	PARSE_OPT_NONEG, option_parse_type, (i) }
>  
> -static struct option builtin_config_options[];
> +static int option_parse_type(const struct option *opt, const char *arg,
> +			     int unset);
> +
> +static struct option builtin_config_options[] = {
> +	OPT_GROUP(N_("Config file location")),
> +	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> +	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> +	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
> +	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
> +	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
> +	OPT_GROUP(N_("Action")),
> +	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
> +	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
> +	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
> +	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
> +	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
> +	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
> +	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
> +	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
> +	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
> +	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
> +	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> +	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> +	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
> +	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> +	OPT_GROUP(N_("Type")),
> +	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
> +	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> +	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
> +	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> +	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
> +	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> +	OPT_GROUP(N_("Other")),
> +	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> +	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
> +	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
> +	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> +	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
> +	OPT_END(),
> +};
>  
>  static int option_parse_type(const struct option *opt, const char *arg,
>  			     int unset)
> @@ -119,44 +158,6 @@ static int option_parse_type(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> -static struct option builtin_config_options[] = {
> -	OPT_GROUP(N_("Config file location")),
> -	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
> -	OPT_BOOL(0, "system", &use_system_config, N_("use system config file")),
> -	OPT_BOOL(0, "local", &use_local_config, N_("use repository config file")),
> -	OPT_STRING('f', "file", &given_config_source.file, N_("file"), N_("use given config file")),
> -	OPT_STRING(0, "blob", &given_config_source.blob, N_("blob-id"), N_("read config from given blob object")),
> -	OPT_GROUP(N_("Action")),
> -	OPT_BIT(0, "get", &actions, N_("get value: name [value-regex]"), ACTION_GET),
> -	OPT_BIT(0, "get-all", &actions, N_("get all values: key [value-regex]"), ACTION_GET_ALL),
> -	OPT_BIT(0, "get-regexp", &actions, N_("get values for regexp: name-regex [value-regex]"), ACTION_GET_REGEXP),
> -	OPT_BIT(0, "get-urlmatch", &actions, N_("get value specific for the URL: section[.var] URL"), ACTION_GET_URLMATCH),
> -	OPT_BIT(0, "replace-all", &actions, N_("replace all matching variables: name value [value_regex]"), ACTION_REPLACE_ALL),
> -	OPT_BIT(0, "add", &actions, N_("add a new variable: name value"), ACTION_ADD),
> -	OPT_BIT(0, "unset", &actions, N_("remove a variable: name [value-regex]"), ACTION_UNSET),
> -	OPT_BIT(0, "unset-all", &actions, N_("remove all matches: name [value-regex]"), ACTION_UNSET_ALL),
> -	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
> -	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
> -	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
> -	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
> -	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
> -	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
> -	OPT_GROUP(N_("Type")),
> -	OPT_CALLBACK('t', "type", &type, "", N_("value is given this type"), option_parse_type),
> -	OPT_CALLBACK_VALUE(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
> -	OPT_CALLBACK_VALUE(0, "int", &type, N_("value is decimal number"), TYPE_INT),
> -	OPT_CALLBACK_VALUE(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
> -	OPT_CALLBACK_VALUE(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
> -	OPT_CALLBACK_VALUE(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
> -	OPT_GROUP(N_("Other")),
> -	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
> -	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
> -	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
> -	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
> -	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
> -	OPT_END(),
> -};
> -
>  static void check_argc(int argc, int min, int max) {
>  	if (argc >= min && argc <= max)
>  		return;
> 

