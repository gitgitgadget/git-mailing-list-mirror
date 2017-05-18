Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46057201A7
	for <e@80x24.org>; Thu, 18 May 2017 02:37:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752852AbdERCfr (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 22:35:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35096 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbdERCe3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 22:34:29 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so3921450pfd.2
        for <git@vger.kernel.org>; Wed, 17 May 2017 19:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=K+mFifYH+XgT/veE8M0Y2rL59owOIGAeAuxbVDObK00=;
        b=lZbQijoOBSV4d56UYNQWBs52dzOCfWrwDibdGo4HG2b3vthh02QJiuky3peaIuwGDt
         YLkKPP15vuKu8s95iYuQp+32hiZWtAiynWD1LKQRZ73Qn9lxKOcrtN112y5Gf1wY1GqR
         lBlTzEy3BLooa2RN+jOziQXTpIEorlLF+6iWHNdizroDSyeFRk/HoA+JcKVr1/IqrY6R
         uiEjVucHib4twazowXdadxtcImYwvD3m86AU6fz0u6N2b4DuoV3FAouIprSNVK11kUVY
         8gI7bTw0POa35o6icqtP6uwqICZdM4S8/Jjl/EBKhrLHjTSwTcZnPGaKfN47AOIf/ZWQ
         iVuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=K+mFifYH+XgT/veE8M0Y2rL59owOIGAeAuxbVDObK00=;
        b=qQWa9f53y3w4ta+6XKOf4VOfKvi9lifMO3It27xRxCsumJLwJ6uojcMK3KoVkl7dsU
         5SlncqN3BV0oc6evHZqls6+UvBGT8I+66Oj1P9HHInyJemPuIXN+Sx2D9LUvzeVy09o9
         gjYzAoIEO1b0/jQcVg8UObDJijOI+oozProJLK4JfkhXNUGplxegmSlXXy3xTXxBRw0Q
         rQkUsIsLzJfuojQ8cuT6ejds6ftl3Q58uPdtaEBcTnaInqjKoO6qt8elx/dPpUq1cCGP
         xrNJPJXfAyDrsbbPUin7soctDxugUiYJcX2V0+I6vh95238LMzO+E2XeJO3wo3O+rQ+K
         TRyg==
X-Gm-Message-State: AODbwcCJE2NFUlCfwMfEu8J43+juwUKHls6ldNKjc/sbB8pRsjjOIBzn
        rm4vkelVzkzYDA==
X-Received: by 10.99.120.206 with SMTP id t197mr1947694pgc.64.1495074869275;
        Wed, 17 May 2017 19:34:29 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f155:f4fa:305b:79e3])
        by smtp.gmail.com with ESMTPSA id f86sm6653869pfj.128.2017.05.17.19.34.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 19:34:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/8] clean: teach clean -d to skip dirs containing ignored files
References: <20170516073423.25762-1-sxlijin@gmail.com>
        <20170505104611.17845-1-sxlijin@gmail.com>
        <20170516073423.25762-7-sxlijin@gmail.com>
Date:   Thu, 18 May 2017 11:34:27 +0900
In-Reply-To: <20170516073423.25762-7-sxlijin@gmail.com> (Samuel Lijin's
        message of "Tue, 16 May 2017 03:34:21 -0400")
Message-ID: <xmqq4lwix58s.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Samuel Lijin <sxlijin@gmail.com> writes:

> @@ -932,7 +935,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	fill_directory(&dir, &pathspec);
>  
> -	for (i = 0; i < dir.nr; i++) {
> +	for (k = i = 0; i < dir.nr; i++) {
>  		struct dir_entry *ent = dir.entries[i];
>  		int matches = 0;
>  		struct stat st;
> @@ -954,10 +957,35 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  		    matches != MATCHED_EXACTLY)
>  			continue;
>  
> +		// skip any dir.entries which contains a dir.ignored
> +		for (; k < dir.ignored_nr; k++) {
> +			if (cmp_dir_entry(&dir.entries[i],
> +						&dir.ignored[k]) < 0)
> +				break;

It is a bit unfortunate that we do not use the short-hand "ent" we
established for dir.entries[i] at the beginning of this loop here.

> +		}
> +		if ((k < dir.ignored_nr) &&
> +				check_dir_entry_contains(dir.entries[i], dir.ignored[k])) {
> +			continue;
> +		}

The above logic is not needed when dir.entries[i] is a directory,
right?

> +
> +		// current entry does not contain any ignored files

... or the entry may not have been a directory in the first place.

>  		rel = relative_path(ent->name, prefix, &buf);
>  		string_list_append(&del_list, rel);
> +
> +		// skip untracked contents of an untracked dir
> +		for (j = i + 1;
> +			 j < dir.nr &&
> +			     check_dir_entry_contains(dir.entries[i], dir.entries[j]);
> +			 j++);
> +		i = j - 1;
>  	}
>
> +	for (i = 0; i < dir.nr; i++)
> +		free(dir.entries[i]);
> +
> +	for (i = 0; i < dir.ignored_nr; i++)
> +		free(dir.ignored[i]);
> +

The above logic may not be incorrect per-se, but I have this
suspicion that the resulting code may become cleaner and easier to
understand if we did it in a new separate loop we call immediately
after fill_directory() returns.  Or it could even be a call to a
helper that "post processes" the "dir" thing that was polupated by
fill_directory() that removes elements in the entries[] array that
contains any element in ignored[] array.

>  	if (interactive && del_list.nr > 0)
>  		interactive_main_loop();

Thanks.
