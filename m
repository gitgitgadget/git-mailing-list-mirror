Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20521C433EF
	for <git@archiver.kernel.org>; Tue, 26 Apr 2022 06:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343502AbiDZGvW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Apr 2022 02:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240515AbiDZGvT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Apr 2022 02:51:19 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295022AC6F
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 23:48:12 -0700 (PDT)
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none
X-Ironport-Dmarc-Check-Result: validskip
X-IronPort-AV: E=Sophos;i="5.90,290,1643670000"; 
   d="scan'208";a="33283269"
Received: from 209.56.68.91.rev.sfr.net (HELO [192.168.1.28]) ([91.68.56.209])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 08:48:10 +0200
Message-ID: <26b353a6-3c31-8f35-a282-877788c00bbf@univ-lyon1.fr>
Date:   Tue, 26 Apr 2022 08:48:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/2] t7615: test how merge behave when there is
 untracked file
Content-Language: en-US
To:     Jonathan <git.jonathan.bressat@gmail.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Cc:     BRESSAT JONATHAN p1802864 <jonathan.bressat@etu.univ-lyon1.fr>,
        "cogoni.guillaume@gmail.com" <cogoni.guillaume@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "guillaume.cogoni@gmail.com" <guillaume.cogoni@gmail.com>
References: <xmqqfsmg97ac.fsf@gitster.g>
 <20220425202721.20066-1-git.jonathan.bressat@gmail.com>
 <eca66375d8b34154856b7da303bf96d7@SAMBXP02.univ-lyon1.fr>
From:   Matthieu Moy <Matthieu.Moy@univ-lyon1.fr>
In-Reply-To: <eca66375d8b34154856b7da303bf96d7@SAMBXP02.univ-lyon1.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/25/22 22:27, Jonathan wrote:
> when there is untracked file that has the same name than file in the
> merged branch git refuse to proceed, even when the file has the same
> content
> 
> t6436 test a similar thing but not especially with same content file

Write your commit message like normal english: capitalize start of 
sentence, and period at the end (we omit the period in the subject line, 
though).

> +test_expect_success 'fastforward fail when untracked file has the same content' '

Here and other test names: third person => s (fail_s_, and overwrite_s_ 
in the next patch).

> +	test_when_finished "git branch -D B && git reset --hard init && git clean --force" &&
> +	git checkout -b B &&
> +	test_commit --no-tag "tracked" file "content" &&
> +	git checkout A &&
> +	echo content >file &&
> +	test_must_fail git merge B

It would make sense to grep for the correct error message in the output, 
but maybe that's overkill.

-- 
Matthieu Moy
https://matthieu-moy.fr/
