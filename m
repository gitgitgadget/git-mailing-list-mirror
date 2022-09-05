Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95CFECAAD5
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 11:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbiIELEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 07:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238241AbiIELDs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 07:03:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17F5A456
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 04:03:45 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id fy31so16325898ejc.6
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 04:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=7WJm06ExWBjzAcrJB+bNMu5TMIScv/bxZ2MZrthtdII=;
        b=LVB/ZUYusoVqJOBGdpXffpA6bNkGFu9rEIl7OQVdk1vpLvQ4AXoK+T7KG4kj0vnvLM
         jahPCGTLO4S+C7yHWp/8nHladMRrYWZa3c2MAnjEBhaeq28JoeHmW749LrRdoass9msS
         c9eEWQyGfhPu20Qt124EYziSp4x9Y2knkQs6UClsz/Qq0QmuDTh2tcKVy6sbqvh8ybTB
         BFV6vLrVuZXw2GQIAz5OcQbGOVZcXSSv/ScqMIvM1sTodastzWDjHwKwhCR2jNYDgHtJ
         xR8J4cLNz0BuXWl79DUkcNPnKcuCWQQ3O4OKXZ73trzEzcGsqzETvsBKg49+kdXZkLR0
         albw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=7WJm06ExWBjzAcrJB+bNMu5TMIScv/bxZ2MZrthtdII=;
        b=2j3avtnHvABPSB9Qjx+9ccIYSMi3kEjo3C5ERB8D83yQol9AFv2InHKiBWIleDYYSi
         ZjlBF/RarY2wfcmUKfrpuow8KkFx4k1PoCcJkrV7owZ0sYSuYTqFQL3kcOteySgDBjyP
         hpiS+jiUxxJoPW9V/6Tm1HlT4cdobW3kTSIVIgFC/GNuUVjGHlHbLDtLWHBlOfajM2SQ
         c7E45BZI09fZhF6S6THEfgbUK7MW8hzMGFYXKUIHJJE1lhfwcpnpk5O5WBT6UoIIcvq5
         5aVcNuu8xhA+lmxCysya9y4v7/DNDTcDHZv76f9b9euMq0PHlkZa5W9r6VlMXq3gsPhQ
         8PQw==
X-Gm-Message-State: ACgBeo2ruC/9XisNYdKo9N/gJBP6qLbGPB3MkbTqQiYXVkM+y/DMk3hs
        Xw1oYe6imscWdmkhPGXl9mE=
X-Google-Smtp-Source: AA6agR7M3CnRa1t875PtiHc0STkbsH6KTPyYnrPDjEKes3MoeHoc3KKk6VVP1XM4yxtu0truUGEc2Q==
X-Received: by 2002:a17:907:31ce:b0:742:1206:529e with SMTP id xf14-20020a17090731ce00b007421206529emr21300021ejb.643.1662375824092;
        Mon, 05 Sep 2022 04:03:44 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v1-20020a170906292100b0073ae9ba9ba8sm4882965ejd.3.2022.09.05.04.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 04:03:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oV9tF-000LJk-3B;
        Mon, 05 Sep 2022 13:03:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] diff --no-index: unleak paths[] elements
Date:   Mon, 05 Sep 2022 13:01:51 +0200
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g>
 <01pn98p2-qppn-260p-8o80-n5483p41859o@tzk.qr>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <01pn98p2-qppn-260p-8o80-n5483p41859o@tzk.qr>
Message-ID: <220905.86zgfekrqq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 05 2022, Johannes Schindelin wrote:

