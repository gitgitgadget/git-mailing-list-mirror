Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A5A61F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727766AbeGTUnC (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:43:02 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727728AbeGTUnC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:43:02 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so12274401wre.6
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=6NYztNxkkWp12GvJrUAwwjVMbIHmI+/4gJLSHRp0zNo=;
        b=INAaSkwT6NTZ7+c0AIXlOdDjMlVTujK7ufhbzy9d12NhPPj5YEzjAbUtGVsrlXiSGc
         4xFdL30cTkbBSZegwxeH403xVBeJ5TE8ePOIwIhEyTkrdwXGkomRPRzSIlwSqaQRCSfb
         x+lhiPvVi5kQe/9rhGe07z+MFPyWyr0RIONb/ABMwAwpgI17iEOZbFwdouM3KJVFriSb
         mOctMUV5o8FnE8EA2897m+puo+sckD8fYV/hNUfZ1xaRamh7bxovYXBhbX/Aj7CmuTVX
         UkrDwZXUrzt55EZ7l7HROvjNDjy7yE+oQUD/3kiJTIkcwQrHh3ewLVnMQaHgNM5qqjrH
         25Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=6NYztNxkkWp12GvJrUAwwjVMbIHmI+/4gJLSHRp0zNo=;
        b=PwBWh9FWry4JApPnF+/W6whn2glrwTukEUGsGxXryiCuS0tBeFOzZHFuN0U7KKE2jK
         Jhi86VCn1+XRpTkMuQB1ra7Rx/AnPcSWK38oGxM7t0+6sWZFPT4kzWO89/3pitUhHPay
         g2X3fRYlMSZ8Fjx2+Rd5KzCp239yXUsMh69YqOeogN+YADWdbjO0xe7fd7CmNuXySGdN
         YL17x+GtJxXGRlQ1sDyjKSAWYhqO5OzUUyFJh0uUEKjOlM7znGKxVAvyjhttt0xjA+jH
         iGLn2gFKYjDXnd1LJh6ja6icaMAF9c2FN0JN7j/LjPt9UjMFzhn3cW5q+yf4fzhPgO8O
         8/PA==
X-Gm-Message-State: AOUpUlGKJQ8QMHZ/RTRJasmFmo1H9yIomnQSqSU+w7gC07Y2ZNBbpiS7
        k0fy8kPcnonlDHGN6fZqjKU=
X-Google-Smtp-Source: AAOMgpfOnGs3ONPBqWBH7dl2pCgaser9vc7w8YQ+wy+I53kncT1b/LimrxE2hh2L4J8yC8njKJG+iw==
X-Received: by 2002:a5d:4542:: with SMTP id p2-v6mr2368362wrr.191.1532116395855;
        Fri, 20 Jul 2018 12:53:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g18-v6sm1690818wmh.21.2018.07.20.12.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 12:53:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: send ref-prefixes when using protocol v2
References: <20180720192749.224284-1-bmwill@google.com>
Date:   Fri, 20 Jul 2018 12:53:14 -0700
In-Reply-To: <20180720192749.224284-1-bmwill@google.com> (Brandon Williams's
        message of "Fri, 20 Jul 2018 12:27:49 -0700")
Message-ID: <xmqqwotpadlh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

Is there an end-user visible effect, caused by the lack of "prefix"
being fixed with this patch, that is worth describing here?  "The
server ended up showing refs that are irrelevant to the normal clone
request which is only for heads and tags, wasting time and
bandwidth", for example?

> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>
> Noticed we miss out on server side filtering of refs when cloning using
> protocol v2, this will enable that.


>
>  builtin/clone.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 99e73dae85..55cc10e93a 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -895,7 +895,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	int err = 0, complete_refs_before_fetch = 1;
>  	int submodule_progress;
>  
> -	struct refspec_item refspec;
> +	struct refspec rs = REFSPEC_INIT_FETCH;
> +	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
>  
>  	fetch_if_missing = 0;
>  
> @@ -1077,7 +1078,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (option_required_reference.nr || option_optional_reference.nr)
>  		setup_reference();
>  
> -	refspec_item_init(&refspec, value.buf, REFSPEC_FETCH);
> +	refspec_append(&rs, value.buf);
>  
>  	strbuf_reset(&value);
>  
> @@ -1134,10 +1135,20 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	if (transport->smart_options && !deepen && !filter_options.choice)
>  		transport->smart_options->check_self_contained_and_connected = 1;
>  
> -	refs = transport_get_remote_refs(transport, NULL);
> +
> +	argv_array_push(&ref_prefixes, "HEAD");
> +	refspec_ref_prefixes(&rs, &ref_prefixes);
> +	if (option_branch) {
> +		expand_ref_prefix(&ref_prefixes, option_branch);
> +	}
> +	if (!option_no_tags) {
> +		argv_array_push(&ref_prefixes, "refs/tags/");
> +	}
> +
> +	refs = transport_get_remote_refs(transport, &ref_prefixes);
>  
>  	if (refs) {
> -		mapped_refs = wanted_peer_refs(refs, &refspec);
> +		mapped_refs = wanted_peer_refs(refs, &rs.items[0]);
>  		/*
>  		 * transport_get_remote_refs() may return refs with null sha-1
>  		 * in mapped_refs (see struct transport->get_refs_list
> @@ -1231,6 +1242,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
>  	strbuf_release(&value);
>  	junk_mode = JUNK_LEAVE_ALL;
>  
> -	refspec_item_clear(&refspec);
> +	refspec_clear(&rs);
> +	argv_array_clear(&ref_prefixes);
>  	return err;
>  }
