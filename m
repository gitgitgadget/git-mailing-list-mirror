Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5422A2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 17:16:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751035AbdCARQC (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 12:16:02 -0500
Received: from mail-qk0-f181.google.com ([209.85.220.181]:32894 "EHLO
        mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751073AbdCARQA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 12:16:00 -0500
Received: by mail-qk0-f181.google.com with SMTP id n127so80714396qkf.0
        for <git@vger.kernel.org>; Wed, 01 Mar 2017 09:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=I9BKRe/zK0Wcwfgp+bp8WtFAjr/MLg4KOzgAAeq1MjY=;
        b=iQI5AwolrLQzxFsT2u+BRyUZAvgtF8vLd/ccoy1KOe+ZtkPTj434iLhqF1LYUIUTDP
         5KD7IowjlBEDOmzkUqCggT8M/99lwlENgm77tkZ0oM60zAQQfksWO3Vt+9x5XarKosjg
         ecDGJZ501XvHbx6IPJvhf4zNLcuRAsZkc3KBPwZn7my0ZIftf+IPi4kVxyfjL4PW5B08
         jx+teKwUPJDLWO1Agj843J3ZRMle1S7OcUx++BfXiZg5jWKDOVAPTo/mBU6a4htGbJeM
         gmPO8+IizEDTb5SgK1feWBC+GyZKlzQOAeZ5hn3xxvdlIKQXRYPO0R2qeDeQcRKlePJQ
         a5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=I9BKRe/zK0Wcwfgp+bp8WtFAjr/MLg4KOzgAAeq1MjY=;
        b=QNLSYudCTdTqjfHXLVI8yav9oIhZ0VzFcsm6X6z78Mo807w5OWIAJSQhseNgP227Oa
         4uIAiZcyWTG8Hxg1dEj6ufsaiz3Mg/DeVy2vANOWRHCkLz6KM+vWmP2T2c4sjLd+srHn
         N3xkpLagzZHFd4OL1neKBsMxc9QHJSKWrAVPqCHDJn740FS7qkpCOYZ8X3vJ8Q6B4ksc
         60/kaCE+jLRz9lV9+kyN4uFEb6Y08qQ8PsbEa8PjGYO6FrToVh7C7NcwwGyP8OkMZK2b
         VYkp4jMV9Nh1lEwFCQeCorc+vej2mRi86GF3MPrj+bMLXbt/L2Ex0ivii1Lc6cYTQmtD
         08DA==
X-Gm-Message-State: AMke39md40o21zCyQXc5tKslY622o1abcMxDQdupGGUwd/Wjsb3VzlmWjnKDgWZtY3N/Vm0tpelqh81RPbGdNg==
X-Received: by 10.55.31.170 with SMTP id n42mr11117452qkh.181.1488384420853;
 Wed, 01 Mar 2017 08:07:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.178.20 with HTTP; Wed, 1 Mar 2017 08:06:40 -0800 (PST)
In-Reply-To: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
References: <4d2a1852-8c84-2869-78ad-3c863f6dcaf7@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
Date:   Wed, 1 Mar 2017 08:06:40 -0800
X-Google-Sender-Auth: 6vy58tmVqL2vO_DJdgi9kC-gavU
Message-ID: <CAPc5daWXafzN0dpyd+kdHcLU_YSmZpiNz_i2rXn_2hbMN-9Xww@mail.gmail.com>
Subject: Re: Delta compression not so effective
To:     Marius Storm-Olsen <mstormo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 1, 2017 at 5:51 AM, Marius Storm-Olsen <mstormo@gmail.com> wrote:
> ... which brought it down to 206GB in a single pack. I then ran
>     git repack -a -d -F --window=350 --depth=250
> which took it down to 203GB, where I'm at right now.

Just a hunch. s/F/f/ perhaps?  "-F" does not allow Git to recover from poor
delta-base choice the original importer may have made (and if the
original importer
used fast-import, it is known that its choice of the delta-base is suboptimal).
