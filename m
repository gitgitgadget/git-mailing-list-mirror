Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D68C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 18:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjEBSvl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 14:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjEBSvk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 14:51:40 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2996E73
        for <git@vger.kernel.org>; Tue,  2 May 2023 11:51:39 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6a5e7482961so1616288a34.3
        for <git@vger.kernel.org>; Tue, 02 May 2023 11:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683053499; x=1685645499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z8YiQdPwQ1yoA5vWGzpO++sZOPjsBltqNKGuFBgr0Ic=;
        b=Gvlts6/Qi8Gnwgc+QPC781YFgH2vlpF7Qhqsa6jtUUIKzziTYSEghkkLbZ4Y+AT7+R
         mkhIDf8ArMeAr3DFQ2yp+rViYQBvdVXANA6OrNvY4oINfeU0Ev3t6Jlwq0M9Ca6E5JGE
         lSx0TbMm6nuDvPMFlRbdKzuzwWb44fjkXMiB4W+JnG1aGrpG6P6qeTAly6eY9SDnXEpv
         2zEPFhyp+RgDgKI9YfaTM21QGUN3E8utx/ve03XlqDP83CtdjYIAD+QE/dtxhsR6prxF
         ZtWrs7OSHH8tCFJwjfYkPDRHj4rLmC0WWUrzzjvooAh1NOZ7BAW81ND9YWbJrHOOmqoT
         PWGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683053499; x=1685645499;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8YiQdPwQ1yoA5vWGzpO++sZOPjsBltqNKGuFBgr0Ic=;
        b=MfHe3qMjJ6/WMjMyHq+XCpGFXYZkoAUzVcPKE9E7ruYFoO6tlGrKceJDVF66Iv3LOt
         Yp5kzA5S1496qsJUHTzGB9ijkCJSZY4Y5q4qwKVFntGVhVKdd35/LHMQH0BgiDAvR9+C
         HWcQaA4LKjkzME6zEzAMi/GvSr61JbuuDDfw9WES2uOYBzPfGL/GDWzPPExE8+Nn6/Y0
         AaUVRy9ErCXkWRgjExyPleYuI1X5yaLUEXwLau6QsBuXmtnRjUYdqZ9T4SZoohZd+Ikv
         9xw1k3L0zm/sS9v5ufOFOk46jwk8CRDa4DiPAQMjE1HWmMAngKjMB6YRaNcD07WZrs60
         ju+g==
X-Gm-Message-State: AC+VfDzosxKAPrELGqsckjM/aCAGQS1TxEM7DLTyqxd6ZtrqjlDif88Z
        yKVMKuyfxU7WYFj5OnqrRIeKd7iBqgw=
X-Google-Smtp-Source: ACHHUZ5zqLwdIpDWpJOzRXplvdF05XLWK7nUoO763Cb7brBlvRPognzUNAxLO6SR2MQItM3ciA1wzQ==
X-Received: by 2002:a05:6808:1801:b0:390:9228:c772 with SMTP id bh1-20020a056808180100b003909228c772mr8868444oib.52.1683053499124;
        Tue, 02 May 2023 11:51:39 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id y64-20020acae143000000b0038bb2f60064sm12889871oig.30.2023.05.02.11.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 11:51:38 -0700 (PDT)
Date:   Tue, 02 May 2023 12:51:37 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Message-ID: <64515bb97dd1b_1ba2d294f3@chronos.notmuch>
In-Reply-To: <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
References: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
 <20230428125601.1719750-1-oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v2] rebase: clarify conditionals in todo_list_to_strbuf()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen wrote:
> Make it obvious that the two conditional branches are mutually
> exclusive. This makes it easier to comprehend and optimize.
> 
> As a drive-by, remove a pair of unnecessary braces.
> 
> Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
> ---
> v2:
> - slightly more verbose commit message
> ---
>  sequencer.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/sequencer.c b/sequencer.c
> index 3be23d7ca2..9169876441 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -5868,12 +5868,9 @@ static void todo_list_to_strbuf(struct repository *r, struct todo_list *todo_lis
>  			if (item->command == TODO_FIXUP) {
>  				if (item->flags & TODO_EDIT_FIXUP_MSG)
>  					strbuf_addstr(buf, " -c");
> -				else if (item->flags & TODO_REPLACE_FIXUP_MSG) {
> +				else if (item->flags & TODO_REPLACE_FIXUP_MSG)
>  					strbuf_addstr(buf, " -C");
> -				}
> -			}
> -
> -			if (item->command == TODO_MERGE) {
> +			} else if (item->command == TODO_MERGE) {
>  				if (item->flags & TODO_EDIT_MERGE_MSG)
>  					strbuf_addstr(buf, " -c");
>  				else
> -- 

FWIW makes total sense to me and does make the code easier to
comprehend.

Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>

-- 
Felipe Contreras
