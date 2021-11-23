Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 896CAC433F5
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 00:14:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhKWARc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 19:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhKWAR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 19:17:29 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7F6C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:14:22 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q17so15491379plr.11
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 16:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/VZiSEdjr1oibLhhzUFaTyx+QW7ClvEcI87lNTXepdU=;
        b=b8gWe8mGBzyafqZJDKQ+NDZtekI8Pnh6pa8HfCLsHfgDlTirZjPQFXAmtwu5THt3Ex
         X2jXXHz1Z/BuTogySkUjP4wecrhew7G9XIdKkIFp/qW0p+v6dvIF09NzxGyPpYXujCYL
         2S/h4htXuoJ3SsRCq9P7+BBCtYyMVnxnUqLCjLGDU7r0t8DdLOgMaYuSy+n0RI7sMWG+
         MBfXWgUiZh2/9W5baxWJ6Ox70FDQzGLbREasooauDawOkVkcFZlcnRN85T+InnrybexX
         X6yS3tdkoL9QsnoTb3e1ReYqI4n5aIPNsjTlICrwCKIyt9kURrEpQBp8cWPsizn0eGx8
         nN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/VZiSEdjr1oibLhhzUFaTyx+QW7ClvEcI87lNTXepdU=;
        b=hK9QPjfsYp/yuHLCLj+5YZELli25vc9CzT2sz5f3tJw19N5iky61wu58KqQRhMWSyd
         GbOFW+O967RkPpGHsQCHF+6ZR6sOnTQ7W3qwr26D8q6S/OsXFahO/M5sATSbwU+JR3T6
         EW0Z3g4yBDZ5bJXSV3JUGfgqg8oyIRPhy1S6/Sily4PZm9PyuWkSaxXjbbyMiTV4D8n7
         k6GGkc5pHhhVKP+9rxFAR/QPKsz/Biqe3wgCE1tZSWKR5uSl/zvImcb8/9NKEiIJyVUF
         pk8YmdqRPNbsEDBW+s4P1FtZDd4rqWLXJh5VEpu9TzHBiy8CiLz50tbE9L+bnvA977I3
         V5wQ==
X-Gm-Message-State: AOAM530B4iZfspH271KlK89/Gi3/PIfeHvwfH2hRX8jq/so2Dp/P75Sx
        8tnJ3OdCX+a39W7nq354q/sHTnviATw=
X-Google-Smtp-Source: ABdhPJzciwhD/A/QOola6fkGkvkJssZGAyPp5ourhBT/7hDCQ1nDWjCYv9v39tJ1uBXGutmquMdtxw==
X-Received: by 2002:a17:902:758b:b0:144:ea8e:1bd4 with SMTP id j11-20020a170902758b00b00144ea8e1bd4mr1734918pll.25.1637626461746;
        Mon, 22 Nov 2021 16:14:21 -0800 (PST)
Received: from localhost ([2402:800:63b8:cddb:bcc6:43b2:1270:7935])
        by smtp.gmail.com with ESMTPSA id b10sm10603872pfl.200.2021.11.22.16.14.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 16:14:21 -0800 (PST)
