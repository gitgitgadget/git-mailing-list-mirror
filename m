Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41F241F453
	for <e@80x24.org>; Fri, 19 Oct 2018 01:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbeJSJiO (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 05:38:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33415 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbeJSJiO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 05:38:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id y140-v6so3008241wmd.0
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MC4+EKd6b59fRqM64dtRJ06GHryiqsH2r8q2UGuxPtk=;
        b=h6n+tJABrq8eXrcz0pLdHa3cJnf/u2Nc3w8ujGRYOrl9ShB2z8/BgTCgD+6TiMNlln
         /f7GkW66qkvrwGWiZBL50v8F3o2aaSvctvR+L2w3whJiHsTnLtUHy6OLM8IMoyLKI/Ba
         mztTfThpOPtILuxOuPlS/0q0rnFw/NkmDok10MDueKJ25X7espGD8RQnSELkdmUDsa25
         riaYwzpTEyjCeUvnn7CqXKfnzEtAiOyZVAJrfQaTkwPrlvxkXhOX//GK8VOw0N1c8gnV
         Nm6GrhBaQulhlLeUQJP6jPN2I6Atas8IXyFmOv3w4otX/tQXRLTz5Ph+6ohWi6WEXtqi
         6qbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MC4+EKd6b59fRqM64dtRJ06GHryiqsH2r8q2UGuxPtk=;
        b=p0WPy0U5hsXqhkPl3tSCNt0YP3i2OpltA9OlbFE5iaRNE7h0R9+QYD9equw4SQxcHC
         fE7CsfcIcr0bjA/QS64060eMNTq1B5oWsh+XmfQipI2SE+UyCLaEvfKr1aSQzAk3Sk2z
         2KaNzE7PYgtOYNyhFoPDrqKrfR3DGsVu0ETp5jvJfk2a/dEPOf58WK4FGFCIytyUfZty
         jOPjB6NdIOFoCWLU0Flh16YxrrMP4jjn7Sjnv04kRZdNkj18ehF3fuhQxvNnM3PKSGhu
         5WMYBq1bKdcAvDykgWpgueholBtRKoxhC6OEU9W5oLfLBCg/UdTin3/6oRbO6h7oFrrp
         OyoQ==
X-Gm-Message-State: ABuFfog3QNkOQQZ+hxcqxllMWhed1JK6w+5YcYQUHQVJbZRLJmJNpFCL
        xr4sPDt8JLzKOcKQHEljlZ0=
X-Google-Smtp-Source: ACcGV62aLTbSqb45IOqUQuXe7Mr1Y/FK+x0oLylXOHrfUXgWlVdF4HN+3urfqLA9X53gCZz9ZqS8ZA==
X-Received: by 2002:a1c:2ecc:: with SMTP id u195-v6mr2639306wmu.137.1539912865452;
        Thu, 18 Oct 2018 18:34:25 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 20-v6sm2437414wml.10.2018.10.18.18.34.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Oct 2018 18:34:24 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Sergey Andreenko <andreenkosa@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: don't attempt to strip prefix from absolute Windows paths
References: <CAD1gVxMg0ZiKqFABrnwt0v_=wr2X_3ErkR92RmCAtFQnuM+L5w@mail.gmail.com>
        <xmqqr2gu8dsx.fsf@gitster-ct.c.googlers.com>
        <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org>
Date:   Fri, 19 Oct 2018 10:34:23 +0900
In-Reply-To: <ae6fc699-6e09-2979-40dc-9cc49f4f8365@kdbg.org> (Johannes Sixt's
        message of "Thu, 18 Oct 2018 20:38:25 +0200")
Message-ID: <xmqqa7na4t40.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Use is_absolute_path() to detect Windows style absolute paths.

When cd676a51 ("diff --relative: output paths as relative to the
current subdirectory", 2008-02-12) was done, neither "is_dir_sep()"
nor "has_dos_drive_prefix()" existed---the latter had to wait until
25fe217b ("Windows: Treat Windows style path names.", 2008-03-05),
but we didn't notice that the above code needs to use the Windows
aware is_absolute_path() when we applied the change.

> One might wonder whether the check for a directory separator that
> is visible in the patch context should be changed from == '/' to
> is_dir_sep() or not. It turns out not to be necessary. That code
> only ever investigates paths that have undergone pathspec
> normalization, after which there are only forward slashes even on
> Windows.

Thanks for carefully explaining.

>  static void strip_prefix(int prefix_length, const char **namep, const char **otherp)
>  {
>  	/* Strip the prefix but do not molest /dev/null and absolute paths */
> -	if (*namep && **namep != '/') {
> +	if (*namep && !is_absolute_path(*namep)) {
>  		*namep += prefix_length;
>  		if (**namep == '/')
>  			++*namep;
>  	}
> -	if (*otherp && **otherp != '/') {
> +	if (*otherp && !is_absolute_path(*otherp)) {
>  		*otherp += prefix_length;
>  		if (**otherp == '/')
>  			++*otherp;

When I read the initial report and guessed the root cause without
looking at the code, I didn't expect the problematic area to be this
isolated and the solution to be this simple.

Nicely done.
