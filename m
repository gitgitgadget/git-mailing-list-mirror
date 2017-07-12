Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0822B202DD
	for <e@80x24.org>; Wed, 12 Jul 2017 18:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdGLSRU (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Jul 2017 14:17:20 -0400
Received: from mail-pf0-f182.google.com ([209.85.192.182]:35322 "EHLO
        mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdGLSRT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2017 14:17:19 -0400
Received: by mail-pf0-f182.google.com with SMTP id c73so16765626pfk.2
        for <git@vger.kernel.org>; Wed, 12 Jul 2017 11:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=drLiBpHzyDQeVssHCtVpZ4rdxI7Yw4+wx6zZJUn4Uqg=;
        b=ArOu4kwBH+TsCkrNTE4PawRvZgr59aEnCcaXu8RAv0ciWFuuQduvmXSwXHjhpe7okM
         yW9YS8VFutqgMhau28hr5v5h1Qwwc+lMkbaM43FEQ+caMSdhjugbrw5yukJVKyUl0wJo
         V+eibOG3trmwpYXjly3LHjW2CYKDrb7sCW+3G15Ha8CowlTxdZ4utG0QMxWiYr3TmTOQ
         8rsGRyQ7UgPMIpPqUWcPgirn0Yvh6ND9eyILLmsrRWF07iMW+ZobgIMpoWosFB6EUQ6z
         LoJ31KcsyxpM6xzuHqgLoTkCMLoNCdqccuGtcrVoEcAx7Chef9RmO9jY5EfWbpNspZRi
         LUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=drLiBpHzyDQeVssHCtVpZ4rdxI7Yw4+wx6zZJUn4Uqg=;
        b=V9c7VzX/P/ig+4QrKEZxxMDeakwDn3eHhw9rtIcIjD/tO5dpkiMAy+Td9VWSEmXXYo
         aHjou384odCcg03Swr9mUdS7ZlBYJGcQehcZIH/vABXuc6gpzLaHH05BZdFUNitFlg5a
         Em7Hsxi0GNM+L9NeA/anSurA0fMcSb4OYXgiH4iE1zWzWyKHek7j4VYF0hIRNKxZPDvj
         6b0ln8EbFgP2V7g8u+3Do1En1dRp6thPtRpEJJXxnWiB8yYwqZSMieSJ16YWrDglMnIk
         mTZ1nN6Kv/OaKNKk4sjifn0R7uMltr9I4kWIp+YIwNVzfykzn1OP7URWjwvEO2QhzkDJ
         j6Ng==
X-Gm-Message-State: AIVw113b5oDDH3hAVVMo9xTlVmBsto4s1r7RGORj/wMFueuM8tsP6qGP
        wTFs+LudJoULQy/myPYvNViS03k9/Yq8
X-Received: by 10.84.232.74 with SMTP id f10mr5461644pln.154.1499883438321;
 Wed, 12 Jul 2017 11:17:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.167.81 with HTTP; Wed, 12 Jul 2017 11:17:17 -0700 (PDT)
In-Reply-To: <20170712180923.GE93855@aiede.mtv.corp.google.com>
References: <20170711220408.173269-1-bmwill@google.com> <20170712074220.565z3gahruqb2e7q@sigill.intra.peff.net>
 <20170712180923.GE93855@aiede.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 12 Jul 2017 11:17:17 -0700
Message-ID: <CAGZ79kbFpvzRHTK6KvWE399devPec+XSq_7V+roANbxbc29_-w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Convert grep to recurse in-process
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 12, 2017 at 11:09 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Hi,
>
> Jeff King wrote:
>
>> I didn't follow the rest of the "struct repository" series closely, but
>> I don't feel like we ever reached a resolution on how config would be
>> handled. I notice that the in-process "ls-files" behaves differently
>> than the old one when config differs between the submodule and the
>> parent repository. As we convert more commands (that use more config)
>> this will become more likely to be noticed by somebody.
>>
>> Do we have a plan for dealing with this? Is our solution just "recursed
>> operations always respect the parent config, deal with it"?
>
> For settings like branch.<name>.remote, I don't think anyone would
> disagree that the right thing to do is to use the per-repository
> config of the submodule.  The repository object is already able to
> handle per-repository config, so this just involves callers being
> careful not to cache values locally in a way that conflates
> repositories.  It should be pretty straightforward (for commands like
> "git fetch --recurse-submodules", for example).
>
> For settings like grep.patternType, on the other hand, it would be
> very strange for the behavior to change when grep crosses the
> submodule boundary.

That is because this option relates to the input given.
Other options relate to the items to be processed, such as grep.color.*
which I would not find strange if they were respected in the submodule.

> So I think using the parent project config is the
> right thing to do and the old behavior was simply wrong.  In other
> words, I don't think this is so much a case of "deal with it" as
> "sorry we got the behavior so wrong before --- we've finally fixed it
> now".

In an ideal world we should pay partial attention to the config
in the submodule, and for each config key we'd have to determine
if it rather relates to the general runtime (grep.threads), the command
line options (grep.patternType) or to the specific content inside the repo
(coloring, whether we show the line number).

For now and in reality we can ignore the content specific settings
and claim that any setting here is related to runtime and command line
options, both of which a user may expect the superproject to win in
case of differing configurations.

Thanks,
Stefan
