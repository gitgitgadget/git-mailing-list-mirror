Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072701F462
	for <e@80x24.org>; Fri,  7 Jun 2019 12:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfFGMyB (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 08:54:01 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:37489 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727102AbfFGMyA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 08:54:00 -0400
Received: by mail-qt1-f195.google.com with SMTP id y57so2068288qtk.4
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 05:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D3Sf83T8mDgfhrtzRachCa9tWBaS+N91e14WJg+DV8s=;
        b=oi5VKLLRdo/1Z+x4BX6myCosCvCJMGSomLZEyzehJyUL7e97tatHD2miXfUXq5cfJC
         Fx6YLHks014mQolnDigTmcRs62+wGZKS9lWtpzCvtiXXQHTC/T/kcQUSxLfoiZSGzoDp
         YFunVZ+m6Rhf6WQJ5rMWrdeyMKgSxxnOndyP5jPqIffNKUtuGLcZGPByMyhnAozd6/Bd
         E+FFUwOooKEIsdbD32f78ve8XjkaZvp6b7YZKrGTeQmLy8/ZOEvc2W2e7dq3olWa5P7D
         5S+NOo888D068jliZq1C+Gz5CYjm2UdlWX3PMn1AHRP76r7yDWR7UjnJAXyS9mfaH/f4
         3A1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D3Sf83T8mDgfhrtzRachCa9tWBaS+N91e14WJg+DV8s=;
        b=GIfGZF5l0m2OpfAks7Siy7Sz56cALxFhbX2FVLDwgNKQ5dSTN3RsmueOLb5nnuVY1q
         nMS3VWRdINroIVpevyQ4pNI26wcZn57KztMBzElwLCYJATC+eF8HlCxHhrQZVe9f4NbA
         6GySFtd2Ll5r5A2mWEqo7gRzJFdamCxKCQAUN+U/BcFHN9Kl5gyOPpwzphi+29kv2pWa
         MWxhRGFH3GFGM8UhxoVb3DPoydeSaa66VRKb0DLepjLojGg4RaMNRAj/gMvKieemWU7L
         7s2AJlbdzo+hVkG4WICSi7XCiGIYPnYWPkHzHRhXZgZNF03m22FWa20Bi3y5E+ukQAId
         KPfQ==
X-Gm-Message-State: APjAAAVUcPLJd38TGgFc0Jn56nW73ivG/6gZCAr46wdg8gncRoTSfZzn
        EppJS5HvzsnpkX0jjPW7GKY=
X-Google-Smtp-Source: APXvYqzuQdisk+JMAlIvA98cK5JrSJAx1ZjHYz6AbEU7dT6XGxHBbFfwlyowPmDvGKAA4lacu7pMrQ==
X-Received: by 2002:a0c:b66f:: with SMTP id q47mr43844916qvf.102.1559912039999;
        Fri, 07 Jun 2019 05:53:59 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:4daa:35d6:a381:1849? ([2001:4898:a800:1012:fedd:35d6:a381:1849])
        by smtp.gmail.com with ESMTPSA id 104sm1029031qtc.36.2019.06.07.05.53.58
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:53:59 -0700 (PDT)
Subject: Re: [PATCH v4 04/14] commit-graph: load commit-graph chains
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        git@jeffhostetler.com, jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Derrick Stolee <dstolee@microsoft.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
 <pull.184.v4.git.gitgitgadget@gmail.com>
 <ca670536dfe08277e953b2ef5f017dc32c1581d5.1559830527.git.gitgitgadget@gmail.com>
 <xmqq4l52qrt0.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <684d1184-71c4-92c2-bdb9-50cf4e547f1e@gmail.com>
Date:   Fri, 7 Jun 2019 08:53:57 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <xmqq4l52qrt0.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2019 6:20 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +	if (stat(chain_name, &st)) {
>> ...
>> +	if (st.st_size <= the_hash_algo->hexsz) {
>> ...
>> +	fp = fopen(chain_name, "r");
>> +	free(chain_name);
>> +
>> +	if (!fp)
>> +		return NULL;
> 
> Checking for size before opening is an invitation for an unnecessary
> race, isn't it?  Perhaps fopen() followed by fstat() is a better
> alternative?
> 
>> +	oids = xcalloc(st.st_size / (the_hash_algo->hexsz + 1), sizeof(struct object_id));
>> +
>> +	while (strbuf_getline_lf(&line, fp) != EOF && valid) {
>> +		char *graph_name;
>> +		struct commit_graph *g;
> 
> I am imagining an evil tester growing the file after you called
> xcalloc() above ;-) Should we at least protect ourselves not to read
> more than we planned to read originally?  I would imagine that the
> ideal code organization would be more like
> 
> 	valid = 1; have_read_all = 0;
> 
> 	fopen();
> 	fstat(fp->fileno);
> 	count = st.st_size / hashsize;
> 	oids = xcalloc();
> 
> 	for (i = 0; i < count; i++) {
>         	if (getline() == EOF) {
> 			have_read_all = 1;
> 			break;
> 		}
> 		add one graph based on the line;
> 		if (error) {
> 			valid = 0;
> 			break;
> 		}
> 	}
> 	if (valid && i < count)
> 		die("file truncated while we are reading?");
> 	if (valid && !have_read_all)
> 		die("file grew while we are reading?");
> 
> if we really care, but even without going to that extreme, at least
> we should refrain from reading more than we allocated.

Thanks! I clearly was not careful enough with this input, which should
have been easy to get right. I think all your points are valid. The
code looks much cleaner after rewriting it to care about counts and to
properly order the stat() call.

-Stolee
