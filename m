Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E64220248
	for <e@80x24.org>; Sun, 24 Mar 2019 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfCXNhw (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Mar 2019 09:37:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51503 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbfCXNhw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Mar 2019 09:37:52 -0400
Received: by mail-wm1-f65.google.com with SMTP id 4so6291952wmf.1
        for <git@vger.kernel.org>; Sun, 24 Mar 2019 06:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7ONc41S6AhnMhy7xi2wztOR8bQsWk4s9KGl/BKMMS8Q=;
        b=A2wAbpd04otN0EzPFTzAYTbY/XLLx0TP5+jSAlaajnq/UlW/y/D3qDDsYD50sidvIH
         xX3G/DVWpzS7LhRdG7pPoo0zOtpmsgQEqXW32Q6ZbvmzEnwoonAtPI7FsN7Kj0LspdGC
         QMvzimJBuwmEMblkvS3nzqqWrJ86EctF7NNkuSzMX1lD5ECmX/GtnOD+Zg+8xzYyrz04
         iJyyRdZE7zD/rpMgs46CxamUn6driv7SPvB26UxOgkaG3X2WnDLqz8uc85pOGM2NgpQf
         gCKwAdpXDSsRI9+fAcG1oWZ5w1dlq+JA26ih8atSYJRNdmiIHnU881XhE+Ntm5/1nL9k
         nCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7ONc41S6AhnMhy7xi2wztOR8bQsWk4s9KGl/BKMMS8Q=;
        b=duUvtNrxeWUzYDpoFiO2y0WqFwjrZMpt6U+ZoriIeTouqcKI94+AJtWozKjbRQ6/Cm
         Xdt8FmfLfNmSwT4aWrMwd0A7D9vyP4Ra8NxDYxUBa2xyiG6AgylhfBdIU4BmNR+YWZCw
         sM1uDHaKMy9ZbiYmZ5CjsumqZnE93VV36ehAdg6uE3ut9XZ+89fv1LU/t/onHTGhnnLW
         Jn5eOJ8ldvUXUgk5bXnqfiPKj+Lwt8uyGvN+UHr7xWTLx0/LJqFMDsCLacn/jfPJIym9
         b7G3TNEoL8sV6kiY+nvPYAlnlkBeH9QYFXuPHJMXlK8IhdpCo9SgPCgiP5jx7FgEobw8
         q+1Q==
X-Gm-Message-State: APjAAAWGM6WoL5OpfE9t71daTWZrGawtd/gFJpgtQDrAS8nR2vGHFMcb
        iDfv/jaGjPDhUgyjhmEeHco=
X-Google-Smtp-Source: APXvYqx12E3k85GherDR+Br1oiAtkpaV2hbGgyj9jrOBoyDVvOX/QEG5mdH2UupRUVufTWDIQxU1Cw==
X-Received: by 2002:a1c:7311:: with SMTP id d17mr2728719wmb.115.1553434670075;
        Sun, 24 Mar 2019 06:37:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id k11sm28083635wmk.45.2019.03.24.06.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 Mar 2019 06:37:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] rebase: teach rebase --keep-base
References: <cover.1553354374.git.liu.denton@gmail.com>
        <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
Date:   Sun, 24 Mar 2019 22:37:49 +0900
In-Reply-To: <f802e5442013613221a4efd8ef1fecce0f3a9914.1553354374.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sat, 23 Mar 2019 08:25:28 -0700")
Message-ID: <xmqqpnqgo0k2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>  	if (strstr(options.onto_name, "...")) {
>  		if (get_oid_mb(options.onto_name, &merge_base) < 0)
> +		    if (keep_base)
> +			die(_("'%s': need exactly one merge base with branch"),
> +				options.upstream_name);
> +		    else
>  			die(_("'%s': need exactly one merge base"),
>  			    options.onto_name);

If you turn a single statement body into if/else, have {} around the
body of the outer if, i.e.

	if (get_oid_mb(...) < 0) {
		if (keep_base)
			die(_("'%s': need exactly one merge base with branch"),
			    options.upstream_name);
		else
			die(_("'%s': need exactly one merge base"),
			    options.onto_name);
	}

Otherwise -Werror=danglng-else will stop compilation.

Thanks.
