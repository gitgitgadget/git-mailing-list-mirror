Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 271B320960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755193AbdDMTIn (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:08:43 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34633 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752196AbdDMTIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:08:42 -0400
Received: by mail-pf0-f181.google.com with SMTP id c198so32410858pfc.1
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LufMecEsRnqj5Vdx3tIwjLolB75m3WnCVQ7SevpJl48=;
        b=q/T3HmuQqidpJifmtt3KTefatDKw3s0khtLUGhugcJOskIknyQ2RlZeDd6geGoG4XV
         Aznd8lc17d1z4AOsR3nRmDFnKriDpVCPQ+3a4q9zw5KcgyaKUTtcltFECJCku6NVj0oL
         kJRA+RG9T5oBBFqQzD7WCLenRZ6xL53fC4dowtMkOAmo2XxoWIJ0VgZ/EtweX+qCuh1E
         Y1abdStMtZHddKqUjSh4qnyFU96Kg81jUirkfR1xtruHYxmWjxF1SJIgHTi2e5w/Ozz+
         0FYscFc/ddhnqbj2AJHCnDm84fylvbQk/TgXKIPyTnSoLXJVYxJ6vBdAkVm1xKskCE+O
         1exw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LufMecEsRnqj5Vdx3tIwjLolB75m3WnCVQ7SevpJl48=;
        b=RDU1S5yZs6sNb0uOiQ1UOwZNzAiQzuy2Czma1n3bYdyhcz0UPKgXeAlLhglR+SbfVL
         agGmrLECA4gqfVunTssQUS0h3nkT3KwAmdSRamTwsG7gEJIped6vMPw9qceFQD3uWhCr
         guoRugMLgfNd77DlJFrA07L3P9Vee7hxn36acimVf6K8WvwlW4bNTpGz/7toz7dwQqtu
         TzzOFWj2k9hwTQEdF93ztL6GgpCkrRcu7JEAAt/jeo3Jc9SciEl+YsO1l34zWu7JD4HE
         ngA2WOPa/Oh5aPQGc3fnyNV7uBuTCaNWlEyUIJG4DAEB6OxMAlpKIAdv+sDxeFhNRc11
         WzIw==
X-Gm-Message-State: AN3rC/66fGuqd12+MGMd1BWXWKkIoH1yjEONcexNlM3vD/IZ4AFZlTH3
        mzw5DlWzAASfouc3
X-Received: by 10.98.131.197 with SMTP id h188mr4072049pfe.99.1492110521431;
        Thu, 13 Apr 2017 12:08:41 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id m4sm13270991pgm.25.2017.04.13.12.08.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 12:08:40 -0700 (PDT)
Date:   Thu, 13 Apr 2017 12:08:39 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 3/4] submodule.c: harden submodule_move_head against
 broken submodules
Message-ID: <20170413190839.GE96917@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
 <20170411234923.1860-4-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411234923.1860-4-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/11, Stefan Beller wrote:
> Early on in submodule_move_head just after the check if the submodule is
> initialized, we need to check if the submodule is populated correctly.
> 
> If the submodule is initialized but doesn't look like populated, this
> is a red flag and can indicate multiple sorts of failures:
> (1) The submodule may be recorded at an object name, that is missing.
> (2) The submodule '.git' file link may be broken and it is not pointing
>     at a repository.
> 
> In both cases we want to complain to the user in the non-forced mode,
> and in the forced mode ignoring the old state and just moving the
> submodule into its new state with a fixed '.git' file link.

What about the case where you have marked a submodule as active but
don't have its respective .gitdir yet?  For now i think it would be
acceptable to complain and do nothing/ignore it, in the future we may
want to actually clone and then check it out.

-- 
Brandon Williams
