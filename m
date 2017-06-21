Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC6320401
	for <e@80x24.org>; Wed, 21 Jun 2017 21:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdFUVjy (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 17:39:54 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:35576 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752124AbdFUVjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 17:39:52 -0400
Received: by mail-pf0-f169.google.com with SMTP id c73so30598846pfk.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RDwVQydv1Z6t3HELvAEwVqDLs6UizOgPV3VjsS4amhU=;
        b=SmN+2wbejHUjpWxRrCRNJf/6p2XbL0xZ6A/pAeD1LUauUFbN8JE3zzjlxes5ed0IiQ
         NOGCZfZgdoIZeZK6zc5IGY4poA8dRsSbKyfpaDiEYVUOjYF+OIYK9QV6liN9Kb6lT3PI
         iXsj+wlBfSqw9R531J0Z0YKU23mVGN1V/1WDYwRcNeqVXgBep/u6ZhIfhUixHgfo+UUK
         +TyEYnewUYlmZOO3WLx1Icjnj+j/fwTWNDtgb3X5Qem6zQW30UEcV7slxRZhDFsS3qYn
         RjNKvz2XDDqPxvV2/kLEnzJvUsGRW5k46RjccVJOKPdmdm1jsyL9bnaBX8pZCFFwVjbP
         3LiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RDwVQydv1Z6t3HELvAEwVqDLs6UizOgPV3VjsS4amhU=;
        b=Wr61V9u9j5MIiGEonsBiYeKovkPoeXojn36d+naUBjVz938iaxlme9v6EgFsf954Z6
         GtqcDRa8eCHONS9PnWnw7Zv4iCuVnUuwPwng3tOYH3lWG4wIBbvPEk7bT8YgY0u4vYYm
         hWOF0ZDje6B0q0xyudoNrG35OLF/RFKDazvYbBlJgp52Agpm5V37/Ny81X5I2/W1DgaD
         /sroN/B8pBW/gC7HEJYMHw5n1IFnScX706YEu+i6LpOxYVKmW3nI9Bx/oauhF9iN7oRw
         fj8+nzRDg1ZCugkPNCHCrzEigJ0tI/+TEj35qoY5JLSITjFW7bOw6MarKYKfy+i5ynDC
         23AQ==
X-Gm-Message-State: AKS2vOyAldxkECV+42ArW81dM/h+Xte+EDqAlbfqEcLdE7ez2NA1BUqI
        eUuDn1bzCNDAIp5O
X-Received: by 10.101.88.67 with SMTP id s3mr38386153pgr.75.1498081191843;
        Wed, 21 Jun 2017 14:39:51 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:d052:1af5:b2b3:bc81])
        by smtp.gmail.com with ESMTPSA id c66sm31964525pfl.81.2017.06.21.14.39.50
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 14:39:50 -0700 (PDT)
Date:   Wed, 21 Jun 2017 14:39:49 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, jonathantanmy@google.com,
        jrnieder@gmail.com, mhagger@alum.mit.edu, peff@peff.net,
        philipoakley@iee.org
Subject: Re: [PATCH 17/26] diff.c: convert show_stats to use emit_diff_symbol
Message-ID: <20170621213949.GD53348@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
 <20170620024816.20021-18-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170620024816.20021-18-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/19, Stefan Beller wrote:
