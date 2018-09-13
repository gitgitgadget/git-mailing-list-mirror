Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A47D21F404
	for <e@80x24.org>; Thu, 13 Sep 2018 22:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbeIND4B (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:56:01 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55723 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727383AbeIND4B (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:56:01 -0400
Received: by mail-wm1-f67.google.com with SMTP id f21-v6so61458wmc.5
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 15:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=LlPShteuSuAClsYGmYF2CV4fuHxSCevX3+NQHPVI4ok=;
        b=NZLAGprNqSp9w8MnB386c1RtxagX6fwTPNUeOr8ZIV7epPPfgCAO4/fMrFVXS+26Dm
         PfiUmyZeB36JveOFl71aYRZ+5xop7HSdvxeN0Z1GCMm6fEocmoF4yOtyL41jBXm1xdGU
         QaMeooGRGc+2OXRhaChnQAtYYwElgbDPygHr6PtneWm5yr3VD780UnQQj2/2Y9hr3d/X
         YFIH95kV7xahrXUaQZW0p1WR264WM/Vw1gz95BnEXcMgX0nWKwNANPRjTNcGvClgXwXZ
         E85czsDw9Qr07Pd3ZqHLuRdrhrnwQcBiANvNi41cuRaXV9cKimaOOK91boPq76G6ASXY
         1DTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=LlPShteuSuAClsYGmYF2CV4fuHxSCevX3+NQHPVI4ok=;
        b=dcNuX4vNZRgmo0k1ONyDR/2vYua9dvMDewZ/3FNcvGbFZJ7HLexnN7CUBRI+cVwz6M
         pzan0JiQkjigI/Z6W405ew7CZ8o0I3Jm/gMA2PtCai6z9HKOuQ/riWbVTYO3fTg1NtGN
         F8k2ywkuQL2Ih0Grxc6J6ZqTuAwQQHXJCoC6VZyDIbRslTb7BRrij8cdukX46nRzz92q
         bWydfhuv3F+aAeo9CiA6ua+X6Tb5BMQx/+IkiXg+lgRh4XS1qxrGDIzsmIRiosEYWah9
         YVdXEsOYZfGwvhxeQ6dSRRytSDLnnNR9x6ZPW/zwXGPnnRh3dPiCEUH0MmFMLL0IpiLI
         eykQ==
X-Gm-Message-State: APzg51BF7gnz2WSyTc8gnkISRjp9zR0QXgsKgTt3mS+mji22dK/tnwoP
        4F33YNCJ/AZsERGACLa2va4=
X-Google-Smtp-Source: ANB0VdZOja0+YuO+lua1xbo/yxpUwbaljxZgWCroYqTHY2QeGFDqi8sgPAGGRQljjR3BpgI0+bxGTQ==
X-Received: by 2002:a1c:a614:: with SMTP id p20-v6mr130449wme.68.1536878667375;
        Thu, 13 Sep 2018 15:44:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b124-v6sm4077wmg.47.2018.09.13.15.44.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 15:44:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <benpeart@microsoft.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180912161832.55324-1-benpeart@microsoft.com>
        <20180912161832.55324-2-benpeart@microsoft.com>
Date:   Thu, 13 Sep 2018 15:44:26 -0700
In-Reply-To: <20180912161832.55324-2-benpeart@microsoft.com> (Ben Peart's
        message of "Wed, 12 Sep 2018 16:18:53 +0000")
Message-ID: <xmqq8t45dnlh.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <benpeart@microsoft.com> writes:

> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 39133bcbc8..f613dd72e3 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -7,6 +7,7 @@ test_description='split index mode tests'
>  # We need total control of index splitting here
>  sane_unset GIT_TEST_SPLIT_INDEX
>  sane_unset GIT_FSMONITOR_TEST
> +export GIT_TEST_DISABLE_EOIE=true
>  
>  test_expect_success 'enable split index' '
>  	git config splitIndex.maxPercentChange 100 &&

It is safer to squash the following in; we may want to revisit the
decision test-lint makes on this issue later, though.

-- >8 --
Subject: [PATCH] SQUASH???

http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#export

specifies how "export name[=word]" ought to work, but because
writing "name=word; export name" is not so much more cumbersome
and some older shells that do not understand the former do grok
the latter.  test-lint also recommends spelling it this way.
---
 t/t1700-split-index.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
index f613dd72e3..dab97c2187 100755
--- a/t/t1700-split-index.sh
+++ b/t/t1700-split-index.sh
@@ -7,7 +7,7 @@ test_description='split index mode tests'
 # We need total control of index splitting here
 sane_unset GIT_TEST_SPLIT_INDEX
 sane_unset GIT_FSMONITOR_TEST
-export GIT_TEST_DISABLE_EOIE=true
+GIT_TEST_DISABLE_EOIE=true; export GIT_TEST_DISABLE_EOIE
 
 test_expect_success 'enable split index' '
 	git config splitIndex.maxPercentChange 100 &&
-- 
2.19.0

