Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33D591F51C
	for <e@80x24.org>; Thu, 24 May 2018 10:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031178AbeEXKWS (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 May 2018 06:22:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:44708 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031139AbeEXKCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 May 2018 06:02:54 -0400
Received: by mail-wr0-f193.google.com with SMTP id y15-v6so1974982wrg.11
        for <git@vger.kernel.org>; Thu, 24 May 2018 03:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w0bDlXuMNv9EKZwwQPpQOF2eUx1E8sEAJAG8givLX+o=;
        b=t6WdhbKjJOeDt7MWkXuAW/qeYtiDpgbTO/HKZuR7BczDQPDBEcI62BuorNtonsK7SW
         ZjYNZf19rGKeuYfNz6diPxtcEJIflqDtfcdeRZpLH6aXS1zqPEwC5UxR2YcT4JtsNCyN
         J4h8521Pq7JDiZoS+Jp06EsXcHCqt4Qqh9QM2FYFAeFggKOWkgMW+2uWV7VS7dNs2zbp
         HY2fGywNJqgdWy8Y9mTThapE/2KMLs8FdExcg/HWL9zEUubvLfSEwfMrWt+Oni6P2tCE
         busM84J0DHXn1qOe0YmNEwF2ANl9fTD28rJJ6Bue95du58tg/QUH3/xanLZoeNDdUvHz
         T32w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w0bDlXuMNv9EKZwwQPpQOF2eUx1E8sEAJAG8givLX+o=;
        b=FdvNpdxT81xV7uyu1YzW3LsjFr6DxNgTXLrDqcAvOCyVYpkcUE/3ofPFn7prZ8I7Sw
         lesQUyYdMo/2QpeJkwZ3+122xD2pllSAhuz0b1YsCiCsuCFQmVKiQaK+uuiqilbVEoGD
         ZqgdWRdcWPzSM9x45suWHf84KOYyErtk1NVoj6NmkizrNMOr3bQdE8aQKKcsisJ984T2
         2/YAkj75BKASKW8dpzqqNZ5HuyBSjeXuTKGDJ3xhHuiBYhSp1l+/u3YKtXHc/XHxv1VI
         gftTFlMr0znQZ1v8o6IgTKhV/FPzX6DllRm53gzkont1Xjij+6OZ8bSOlUfEQ3KUHyiz
         eJaQ==
X-Gm-Message-State: ALKqPwfgbrt4fkysPrcyZpmX9Ji4ljkVNyWRyvOg14GuXrz1VuHOE61B
        pg47Wm5kaImXtA7JVQxfo3Y=
X-Google-Smtp-Source: AB8JxZpYCYtAl+78kDPHixUxUbZjh75cSQ8ncMjvLphtX44ax1BUIETBrdejvZea1eJZv9ysdkNOTQ==
X-Received: by 2002:adf:9006:: with SMTP id h6-v6mr6353582wrh.123.1527156172872;
        Thu, 24 May 2018 03:02:52 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a129-v6sm3986436wme.34.2018.05.24.03.02.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 03:02:51 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 5/7] rerere: only return whether a path has conflicts or not
References: <20180520211210.1248-1-t.gummerer@gmail.com>
        <20180520211210.1248-6-t.gummerer@gmail.com>
Date:   Thu, 24 May 2018 19:02:51 +0900
In-Reply-To: <20180520211210.1248-6-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Sun, 20 May 2018 22:12:08 +0100")
Message-ID: <xmqqin7dqsl0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> We currently return the exact number of conflict hunks a certain path
> has from the 'handle_paths' function.  However all of its callers only
> care whether there are conflicts or not or if there is an error.
> Return only that information, and document that only that information
> is returned.  This will simplify the code in the subsequent steps.

Makes sense.
