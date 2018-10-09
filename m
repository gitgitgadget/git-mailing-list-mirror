Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53911F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 09:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbeJIQqg (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 12:46:36 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46355 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbeJIQqf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 12:46:35 -0400
Received: by mail-wr1-f65.google.com with SMTP id n11-v6so909401wru.13
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 02:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B2ZrI1NRdHnaCAUW3hpcUICS+hyKkB/8z79QnOfSAOA=;
        b=R1TBZd0MliR8xmptCGUX0F2N7V64eeKmwFrZ4IPDMnmlfN/XPfWEO2Ajri+7tSWnva
         UBYfkxUIH40TJ/DjZR1lUCmyX4mFAOD03jBwff/7WEyqTVx6/LNbZLLJz4hhbVjKeljV
         bYkB0+0p7fjFPOJKqjhq0YNBqaOx5ZurXwAeEpeaTk0v4LT1Ze2BXCOfajsT5rFk4UBE
         3n5qSYuxGq7+h8tStsVuplzPCfSAGLEPI31PieuDBUsNCbncM7c06n0iW9ig/z5m//xf
         B3A0DRJtzL5wfVo4pJcK+iv3DjA4e1XBp32oCwD4jBzcBF1k6X6VqUnrIRXV+zH7+32c
         VA1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B2ZrI1NRdHnaCAUW3hpcUICS+hyKkB/8z79QnOfSAOA=;
        b=RVrnoRig9Z/najJqLpODso4nFD9kC0iknTqxTxrc4DxI63sSdXK9Fk8F6uKFiJgFig
         noCb1Ia9NwSynHbg4Rz7E9qTKak5sp9oipRWfHadOhtW4v4jGudexMTk1y6qTMYlR4jb
         WCJ7w3H7XFaSbnqcX+lLsSvlOx19vBgG91fqQl9Aa8Bu1LIL5KcraeiOU3dT/ZAZ44oJ
         HT8EfxDc1zJ/7GW2ltTzEM002PEkGS/h77o93HpSHKJSUMUr72e4/UptZMXDQ8tGo3OK
         bFt3xju1KR5YHvn6hwQ7xrP8G0Ql5o+nCV91y1xQHek6uwMQ/EkyE5TbhIkte3V/4ll6
         fnsQ==
X-Gm-Message-State: ABuFfogOVlFtDuIjDlF8sGJJeLVdkESYEyvSNBAP/TYeTKdEu0jYk6Pd
        IqgaNG7WKKmWtPGwzN9eQ94=
X-Google-Smtp-Source: ACcGV62VnB5u4bykyJTP2cv/mK+ukUMKyxfEPx/bYx8LP107WXe92Wl22yzQ6frcg+7K3KC9/vTf0Q==
X-Received: by 2002:adf:d149:: with SMTP id b9-v6mr20311201wri.17.1539077434194;
        Tue, 09 Oct 2018 02:30:34 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b81-v6sm10881596wmh.47.2018.10.09.02.30.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Oct 2018 02:30:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] unpack-trees: allow missing CE_SKIP_WORKTREE objs
References: <20181008214816.42856-1-jonathantanmy@google.com>
Date:   Tue, 09 Oct 2018 18:30:32 +0900
In-Reply-To: <20181008214816.42856-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Mon, 8 Oct 2018 14:48:16 -0700")
Message-ID: <xmqqpnwjpivb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -1635,6 +1635,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
>  				o->result.cache_tree = cache_tree();
>  			if (!cache_tree_fully_valid(o->result.cache_tree))
>  				cache_tree_update(&o->result,
> +						  WRITE_TREE_SKIP_WORKTREE_MISSING_OK |
>  						  WRITE_TREE_SILENT |
>  						  WRITE_TREE_REPAIR);
>  		}

Hmmmm.  Should this be passing the bit unconditionally?  Shouldn't
it be set only when we are doing lazy clone?  A non-lazy clone that
merely uses sparse checkout has nowhere else to turn to if it loses
a blob object that currently is not necessary to complete a checkout,
unlike a repository with promisor.