> We call print_stat_summary from builtin/apply, so we still
> need the version with a file pointer, so introduce
> print_stat_summary_0 that uses emit_string machinery and
> keep print_stat_summary with the same arguments around.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 118 +++++++++++++++++++++++++++++++++++++++++------------------------
>  diff.h |   4 +--
>  2 files changed, 77 insertions(+), 45 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index e6ade5fde0..0a5ff2500f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -586,7 +586,10 @@ enum diff_symbol {
>  	DIFF_SYMBOL_SUBMODULE_HEADER,
>  	DIFF_SYMBOL_SUBMODULE_ERROR,
>  	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
> -
> +	DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
> +	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
> +	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
> +	DIFF_SYMBOL_STATS_LINE,
>  };
>  /*
>   * Flags for content lines:
> @@ -628,6 +631,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>  {
>  	static const char *nneof = " No newline at end of file\n";
>  	const char *context, *reset, *set, *meta, *fraginfo;
> +	struct strbuf sb = STRBUF_INIT;
>  	switch (s) {
>  	case DIFF_SYMBOL_SEPARATOR:
>  		fprintf(o->file, "%s%c",
> @@ -756,9 +760,22 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
>  	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
>  		emit_line(o, "", "", line, len);
>  		break;
> +	case DIFF_SYMBOL_STATS_SUMMARY_NO_FILES:
> +		fprintf(o->file, " 0 files changed\n");

Why is this one a fprintf call instead of an emit_line call?  I'm sure
this is intended It just stands out to me.

> +		break;
> +	case DIFF_SYMBOL_STATS_SUMMARY_ABBREV:
> +		emit_line(o, "", "", " ...\n", strlen(" ...\n"));
> +		break;
> +	case DIFF_SYMBOL_STATS_LINE:
> +		emit_line(o, "", "", line, len);
> +		break;
> +	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
> +		emit_line(o, "", "", line, len);
> +		break;
>  	default:
>  		die("BUG: unknown diff symbol");
>  	}
> +	strbuf_release(&sb);
>  }
>  
>  void diff_emit_submodule_del(struct diff_options *o, const char *line)
> @@ -1712,20 +1729,14 @@ static int scale_linear(int it, int width, int max_change)
>  	return 1 + (it * (width - 1) / max_change);
>  }
>  
> -static void show_name(FILE *file,
> -		      const char *prefix, const char *name, int len)
> -{
> -	fprintf(file, " %s%-*s |", prefix, len, name);
> -}
> -
> -static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
> +static void show_graph(struct strbuf *out, char ch, int cnt,
> +		       const char *set, const char *reset)
>  {
>  	if (cnt <= 0)
>  		return;
> -	fprintf(file, "%s", set);
> -	while (cnt--)
> -		putc(ch, file);
> -	fprintf(file, "%s", reset);
> +	strbuf_addstr(out, set);
> +	strbuf_addchars(out, ch, cnt);
> +	strbuf_addstr(out, reset);
>  }
>  
>  static void fill_print_name(struct diffstat_file *file)
> @@ -1749,14 +1760,16 @@ static void fill_print_name(struct diffstat_file *file)
>  	file->print_name = pname;
>  }
>  
> -int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
> +static void print_stat_summary_inserts_deletes(struct diff_options *options,
> +		int files, int insertions, int deletions)
>  {
>  	struct strbuf sb = STRBUF_INIT;
> -	int ret;
>  
>  	if (!files) {
>  		assert(insertions == 0 && deletions == 0);
> -		return fprintf(fp, "%s\n", " 0 files changed");
> +		emit_diff_symbol(options, DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
> +				 NULL, 0, 0);
> +		return;
>  	}
>  
>  	strbuf_addf(&sb,
> @@ -1783,9 +1796,19 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
>  			    deletions);
>  	}
>  	strbuf_addch(&sb, '\n');
> -	ret = fputs(sb.buf, fp);
> +	emit_diff_symbol(options, DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
> +			 sb.buf, sb.len, 0);
>  	strbuf_release(&sb);
> -	return ret;
> +}
> +
> +void print_stat_summary(FILE *fp, int files,
> +			int insertions, int deletions)
> +{
> +	struct diff_options o;
> +	memset(&o, 0, sizeof(o));
> +	o.file = fp;
> +
> +	print_stat_summary_inserts_deletes(&o, files, insertions, deletions);
>  }
>  
>  static void show_stats(struct diffstat_t *data, struct diff_options *options)
> @@ -1795,13 +1818,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  	int total_files = data->nr, count;
>  	int width, name_width, graph_width, number_width = 0, bin_width = 0;
>  	const char *reset, *add_c, *del_c;
> -	const char *line_prefix = "";
>  	int extra_shown = 0;
> +	const char *line_prefix = diff_line_prefix(options);
> +	struct strbuf out = STRBUF_INIT;
>  
>  	if (data->nr == 0)
>  		return;
>  
> -	line_prefix = diff_line_prefix(options);
>  	count = options->stat_count ? options->stat_count : data->nr;
>  
>  	reset = diff_get_color_opt(options, DIFF_RESET);
> @@ -1955,26 +1978,32 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		}
>  
>  		if (file->is_binary) {
> -			fprintf(options->file, "%s", line_prefix);
> -			show_name(options->file, prefix, name, len);
> -			fprintf(options->file, " %*s", number_width, "Bin");
> +			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> +			strbuf_addf(&out, " %*s", number_width, "Bin");
>  			if (!added && !deleted) {
> -				putc('\n', options->file);
> +				strbuf_addch(&out, '\n');
> +				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
> +						 out.buf, out.len, 0);
> +				strbuf_reset(&out);
>  				continue;
>  			}
> -			fprintf(options->file, " %s%"PRIuMAX"%s",
> +			strbuf_addf(&out, " %s%"PRIuMAX"%s",
>  				del_c, deleted, reset);
> -			fprintf(options->file, " -> ");
> -			fprintf(options->file, "%s%"PRIuMAX"%s",
> +			strbuf_addstr(&out, " -> ");
> +			strbuf_addf(&out, "%s%"PRIuMAX"%s",
>  				add_c, added, reset);
> -			fprintf(options->file, " bytes");
> -			fprintf(options->file, "\n");
> +			strbuf_addstr(&out, " bytes\n");
> +			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
> +					 out.buf, out.len, 0);
> +			strbuf_reset(&out);
>  			continue;
>  		}
>  		else if (file->is_unmerged) {
> -			fprintf(options->file, "%s", line_prefix);
> -			show_name(options->file, prefix, name, len);
> -			fprintf(options->file, " Unmerged\n");
> +			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> +			strbuf_addstr(&out, " Unmerged\n");
> +			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
> +					 out.buf, out.len, 0);
> +			strbuf_reset(&out);
>  			continue;
>  		}
>  
> @@ -1997,14 +2026,16 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  				add = total - del;
>  			}
>  		}
> -		fprintf(options->file, "%s", line_prefix);
> -		show_name(options->file, prefix, name, len);
> -		fprintf(options->file, " %*"PRIuMAX"%s",
> +		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
> +		strbuf_addf(&out, " %*"PRIuMAX"%s",
>  			number_width, added + deleted,
>  			added + deleted ? " " : "");
> -		show_graph(options->file, '+', add, add_c, reset);
> -		show_graph(options->file, '-', del, del_c, reset);
> -		fprintf(options->file, "\n");
> +		show_graph(&out, '+', add, add_c, reset);
> +		show_graph(&out, '-', del, del_c, reset);
> +		strbuf_addch(&out, '\n');
> +		emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
> +				 out.buf, out.len, 0);
> +		strbuf_reset(&out);
>  	}
>  
>  	for (i = 0; i < data->nr; i++) {
> @@ -2025,11 +2056,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  		if (i < count)
>  			continue;
>  		if (!extra_shown)
> -			fprintf(options->file, "%s ...\n", line_prefix);
> +			emit_diff_symbol(options,
> +					 DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
> +					 NULL, 0, 0);
>  		extra_shown = 1;
>  	}
> -	fprintf(options->file, "%s", line_prefix);
> -	print_stat_summary(options->file, total_files, adds, dels);
> +
> +	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
>  }
>  
>  static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
> @@ -2041,7 +2074,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
>  
>  	for (i = 0; i < data->nr; i++) {
>  		int added = data->files[i]->added;
> -		int deleted= data->files[i]->deleted;
> +		int deleted = data->files[i]->deleted;
>  
>  		if (data->files[i]->is_unmerged ||
>  		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
> @@ -2051,8 +2084,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
>  			dels += deleted;
>  		}
>  	}
> -	fprintf(options->file, "%s", diff_line_prefix(options));
> -	print_stat_summary(options->file, total_files, adds, dels);
> +	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
>  }
>  
>  static void show_numstat(struct diffstat_t *data, struct diff_options *options)
> diff --git a/diff.h b/diff.h
> index 2ee0ef3908..b73f7a1e75 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -398,8 +398,8 @@ extern int parse_rename_score(const char **cp_p);
>  
>  extern long parse_algorithm_value(const char *value);
>  
> -extern int print_stat_summary(FILE *fp, int files,
> -			      int insertions, int deletions);
> +extern void print_stat_summary(FILE *fp, int files,
> +			       int insertions, int deletions);
>  extern void setup_diff_pager(struct diff_options *);
>  
>  #endif /* DIFF_H */
> -- 
> 2.12.2.575.gb14f27f917
> 

-- 
Brandon Williams
