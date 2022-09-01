Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0014CECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 12:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiIAMcs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 08:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbiIAMcq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 08:32:46 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E07D1EC62
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 05:32:45 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b16so22359181edd.4
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date;
        bh=BrLjNj8SA9Fvc+Zv6kWc3AC0jzbAfOf1bm9v7A8IA1k=;
        b=QDPHddbrPAwdURjKpm5LwLbWLaLGjr4oLs8JFEM6xNrgDDLv/MS76w+4WXVgB4tUrF
         cdcJdJqwxoYXHv9bAvmfkVqygjpqxv1t/0TvkqoLfMNvLnCUp6XvDAi+bDILmy+XmAdj
         7+aYe32EyQbGylodXJsHXnayW6o+nZfDYxjUseaCeFl5+t8f8hcXVjnvG41zfEfSHV5h
         Ar2h6x9WvORaYuSuJwyUN6G2EaI7R7enP21gPd36ChJF9lcx0ZE27TeATYG8Xxw+1XAG
         ru5W3BVwtb3M45M4kdiIcJzBOtjcZqIpKe2vIhf+JLI7YlQoDvsv6FvDYmwWNkkNMQVv
         N0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=BrLjNj8SA9Fvc+Zv6kWc3AC0jzbAfOf1bm9v7A8IA1k=;
        b=wN3C+5fvUfGtaPgW3S2TUkzxgN1TYpKJuGb/NzYvvihYcrNIjUWUgcKfdqY1aqIeL/
         gahmGNjJ51CHf4A9SVnmjiq32hUi6oLsLeEhOATyODGTcSPkwShLZS2FLgND6E5TCgOi
         5pWuCQyiaxKfjsl0ZKUBfLGIxNphUvh8CNze6Ca5oysdZ9/+rphD4rFkSVgDGj/s1brM
         Ap88Ycvmymc5duKWtHNe+CSNGf4Z9BPIWKLXbrAOc34+I+DxR0Zb3b9RM+TL6SucJS7p
         cR2C/fPQIbWomHOnRGseFSJcdP5Px+1TmS7HaqBzfUSx0FtO5lvxzcN4RdF0TXXyssbt
         a1ew==
X-Gm-Message-State: ACgBeo2zdFHEuVVBc6A+vOoOU1j3+NkdD4wBSVGbs6FKR+IWtEi2K8UF
        nC+2VsucLjom/A/8TxHnAfHUsqSYanlbYw==
X-Google-Smtp-Source: AA6agR7t1SAzpBTBEshlf6zxwpB5CIDCX9gLt8PeWzGYNNaqkdr8i5M+Mg3R/Z5F8yBTaaGRAV3UDw==
X-Received: by 2002:a05:6402:40c3:b0:442:d798:48ad with SMTP id z3-20020a05640240c300b00442d79848admr28404546edb.154.1662035562705;
        Thu, 01 Sep 2022 05:32:42 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id bt21-20020a170906b15500b0073dbc35a0desm8430783ejb.100.2022.09.01.05.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 05:32:42 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oTjNB-0009gF-0m;
        Thu, 01 Sep 2022 14:32:41 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 01/18] t: add skeleton chainlint.pl
Date:   Thu, 01 Sep 2022 14:27:47 +0200
References: <pull.1322.git.git.1661992197.gitgitgadget@gmail.com>
 <3423df94bd6035640828a2508968cf8e1f5b4dda.1661992197.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3423df94bd6035640828a2508968cf8e1f5b4dda.1661992197.git.gitgitgadget@gmail.com>
Message-ID: <220901.86k06njmvq.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 01 2022, Eric Sunshine via GitGitGadget wrote:

> From: Eric Sunshine <sunshine@sunshineco.com>
> [...]
> diff --git a/t/chainlint.pl b/t/chainlint.pl

I really like this overall direction...

> +use warnings;
> +use strict;

I think that in general we're way overdue for at least a :

	use v5.10.1;

Or even something more aggresive, I think we can definitely depend on a
newer version for this bit of dev tooling.

That makes a lot of things in this series more pleasing to look
at. E.g. you could use named $+{} variables for regexes.

> +package ScriptParser;

I really wish this could be changed to just put this in
t/chainlint/ScriptParser.pm early on, we could set @INC appropriately
and "use" these, which...

> +my $getnow = sub { return time(); };
> +my $interval = sub { return time() - shift; };

Would eliminate any scoping concerns about this sort of thing.

> +if (eval {require Time::HiRes; Time::HiRes->import(); 1;}) {
> +	$getnow = sub { return [Time::HiRes::gettimeofday()]; };
> +	$interval = sub { return Time::HiRes::tv_interval(shift); };
> +}

Is this "require" even needed, Time::HiRes is there since 5.7.* says
"corelist -l Time::HIRes".

> [...]
> +sub check_script {
> +	my ($id, $next_script, $emit) = @_;
> +	my ($nscripts, $ntests, $nerrs) = (0, 0, 0);
> +	while (my $path = $next_script->()) {
> +		$nscripts++;
> +		my $fh;
> +		unless (open($fh, "<", $path)) {
> +			$emit->("?!ERR?! $path: $!\n");

If we can depend on v5.10.1 this can surely become:

	use autodie qw(open close);

No?

> +			$nerrs += () = $s =~ /\?![^?]+\?!/g;

y'know if we add some whitespace there we can conform to
https://metacpan.org/dist/perlsecret/view/lib/perlsecret.pod >:) (not
serious...)
