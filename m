Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF043202A0
	for <e@80x24.org>; Mon, 23 Oct 2017 22:51:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751216AbdJWWvK (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 18:51:10 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:46884 "EHLO
        mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdJWWvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 18:51:09 -0400
Received: by mail-io0-f181.google.com with SMTP id 101so21877283ioj.3
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 15:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SK5vuRA821nXBjZ/4RyHIgAarLCZQv6ZNJuNXmvSPnQ=;
        b=Ueih/hM/acOwJ/fKZZY2e99S7l36wTsJzB8rRh94aHicb+my0KbczLPleBDv4bsg+K
         oYv41QyOxEEZvNI/ODSijL7oyCkaxCMNmixNvCEo21gi0nDMIO6T/ZYCMGYEFNyVXTOv
         hwxRPGmMLt9nli5/JENtmomfnRC1QHgDInNiClHcbR3xMbu5n9eXRWloTQyZEa7ZkfH4
         UZELlysyuOA+JpXSpGWmwR46yuIiOgMpw2H99rcdYXb5dqBnJLu/gAzueIAn2+kQjmz5
         XBasXigTp8NUN3F1J3oyukcTzLuAzVI+IsRY8XE4EHQ3bBA9KvVbqQCYo1eYy3ZwAsuB
         aT8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SK5vuRA821nXBjZ/4RyHIgAarLCZQv6ZNJuNXmvSPnQ=;
        b=Ay+82+FFrTXSiRG/JfYP34XVRHq7BO+0cpSJdIu1zPXQAtGbO348PwGE6XDvPrGNdA
         Yt7fP27BCFHtTPHnQdshvH3bl/DsKXYfSIwe3NFFcXoppNrqeQZBBQ3pv9qXABHoZmcI
         6WaW1PvHvDGzyZfmIzCHYjwSYqEIA+bFRtiuf8H0NRdYP88w+Ub0wrwMFGEiLLlSIv+m
         uLYuZyI/KOSjWRC5IHTKqOO0F1CdO5mcGT+6XlnVPkzW155yW7sVK8Tk6V2nvf5M/+xF
         qohTE83CcW1xbute3PqStSMD7/H3NDmr68qeMxUkX2Vmx/AXDLC+8z1ygmuaimiNnHfA
         mOYg==
X-Gm-Message-State: AMCzsaXxmudDyvhSGMeQWo3eqqoEFgCHZiPsYVo6KFl7c1ivwhyu8y8P
        vDB6xpw4GC4dtoZVcmkEKiLQ6upohUM=
X-Google-Smtp-Source: ABhQp+SFDqirOt0mh2+RKRU93KwuZPN5fEt1ztryeCJQVpTVzoD8BDNkMlqD/9ddxkGsos9t84vdYw==
X-Received: by 10.107.29.73 with SMTP id d70mr18589019iod.201.1508799068694;
        Mon, 23 Oct 2017 15:51:08 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:692b:e84b:6615:aa09])
        by smtp.gmail.com with ESMTPSA id a31sm28792itj.7.2017.10.23.15.51.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 23 Oct 2017 15:51:07 -0700 (PDT)
Date:   Mon, 23 Oct 2017 15:51:06 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        peff@peff.net, sbeller@google.com, William Yan <wyan@google.com>
Subject: Re: [PATCH 3/5] ssh: 'auto' variant to select between 'ssh' and
 'simple'
Message-ID: <20171023225106.GA73667@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-11-bmwill@google.com>
 <20171003214206.GY19555@aiede.mtv.corp.google.com>
 <20171016171812.GA4487@google.com>
 <20171023212740.qodxzsq5w7rn2r6y@aiede.mtv.corp.google.com>
 <20171023213159.eitrjrqrh277advm@aiede.mtv.corp.google.com>
 <20171023151929.67165aea67353e5c24a15229@google.com>
 <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171023224310.o7ftwmbr7n74vvc6@aiede.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/23, Jonathan Nieder wrote:
> Hi,
> 
> Jonathan Tan wrote:
> 
> > The new documentation seems to imply that setting ssh.variant (or
> > GIT_SSH_VARIANT) to "auto" is equivalent to not setting it at all, but
> > looking at the code, it doesn't seem to be the case (not setting it at
> > all invokes checking the first word of core.sshCommand, and only uses
> > VARIANT_AUTO if that check is inconclusive, whereas setting
> > ssh.variant=auto skips the core.sshCommand check entirely).
> >
> > Maybe document ssh.variant as follows:
> >
> >     If unset, Git will determine the command-line arguments to use based
> >     on the basename of the configured SSH command (through the
> >     environment variable `GIT_SSH` or `GIT_SSH_COMMAND`, or the config
> >     setting `core.sshCommand`). If the basename is unrecognized, Git
> >     will attempt to detect support of OpenSSH options by first invoking
> >     the configured SSH command with the `-G` (print configuration) flag,
> >     and will subsequently use OpenSSH options (upon success) or no
> >     options besides the host (upon failure).
> >
> >     If set, Git will not do any auto-detection based on the basename of
> >     the configured SSH command. This can be set to `ssh` (OpenSSH
> >     options), `plink`, `putty`, `tortoiseplink`, `simple` (no options
> >     besides the host), or `auto` (the detection with `-G` as described
> >     above). If set to any other value, Git behaves as if this is set to
> >     `ssh`.
> 
> Good point.  Brandon noticed something similar as well.
> 
> Separately from how to document it, what do you think a good behavior
> would be?  Should the "auto" configuration trigger command line based
> detection just like no configuration at all?  Should the "auto" value
> for configuration be removed and that behavior restricted to the
> no-configuration case?
> 
> I'm tempted to go with the former, which would look like the following.
> What do you think?

