Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02F96202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 17:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754047AbdGLR1s (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 13:27:48 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34959 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753913AbdGLR1r (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 13:27:47 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so16181847pfk.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 10:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U/7wg4dzozwcxC+fIizvSZHzk+FXz1quazkBBsXBzqA=;
        b=ec70Eom+TdmAPgpHus1ixMmIMMEl2fwJjO11ezlATNPVZzWSSMv4lHapm7RiktmRVd
         Fg0d+wZ5cgw9MiTAO7PPPvaKzQFYpHfmTmagydHq1EjbidNBrFiw3jwbcHzt2x5YaFPr
         HPqwfEkHZkAAuEHx3SjW5QK0iL0CfjjJsR4dkuPv58KzzIYZ136XinQKJUXbQOgGUxxK
         frcZKUPql3y1pDofps7hl0K5tC3oSxFnzahzs35C/uJ2nYH5Egki7hot5jgSjxLNRAa/
         ELCX6U42QQ/ldDXIOvAzx+LW4G0HrfAEH+UW8QxjhsuqTJcOUOnauzHUC5VOYbCuiIdl
         N9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=U/7wg4dzozwcxC+fIizvSZHzk+FXz1quazkBBsXBzqA=;
        b=q4mwGKqtTIWuiwSkOJ2sueQGV0BdaT8A6ZJ44n4q/reh/51+4bpGjtmib1pn4GLCby
         ORnI8Ppz1suPVK5tuliqs05r79DiYyn+cXrI3hIXRstxAARyOrpq+zIOV+ScHAV4PU7P
         PnsCh1UsQfkjfD0bx15V2O4NAkx0K4TbA1OPAAxITZ7GkqU+Vglpmne6wNfoym4Vv17F
         lsNZ5Aq/ZQy3zOch8ZrWChEi+tW2eY6fCv0y4Wg98N4deXme1VEJsmV4uDOEUqwPD3ou
         f7yGRHFUXNL+O9Jwb33ISUDZpw4ASmLU0OzaCHRZ+9nLDbDuFPcjKNGFZASfszY6OEb8
         LoxA==
X-Gm-Message-State: AIVw113dW4pD5an+KZg5ThPsDZhHVAwTeiBbNFrC5IXK4ow3f/T/DGlA
        L6OfR8vHHSHCgCYS
X-Received: by 10.99.104.129 with SMTP id d123mr4882817pgc.236.1499880466554;
        Wed, 12 Jul 2017 10:27:46 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:3d1f:bb9:8897:56b4])
        by smtp.gmail.com with ESMTPSA id f2sm5839117pgc.17.2017.07.12.10.27.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 12 Jul 2017 10:27:45 -0700 (PDT)
Date:   Wed, 12 Jul 2017 10:27:44 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 1/3] repo_read_index: don't discard the index
Message-ID: <20170712172744.GB65927@google.com>
References: <20170711220408.173269-1-bmwill@google.com>
 <20170711220408.173269-2-bmwill@google.com>
 <20170711235116.GB93855@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170711235116.GB93855@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Jonathan Nieder wrote:
> Brandon Williams wrote:
> 
> > Have 'repo_read_index()' behave more like the other read_index family of
> > functions and don't discard the index if it has already been populated.
> >
> > Signed-off-by: Brandon Williams <bmwill@google.com>
> > ---
> >  repository.c | 2 --
> >  1 file changed, 2 deletions(-)
> 
> How did you discover this?  E.g. was it from code inspection or does
> this make the function more convenient to use for some kinds of callers?

When working on another series I realized that some code paths may end
up calling read_index() a bunch and I want to prevent discarding and
then re-reading the same index over and over again if/when those calls
are migrated to using repo_read_index.

> 
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

-- 
Brandon Williams
