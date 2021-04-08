Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 097FAC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0290610C7
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:43:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbhDHWne (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWnd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:43:33 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA899C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 15:43:21 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id f8so4272847edd.11
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=JbCoHMLURFHApYYaQH4ozri55o9QACmKCkiExYarJCk=;
        b=k254Q7vdQKkRP2W7eTKqU+JvidTjuRO4sCX3rCd2jFD54wRjbZf6pRp77syR9m+NUT
         nez2WbDv/BSqhRNHME2SMg+XuR9QcTv5wOV200bHhn90gyxPEsYrO0Oc0eAs24G1HRiH
         a1odrQIvTFVX0aJSCjewcFfjp66MKsSjzt7GSrfFWF2e4O4XakBQOZq+BSJN1ZBLlVca
         HNPEaanqYEf9WYGUWcBojFsiWB17s9q/FkoxKUd4ii026A2siTbNZ6kyprY8W0ei2qMj
         lAVmc2i1QnG34B0A7La3ks2+r+DTFP1YqUa27DBgFgYAguVv8927D8LK/L3QotbZhIXA
         s6vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=JbCoHMLURFHApYYaQH4ozri55o9QACmKCkiExYarJCk=;
        b=mLwAgs/xs8gDPEB0a2AqRE/xkWXQdkr2cUNukAB2rfGFHc9iFYm95/nvHXmvCnLM2X
         z6tzCQwLoWUzX/s3gPPNfQ4WbXqTu82zPSHIvdZsBCUXg/JZmI1VPklGZo/SOnvPyuuU
         6Otp86k81+zbM6qfdjv3AN3S2ai2HfvsV6JWPwf8RM1OHzslUDneQYMnAPhiJyod/IsB
         fT6euhHUlInkFQKQYx8HRZdeQHZfOmXrKr+9C3D6NEkOFxp5tjG0INvGOn+v5vUvZJPF
         p3vgmIicXeRNgzKvJwgI2vI3aWek2KOmmMc96p8aOG3kKqsGYf9teJ+WWQJ/BYWnMB5E
         49sw==
X-Gm-Message-State: AOAM533dsKcvbYh8V246WkJD8PbZeuC/HZzwQ+7SGehEN3nDyKGd2g4U
        fYqpe1+NdG+fJVZd5cQQfR0+wQ7OloVnYQ==
X-Google-Smtp-Source: ABdhPJwYPBZJ6uCsUCezUpZXWwwgW+PSJgibv9o60ObekIeEm+gUay984bukLWkaDkBx6ip8ioflOw==
X-Received: by 2002:aa7:d5c9:: with SMTP id d9mr14331120eds.335.1617921800566;
        Thu, 08 Apr 2021 15:43:20 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l2sm287237ejz.93.2021.04.08.15.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 15:43:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v6] gitweb: redacted e-mail addresses feature.
References: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
 <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
Date:   Fri, 09 Apr 2021 00:43:19 +0200
Message-ID: <87eefkieig.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 29 2021, Georgios Kontaxis via GitGitGadget wrote:

