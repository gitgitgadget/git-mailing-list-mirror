Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEDA41F404
	for <e@80x24.org>; Mon,  5 Feb 2018 21:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeBEV6i (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 16:58:38 -0500
Received: from mail-yw0-f178.google.com ([209.85.161.178]:36476 "EHLO
        mail-yw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbeBEV6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 16:58:37 -0500
Received: by mail-yw0-f178.google.com with SMTP id q6so19518138ywg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 13:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C3v+TKByKdVCwMQXbLYoNRJHbHDMb5e9l9X2OVIIA6Y=;
        b=OI/I9MQv7FA+cxi/jFyStj1fsOxeRJvY4fHjFiOt7UnmRHVsr6yDuGECVleuQOVwhM
         Tt9CRrXN/MffOHnhp8Kpl438pMeIVoqiq1HXYjPiBXw3/T9wSI2MA4MFW6kSehzw1vCz
         j5uSt0zlUvsdHs4gpuhi/J5hQFEDXjetISzzYF8/S6MYW6jUf3cabSVtgR5ZqPo+Sn81
         5OgurXmrB6kbOVZx7T0yvjolSQjPkFDQN70RFw57L+bifj2Bd+AiS57A7bdu2mc5nO+n
         1+Vsfa4C6d0vuzouLhVfnWqRfgaxLFwocGui9VcPZht1rUMiANge8qiqanxYtYtIozBi
         ZpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C3v+TKByKdVCwMQXbLYoNRJHbHDMb5e9l9X2OVIIA6Y=;
        b=J8T/Oc6M8eg2Xpm62w/O7xgo3S/zC0zUMQrlstQcdlDhPtVYUQricRcLdgQxRc2lMg
         SozCsMXBGIkQK/msdMUTCdLYSEUht7MpRT2vkYASAJPqf+lQ4bZvI0UgJnC4/o0JQ5oX
         Z9k+KYyMNccIyDzpy2JbHFF9DucPePEHalkuP6xwTR9Wp/jdXK95/fx10KymR9Vn0Njh
         Kbfh5NOI/h0pppqOh6YLVaVNgMU1loDDoaNxZdjLSf67F+NEXpcBF5lKbN+iRcM5R60b
         iJCnAcTN3HYi0cgYqSdL0cvkjgWok6mygKAViK8CU2cYtxRVnGl2JWIaU/3Ut5IDY77P
         Adeg==
X-Gm-Message-State: APf1xPAGdAq0yQl6JBBlIsV+D/U6HppJeRrasaAA1/T95xrIXN3iYyw+
        Eh6E12n2u+WoOy1MNhNZOqG7l5FbU9N5LQd3F9fQxg==
X-Google-Smtp-Source: AH8x225Bi7aKmozaX6jWZ1NZC0ib26QtRQsiBTDHg2XI2SsMs27leMCJVBefOUK4+6EG7c2AGNRndeMpHGvFk1DiubI=
X-Received: by 10.129.86.139 with SMTP id k133mr147037ywb.253.1517867916513;
 Mon, 05 Feb 2018 13:58:36 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 13:58:36 -0800 (PST)
In-Reply-To: <20180130232533.25846-32-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-32-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 13:58:36 -0800
Message-ID: <CAGZ79kaZNF=Tr5jaOBqkoFhsMC9fzM3pGS1+1GEY3542xtY8=w@mail.gmail.com>
Subject: Re: [PATCH v7 31/31] merge-recursive: ensure we write updates for
 directory-renamed file
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> When a file is present in HEAD before the merge and the other side of the
> merge does not modify that file, we try to avoid re-writing the file and
> making it stat-dirty.  However, when a file is present in HEAD before the
> merge and was in a directory that was renamed by the other side of the
> merge, we have to move the file to a new location and re-write it.
> Update the code that checks whether we can skip the update to also work in
> the presence of directory renames.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Now I did not just review the tests, but also the code of this series.
(though I think I was more detail oriented on Friday)
All patches that had no comments are fine with me,
I left some comments on others.

Thanks,
Stefan
