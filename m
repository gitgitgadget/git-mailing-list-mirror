Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9F731F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 01:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbfDWBSw (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 21:18:52 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38891 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbfDWBSw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 21:18:52 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so16507230wmc.3
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 18:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tp396Std37eZIRJRIWMz6fF0JZ5Tll0icjEAu4ZEnpM=;
        b=bGD5rFVBZVMrwGvWK2yE87JWjpF2cZjWw2FOMB5CcFihomDJfnVPEAZg7RFtggT8Oz
         bAb4fmRl5gkbBh1hElu67CWLHJB979P9aMpahBw2BAzXTHHTfuAvYQPT3y6PZS22QHWo
         Aj5Hi4xA633kqM0Lo6pMINCKnFPo1HZBChlWP7sqdAf25RyUwQbeDgAeyJXh9jBFSzgU
         cdmaSzinAoVkA6sd5HCwzEU5EdxswMQTmddPaz7eI3xkbgI7VGBw55ezFGH9gbJe75Su
         v0UQEvYVVKiv6Zn6wm8evUYho6xoLl5ywBBniK3fItCIXkCQdVjiPt5TuXhwtjwEC5rd
         PqaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tp396Std37eZIRJRIWMz6fF0JZ5Tll0icjEAu4ZEnpM=;
        b=IJAn+FyX13B/kNXgBBikJAftjbKJGsCxwwwPp1UYPOQuoFyT1Q6wumOwJ7bNkg6KEM
         6CGeeISkPbBUNSDH2OVBhKK3pyRcSYXWQ3lQl/zA80iFqqL+DGRxrhvSHSDfTI7NsreJ
         jWfcsJQ0EFI1rWjLFFgXbUOZk70Td/zGjVe2PGNlhouinv8qJ86ieu8fEZmYJIMiWyI/
         6wahDvuF2ESdX01Pi+I6tF1f4H+jMvcMs+HmkFeOgkzIcZjoPopMCxZNwkzk6C9W2Cra
         s9PqAXIvWUaIhrbilD+Vro1OawKc1NPf0GUCwDzSKgsSTndcG3j1wOfNe8wv99fBbjF5
         qfEQ==
X-Gm-Message-State: APjAAAUiS0qFSHBVw3TiLQTB5SyKUFWEgwibKH+SXApd24Hx8MqfTwaD
        K5gsUzu3z1op/fvLlzyvoBw=
X-Google-Smtp-Source: APXvYqzAQnKREz447tZ895o49M7aWzqELH+1JciEktW2DypbJLt9Td6ZHm/M68oYPGoUDfUDCILtJw==
X-Received: by 2002:a7b:c408:: with SMTP id k8mr182478wmi.69.1555982330146;
        Mon, 22 Apr 2019 18:18:50 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t15sm14247829wmt.2.2019.04.22.18.18.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 18:18:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH/RFC] Makefile: dedup list of files obtained from ls-files
References: <xmqqy343a43b.fsf@gitster-ct.c.googlers.com>
        <20190422144927.GA6519@sigill.intra.peff.net>
        <d869060a-a731-ff1d-3131-a146078fcf88@ramsayjones.plus.com>
Date:   Tue, 23 Apr 2019 10:18:49 +0900
In-Reply-To: <d869060a-a731-ff1d-3131-a146078fcf88@ramsayjones.plus.com>
        (Ramsay Jones's message of "Mon, 22 Apr 2019 18:15:34 +0100")
Message-ID: <xmqq8sw17c3q.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>> FWIW, after reading your commit message my thoughts immediately turned
>> to "why can't ls-files have a mode that outputs each just once", but
>> then ended up at the same place as your patch: it's not that hard to
>> just de-dup the output.
>
> My immediate thought was "that is simply a bug, no?" :-D
>
> I haven't used 'git ls-files' that much, so it's no great surprise
> that I had not noticed it odd behaviour!

Yup, the real issue is that ls-files uses exactly the same code for
tagged output, output with stage numbers and just plain list of
paths, so as we saw in the motivating use case for this patch,
unmerged paths give us one source of duplication when we are asking
for list of paths without stages.

It also considers, IIRC, deletion is merely one of the forms of
modifications, so asking it to list modified paths and deleted paths
at the same time would give you another source of duplication.

Perhaps not-so-low-hanging fruit miniproject would be to teach
"ls-files" a new "--dedup" option that does two things:

 * When -m and -d are asked at the same time, ignore '-d', because
   '-d' will give duplicates for subsets of what '-m' would show
   anyway; and

 * When neither -s nor -u is given, do not show the same path more
   than once, even the ones with multiple stages.

Perhaps it is safe to leave a #leftoverbits mark for the above, now
that two people in addition to I noticed that the behaviour is less
than ideal.


