Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1EEF1F4BE
	for <e@80x24.org>; Wed,  2 Oct 2019 20:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfJBURD (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 16:17:03 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38194 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfJBURD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 16:17:03 -0400
Received: by mail-pg1-f193.google.com with SMTP id x10so213742pgi.5
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 13:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6nVyhp6sAiUffMIh3cdGAW+GWDG+8o98wX6opxCA+o4=;
        b=sr9j2KCBXeg4XjY34wNfxc6ma8gpjyZ6cjvkpa/sIEwnxl/L2zF3hNf3lwsruHkVPi
         s1dkvBVogXNvLP4rxp7Bj5YrY9/ECWck38U8vIMZYOGNfaw8H2wvz2DKaZopGmglj1GT
         GTy3Q8YNh/U3dKssLEEBc5fhlq2WYbqppZ2py9XBssGcw42vyde/4zR+inPANaTuwv/U
         e9QouwWIKlqnetGiNDbd/qTuR/m27whaEH0hofEObfrfVQ4DiLUUdeztjItg6TXYvU5W
         FkL+qhsSR0OXuQUx5K7MhnbhMsJTebrF7xHyQtUpvUI6V2UHucRMPu/xk5YqYZf+KISr
         viaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6nVyhp6sAiUffMIh3cdGAW+GWDG+8o98wX6opxCA+o4=;
        b=H5UhE2GAoadeN9MtYSAEdwdJyPjh5v9Dt0C+4/saPrk6VTaaJM03Py/0fwgWICzUVO
         8aqvgzHBhf9oQ3O2AKSQKgGSIX3+OH0nWdE8CMYl7Enc6bX3irbShvcd6srRFPkjnIJT
         m9L0J8mO1F5Bti9Lvh4k7AlVJAV00t3HkKlbTGC8amUmObBuWRZBSbaE5lPsu9ZeG//r
         4aJB7hj+XX257SUSGvN0QCP22Jmt0TDE5D55IbxaN0UzJGyEFGWJoVWoiQc/7VlTiF13
         3Cg3a6wR6Jd+Hg4binMVHWu7rMw9SVIMRQEoMturUYxwotXQ8l38u9KEU2hhhFurAJEp
         JnSA==
X-Gm-Message-State: APjAAAU5SXbb30QbaoevsQNnVu16sBOtG29rW2T8kmhadKQZJSLdAKqr
        XsjPHPucgYbJNEjyE6IoZik=
X-Google-Smtp-Source: APXvYqzdHlcZ8lwUaHv0aRa84JUVJssvzw0U3bVSfvsuwIpxV/bdHHGt/5NsG73s7OT/KAy1AaiTxg==
X-Received: by 2002:a62:53c7:: with SMTP id h190mr6689638pfb.208.1570047422428;
        Wed, 02 Oct 2019 13:17:02 -0700 (PDT)
Received: from generichostname ([204.14.239.137])
        by smtp.gmail.com with ESMTPSA id z12sm325551pfj.41.2019.10.02.13.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2019 13:17:01 -0700 (PDT)
Date:   Wed, 2 Oct 2019 13:16:59 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Paul Tan <pyokagan@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [BUG] incorrect line numbers reported in git am
Message-ID: <20191002201659.GB24697@generichostname>
References: <20191002184546.GA22174@generichostname>
 <xmqq8sq2ewzh.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8sq2ewzh.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 03, 2019 at 05:03:14AM +0900, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > which is in the middle of the log message. I expect the line to be
> > reported as something in the range of 198-203,...
> 
> That comes from not knowing who is complaining and what it is
> reading.  In this case, "git apply" issues a warning because it is
> fed .git/rebase-apply/patch file, which is the output of mailinfo
> that parses header & log message out, leaves the message in a
> separate 'msg' file in the same directory and stores the rest in
> that 'patch' file.  And it is line 87 that has problems.

In this case, I would still regard this as a bug since users would
expect the line 87 to refer to their input file. I think most users
don't even realise that a .git/rebase-apply/patch file exists. (I
certainly didn't.)

In fact, running `git am --show-current-patch` shows the whole mail, not
only the 'patch' file so users would have no reason to expect the line
numbers to refer to the 'patch' file.

I think it would make sense to pass the number of lines skipped by
mailinfo to the apply step so that more accurate line numbers can be
reported to users.