> [...]
> +email-privacy::
> +	Redact e-mail addresses from the generated HTML, etc. content.
> +	This obscures e-mail addresses retrieved from the author/committer
> +	and comment sections of the Git log.
> +	It is meant to hinder web crawlers that harvest and abuse addresses.
> +	Such crawlers may not respect robots.txt.
> +	Note that users and user tools also see the addresses as redacted.
> +	If Gitweb is not the final step in a workflow then subsequent steps
> +	may misbehave because of the redacted information they receive.
> +	Disabled by default.
> +
>  highlight::
>  	Server-side syntax highlight support in "blob" view.  It requires
>  	`$highlight_bin` program to be available (see the description of
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 0959a782eccb..01c6faf88006 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -569,6 +569,15 @@ sub evaluate_uri {
>  		'sub' => \&feature_extra_branch_refs,
>  		'override' => 0,
>  		'default' => []},
> +
> +	# Redact e-mail addresses.
> +
> +	# To enable system wide have in $GITWEB_CONFIG
> +	# $feature{'email-privacy'}{'default'} = [1];
> +	'email-privacy' => {
> +		'sub' => sub { feature_bool('email-privacy', @_) },
> +		'override' => 1,
> +		'default' => [0]},
>  );
>  
>  sub gitweb_get_feature {
> @@ -3449,6 +3458,13 @@ sub parse_date {
>  	return %date;
>  }
>  
> +sub hide_mailaddrs_if_private {
> +	my $line = shift;
> +	return $line unless gitweb_check_feature('email-privacy');
> +	$line =~ s/<[^@>]+@[^>]+>/<redacted>/ig;

The /i here is redundant, since you have nothing that'll case-fold on
the LHS of the s///, doesn't harm anything either. Just a small note
since it's new in v6...

> +	return $line;
> +}
> +
>  sub parse_tag {
>  	my $tag_id = shift;
>  	my %tag;
> @@ -3465,7 +3481,7 @@ sub parse_tag {
>  		} elsif ($line =~ m/^tag (.+)$/) {
>  			$tag{'name'} = $1;
>  		} elsif ($line =~ m/^tagger (.*) ([0-9]+) (.*)$/) {
> -			$tag{'author'} = $1;
> +			$tag{'author'} = hide_mailaddrs_if_private($1);
>  			$tag{'author_epoch'} = $2;
>  			$tag{'author_tz'} = $3;
>  			if ($tag{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> @@ -3513,7 +3529,7 @@ sub parse_commit_text {
>  		} elsif ((!defined $withparents) && ($line =~ m/^parent ($oid_regex)$/)) {
>  			push @parents, $1;
>  		} elsif ($line =~ m/^author (.*) ([0-9]+) (.*)$/) {
> -			$co{'author'} = to_utf8($1);
> +			$co{'author'} = hide_mailaddrs_if_private(to_utf8($1));
>  			$co{'author_epoch'} = $2;
>  			$co{'author_tz'} = $3;
>  			if ($co{'author'} =~ m/^([^<]+) <([^>]*)>/) {
> @@ -3523,7 +3539,7 @@ sub parse_commit_text {
>  				$co{'author_name'} = $co{'author'};
>  			}
>  		} elsif ($line =~ m/^committer (.*) ([0-9]+) (.*)$/) {
> -			$co{'committer'} = to_utf8($1);
> +			$co{'committer'} = hide_mailaddrs_if_private(to_utf8($1));
>  			$co{'committer_epoch'} = $2;
>  			$co{'committer_tz'} = $3;
>  			if ($co{'committer'} =~ m/^([^<]+) <([^>]*)>/) {
> @@ -3568,9 +3584,10 @@ sub parse_commit_text {
>  	if (! defined $co{'title'} || $co{'title'} eq "") {
>  		$co{'title'} = $co{'title_short'} = '(no commit message)';
>  	}
> -	# remove added spaces
> +	# remove added spaces, redact e-mail addresses if applicable.
>  	foreach my $line (@commit_lines) {
>  		$line =~ s/^    //;
> +		$line = hide_mailaddrs_if_private($line);
>  	}
>  	$co{'comment'} = \@commit_lines;
>  
> @@ -7489,7 +7506,8 @@ sub git_log_generic {
>  			         -accesskey => "n", -title => "Alt-n"}, "next");
>  	}
>  	my $patch_max = gitweb_get_feature('patches');
> -	if ($patch_max && !defined $file_name) {
> +	if ($patch_max && !defined $file_name &&
> +		!gitweb_check_feature('email-privacy')) {
>  		if ($patch_max < 0 || @commitlist <= $patch_max) {
>  			$paging_nav .= " &sdot; " .
>  				$cgi->a({-href => href(action=>"patches", -replay=>1)},
> @@ -7550,7 +7568,8 @@ sub git_commit {
>  			} @$parents ) .
>  			')';
>  	}
> -	if (gitweb_check_feature('patches') && @$parents <= 1) {
> +	if (gitweb_check_feature('patches') && @$parents <= 1 &&
> +		!gitweb_check_feature('email-privacy')) {
>  		$formats_nav .= " | " .
>  			$cgi->a({-href => href(action=>"patch", -replay=>1)},
>  				"patch");
> @@ -7863,7 +7882,8 @@ sub git_commitdiff {
>  		$formats_nav =
>  			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
>  			        "raw");
> -		if ($patch_max && @{$co{'parents'}} <= 1) {
> +		if ($patch_max && @{$co{'parents'}} <= 1 &&
> +			!gitweb_check_feature('email-privacy')) {
>  			$formats_nav .= " | " .
>  				$cgi->a({-href => href(action=>"patch", -replay=>1)},
>  					"patch");

I didn't run this, and hadn't kept up for a few rounds. I'm happy to see
the pos/while etc. looping gone, this LGTM.
