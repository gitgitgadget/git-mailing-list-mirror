Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1841F404
	for <e@80x24.org>; Mon, 10 Sep 2018 05:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbeIJKKE (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 06:10:04 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34114 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbeIJKKE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 06:10:04 -0400
Received: by mail-pl1-f193.google.com with SMTP id f6-v6so9179591plo.1
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 22:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JlA6riSsvmjNwpGrlzJRusN5VlMI5iHtSEVTeLW1/jg=;
        b=h/+60+vNknKxvoKy0ACdhBBuiVcuYKXXDDhVWIB9+cdDMOaAuCVqcgTe3QuIPbNrlr
         WeUA13splC1ftPQTj/BmeBhElp6xQJnNMRtYr7+MmtZe5Wx0GqEgK6reUvgfIiHRg8U2
         oLQG1ZjmpLKFzhz5Wd3fa4vwPy6jzJ+Yh6DwD8pC3la45XkxyKl42ooIqB+g5R0UzdZy
         Z+d21kbS2LVA63lTOIES69hpO5aherhYgIsa56Bmy9bgTKkw27xrwnPWV4+ibTQhzShg
         GnHGFsOL0ltGBlQha6P1lTr1vCL4el5U0JwuGPivCgI897mq6+dp1E5UV8/iDh+y4ZKl
         JRfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JlA6riSsvmjNwpGrlzJRusN5VlMI5iHtSEVTeLW1/jg=;
        b=YZAQArq4qSkfK1wwtapznWG8Uryrhh0/aqeEUtac6ZBDDzIDFejA4+sMqhHc+NcWA/
         wyHKwbWY8Wad3V2CRsLDtXJMqfUU/E1uOcFCRsvV5vJW+8x0ay0EWhzJg3Avs2lwGQDu
         6N1InJ+Nnkhem9DSA+1S22HrazK3nadNEJnquMd/PfAOddm++Lt3w4VCP0TVp1GPZZRh
         mXcPjHRhxrxXc6Wobl45SlSWRS8k7eMgSYZ91IdDkHRb4KJUJIiwmlxFKvX56gqk7djB
         faXNVGUeqHAtghzK1haqk8OrDKIQmuIuXW9Kyj/vFf0Iv+NN/sUqI5D+scDRHbbxI/hD
         MdRA==
X-Gm-Message-State: APzg51AI1UMb3gYlIgcOSSwpYS8jSbGi0iAm5gLrmxbI8I2vho0NYe1V
        JDLdbd/w8coD1kefgn8Rq/6h9Rdp
X-Google-Smtp-Source: ANB0Vdb3+JUGRpHLwCA7Qqv4jIvGTHy5XEnYaUEohq4EmmJkDZjYYiz/+fd/M38u8Nfh6ktiPzdUFQ==
X-Received: by 2002:a17:902:102c:: with SMTP id b41-v6mr20076905pla.257.1536556670896;
        Sun, 09 Sep 2018 22:17:50 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id r23-v6sm29693985pfj.5.2018.09.09.22.17.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 09 Sep 2018 22:17:50 -0700 (PDT)
Date:   Sun, 9 Sep 2018 22:17:48 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Max Kirillov <max@max630.net>
Cc:     Jelmer =?utf-8?Q?Vernoo=C4=B3?= <jelmer@jelmer.uk>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v3] http-backend: allow empty CONTENT_LENGTH
Message-ID: <20180910051748.GA55941@aiede.svl.corp.google.com>
References: <20180908001940.GB225427@aiede.svl.corp.google.com>
 <20180908054224.21856-1-max@max630.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180908054224.21856-1-max@max630.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Max Kirillov <max@max630.net>
Subject: http-backend test: make empty CONTENT_LENGTH test more realistic

This is a test of smart HTTP, so it should use the smart HTTP endpoints
(e.g. /info/refs?service=git-receive-pack), not dumb HTTP (HEAD).

Signed-off-by: Max Kirillov <max@max630.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Max Kirillov wrote:

> Provided more thorough message, also fix test (it did not test
> actually the error before)
>
> There will be more versions later, at least the one which suggested
> by Jeff

v2 is in "next", and I believe that version should already be
sufficient for Git 2.19.  Please correct me if I'm wrong.

Since v2 is in "next", I think any further refinements are supposed to
be incremental patches on top.  Here's an example (representing the
v2->v3 diff).  It's more of an RFC than a serious patch, because:

This version of the test doesn't seem to reproduce the bug.  When I
run the test against the unfixed version of http-backend, it passes.
Ideas?

Not about this patch: could this test share some infrustructure with
t5560-http-backend-noserver.sh?  If there were some common shell
library that they shared, the tests might be easier to read and write.

Thanks,
Jonathan

 t/t5562-http-backend-content-length.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index f94d01f69e..fceb3d39c1 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -155,8 +155,8 @@ test_expect_success 'CONTENT_LENGTH overflow ssite_t' '
 
 test_expect_success 'empty CONTENT_LENGTH' '
 	env \
-		QUERY_STRING=/repo.git/HEAD \
-		PATH_TRANSLATED="$PWD"/.git/HEAD \
+		QUERY_STRING="/repo.git/info/refs?service=git-receive-pack" \
+		PATH_TRANSLATED="$PWD"/.git/info/refs \
 		GIT_HTTP_EXPORT_ALL=TRUE \
 		REQUEST_METHOD=GET \
 		CONTENT_LENGTH="" \
-- 
2.19.0.rc2.392.g5ba43deb5a