> Hi Junio,
>
> On Fri, 2 Sep 2022, Junio C Hamano wrote:
>
>> "git diff --no-index" codepath starts with the two elements in
>> argv[] and munges them into two paths to be compared, stored in a
>> separate path[] arrays.  The munging is implemented in a rather
>> haphazard way, sometimes overwriting old version with a new copy,
>> and sometimes a constant string assigned to path[], making it
>> impossible to release the resources properly:
>>
>>  * A single dash "-" from the command line is a special signal that
>>    the standard input is used for the side to be compared, and is
>>    internally replaced with a copy of string "-" at a known address.
>>
>>  * When run in a subdirectory, full paths to the two paths are
>>    allocated and placed in path[].
>>
>>  * After the above happens, when comparing a file with a directory,
>>    the directory side is replaced with the path to a file in the
>>    directory with the same name as the file.
>>
>> This was perfectly fine for just two strings that are pathnames used
>> during the lifetime of the program and cleaned up upon program exit,
>> but it gets in the way when leak sanitizer is in effect.  The third
>> step can be losing the full path that was allocated in the second
>> step, but it is not easy to tell if its input is an allocated piece
>> of memory to begin with.
>>
>> Loosen the earlier two steps a bit so that elements of the path[]
>> array that come to the directory/file comparison code are either the
>> singleton "-" or an allocated piece of memory.  Use that knowledge
>> in the third step to release an allocated piece of memory when it
>> replaces the path to a directory with the path to a file in that
>> directory, and also at the end to release the two elements of the
>> path[] array as needed.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>>
>>  * The previous one allowed strbuf_release() to free replacement.buf
>>    which may be used in path[0] or path[1] potentially leading to
>>    double freeing.  The kosher way may be to use strbuf_detach() in
>>    fixup_paths(), but this is a simpler fix, it is getting late in
>>    the day, and I am getting sick of fighting the leak-checker, so...
>
> I wonder whether a much better way would be to first fix the code to
> always release `replacement`, like so:
>
> -- snip --
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 9a8b09346bd..87047605385 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -242,7 +242,7 @@ int diff_no_index(struct rev_info *revs,
>  		  int implicit_no_index,
>  		  int argc, const char **argv)
>  {
> -	int i, no_index;
> +	int i, no_index, ret;
>  	const char *paths[2];
>  	struct strbuf replacement = STRBUF_INIT;
>  	const char *prefix = revs->prefix;
> @@ -294,17 +294,23 @@ int diff_no_index(struct rev_info *revs,
>  	setup_diff_pager(&revs->diffopt);
>  	revs->diffopt.flags.exit_with_status = 1;
>
> -	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
> -		return 1;
> +	if (queue_diff(&revs->diffopt, paths[0], paths[1])) {
> +		ret = 1;
> +		goto out;
> +	}
> +
>  	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
>  	diffcore_std(&revs->diffopt);
>  	diff_flush(&revs->diffopt);
>
> -	strbuf_release(&replacement);
> -
>  	/*
>  	 * The return code for --no-index imitates diff(1):
>  	 * 0 = no changes, 1 = changes, else error
>  	 */
> -	return diff_result_code(&revs->diffopt, 0);
> +	ret = diff_result_code(&revs->diffopt, 0);
> +
> +out:
> +	strbuf_release(&replacement);
> +
> +	return ret;
>  }
> -- snap --
>
> After that, the proposed diff could be replaced by this diff:
>
> -- snip --
> diff --git a/diff-no-index.c b/diff-no-index.c
> index 87047605385..d350e4381bc 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -244,6 +244,7 @@ int diff_no_index(struct rev_info *revs,
>  {
>  	int i, no_index, ret;
>  	const char *paths[2];
> +	struct string_list to_release = STRING_LIST_INIT_DUP;
>  	struct strbuf replacement = STRBUF_INIT;
>  	const char *prefix = revs->prefix;
>  	struct option no_index_options[] = {
> @@ -274,6 +275,12 @@ int diff_no_index(struct rev_info *revs,
>  			p = file_from_standard_input;
>  		else if (prefix)
>  			p = prefix_filename(prefix, p);
> +		else {
> +			char *dup = xstrdup(p);
> +
> +			p = dup;
> +			string_list_append_nodup(&to_release, dup);
> +		}
>  		paths[i] = p;
>  	}
>
> @@ -310,6 +317,7 @@ int diff_no_index(struct rev_info *revs,
>  	ret = diff_result_code(&revs->diffopt, 0);
>
>  out:
> +	string_list_clear(&to_release, 1);
>  	strbuf_release(&replacement);
>
>  	return ret;
>
> -- snap --
>
> That approach has the distinct advantage of making it very easy to reason
> about the code.
>
> What do you think?
>
> Ciao,
> Dscho
>
>>
>>  diff-no-index.c | 24 ++++++++++++++++++++++--
>>  1 file changed, 22 insertions(+), 2 deletions(-)
>>
>>
>> diff --git a/diff-no-index.c b/diff-no-index.c
>> index 9a8b09346b..77a126469b 100644
>> --- a/diff-no-index.c
>> +++ b/diff-no-index.c
>> @@ -208,6 +208,14 @@ static void append_basename(struct strbuf *path, const char *dir, const char *fi
>>  	strbuf_addstr(path, tail ? tail + 1 : file);
>>  }
>>
>> +static void free_allocated_path(const char *path)
>> +{
>> +	if (!path ||
>> +	    (path == file_from_standard_input))
>> +		return;
>> +	free((char *)path);
>> +}
>> +
>>  /*
>>   * DWIM "diff D F" into "diff D/F F" and "diff F D" into "diff F D/F"
>>   * Note that we append the basename of F to D/, so "diff a/b/file D"
>> @@ -226,9 +234,11 @@ static void fixup_paths(const char **path, struct strbuf *replacement)
>>  		return;
>>  	if (isdir0) {
>>  		append_basename(replacement, path[0], path[1]);
>> +		free_allocated_path(path[0]);
>>  		path[0] = replacement->buf;
>>  	} else {
>>  		append_basename(replacement, path[1], path[0]);
>> +		free_allocated_path(path[1]);
>>  		path[1] = replacement->buf;
>>  	}
>>  }
>> @@ -274,6 +284,8 @@ int diff_no_index(struct rev_info *revs,
>>  			p = file_from_standard_input;
>>  		else if (prefix)
>>  			p = prefix_filename(prefix, p);
>> +		else
>> +			p = xstrdup(p);
>>  		paths[i] = p;
>>  	}
>>
>> @@ -294,13 +306,21 @@ int diff_no_index(struct rev_info *revs,
>>  	setup_diff_pager(&revs->diffopt);
>>  	revs->diffopt.flags.exit_with_status = 1;
>>
>> -	if (queue_diff(&revs->diffopt, paths[0], paths[1]))
>> +	if (queue_diff(&revs->diffopt, paths[0], paths[1])) {
>> +		free_allocated_path(paths[0]);
>> +		free_allocated_path(paths[1]);
>>  		return 1;
>> +	}
>>  	diff_set_mnemonic_prefix(&revs->diffopt, "1/", "2/");
>>  	diffcore_std(&revs->diffopt);
>>  	diff_flush(&revs->diffopt);
>>
>> -	strbuf_release(&replacement);
>> +	/*
>> +	 * do not strbuf_release(&replacement), as it is in paths[]
>> +	 * when replacement was actually used.
>> +	 */
>> +	free_allocated_path(paths[0]);
>> +	free_allocated_path(paths[1]);
>>
>>  	/*
>>  	 * The return code for --no-index imitates diff(1):
>> --
>> 2.37.3-661-g73a641a77a
>>
>>

That looks like a much better approach, I'd think you'd want this on
top, because:

 * We entirely avoid playing cames with the string_list "dup" and then
   "nodup" append. In some cases we have to, but in this case we can
   just get the pointer to the member we just created, and avoid the
   explicit xstrdup() in the caller.
 * The free_util=1 in your code isn't needed/is a bug, we make no use of
   "util" here, so it should be free_util=0
 * It avoids the "add braces to all if/else arms" part of
   CodingGuidelines.

diff --git a/diff-no-index.c b/diff-no-index.c
index d350e4381bc..2861319c0e5 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -275,12 +275,8 @@ int diff_no_index(struct rev_info *revs,
 			p = file_from_standard_input;
 		else if (prefix)
 			p = prefix_filename(prefix, p);
-		else {
-			char *dup = xstrdup(p);
-
-			p = dup;
-			string_list_append_nodup(&to_release, dup);
-		}
+		else
+			p = string_list_append(&to_release, p)->string;
 		paths[i] = p;
 	}
 
@@ -317,7 +313,7 @@ int diff_no_index(struct rev_info *revs,
 	ret = diff_result_code(&revs->diffopt, 0);
 
 out:
-	string_list_clear(&to_release, 1);
+	string_list_clear(&to_release, 0);
 	strbuf_release(&replacement);
 
 	return ret;
