Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E1FB207D6
	for <e@80x24.org>; Mon,  1 May 2017 23:29:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750842AbdEAX3X (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 19:29:23 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34218 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbdEAX3W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 19:29:22 -0400
Received: by mail-pg0-f66.google.com with SMTP id t7so18116663pgt.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 16:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=9FUmsfQQ/IzIULXeGVB1vsAPHjJIYMOshrv4nEKugK4=;
        b=auAfqyrc3cdhsP9ejZbRXdAcYsTc0ma4dDp/uyMxRjeT34fwjRLmekbnOGujikxkaO
         rKwBdZGb8avXZydbqdiEmPHQ2s5cDQp0CHYtppHY6qydcUflvU8kEA8NYszt/EY2ht9h
         waq6/WFxnU8v2zKWnRz4o6gD8efBvmkdFOhxZywVbdB2oRoHe7Cttrm/CyYlEFh1zI0o
         sTf0VBSnfFOzjx2lMYZf+arGEmMSyiEjt0FJm00oHIlt8AMRI+TMshyOSJEyMJ5heTXD
         YO5wTUYdrnzU/xq4G+xRwINXSouS0G+gG+2mgchxNZME2RNUmwwmNF0y+RcApRQ6Gf9a
         /PNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=9FUmsfQQ/IzIULXeGVB1vsAPHjJIYMOshrv4nEKugK4=;
        b=SjvSLTDg+qt47Dq4c+oXg1NhOePmyNJPJTxUC8dyAOaPsdB3b4wedMt0/nON5HOe1X
         dBnJCP3EwCVf/WCNjRkYh2+EGiJwsoZr0IAoQ5LLZe/kbo7Nqwmu1AlGqvGe6iJ36oVS
         MlSZbWgjjxBua8JiZZ5OrQuPQA0AuoThEzCpWCgNMRAMkZkxh9C16f9t7XRCPYSi1LpR
         JL83BxAjxEKKgdu+YRnvzxB+nQtwI6OqqtK3LV/CkCvy6NWr9bDd7H+5hHIRtnNJmT5U
         ZP5jpejb3+v7NOBfzw0ieC9L3mXMFrF+QFyIExNXFo93CYETgoTYrrhThLECF9rjJFIg
         gRAQ==
X-Gm-Message-State: AN3rC/6OFJZwC8ajf8ySuCjWqz1aH1F2Ig4J7ors+x5JhLsaKtPH0pc4
        gQaeEy7jzuW8DQ==
X-Received: by 10.99.8.67 with SMTP id 64mr29300733pgi.220.1493681361943;
        Mon, 01 May 2017 16:29:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3c5e:d1c1:579c:ef99])
        by smtp.gmail.com with ESMTPSA id c3sm27392325pfg.46.2017.05.01.16.29.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 16:29:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, markbt@efaref.net, git@jeffhostetler.com,
        kevin.david@microsoft.com
Subject: Re: Proposal for missing blob support in Git repos
References: <20170426221346.25337-1-jonathantanmy@google.com>
        <xmqqinllgrfl.fsf@gitster.mtv.corp.google.com>
        <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com>
Date:   Mon, 01 May 2017 16:29:20 -0700
In-Reply-To: <193d1d84-2386-c4c8-81ef-0042f0d8bb02@google.com> (Jonathan Tan's
        message of "Mon, 1 May 2017 12:12:27 -0700")
Message-ID: <xmqq1ss8gnqn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Thanks for your comments. If you're referring to the codepath
> involving write_sha1_file() (for example, builtin/hash-object ->
> index_fd or builtin/unpack-objects), that is fine because
> write_sha1_file() invokes freshen_packed_object() and
> freshen_loose_object() directly to check if the object already exists
> (and thus does not invoke the new mechanism in this patch).

Is that a good thing, though?  It means that you an attacker can
feed one version to the remote object store your "grab blob" hook
gets the blobs from, and have you add a colliding object locally,
and the usual "are we recording the same object as existing one?"
check is bypassed.

