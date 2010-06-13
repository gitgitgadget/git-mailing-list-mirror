From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] grep -O: allow optional argument specifying the
 pager (or editor)
Date: Sun, 13 Jun 2010 09:35:17 -0700
Message-ID: <7vvd9mevqy.fsf@alter.siamese.dyndns.org>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino> <20100612163946.GD5657@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Paolo Bonzini <bonzini@gnu.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 13 18:43:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONqHE-00048Y-91
	for gcvg-git-2@lo.gmane.org; Sun, 13 Jun 2010 18:43:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753983Ab0FMQfa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jun 2010 12:35:30 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab0FMQf3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jun 2010 12:35:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 24657BB5EF;
	Sun, 13 Jun 2010 12:35:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xsjbcCb0vFcqTQ4FZx93lSIsCAs=; b=tl3nz8
	0WdslMrgNed/dNB8FXC6v14ZfTkjOgIAbf4+tebXOgNhwKwegQuIRY/lMIoisEFc
	yVNEbC5q9XUv7q4dwdKCO83eUfJySkzsQMHvgyN+M6rxaxx85hYi1LvnNijgmaQg
	1GoYcuszr2aEEf8mvKRRHM0eunv7nyWWxwmYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fvBcr9KHbU9AhBiFpLS6ahxqxUwQXY1o
	C5lLt4cNLun+HAf6Q51XTvf+Sdu+qYSuZ4i+bDLV7xUVc98ujLpW7YMZQd3lM62S
	LbkUuRi2jgUdHms5PImi0mQA9asmpKGhAhylkg1787n5JNpO/2pv3z9xXR/Spf/m
	sZmaG7f46mg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D47CABB5E7;
	Sun, 13 Jun 2010 12:35:23 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F241FBB5E2; Sun, 13 Jun
 2010 12:35:18 -0400 (EDT)
In-Reply-To: <20100612163946.GD5657@burratino> (Jonathan Nieder's message of
 "Sat\, 12 Jun 2010 11\:39\:46 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: AA347C34-7709-11DF-B914-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149053>

Jonathan Nieder <jrnieder@gmail.com> writes:

> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 8fdd8e1..d89ec32 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -14,7 +14,7 @@ SYNOPSIS
>  	   [-E | --extended-regexp] [-G | --basic-regexp]
>  	   [-F | --fixed-strings] [-n]
>  	   [-l | --files-with-matches] [-L | --files-without-match]
> -	   [-O | --open-files-in-pager]
> +	   [(-O | --open-files-in-pager) [<pager>]]
>  	   [-z | --null]
>  	   [-c | --count] [--all-match] [-q | --quiet]
>  	   [--max-depth <depth>]

Hmm, does "git grep -e Heh -O frotz" look for Heh and show in the frotz
pager, or does it look for Heh in paths under frotz/ directory and show
hits in the default pager?

> diff --git a/builtin/grep.c b/builtin/grep.c
> index 1e8b946..f32fbbc 100644
> --- a/builtin/grep.c
> +++ b/builtin/grep.c
> @@ -828,7 +828,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>  	int cached = 0;
>  	int seen_dashdash = 0;
>  	int external_grep_allowed__ignored;
> -	int show_in_pager = 0;
> +	const char *show_in_pager = NULL, *default_pager = "dummy";

If there were another instance of constant string "dummy" elsewhere in the
program, is a clever compiler-linker combo allowed to optimize memory use
by allocating one instance of such a string and pointing default_pager
pointer to it?  IOW, if the patch were:

> +	const char *show_in_pager = NULL, *default_pager = "dummy";
> +	const char *another_dummy = "dummy";

could another_dummy and default_pager start out with the same value?

This is just out of curiosity and does not affect correctness of the code,
but I am wondering...
