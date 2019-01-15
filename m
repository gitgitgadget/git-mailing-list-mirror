Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7DEC1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 23:41:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391480AbfAOXlq (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 18:41:46 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41396 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387904AbfAOXlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jan 2019 18:41:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so4910259wrs.8
        for <git@vger.kernel.org>; Tue, 15 Jan 2019 15:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gHyKpfCirnJ9vr2w+XWXzOesKakQNdZfQBXa6Tt6AoE=;
        b=cNfLZDEB7INZ+6TfdrK0XyWpakHmREDCmGrAbAatnvY7/C2Tks5rxyd4KYwFyAehK6
         Md8AItyznnDFuzJqMgAca+NQW2UWn3Imo1xtwSolNjsBuStJ85V7poc+CKQsEfMLdIfo
         jeZHrCHRnzM8Lyyq3NrAY6VvXx8BiiHv471EVO1+dNwjnXGfYZDygsbyIRRdd/WHYYoz
         cYn6vMs1YWWPdfWSUbiQaMz3oCIzaUXuYh31fLjHJDmkAej0aO/adu6/Kufpj+gI4Nrl
         9Um/nIKurLMiR1e/rk8mLDbYj0DU7r8EdPbcuI2j3p5BqP04+JqIciNxGdLd6AlT39qY
         DyKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=gHyKpfCirnJ9vr2w+XWXzOesKakQNdZfQBXa6Tt6AoE=;
        b=WzeXlhwRuqKTXf7aqddJte7YwxpBQWLFpvwBJvaU0LBmVWHvOZcU8pjkDZF5Umjsvr
         AGUsfirgsGQSblQ8zzhNtgz6ZkTYCaTFg5ePeeVNYSXxVV+C6TACdAN1iLUJmAl3zpYc
         o88/T8JnpZrKwGfzR8RABA/uWeMDIqet3bzXh0ocwWGGtNIxhsTPcpK3sZvVRh7H+YmS
         U0HHz49von5ZCaISKIG48NimvFuzNvxCPtBSMpNuEJot1Ofv7yPZ4y7SxEO+KA5NaIqK
         TqDfU63cYO7fLNjaxWgVMYf1x0bV/8nyAX1Kq7J1NFjKpgJ7b+RJZqqgDh0qS3fP+XOp
         nlCw==
X-Gm-Message-State: AJcUukdHMlW/0aphGs7r8DeOKVbj5tbpmTfJaWdQ3zkj7UzqRaIBz6io
        WpvWqeh28Ft+Nb/OD/9krK8=
X-Google-Smtp-Source: ALg8bN62YbKWTEREGESOQAlEYIZu/TpNKZ19VL+9eCy54zu21pHpTQQ74XoNz3XY+lgmqIiPRRNj8Q==
X-Received: by 2002:adf:c7cc:: with SMTP id y12mr5225533wrg.52.1547595704637;
        Tue, 15 Jan 2019 15:41:44 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p10sm22524665wrt.25.2019.01.15.15.41.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Jan 2019 15:41:43 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     matvore@google.com, git@vger.kernel.org
Subject: Re: [PATCH v3 0/2] support for filtering trees and blobs based on depth
References: <20190109025914.247473-1-matvore@google.com>
        <20190109180633.10273-1-jonathantanmy@google.com>
        <xmqqftttpk8w.fsf@gitster-ct.c.googlers.com>
Date:   Tue, 15 Jan 2019 15:41:43 -0800
In-Reply-To: <xmqqftttpk8w.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 15 Jan 2019 15:35:27 -0800")
Message-ID: <xmqqbm4hpjyg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> This is turning out to be messier than I like.
>
> The topic is tangled with too many things in flight and I think I
> reduced its dependencies down to nd/the-index and
> sb/more-repo-in-api plus then-current tip of master (and that is why
> it is based on a1411cecc7), but it seems that it wants a bit more
> than that; builtin/rebase.c at its tip does not even compile, so
> I'll need to wiggle the topic before it can go to 'next'.

Half false alarm.  I do need to wiggle the topic, but that was not
because the choice of base was bad.  It was that nd/the-index plus
sb/more-repo-in-api had semantic merge conflicts with the then-current
master.

> And worse yet, it seems that filter-options-should-use-plain-int
> topic depends on this topic in turn as it wants to use
> LOFC_TREEE_DEPTH.

This part is still true.  The scaling-factor-over-the-wire topic
does need to be rebuilt on top of this one.
