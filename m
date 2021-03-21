Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02909C433C1
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 07:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60896192D
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 07:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhCUGoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Mar 2021 02:44:07 -0400
Received: from mx.99rst.org ([52.22.122.190]:37756 "EHLO mx.99rst.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhCUGns (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Mar 2021 02:43:48 -0400
Received: from mail.kodaksys.org (localhost [127.0.0.1])
        by mx.99rst.org (Postfix) with ESMTP id D292D42093;
        Sun, 21 Mar 2021 06:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=99rst.org;
        s=20161001; t=1616309027;
        bh=A5ZZr/dnEkN+qsaBIK4Gnwl0et2LjrEAUqnLcsen8RQ=;
        h=In-Reply-To:References:Date:Subject:From:To:Cc:From;
        b=LvMzGFXj+dsTPLS8ljoMpnMgtN/GKbm4t0FPdCrDrSYmeZmb6lusiExSzvtziwdhA
         b97u17Eiq+toSrMQETgDtyck2RJboHj1SjLBaS6pZ1h/2yaIndEEeZcB9gYA7Gp4nR
         A2Y8hOg2FL196ohFcUb626u6S8tjM5HUotY2uV6HCd5nlk/7CnW+1UmvAJAEoECeWW
         NeG98JngUzrgFpd+jP/TybVGthrVE2NQNRPElqvIXkTKWUiFw3qaL2WUuM2NffO4Wu
         BHgEbrIN8cUD9w19yIfCLPHVWWxX2J5DpH7Us/GSK+S8y4zWGyfkVyq4FeJsrmSrO4
         43TEkiPaMk1zQ==
Received: by mail.kodaksys.org with HTTP;
        Sun, 21 Mar 2021 06:43:47 -0000
Message-ID: <20b1b63fe22560205d7e7c50b9f826e5.squirrel@mail.kodaksys.org>
In-Reply-To: <xmqqft0pcagu.fsf@gitster.g>
References: <pull.910.git.1616283780358.gitgitgadget@gmail.com>
    <xmqqft0pcagu.fsf@gitster.g>
Date:   Sun, 21 Mar 2021 06:43:47 -0000
Subject: Re: [PATCH] gitweb: redacted e-mail addresses feature.
From:   "Georgios Kontaxis" <geko1702+commits@99rst.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
User-Agent: SquirrelMail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> "Georgios Kontaxis via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
>> +    # To disable system wide have in $GITWEB_CONFIG
>> +    # $feature{'email_privacy'}{'default'} = [0];
>> +	'email_privacy' => {
>> +		'sub' => sub { feature_bool('email_privacy', @_) },
>> +		'override' => 0,
>> +		'default' => [1]},
>>  );
>
> I do not see why this should default to true.
>
I've changed the default to "false". V2 should reflect the change.

> It would break existing installations, who have been perfectly happy
> with the convenience of supplying a ready access to potential new
> contributors who/which addresses to contact plausible mentors in the
> projects they are interested in.
>
> And more importantly, I do not see why it should be made impossible
> to override per repository/project in a multi-tenant installation.
> Some projects may be more "privacy" sensitive than others.  Those
> who want to use tighter setting should be able to enable it even
> when the side-wide default is set to false, no?
>
> Thanks.
>
I was actually thinking about the other way around;
preventing projects from disabling this feature.

Sounds like the "override" flag is for other types
of use cases though. I'll change it to "true".

Thanks for the feedback.

