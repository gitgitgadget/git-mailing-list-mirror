Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91B5A1F453
	for <e@80x24.org>; Wed, 24 Oct 2018 04:35:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbeJXNBy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 09:01:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45161 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeJXNBy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 09:01:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id n5-v6so173056wrw.12
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 21:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8lheZnjAPRLzF50jn+R5nUyrSIyI3dKHuWEW0SHUP2c=;
        b=A0G7MGrA+otmx5Vsj2r9v7Ite+EsDfqHLPt/r4vYpyvhfy/amnlLIo1nwcxdML02R3
         miuVcGnR/raPhCQ+qsSIb8hSGaVtzP0ZlU9/kDb5NEt5cUep0H2gtFK3pAB8J6gahN7b
         FHUDeuSklh3choacvR/SuVNcqSY7NmvBJ3OcGrhDHg8MGaUUdufp1eybf5g1ovhGxVrj
         ENyuMkm0KuUf/kHT32fl7BDIQ5GMGyztBUPt1JNyiQ7cHmtUJdmRhdOcSTduIj0mCzad
         oWSqgt2FgpiDcNvNy+d+hS0cb2QNYCo9g+26mw6ooSwfgQBDNmpQOh2pPvYRHSJAgFP7
         0gzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8lheZnjAPRLzF50jn+R5nUyrSIyI3dKHuWEW0SHUP2c=;
        b=IKTg29JE/0oJMcKlWyyeCcgyPSf4SMDcBEgfOpWtCE9IZiIg+jT06u1BpxNv6GSO3k
         ifHTeDFMa/w/ibbO8orIm0op7EZS41IxB/dEro371KxhfDcMi1vJSyFWI6yYzLdcavt8
         ceLcNRLa2+bT9VFe5a5mM0eXiNE963MKFqpAC0CJCFF9xquOyRJvoFUJmfMSDmUl2c3L
         E9SEdRDHy5ItpX7iv+KTAf7YJa3iRvcNUvKws6Ruva3WOdkQZjm7bzTnou0QDtngNrF3
         PwVdfo5hlt4wHipdJHBMrEAzh1Bur5gPAw6TLWYU5bcS6wzTdSbeQRX86+N0Lq6SLCc0
         fHew==
X-Gm-Message-State: AGRZ1gLJlgloV4Oh30TeHkSPQNFxFHXgwVJGiROTEbD8cGs4lAeT80AR
        SKWf/QO+zg8rO3/vaHEO5GbGmhjBg5A=
X-Google-Smtp-Source: AJdET5eqDOQteFbcobO2o7pbnFEMx1EiUQBptzkDhXO97yf9QZu8GQ/N6xZ7eBHEz89utlCTNoIMeQ==
X-Received: by 2002:a5d:640b:: with SMTP id z11-v6mr946381wru.64.1540355729989;
        Tue, 23 Oct 2018 21:35:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e21-v6sm5031326wma.8.2018.10.23.21.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 21:35:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Clear --exclude list after 'git rev-parse --all'
References: <20181023191758.15138-1-agruenba@redhat.com>
Date:   Wed, 24 Oct 2018 13:35:27 +0900
In-Reply-To: <20181023191758.15138-1-agruenba@redhat.com> (Andreas
        Gruenbacher's message of "Tue, 23 Oct 2018 21:17:58 +0200")
Message-ID: <xmqqefcgotbk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andreas Gruenbacher <agruenba@redhat.com> writes:

> Commit [1] added the --exclude option to revision.c.  The --all,
> --branches, --tags, --remotes, and --glob options clear the exclude
> list.  Shortly therafter, commit [2] added the same to 'git rev-parse',
> but without clearing the exclude list for the --all option.  Fix that.
>
> [1] e7b432c52 ("revision: introduce --exclude=<glob> to tame wildcards", 2013-08-30)
> [2] 9dc01bf06 ("rev-parse: introduce --exclude=<glob> to tame wildcards", 2013-11-01)
>
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> ---
>  builtin/rev-parse.c | 1 +
>  1 file changed, 1 insertion(+)

All other glob options do show_reference with for_each_ref_in() and
then calls clear_ref_exclusion(), and logically the patch makes
sense.  

What is the "problem" this patch fixes, though?  Is it easy to add a
new test to t/6018-rev-list-glob.sh to demonstrate that "--glob" (or
whatever that clears exclusion list without this patch) works
correctly but "--all" misbehaves without this change?

Thanks.

> diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
> index 0f09bbbf6..c71e3b104 100644
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -764,6 +764,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  			}
>  			if (!strcmp(arg, "--all")) {
>  				for_each_ref(show_reference, NULL);
> +				clear_ref_exclusion(&ref_excludes);
>  				continue;
>  			}
>  			if (skip_prefix(arg, "--disambiguate=", &arg)) {
