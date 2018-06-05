Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EB61F403
	for <e@80x24.org>; Tue,  5 Jun 2018 19:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeFETox (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 15:44:53 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:45699 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeFETow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 15:44:52 -0400
Received: by mail-yw0-f181.google.com with SMTP id v190-v6so1124711ywa.12
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 12:44:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zaKXkNwIQtjQ8qq7gcbBCXYL7CKHPu6hOu165/5FEPU=;
        b=NFbtubOC68wCDlvqO2PzuYd+C9HKs4mZ5drn517ce1Me0gk+dj6612e9AtdbRfGV3U
         o+U3yIwyXpaQH97fnnlqmW98Kg9Epl0WXiJasbotzY+yCQ68d67K4DOcotBHMD6KgGtr
         WaTXOnbj+lSVQBXY4SFrMwBYTbz3P7LugXLJIwx+Lb0O7Td0CjdekQbHZXZmF4uh8dV0
         pyMIKZr7QsgS/L9/I6SGZTTSKFXYrOx+woWAbDGmpTYwVZLwz7PU2amOHitnvDYYjnd1
         OnCFqNFPdnmb17Wq+mL7ytyYfDhwEyTQNf1GszqPtBiSFJoH9znDaUE3CABHK++vRq2z
         0LpQ==
X-Gm-Message-State: APt69E1rXLe5/aQA+o+HMcJeOUiG+9QfdUdX6k005BiKk1S+vIvRJYBN
        WksPuddTIKDR3exL+swKSSmWqFFC4eBpi2YBChs=
X-Google-Smtp-Source: ADUXVKJQHhxF/IJsszwtGgj9cTu303NtS/6FPCTV+yjsWseFfD90qClZt5K5CmcHQnbiknAbQUDsUuNZDtfO3P/rvbk=
X-Received: by 2002:a81:3c0d:: with SMTP id j13-v6mr15566ywa.16.1528227892038;
 Tue, 05 Jun 2018 12:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180605085524.10838-1-luke@diamand.org> <20180605085524.10838-2-luke@diamand.org>
 <777690205.383623.1528195798488@mail.yahoo.com> <CAE5ih7_01ZixwnFP2kGN9Y5M26MyNai82USUr2UfunL3Ubztdg@mail.gmail.com>
In-Reply-To: <CAE5ih7_01ZixwnFP2kGN9Y5M26MyNai82USUr2UfunL3Ubztdg@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 5 Jun 2018 15:44:40 -0400
Message-ID: <CAPig+cSP5RJedaoO1T=j4qmbAGmrNh_bJkamKcJRS+kF5wq0JQ@mail.gmail.com>
Subject: Re: [PATCHv1 1/1] git-p4: better error reporting when p4 fails
To:     Luke Diamand <luke@diamand.org>
Cc:     merlorom@yahoo.fr, Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        vin ku <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 5, 2018 at 6:59 AM Luke Diamand <luke@diamand.org> wrote:
> On 5 June 2018 at 11:49, Merland Romain <merlorom@yahoo.fr> wrote:
> >> +    # now check that we can actually talk to the server
> >> +    global p4_access_checked
> >> +    if not p4_access_checked:
> >> +        p4_access_checked = True
> >> +        p4_check_access()
> >> +
> >
> > Just switch the 2 lines 'p4_access_checked = True' and 'p4_check_access()'
> > It seems to me more logical
>
> Like this:
>
> +        p4_check_access()
> +        p4_access_checked = True
>
> You need to set p4_access_checked first so that it doesn't go and try
> to check the p4 access before running "p4 login -s", which would then
> get stuck forever.

Such subtlety may deserve an in-code comment.
