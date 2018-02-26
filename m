Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 358CF1F404
	for <e@80x24.org>; Mon, 26 Feb 2018 22:24:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeBZWYE (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 17:24:04 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:44709 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeBZWYD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 17:24:03 -0500
Received: by mail-pg0-f52.google.com with SMTP id l4so6733872pgp.11
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 14:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Net3xH161QORvVAAneOYVw38j779K0JtMf0FhW+1nuU=;
        b=OwV9uJjU9hs+2XlOqhC9J3W0kScWo/YAn2eWp1Ru2kzD/xuvkzppN7WRnspM1yTUa9
         gJs27eCKayQKP/Nmm1RcgpQW6ydROgF9qjiJEVXAsAm8IrhUlUHQV7cjQL7A8beXYkKi
         LaWeTyYJ/Tdk35o23PtYKdA8x/ZHELGerMSlK4UCX5Ni01Icwv/VfPrsU+FVWyXr9/x+
         s3hC5gyIhgMDN+8Uwa+BzXgndOICCkIUjHz35ZGVo46pNgFJUf2sseztoghRKwuICNl6
         A45eFj7Z6eIkz7dhexpHVJvOSedR7wumYkDew8/wqfGiaiD8ltICUOHdUHgNKShJ2iM9
         51dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Net3xH161QORvVAAneOYVw38j779K0JtMf0FhW+1nuU=;
        b=Bk1A+kPDcKH30pK9nCzjVvGXTa2yqp2j5ldkVC2K/DiIHg1l44RKvY4jmWnfij4sOy
         HNo8Qj57LpqKBb+wRckXc/IvLm52VnIhCXobNkcBF8JDsHlGb6pFpaVA5ryS7CrGpd/W
         BUQP3TqenrjSzq9YXLKDIh0AWUcQ+7k82mMZtCRZigLeJkV5gjOqVy/iXP6U22jpnWpv
         Sapam934p/KVldU080V3qSaD3LNEX7ZELroZrB8qBbSUBomr6rl2O8dbGGnOlutqtTHA
         A9vd0HY2DAq43OJEgC/K1rWkBypfjE+fgA2slzJHu046LapFDOLKbWs4U/nR9Civp0uY
         lJvA==
X-Gm-Message-State: APf1xPCjhe8Xw1vp5GOqGH5+vk07VluaRKcdypTlBlXrCQ01fVtjxS88
        GaCdHSV3PIuYLgZIXIlP1M4bLGgEN8I=
X-Google-Smtp-Source: AG47ELt1yn69jDRgUzLuebv3HTERZoG3/meNnC8B78P0tflnZRjl66PP35JxPmhVORG95N6IGkrVbQ==
X-Received: by 10.98.7.68 with SMTP id b65mr4939597pfd.39.1519683842506;
        Mon, 26 Feb 2018 14:24:02 -0800 (PST)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q22sm12783361pfk.138.2018.02.26.14.24.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 14:24:01 -0800 (PST)
Date:   Mon, 26 Feb 2018 14:23:59 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 21/35] fetch-pack: perform a fetch using v2
Message-ID: <20180226222359.GB60857@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-22-bmwill@google.com>
 <20180223165407.2d2f4343b2497172523f9f66@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223165407.2d2f4343b2497172523f9f66@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/23, Jonathan Tan wrote:
> On Tue,  6 Feb 2018 17:12:58 -0800
> Brandon Williams <bmwill@google.com> wrote:
> 
> > +	while ((oid = get_rev())) {
> > +		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
> > +		if (++haves_added >= INITIAL_FLUSH)
> > +			break;
> > +	};
> 
> Unnecessary semicolon after closing brace.

Thanks, I'll remove that.

> 
> > +			/* Filter 'ref' by 'sought' and those that aren't local */
> > +			if (everything_local(args, &ref, sought, nr_sought))
> > +				state = FETCH_DONE;
> > +			else
> > +				state = FETCH_SEND_REQUEST;
> > +			break;
> 
> I haven't looked at this patch in detail, but I found a bug that can be
> reproduced if you patch the following onto this patch:
> 
>     --- a/t/t5702-protocol-v2.sh
>     +++ b/t/t5702-protocol-v2.sh
>     @@ -124,6 +124,7 @@ test_expect_success 'clone with file:// using protocol v2' '
>      
>      test_expect_success 'fetch with file:// using protocol v2' '
>             test_commit -C file_parent two &&
>     +       git -C file_parent tag -d one &&
>      
>             GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=2 \
>                     fetch origin 2>log &&
>     @@ -133,7 +134,8 @@ test_expect_success 'fetch with file:// using protocol v2' '
>             test_cmp expect actual &&
>      
>             # Server responded using protocol v2
>     -       grep "fetch< version 2" log
>     +       grep "fetch< version 2" log &&
>     +       grep "have " log
>      '
> 
> Merely including the second hunk (the one with 'grep "have "') does not
> make the test fail, but including both the first and second hunks does.
> That is, fetch v2 emits "have" only for remote refs that point to
> objects we already have, not for local refs.
> 
> Everything still appears to work, except that packfiles are usually much
> larger than they need to be.
> 
> I did some digging in the code and found out that the equivalent of
> find_common() (which calls `for_each_ref(rev_list_insert_ref_oid,
> NULL)`) was not called in v2. In v1, find_common() is called immediately
> after everything_local(), but there is no equivalent in v2. (I quoted
> the invocation of everything_local() in v2 above.)

I actually caught this Friday morning when I realized that fetching from
a referenced repository would replicated objects instead of using them
from the referenced repository.  Thanks for pointing this out :)

-- 
Brandon Williams
