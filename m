From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/6] fast-import: add option command
Date: Wed, 02 Sep 2009 19:41:08 -0700
Message-ID: <7vskf4px6j.fsf@alter.siamese.dyndns.org>
References: <1251914223-31435-1-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-2-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-3-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-4-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-5-git-send-email-srabbelier@gmail.com>
 <1251914223-31435-6-git-send-email-srabbelier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git List <git@vger.kernel.org>,
	Ian Clatworthy <ian.clatworthy@canonical.com>,
	Matt McClure <mlm@aya.yale.edu>,
	Miklos Vajna <vmiklos@frugalware.org>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	<vcs-fast-import-devs@lists.launchpad.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 04:41:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mj2Gb-0002MT-1p
	for gcvg-git-2@lo.gmane.org; Thu, 03 Sep 2009 04:41:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbZICCl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2009 22:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754063AbZICCl3
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Sep 2009 22:41:29 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:53730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985AbZICCl2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2009 22:41:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DC772233FB;
	Wed,  2 Sep 2009 22:41:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C+sy/k+/4oAynXShSrtav1xSYgc=; b=t0t6CO
	XcNmgAYUgiPi8AhyYgUkggotuyghdV6TDB0nA9Hs1n2U6Qja2VwDGQ/a6osMAngZ
	fUKzA394Utoto2yM1gU4zJnrsLGMLEcrt82v81dsQ9Whx4+pGnnxGJXFGvXaeB9b
	KsI7nfQP2hE1GE9KDWr20UXwmdC+boJjW/fis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uzcNUbQXv6gHBCBUCWY+p4INKBg6kLqC
	Is87FjFlFRR8LTt1CWUxUzYukgKbOYMWX4CFpNbMCWj6cn9zxieqF5uCioCZkymy
	DML4xsDU2m+kTP+KHD16poc3W1kHauZX2I7HS/bBa4yRUV4Mo6UJ5aIVNF+ghs6K
	WOBC9tntX8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5649A233F7;
	Wed,  2 Sep 2009 22:41:20 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1808233F3; Wed,  2 Sep
 2009 22:41:09 -0400 (EDT)
In-Reply-To: <1251914223-31435-6-git-send-email-srabbelier@gmail.com> (Sverre
 Rabbelier's message of "Wed\,  2 Sep 2009 19\:57\:02 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 430A7546-9833-11DE-BEDB-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127638>

Sverre Rabbelier <srabbelier@gmail.com> writes:

>   Main difference with v5 is that the syntax is now 'option git ...'
>   as per a discussion with the other fast-import devs. Other options,
>   e.g. 'option hg' are ignored. Also fixed the docs to say that
>   feature commands are allowed before git option commands.

Perhaps the other people have discussed and thought about this much deeper
than I have after seeing the above description, but what should the
semantics be when you see unknown options?

If "option git something-unknown" is given, it is clear that the tool that
generated the stream assumed that such an option exists in the importer;
it might appear prudent to abort the operation.

But what about "option hg something"?

It is an indication that the stream is meant to be used with the named
option if fed to Hg, but it does not say anything about what should happen
when used with other systems.  If older versions of Hg that do not grok
the given option is expected to abort because they won't be able to change
the behaviour to obey the optional semantics demanded by the "option hg
something", what should the other VCS do?

Worrying about the above would be unnecessary, if you declare that it is
*entirely* optional to understand and obey "option", and ignoring them
does not result in a corrupt import at all.  I think that is the intent
behind "option", as opposed to "feature", and is consistent with the fact
that the command line options can override the in-stream settings.  In
other words, any in-stream instruction that changes the semantics of
stream to render it dangerous to be processed by older version of tools
would be expressed with "feature", not with "option".

If that is the sensible thing to do, then we obviously should ignore
"option hg anything", but at the same time we should ignore "option git
we-do-not-know-what-it-does".

But then, the call to die("Unsupported option: %s", option) at the end of
parse_one_option() is wrong, isn't it?

I think at least the function should be made conditional to die() if it
was called from parse_argv() but simply ignore unknown if it was called
from the input stream.

> diff --git a/fast-import.c b/fast-import.c
> index 9bf06a4..bad93dc 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -2456,11 +2468,31 @@ static void parse_feature(void)
>  
>  	if (!prefixcmp(feature, "date-format=")) {
>  		option_date_format(feature + 12);
> +	} else if (!strcmp("git-options", feature)) {
> +		options_enabled = 1;
>  	} else {
>  		die("This version of fast-import does not support feature %s.", feature);
>  	}
>  }
>  
> +static void parse_option(void)
> +{
> +	char* option = command_buf.buf + 11;

ERROR: "foo* bar" should be "foo *bar"

> +
> +	if (!options_enabled)
> +		die("Got option command '%s' before options feature'", option);
> +
> +	if (seen_non_option_command)
> +		die("Got option command '%s' after non-option command", option);
> +
> +	parse_one_option(option);
> +}
> +
> +static void parse_nongit_option(void)
> +{
> +  // do nothing

ERROR: do not use C99 // comments

> @@ -2539,9 +2581,18 @@ int main(int argc, const char **argv)
>  			parse_progress();
>  		else if (!prefixcmp(command_buf.buf, "feature "))
>  			parse_feature();
> +		else if (!prefixcmp(command_buf.buf, "option git "))
> +			parse_option();
> +    else if (!prefixcmp(command_buf.buf, "option "))
> +      parse_nongit_option();
>  		else
>  			die("Unsupported command: %s", command_buf.buf);
>  	}
> +
> +	// argv hasn't been parsed yet, do so

ERROR: do not use C99 // comments