As a user having some variant as 'auto' doesn't make much sense, i mean
isn't that exactly what the default behavior is?  Check if my ssh
command matches existing variants and go with that.  What you are
proposing is the make the existing auto detection better (yay!) though I
don't know if it warrants adding a new variant all together.

Instead it may be better to stick this new improved detection at the end
of the existing variant discovery function 'determine_ssh_variant()' as
a last ditch effort to figure out the variant.  That way we don't have
an extra variant type that can be configured and eliminates some of the
additional code in the switch statements to handle that enum value
(though that isn't really that big of a deal).

> 
> If this looks good, I can reroll in a moment.
> 
> diff --git i/Documentation/config.txt w/Documentation/config.txt
> index 4a16b324f0..6dffa4aa3d 100644
> --- i/Documentation/config.txt
> +++ w/Documentation/config.txt
> @@ -2081,20 +2081,21 @@ matched against are those given directly to Git commands.  This means any URLs
>  visited as a result of a redirection do not participate in matching.
>  
>  ssh.variant::
> -	Depending on the value of the environment variables `GIT_SSH` or
> -	`GIT_SSH_COMMAND`, or the config setting `core.sshCommand`, Git
> -	auto-detects whether to pass command-line parameters for use
> -	with a simple wrapper script (simple), OpenSSH (ssh), plink, or
> -	tortoiseplink.
> -+
> -The default is `auto`, which means to auto-detect whether the ssh command
> -implements OpenSSH options using the `-G` (print configuration) option.
> -If the ssh command supports OpenSSH options, it then behaves like `ssh`;
> -otherwise, it behaves like `simple`.
> -+
> -The config variable `ssh.variant` can be set to override this auto-detection;
> -valid values are `ssh`, `simple`, `plink`, `putty`, `tortoiseplink`, and
> -`auto`.  Any other value will be treated as normal ssh.  This setting can be
> +	By default, Git determines the command line arguments to use
> +	based on the basename of the configured SSH command (configured
> +	using the environment variable `GIT_SSH` or `GIT_SSH_COMMAND` or
> +	the config setting `core.sshCommand`). If the basename is
> +	unrecognized, Git will attempt to detect support of OpenSSH
> +	options by first invoking the configured SSH command with the
> +	`-G` (print configuration) option and will subsequently use
> +	OpenSSH options (if that is successful) or no options besides
> +	the host and remote command (if it fails).
> ++
> +The config variable `ssh.variant` can be set to override this detection:
> +valid values are `ssh` (to use OpenSSH options), `plink`, `putty`,
> +`tortoiseplink`, `simple` (no options except the host and remote command).
> +The default auto-detection can be explicitly requested using the value
> +`auto`.  Any other value is treated as `ssh`.  This setting can also be
>  overridden via the environment variable `GIT_SSH_VARIANT`.
>  +
>  The current command-line parameters used for each variant are as
> diff --git i/connect.c w/connect.c
> index 98f2d9ce57..06bcd3981e 100644
> --- i/connect.c
> +++ w/connect.c
> @@ -785,12 +785,12 @@ enum ssh_variant {
>  	VARIANT_TORTOISEPLINK,
>  };
>  
> -static int override_ssh_variant(enum ssh_variant *ssh_variant)
> +static void override_ssh_variant(enum ssh_variant *ssh_variant)
>  {
>  	const char *variant = getenv("GIT_SSH_VARIANT");
>  
>  	if (!variant && git_config_get_string_const("ssh.variant", &variant))
> -		return 0;
> +		return;
>  
>  	if (!strcmp(variant, "auto"))
>  		*ssh_variant = VARIANT_AUTO;
> @@ -804,8 +804,6 @@ static int override_ssh_variant(enum ssh_variant *ssh_variant)
>  		*ssh_variant = VARIANT_SIMPLE;
>  	else
>  		*ssh_variant = VARIANT_SSH;
> -
> -	return 1;
>  }
>  
>  static enum ssh_variant determine_ssh_variant(const char *ssh_command,
> @@ -815,7 +813,9 @@ static enum ssh_variant determine_ssh_variant(const char *ssh_command,
>  	const char *variant;
>  	char *p = NULL;
>  
> -	if (override_ssh_variant(&ssh_variant))
> +	override_ssh_variant(&ssh_variant);
> +
> +	if (ssh_variant != VARIANT_AUTO)
>  		return ssh_variant;
>  
>  	if (!is_cmdline) {
> diff --git i/t/t5601-clone.sh w/t/t5601-clone.sh
> index 11fa516997..f9a2ae84c7 100755
> --- i/t/t5601-clone.sh
> +++ w/t/t5601-clone.sh
> @@ -373,6 +373,12 @@ test_expect_success 'variant can be overridden' '
>  	expect_ssh "-4 -P 123" myhost src
>  '
>  
> +test_expect_success 'variant=auto picks based on basename' '
> +	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink" &&
> +	git -c ssh.variant=auto clone -4 "[myhost:123]:src" ssh-auto-clone &&
> +	expect_ssh "-4 -P 123" myhost src
> +'
> +
>  test_expect_success 'simple does not support -4/-6' '
>  	copy_ssh_wrapper_as "$TRASH_DIRECTORY/simple" &&
>  	test_must_fail git clone -4 "myhost:src" ssh-4-clone-simple

-- 
Brandon Williams
