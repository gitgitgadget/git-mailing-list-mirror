Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36789C61DA4
	for <git@archiver.kernel.org>; Tue,  7 Mar 2023 00:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjCGAqq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Mar 2023 19:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCGAqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2023 19:46:45 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343FB47402
        for <git@vger.kernel.org>; Mon,  6 Mar 2023 16:46:44 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id i4so7644694ils.1
        for <git@vger.kernel.org>; Mon, 06 Mar 2023 16:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1678150003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FwjF8mOlEck314nUBmdaXOKaPHNE9uN/3GrZe7O9f6c=;
        b=mPSJ1Ttg4QP5/ZE4wQA+FkoS33HHlhRf3S2UoOkK2RNuvnNK3VcEoR5D2qsflICjsY
         9PzZYixaIlkiJBRxaho+ObrZZcwp+vMa3lmWlp9AVd3qcPS1lZGEE++u8ulqNqsjIgVt
         idi+NWR3zjEHa9d3SyA8XHbZBrgv1VXt0TDWQqq53fqUGgCj8abxeUfEs9Vijo88nPBF
         d6lPxa6SpNV+xQSXmu6HYPO1qG+/SpOrknpBcG2NUkzbPUwe2dht//YOZPEU7vw2NDOD
         rrO6qBOGhqvvk+wqeopRCYt4bHeib5XUOFaEDLzCGL3sxGrTOMquNcjx2HtKoq81qJmt
         Uljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678150003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwjF8mOlEck314nUBmdaXOKaPHNE9uN/3GrZe7O9f6c=;
        b=zCU5r5Ic4HpTD9hbQPR7iRVBT+iPXqYbG89L/f9eY6NQskCCTpvJ0LU2UOlh/X5092
         SBOvtp+EUOWc5A7zJHFCk4k9kfn9YCq81ko2j87D0Qdf4u9/9PA+swl+OOigw6yJYDvh
         CyFdQhNAXfBZnBAm5eLco+fwekNdXpfGQFJSBU0GUllr78PNRtQUZhSK/DthjuxdJRAc
         tfIkQ4VJABHLsrsQrkVduslWP2IEo8yl+ZRZNcFw0IjUCABmhQXYRLHwTzxAPeDOsG6x
         g77c5vR08Q1arCXZREjrdRAHWYrsDBrUNcetJOwQ3TVPWS3Z/vNyFKnRdETnBx0uV4HQ
         YkCg==
X-Gm-Message-State: AO0yUKXChYTGQ0+lKWP9a9P+1DxXmVxuxvKOjFPCD7Zvq+p2wsL40m6L
        UG493XrFwYysrenK0VcOjbI6rj3a8EWmMGB/teyF0g==
X-Google-Smtp-Source: AK7set/AjwC4U8Lpo84UqXZq6X1znlsGZzz1S8TI8llmMs3inJO3QYh65ST/W6zxN88GWB/duFQoSA==
X-Received: by 2002:a05:6e02:2164:b0:315:475c:5cfb with SMTP id s4-20020a056e02216400b00315475c5cfbmr12537612ilv.2.1678150003501;
        Mon, 06 Mar 2023 16:46:43 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x14-20020a02970e000000b003c51840bc35sm3749467jai.146.2023.03.06.16.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 16:46:43 -0800 (PST)
Date:   Mon, 6 Mar 2023 19:46:42 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 3/8] ahead-behind: implement --ignore-missing option
Message-ID: <ZAaJckdkz6zaF6lw@nand.local>
References: <pull.1489.git.1678111598.gitgitgadget@gmail.com>
 <b1d022c7cac5aed6e2d64b45f20dba5b3297536c.1678111599.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b1d022c7cac5aed6e2d64b45f20dba5b3297536c.1678111599.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 06, 2023 at 02:06:33PM +0000, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
>
> When parsing the tip revisions from the ahead-behind inputs, it is
> important to check that those tips exist before adding them to the list
> for computation. The previous change caused the builtin to return with
> errors if the revisions could not be resolved.
>
> However, when running 'git ahead-behind' in an environment with
> concurrent edits, such as a Git server, then the references could be
> deleted from underneath the caller between reading the reference list
> and starting the 'git ahead-behind' process. Avoid this race by allowing
> the caller to specify '--ignore-missing' and continue using the
> information that is still available.

Well explained, thanks for writing this all out :-).

> diff --git a/builtin/ahead-behind.c b/builtin/ahead-behind.c
> index c1212cc8d46..e4f65fc0548 100644
> --- a/builtin/ahead-behind.c
> +++ b/builtin/ahead-behind.c
> @@ -8,13 +8,18 @@ static const char * const ahead_behind_usage[] = {
>  	NULL
>  };
>
> +static int ignore_missing;
> +
>  static int handle_arg(struct string_list *tips, const char *arg)
>  {
>  	struct string_list_item *item;
>  	struct commit *c = lookup_commit_reference_by_name(arg);
>
> -	if (!c)
> +	if (!c) {
> +		if (ignore_missing)
> +			return 0;
>  		return error(_("could not resolve '%s'"), arg);
> +	}

And the diff makes complete sense here, too.

>  	item = string_list_append(tips, arg);
>  	item->util = c;
> @@ -30,6 +35,7 @@ int cmd_ahead_behind(int argc, const char **argv, const char *prefix)
>  	struct option ahead_behind_opts[] = {
>  		OPT_STRING('b', "base", &base_ref, N_("base"), N_("base reference to process")),
>  		OPT_BOOL(0 , "stdin", &from_stdin, N_("read rev names from stdin")),
> +		OPT_BOOL(0 , "ignore-missing", &ignore_missing, N_("ignore missing tip references")),

The spacing between "0" and the comma and "ignore-missing" (as well with
"stdin" above, though I didn't notice it when reading the previous
patch) is a little funky.

I suspect that it is carried over from some historical typo from many
years ago, but probably worth fixing while we're thinking about it.

Thanks,
Taylor
