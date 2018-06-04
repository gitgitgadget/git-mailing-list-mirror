Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3292F1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 10:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbeFDKqc (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 06:46:32 -0400
Received: from mail-wr0-f174.google.com ([209.85.128.174]:42182 "EHLO
        mail-wr0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbeFDKqb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 06:46:31 -0400
Received: by mail-wr0-f174.google.com with SMTP id w10-v6so42724699wrk.9
        for <git@vger.kernel.org>; Mon, 04 Jun 2018 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rrtsTmOTy1cZU1b0dsBKOeBl8C2ybdibr3YkUgLFEUs=;
        b=uQlQ5w9ilxKa0nGvMteAz4TEfKoKmUFFTkgrTKQx2pB+DmTFO8Y1LYpm8atSRmZ+8Z
         rBp0TXuP6Zwk9Ye7mV9Y0OCCgOrrZoDYT2deYPL6yiAESS2gCggSsWwWEfVYiHeM7vkH
         ERULScX8ZY8ZvS0/0kVKC6S+O5VFGZwUKjFKM7QsxSg6kGPzxQLbWyYKO1cRyRXjfllQ
         0RFxKBlsehcSs1zqvNXIdd7Ghfxmq80fQj2SqNXoYXh1Sa4CpVD9JBYzUy3+NtK2Qahc
         VbMgldXet+k8rXseAao+V55TVfC0Ydd7w59TGTD79AgMU6OtxqtAupkhJSxUOiIJDVHO
         02ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rrtsTmOTy1cZU1b0dsBKOeBl8C2ybdibr3YkUgLFEUs=;
        b=I1LTJsYOdeZ5RjuW4BId4tnBk9xyFGpRmx5hJp4ldgxp9uB5iUE9tJB6d/9uBXTBNb
         hN9hNL1WgutS7YttlTJmrvmiO4ipqsmb5ogUang4OvwEG1YvgyNgIsfCJ6Um3BneSrk8
         2n/QY1hk81ldZ+BmN1yttBo1pJW7f+4Th1inFYj2aP3I4pk99jESuWUQOpG+yUjUPtB9
         cxDLdG55pyZCHi+hb0e+3s1CHH5IpqpdOBgXMUmhcRexlQvXYgKws007Vgygk6EvPp9G
         7eQrw0Fq4SuHpu4K7L+SsAoneHYO5WIrpwOj4ojz9eJtg4WNi0mEivlT4GfFrWBr7DLF
         IGHQ==
X-Gm-Message-State: ALKqPwe2bwBpRCw7xQ0l1pXFsEBVeu7mh+kGmt2NzMX+djCNuCu5LJTS
        8JHKzKKb/xEVP6U9Pd/ZTP8=
X-Google-Smtp-Source: ADUXVKK80oNzTdMhyRVXl78NDmNOpovM3JxfoVuHMzbLReQp8HFUOBTSttTZt1PJXHizIvTqbZdE7A==
X-Received: by 2002:adf:e20b:: with SMTP id j11-v6mr15913119wri.205.1528109189772;
        Mon, 04 Jun 2018 03:46:29 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d9-v6sm39174766wrn.71.2018.06.04.03.46.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Jun 2018 03:46:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, a.krey@gmx.de
Subject: Re: [PATCH] upload-pack: reject shallow requests that would return nothing
References: <20180522194854.GA29564@inner.h.apk.li>
        <20180526113518.22403-1-pclouds@gmail.com>
Date:   Mon, 04 Jun 2018 19:46:27 +0900
In-Reply-To: <20180526113518.22403-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 26 May 2018 13:35:18 +0200")
Message-ID: <xmqq602y6d8c.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Shallow clones with --shallow-since or --shalow-exclude work by
> running rev-list to get all reachable commits, then draw a boundary
> between reachable and unreachable and send "shallow" requests based on
> that.
>
> The code does miss one corner case: if rev-list returns nothing, we'll
> have no border and we'll send no shallow requests back to the client
> (i.e. no history cuts). This essentially means a full clone (or a full
> branch if the client requests just one branch). One example is the
> oldest commit is older than what is specified by --shallow-since.

"the newest commit is older than", isn't it?  That is, the cutoff
point specified is newer than the existing history.
