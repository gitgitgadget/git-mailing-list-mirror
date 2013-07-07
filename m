From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-config: update doc for --get with multiple values
Date: Sun, 07 Jul 2013 10:31:38 -0700
Message-ID: <7v38rq5lad.fsf@alter.siamese.dyndns.org>
References: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
	<7vd2qzfpk9.fsf@alter.siamese.dyndns.org>
	<20130707095026.GR9161@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Jul 07 19:31:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvsoL-0002Xc-N0
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 19:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792Ab3GGRbm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 13:31:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52323 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752628Ab3GGRbl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 13:31:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A85FA2AD02;
	Sun,  7 Jul 2013 17:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IDtr8PP6MyS7HKNbq4ovN3h/fV8=; b=Jp2InQ
	utvSIqcOEGDcYbb13SFVbzU7uloGVsgr0JhecXPQBtgPRr9xR/I93s2f4kgmaLj+
	nN8yMFR8WCErUWu2T5AC3cbNs1BcNLABwaOhmhrhhIjFNpztNsP1EVxH7i7Xl9LD
	6+kU6ARh+Cr1GKb0LzUKh4QkP8RbpIkBR/3rA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g4olr3uRaxYe/oIZ2bIj7nQqRuHulGak
	mWAmm7Yy5N3f8TDdHy+EOYeJACNKiWSoFkRDdAgedqDeJA8+uF6MR+AT+d8HvlpU
	fAmFYA/m7UrC0bIUcEUH+QCj7Sttm8HrsClZSbHOTo/hQcUr9gutUU6Vksmn4poP
	StFwqBOG6P0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9CF712AD00;
	Sun,  7 Jul 2013 17:31:40 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0461F2ACFD;
	Sun,  7 Jul 2013 17:31:39 +0000 (UTC)
In-Reply-To: <20130707095026.GR9161@serenity.lan> (John Keeping's message of
	"Sun, 7 Jul 2013 10:50:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 153A0B5E-E72B-11E2-9920-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229781>

John Keeping <john@keeping.me.uk> writes:

>> I wondered if we should explain the significance of "last" a bit
>> more (like "this results in the value from the most specific
>> configuration file to be used, the ones in $GIT_DIR/config
>> overriding what is in $HOME/.gitconfig"), but I do not have a strong
>> opinion either way.  Let's queue this for 'maint' for now.
>
> I don't think that change belongs here.  How about doing something like
> this in the FILES section (the first two hunks are just reordering the
> existing list, only the last hunk changes the content):

Sounds like a good change to me ;-).

> -- >8 --
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index fbad05e..99dc497 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -206,12 +206,8 @@ FILES
>  If not set explicitly with '--file', there are four files where
>  'git config' will search for configuration options:
>  
> -$GIT_DIR/config::
> -	Repository specific configuration file.
> -
> -~/.gitconfig::
> -	User-specific configuration file. Also called "global"
> -	configuration file.
> +$(prefix)/etc/gitconfig::
> +	System-wide configuration file.
>  
>  $XDG_CONFIG_HOME/git/config::
>  	Second user-specific configuration file. If $XDG_CONFIG_HOME is not set
> @@ -221,8 +217,12 @@ $XDG_CONFIG_HOME/git/config::
>  	you sometimes use older versions of Git, as support for this
>  	file was added fairly recently.
>  
> -$(prefix)/etc/gitconfig::
> -	System-wide configuration file.
> +~/.gitconfig::
> +	User-specific configuration file. Also called "global"
> +	configuration file.
> +
> +$GIT_DIR/config::
> +	Repository specific configuration file.
>  
>  If no further options are given, all reading options will read all of these
>  files that are available. If the global or the system-wide configuration
> @@ -230,6 +230,10 @@ file are not available they will be ignored. If the repository configuration
>  file is not available or readable, 'git config' will exit with a non-zero
>  error code. However, in neither case will an error message be issued.
>  
> +The files are read in the order given above, with last value found taking
> +precedence over values read earlier.  When multiple values are taken then all
> +values of a key from all files will be used.
> +
>  All writing options will per default write to the repository specific
>  configuration file. Note that this also affects options like '--replace-all'
>  and '--unset'. *'git config' will only ever change one file at a time*.
