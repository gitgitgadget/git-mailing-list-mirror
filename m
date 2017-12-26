Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2EA31F404
	for <e@80x24.org>; Tue, 26 Dec 2017 18:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751086AbdLZSOy (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Dec 2017 13:14:54 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:43069 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750854AbdLZSOx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Dec 2017 13:14:53 -0500
Received: by mail-wm0-f48.google.com with SMTP id n138so36051150wmg.2
        for <git@vger.kernel.org>; Tue, 26 Dec 2017 10:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iMq/zgP5f6fLzlfJYn8cylpdKXhjRjrOEkfb35XE+f8=;
        b=FHD3xQDRz4U4Nr9VBdWAqfWLz9F2UQOS1TRxhFhrvzBRoUkICfONAtbJhqhYX7kVxf
         aV8W6mNd6dvnSUIN/jld52jgqNIvCZilOb3vRM8TWG/AlMsOii0hAny68D23vcHJAoOA
         etxt8SMy2Mhhpi0syTCt1Zpd+GHzXGhxTwBeUS0nUh3hcB/W/BSEiH8VpPDJp+yh74vM
         4WkJPAbSTup2ORaIDf6Pkn7LHIGFF8lia7AzZdP4Gx79Z0LfQjqAupZBl6Xddr9584mG
         /CE145xB0GLciXJCEsTfMD9c7222mBSmogki7XOvIX5BzoLiRUhQgsU50Nqm9JJDI1N8
         PTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iMq/zgP5f6fLzlfJYn8cylpdKXhjRjrOEkfb35XE+f8=;
        b=YckE3ZI/krCLGESueZv2tEYPP6aqrBvFAFcrNv4YPUYTebcnH9b9aHe/pISbocBC21
         SnJ6wwNjw/uleeBZwVty1f7YhXNRk204ZhrRbIQ4O9i/EML85VgOEsKeudaRpfbyX2s2
         ZTf4v2/uHTu/edJ2xf3tkAAcu1HLQ6uzBn9IWUHNE/osBPjG2yMayRZH8iICrQuAj1xe
         1J4wNnBVnclAmS6v5vjhaLilKJnec6eZILzJ1PkKamur9ejC+w8vKb+a0pFuLmoNtCOh
         iyf/FjO4DDjeaZPgEhIIezSSLw1DewiuonmHrk5iwAoicS4fdebQhOqcg946aM/JAXcn
         GWlg==
X-Gm-Message-State: AKGB3mKwvmfRFCFmwU/IjfKI4ZN1GXdCWY0VJOXiE0nZ1cWH6bS2VBMm
        SAi2QZEgZ4C4Xn/3bb5rqoA=
X-Google-Smtp-Source: ACJfBosqQoa3+4NpH/he6KeTX3GgkWB5iUeqFpeOHZqq/LwXYzZGKvP5XIAITgxrFXmbAFeRA+pYhw==
X-Received: by 10.28.132.209 with SMTP id g200mr20076070wmd.91.1514312091488;
        Tue, 26 Dec 2017 10:14:51 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id i65sm71675269wme.20.2017.12.26.10.14.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Dec 2017 10:14:50 -0800 (PST)
Subject: Re: [PATCH v2 6/7] wt-status.c: handle worktree renames
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, alexmv@dropbox.com
References: <20171225103718.24443-1-pclouds@gmail.com>
 <20171226091012.24315-1-pclouds@gmail.com>
 <20171226091012.24315-7-pclouds@gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <d0f2055c-e0c4-32af-6371-53d0e9a5fbc5@gmail.com>
Date:   Tue, 26 Dec 2017 19:14:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171226091012.24315-7-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy,

On 26/12/2017 10:10, Nguyễn Thái Ngọc Duy wrote:
> Before 425a28e0a4 (diff-lib: allow ita entries treated as "not yet exist
> in index" - 2016-10-24) there are never "new files" in the index, which
> essentially disables rename detection because we only detect renames
> when a new file appears in a diff pair.
> 
> After that commit, an i-t-a entry can appear as a new file in "git
> diff-files". But the diff callback function in wt-status.c does not
> handle this case and produces incorrect status output.
> 
> PS. The reader may notice that this patch adds a new xstrdup() but not
> a free(). Yes we leak memory (the same for head_path). But wt_status
> so far has been short lived, this leak should not matter in
> practice.
> 
> Noticed-by: Alex Vandiver <alexmv@dropbox.com>
> Helped-by: Igor Djordjevic <igor.d.djordjevic@gmail.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  t/t2203-add-intent.sh | 28 ++++++++++++++++++++
>  wt-status.c           | 72 +++++++++++++++++++++++++++++++++++++++------------
>  wt-status.h           |  4 +--
>  3 files changed, 85 insertions(+), 19 deletions(-)
> 
> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 878e73fe98..e5bfda1853 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -162,5 +162,33 @@ test_expect_success 'commit: ita entries ignored in empty commit check' '
>  	)
>  '
>  
> +test_expect_success 'rename detection finds the right names' '
> +	git init rename-detection &&
> +	(
> +		cd rename-detection &&
> +		echo contents > first &&
> +		git add first &&
> +		git commit -m first &&
> +		mv first third &&
> +		git add -N third &&
> +
> +		git status | grep -v "^?" >actual.1 &&
> +		test_i18ngrep "renamed: *first -> third" actual.1 &&
> +
> +		git status --porcelain | grep -v "^?" >actual.2 &&
> +		cat >expected.2 <<-\EOF &&
> +		 R first -> third
> +		EOF
> +		test_cmp expected.2 actual.2 &&
> +
> +		oid=12f00e90b6ef79117ce6e650416b8cf517099b78 &&
> +		git status --porcelain=v2 | grep -v "^?" >actual.3 &&
> +		cat >expected.3 <<-EOF &&
> +		2 .R N... 100644 100644 100644 $oid $oid R100 first	third
> +		EOF
> +		test_cmp expected.3 actual.3
> +	)
> +'
> +
>  test_done

I`m afraid "--porcelain=v2" test might be incorrect here, as `git 
status --porcelain=v2` output seems to be too, with this v2 series 
applied. Test I sent previously[1] fails, and it looks valid.

This is output I now get, with old/deleted file unstaged and 
new/created file staged with `git add -N`:

    $ git status --porcelain=v2
    2 .R N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 original-file	new-file

Note "original-file" listed first, where "new-file" listed second 
(last). According the "v2" documentation[2] (excerpt):

  ... <path><sep><origPath>

  <path>     The pathname. In a renamed/copied entry, this
             is the path in the index and in the working tree.
  ...
  <origPath> The pathname in the commit at HEAD. This is only
             present in a renamed/copied entry, and tells
             where the renamed/copied contents came from.


If I`m reading this correctly, it should be vice-versa - value from 
HEAD, being "original-file", should come last, where value from 
working tree ("new-file") should be first.

If I stage both files and try again, output is as expected 
("new-file" comes first):

    $ git status --porcelain=v2
    2 R. N... 100644 100644 100644 12f00e90b6ef79117ce6e650416b8cf517099b78 12f00e90b6ef79117ce6e650416b8cf517099b78 R100 new-file	original-file

> diff --git a/wt-status.c b/wt-status.c
> index c124d7589c..d5bdf4c2e9 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -376,6 +376,8 @@ static void wt_longstatus_print_change_data(struct wt_status *s,
>  			strbuf_addch(&extra, ')');
>  		}
>  		status = d->worktree_status;
> +		if (d->worktree_path)
> +			two_name = d->worktree_path;
>  		break;
>  	default:
>  		die("BUG: unhandled change_type %d in wt_longstatus_print_change_data",
> @@ -460,6 +462,12 @@ static void wt_status_collect_changed_cb(struct diff_queue_struct *q,
>  			/* mode_worktree is zero for a delete. */
>  			break;
>  
> +		case DIFF_STATUS_COPIED:
> +		case DIFF_STATUS_RENAMED:
> +			d->worktree_path = xstrdup(p->two->path);
   			                              ^^^
This is changed from v1 of this patch, where it was:

+			d->worktree_path = xstrdup(p->one->path);
 			                              ^^^
..., and might be it introduced the issue here...? Or, if this is 
correct now, then might be the other part further below should then 
be adapted accordingly, inside wt_porcelain_v2_print_changed_entry()?

> +			d->worktree_score = p->score * 100 / MAX_SCORE;
> +			/* fallthru */
> +
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_TYPE_CHANGED:
>  		case DIFF_STATUS_UNMERGED:
> @@ -1712,6 +1720,7 @@ static void wt_shortstatus_status(struct string_list_item *it,
>  			 struct wt_status *s)
>  {
>  	struct wt_status_change_data *d = it->util;
> +	const char *from, *to;
>  
>  	if (d->index_status)
>  		color_fprintf(s->fp, color(WT_STATUS_UPDATED, s), "%c", d->index_status);
> @@ -1722,15 +1731,30 @@ static void wt_shortstatus_status(struct string_list_item *it,
>  	else
>  		putchar(' ');
>  	putchar(' ');
> +
> +	if (d->head_path && d->worktree_path)
> +		die("BUG: to be addressed in the next patch");
> +
> +	if (d->head_path) {
> +		from = d->head_path;
> +		to = it->string;
> +	} else if (d->worktree_path) {
> +		from = it->string;
> +		to = d->worktree_path;
> +	} else {
> +		from = it->string;
> +		to = NULL;
> +	}
>  	if (s->null_termination) {
> -		fprintf(stdout, "%s%c", it->string, 0);
> -		if (d->head_path)
> -			fprintf(stdout, "%s%c", d->head_path, 0);
> +		fprintf(stdout, "%s%c", from, 0);
> +		if (to)
> +			fprintf(stdout, "%s%c", to, 0);
>  	} else {
>  		struct strbuf onebuf = STRBUF_INIT;
>  		const char *one;
> -		if (d->head_path) {
> -			one = quote_path(d->head_path, s->prefix, &onebuf);
> +
> +		if (to) {
> +			one = quote_path(from, s->prefix, &onebuf);
>  			if (*one != '"' && strchr(one, ' ') != NULL) {
>  				putchar('"');
>  				strbuf_addch(&onebuf, '"');
> @@ -1738,8 +1762,9 @@ static void wt_shortstatus_status(struct string_list_item *it,
>  			}
>  			printf("%s -> ", one);
>  			strbuf_release(&onebuf);
> -		}
> -		one = quote_path(it->string, s->prefix, &onebuf);
> +			one = quote_path(to, s->prefix, &onebuf);
> +		} else
> +			one = quote_path(from, s->prefix, &onebuf);
>  		if (*one != '"' && strchr(one, ' ') != NULL) {
>  			putchar('"');
>  			strbuf_addch(&onebuf, '"');
> @@ -2036,12 +2061,13 @@ static void wt_porcelain_v2_print_changed_entry(
>  {
>  	struct wt_status_change_data *d = it->util;
>  	struct strbuf buf_index = STRBUF_INIT;
> -	struct strbuf buf_head = STRBUF_INIT;
> +	struct strbuf buf_other = STRBUF_INIT;
>  	const char *path_index = NULL;
> -	const char *path_head = NULL;
> -	char key[3];
> +	const char *path_other = NULL;
> +	char key[3], status_other;
>  	char submodule_token[5];
>  	char sep_char, eol_char;
> +	int score;
>  
>  	wt_porcelain_v2_fix_up_changed(it, s);
>  	wt_porcelain_v2_submodule_state(d, submodule_token);
> @@ -2050,6 +2076,19 @@ static void wt_porcelain_v2_print_changed_entry(
>  	key[1] = d->worktree_status ? d->worktree_status : '.';
>  	key[2] = 0;
>  
> +	if (d->head_path && d->worktree_path)
> +		die("BUG: to be addressed in the next patch");
> +
> +	if (d->head_path) {
> +		path_other = d->head_path;
> +		status_other = d->index_status;
> +		score = d->head_score;
> +	} else if (d->worktree_path) {
> +		path_other = d->worktree_path;
> +		status_other = d->worktree_status;
> +		score = d->worktree_score;
> +	}
> +

"path_other" calculation seems incorrect here...? As that one is 
later used as "<origPath>", coming last, it should be value from HEAD 
exclusively (in case of rename/copy, otherwise empty).

Here, in case HEAD is missing, "path_other" is set to worktree path - 
which should be only (possibly) found inside "<path>", being the 
first listed of the two paths (currently represented by "path_index" 
further below).

That said, might be even better to have previously existing "path_head"
variable restored, and "path_index" replaced with this new "path_other" 
instead, as that`s what documentation seems to talk about.

>  	if (s->null_termination) {
>  		/*
>  		 * In -z mode, we DO NOT C-quote pathnames.  Current path is ALWAYS first.
> @@ -2058,7 +2097,6 @@ static void wt_porcelain_v2_print_changed_entry(
>  		sep_char = '\0';
>  		eol_char = '\0';
>  		path_index = it->string;
> -		path_head = d->head_path;
>  	} else {
>  		/*
>  		 * Path(s) are C-quoted if necessary. Current path is ALWAYS first.
> @@ -2069,17 +2107,17 @@ static void wt_porcelain_v2_print_changed_entry(
>  		sep_char = '\t';
>  		eol_char = '\n';
>  		path_index = quote_path(it->string, s->prefix, &buf_index);
> -		if (d->head_path)
> -			path_head = quote_path(d->head_path, s->prefix, &buf_head);
> +		if (path_other)
> +			path_other = quote_path(path_other, s->prefix, &buf_other);
>  	}
>  
> -	if (path_head)
> +	if (path_other)
>  		fprintf(s->fp, "2 %s %s %06o %06o %06o %s %s %c%d %s%c%s%c",
>  				key, submodule_token,
>  				d->mode_head, d->mode_index, d->mode_worktree,
>  				oid_to_hex(&d->oid_head), oid_to_hex(&d->oid_index),
> -				key[0], d->head_score,
> -				path_index, sep_char, path_head, eol_char);
> +				status_other, score,
> +				path_index, sep_char, path_other, eol_char);
   				^^^^^^^^^^            ^^^^^^^^^^
This seems mixed up a bit - first value (now "path_index") should be 
"index and/or working tree" (so "path_other", I guess), and second 
value (now "path_other") should be "path_head" (exclusively).

>  	else
>  		fprintf(s->fp, "1 %s %s %06o %06o %06o %s %s %s%c",
>  				key, submodule_token,
> @@ -2088,7 +2126,7 @@ static void wt_porcelain_v2_print_changed_entry(
>  				path_index, eol_char);
>  
>  	strbuf_release(&buf_index);
> -	strbuf_release(&buf_head);
> +	strbuf_release(&buf_other);
>  }
>  
>  /*
> diff --git a/wt-status.h b/wt-status.h
> index f9330982ac..332ff545aa 100644
> --- a/wt-status.h
> +++ b/wt-status.h
> @@ -44,10 +44,10 @@ struct wt_status_change_data {
>  	int worktree_status;
>  	int index_status;
>  	int stagemask;
> -	int head_score;
> +	int head_score, worktree_score;
>  	int mode_head, mode_index, mode_worktree;
>  	struct object_id oid_head, oid_index;
> -	char *head_path;
> +	char *head_path, *worktree_path;
>  	unsigned dirty_submodule       : 2;
>  	unsigned new_submodule_commits : 1;
>  };
> 

Funny thing is that, overall, changes this patch introduces regarding 
"--porcelain=v2" are (functionally) pretty much what I did in that 
exercise patch I sent earlier[3], but while that one worked (on top 
of your v1), this one seems not to...

Could it be because of that "p->one->path" vs "p->two->path" 
difference introduced inside wt_status_collect_changed_cb() in patch 
series v2, where wt_porcelain_v2_print_changed_entry() (using the 
affected value) stayed the same as in v1?

Regards, Buga

[1] https://public-inbox.org/git/20171226091012.24315-2-pclouds@gmail.com/T/#m866cf8b7edfd40172972771079c50bd5ff5bd535
[2] https://git-scm.com/docs/git-status#_porcelain_format_version_2
[3] https://public-inbox.org/git/20171226091012.24315-2-pclouds@gmail.com/T/#m095c33d69994c6ecb4f1adbf80dd48eab66750d8