Date:   Tue, 23 Nov 2021 07:14:20 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        peff@peff.net
Subject: Re: [PATCH v3 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Message-ID: <YZwyXAn+gxUZ+aD9@danh.dev>
References: <cover.1637567328.git.dyroneteng@gmail.com>
 <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c15b4c176b7c03072fa59a4efd9f6fea7d62eae.1637567328.git.dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-11-22 16:07:28+0800, Teng Long <dyroneteng@gmail.com> wrote:
> Sometimes, we only want to get the objects from output of `ls-tree`
> and commands like `sed` or `cut` is usually used to intercept the
> origin output to achieve this purpose in practical.
> 
> This commit supply an option names `--oid-only` to let `git ls-tree`
> only print out the OID of the object. `--oid-only` and `--name-only`
> are mutually exclusive in use.
> 
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  Documentation/git-ls-tree.txt |  8 +++++--
>  builtin/ls-tree.c             | 27 ++++++++++++++++-------
>  t/t3104-ls-tree-oid.sh        | 40 +++++++++++++++++++++++++++++++++++
>  3 files changed, 65 insertions(+), 10 deletions(-)
>  create mode 100755 t/t3104-ls-tree-oid.sh
> 
> diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
> index db02d6d79a..bc711dc00a 100644
> --- a/Documentation/git-ls-tree.txt
> +++ b/Documentation/git-ls-tree.txt
> @@ -10,7 +10,8 @@ SYNOPSIS
>  --------
>  [verse]
>  'git ls-tree' [-d] [-r] [-t] [-l] [-z]
> -	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
> +	    [--name-only] [--name-status] [--oid-only]

Please indicate those options are incompatible (as someone else said):

	[--name-only | --name-status | --oid-only]

> +	    [--full-name] [--full-tree] [--abbrev[=<n>]]
>  	    <tree-ish> [<path>...]
>  
>  DESCRIPTION
> @@ -59,7 +60,10 @@ OPTIONS
>  --name-only::
>  --name-status::
>  	List only filenames (instead of the "long" output), one per line.
> -
> +	Cannot be used with `--oid-only` together.
> +--oid-only::
> +	List only OIDs of the objects, one per line. Cannot be used with
> +	`--name-only` or `--name-status` together.
>  --abbrev[=<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
>  	lines, show the shortest prefix that is at least '<n>'
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 3a442631c7..1e4a82e669 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -18,19 +18,26 @@ static int line_termination = '\n';
>  #define LS_RECURSIVE 1
>  #define LS_TREE_ONLY 2
>  #define LS_SHOW_TREES 4
> -#define LS_NAME_ONLY 8
> -#define LS_SHOW_SIZE 16
> +#define LS_SHOW_SIZE 8
>  static int abbrev;
>  static int ls_options;
>  static struct pathspec pathspec;
>  static int chomp_prefix;
>  static const char *ls_tree_prefix;
>  
> -static const  char * const ls_tree_usage[] = {
> +static const char * const ls_tree_usage[] = {
>  	N_("git ls-tree [<options>] <tree-ish> [<path>...]"),
>  	NULL
>  };
>  
> +enum {
> +	MODE_UNSPECIFIED = 0,
> +	MODE_NAME_ONLY,
> +	MODE_OID_ONLY
> +};
> +
> +static int cmdmode = MODE_UNSPECIFIED;
> +
>  static int show_recursive(const char *base, int baselen, const char *pathname)
>  {
>  	int i;
> @@ -90,7 +97,12 @@ static int show_tree(const struct object_id *oid, struct strbuf *base,
>  	else if (ls_options & LS_TREE_ONLY)
>  		return 0;
>  
> -	if (!(ls_options & LS_NAME_ONLY)) {
> +	if (cmdmode == 2) {

I think it's better to use the enum name:

	if (cmdmode == MODE_OID_ONLY) {

> +		printf("%s\n", find_unique_abbrev(oid, abbrev));
> +		return 0;
> +	}
> +
> +	if (cmdmode == 0) {

Ditto:

	if (cmdmode == MODE_UNSPECIFIED) {

Speaking about this, where will MODE_NAME_ONLY be used?

>  		if (ls_options & LS_SHOW_SIZE) {
>  			char size_text[24];
>  			if (!strcmp(type, blob_type)) {
> @@ -135,10 +147,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
>  			    N_("terminate entries with NUL byte"), 0),
>  		OPT_BIT('l', "long", &ls_options, N_("include object size"),
>  			LS_SHOW_SIZE),
> -		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> -		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> +		OPT_CMDMODE('n', "name-only", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
> +		OPT_CMDMODE('s', "name-status", &cmdmode, N_("list only filenames"), MODE_NAME_ONLY),
> +		OPT_CMDMODE('o', "oid-only", &cmdmode, N_("list only oids"), MODE_OID_ONLY),
>  		OPT_SET_INT(0, "full-name", &chomp_prefix,
>  			    N_("use full path names"), 0),
>  		OPT_BOOL(0, "full-tree", &full_tree,
> diff --git a/t/t3104-ls-tree-oid.sh b/t/t3104-ls-tree-oid.sh
> new file mode 100755
> index 0000000000..4c02cdd3c3
> --- /dev/null
> +++ b/t/t3104-ls-tree-oid.sh
> @@ -0,0 +1,40 @@
> +#!/bin/sh
> +
> +test_description='git ls-tree oids handling.'
> +
> +. ./test-lib.sh
> +
> +test_expect_success 'setup' '
> +	echo 111 >1.txt &&
> +	echo 222 >2.txt &&
> +	mkdir -p path0/a/b/c &&
> +	echo 333 >path0/a/b/c/3.txt &&
> +	find *.txt path* \( -type f -o -type l \) -print |
> +	xargs git update-index --add &&
> +	tree=$(git write-tree) &&
> +	echo $tree
> +'
> +
> +test_expect_success 'usage: --oid-only' '
> +	git ls-tree --oid-only $tree >current &&
> +	git ls-tree $tree | awk "{print \$3}" >expected &&
> +	test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --oid-only with -r' '
> +	git ls-tree --oid-only -r $tree >current &&
> +	git ls-tree -r $tree | awk "{print \$3}" >expected &&
> +	test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --oid-only with --abbrev' '
> +	git ls-tree --oid-only --abbrev=6 $tree >current &&
> +	git ls-tree --abbrev=6 $tree | awk "{print \$3}" > expected &&
> +	test_cmp current expected
> +'
> +
> +test_expect_failure 'usage: incompatible options: --name-only with --oid-only' '
> +	test_incompatible_usage git ls-tree --oid-only --name-only
> +'
> +
> +test_done

It seems like you haven't updated the test code from v2

-- 
Danh
