Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B72211B4
	for <e@80x24.org>; Mon, 14 Jan 2019 11:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbfANLMI (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 06:12:08 -0500
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:2339 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726542AbfANLMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 06:12:08 -0500
Received: from [192.168.2.201] ([92.28.143.98])
        by smtp.talktalk.net with SMTP
        id j0A0gjMWwwhzSj0A0gRmx1; Mon, 14 Jan 2019 11:12:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1547464325;
        bh=t/NhHkmCclcqE1CPtQFdOGCw7pWioxxBEpFDPvDGYGY=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U3AG3E8sqi7M3T3b9ecLHO/mKGt7bH/d36H5Ag84I9F7v9ws+2C1SRno61yE68a8X
         BoacnjK4bqm8EJm8ooGPMIifvSwHVPxL7OPZ16OkMeU8rnrpG2yYjZW71F2B7a092W
         HEOsFvnGsBhce1iivp/oD51F1UvVd4DFvleXwBK4=
X-Originating-IP: [92.28.143.98]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=j7EZ+OPOvdswaUU3zPu4lA==:117
 a=j7EZ+OPOvdswaUU3zPu4lA==:17 a=IkcTkHD0fZMA:10 a=69EAbJreAAAA:8
 a=vNuk4kiWIt_Rtt1YJIQA:9 a=QEXdDO2ut3YA:10
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 5/7] add-interactive.c: implement show-help command
To:     Slavica Djukic via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
References: <pull.103.git.gitgitgadget@gmail.com>
 <19fdea5db197527ce306f23cc6fb71aadc9465cd.1545307756.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <6a8fb6b5-31bf-df19-5ab6-997cd1d2379f@talktalk.net>
Date:   Mon, 14 Jan 2019 11:12:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <19fdea5db197527ce306f23cc6fb71aadc9465cd.1545307756.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAW6+GCbqXCX2dD+BXmIxTFw3VmtYb9l1rlUxrFoyijMGnYGm1uZhmQTTXMuG8U1nxjDnvIP/TEY2EkMDaKVKbC4KJqGeUpb384b6NJ6CCb6O8xN5lzt
 hsaEEHu+8178FVe5TdDrQOO6UmKhYc3RZdpyuv9FHSN95ui7+zc1wYOQu9iDBuyOrhWeGECL2zQKnSETaVhw34rmIchjISL8+vReZAgFEoxBSxsXXyqDG5qT
 y8Lo3USy3XgjZ41VZB5xn39/siFOKsJd6DdhrQJEfy8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Slavica

I think the basics of this patch are fine, I've got a few comments below

On 20/12/2018 12:09, Slavica Djukic via GitGitGadget wrote:
> From: Slavica Djukic <slawica92@hotmail.com>
> 
> Implement show-help command in add-interactive.c and use it in
> builtin add--helper.c.
> 
> Use command name "show-help" instead of "help": add--helper is
> builtin, hence add--helper --help would be intercepted by
> handle_builtin and re-routed to the help command, without ever
> calling cmd_add__helper().
> 
> Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
> ---
>  add-interactive.c     | 19 +++++++++++++++++++
>  add-interactive.h     |  2 ++
>  builtin/add--helper.c |  7 ++++++-
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/add-interactive.c b/add-interactive.c
> index c55d934186..ff5bfbac49 100644
> --- a/add-interactive.c
> +++ b/add-interactive.c
> @@ -8,6 +8,16 @@
>  
>  #define HEADER_INDENT "      "
>  
> +/* TRANSLATORS: please do not translate the command names
> +   'status', 'update', 'revert', etc. */
> +static const char help_info[] = 
> +		N_("status        - show paths with changes\n"
> +		"update        - add working tree state to the staged set of changes\n"
> +		"revert        - revert staged set of changes back to the HEAD version\n"
> +		"patch         - pick hunks and update selectively\n"
> +		"diff          - view diff between HEAD and index\n"
> +		"add untracked - add contents of untracked files to the staged set of changes");

If we were starting from scratch I'd suggest only translating the help
text, not the command names as this would avoid any possible problems
with the command names and indentation. As we already have this
translated it is easier to leave it as is unless the translators think
it would be useful to change it. I'd be inclined to put this definition
next to the function that uses it (or possibly in that function) so it
is easy to see what text will be printed when reading the function.

> +
>  enum collection_phase {
>  	WORKTREE,
>  	INDEX
> @@ -244,3 +254,12 @@ void add_i_print_modified(void)
>  	free(files);
>  	hashmap_free(&s.file_map, 1);
>  }
> +
> +void show_help(void)
> +{
> +	const char *help_color = get_color(COLOR_HELP);
> +	const char *modified_fmt = _("%s");

This does not need to be translated, also I'm not sure we need a
separate variable (unless something funny is happening - why has it got
'modified' in its name?)

> +	printf("\n");
> +	color_fprintf(stdout, help_color, modified_fmt, _(help_info));
> +	printf("\n");
> +}
> diff --git a/add-interactive.h b/add-interactive.h
> index 1f4747553c..a74c65b7e1 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -5,4 +5,6 @@ int add_i_config(const char *var, const char *value, void *cbdata);
>  
>  void add_i_print_modified(void);
>  
> +void show_help(void);

As this is a global function I think it needs a more specific name to
avoid clashing with a function that shows the help for a different
command. Maybe add_i_show_help() to match add_i_print_modified()?

> +
>  #endif
> \ No newline at end of file

C files should end with a new line (it is actually undefined behavior if
they don't!)

Best Wishes

Phillip

> diff --git a/builtin/add--helper.c b/builtin/add--helper.c
> index 43545d9af5..e288412d56 100644
> --- a/builtin/add--helper.c
> +++ b/builtin/add--helper.c
> @@ -10,7 +10,8 @@ static const char * const builtin_add_helper_usage[] = {
>  
>  enum cmd_mode {
>  	DEFAULT = 0,
> -	STATUS
> +	STATUS,
> +	HELP
>  };
>  
>  int cmd_add__helper(int argc, const char **argv, const char *prefix)
> @@ -20,6 +21,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
>  	struct option options[] = {
>  		OPT_CMDMODE(0, "status", &mode,
>  			 N_("print status information with diffstat"), STATUS),
> +		OPT_CMDMODE(0, "show-help", &mode,
> +			 N_("show help"), HELP),
>  		OPT_END()
>  	};
>  
> @@ -30,6 +33,8 @@ int cmd_add__helper(int argc, const char **argv, const char *prefix)
>  
>  	if (mode == STATUS)
>  		add_i_print_modified();
> +	else if (mode == HELP)
> +		show_help();
>  	else
>  		usage_with_options(builtin_add_helper_usage,
>  				   options);
> 

