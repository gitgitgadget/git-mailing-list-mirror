From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD/PATCH] submodule doc: describe where we can configure them
Date: Wed, 04 May 2016 13:48:50 -0700
Message-ID: <xmqqh9edft1p.fsf@gitster.mtv.corp.google.com>
References: <1462317985-640-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 04 22:48:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay3j7-0005SI-TT
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 22:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbcEDUsy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 16:48:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59141 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752944AbcEDUsx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 16:48:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 179F51855E;
	Wed,  4 May 2016 16:48:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M2Ryel6td7505QBAk6OkKMfJfs8=; b=hhoxZ5
	UE5xlzgqDbZsbyeVtsoRGgwcaUZjdaTW9WI1eXT+ZvCCjisuYgtdPQYBs5l5le/c
	Fs6TcErT9plQ3QaFFu3opVcU7Xb311gBuhsN/mLxA2MB+qZp6mheKvEttZUaGO+2
	2VGDec86b2m4GEQognmrtSInKYOzq+5d+RboQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7fFGiAPtmUuGUasxBGsVFiO6Rn0Q1+E
	AwyhG3ikEcd4y3oYFOkMekDxaeXqC/NHTWj0p4ydvydEJqAlEvQgpB7ChstetJhW
	8m1UFdIwzUElsr+9UYFsWm5zG6jX5ZGzgsjoh2bjSggl8lMqcBNiUFHQz3rLaa46
	V7Y36nnwqQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0F8FC1855D;
	Wed,  4 May 2016 16:48:52 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88AA11855C;
	Wed,  4 May 2016 16:48:51 -0400 (EDT)
In-Reply-To: <1462317985-640-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 3 May 2016 16:26:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9BAE66EE-1239-11E6-819F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293590>

Stefan Beller <sbeller@google.com> writes:

> This is similar to the gitignore document, but doesn't mirror
> the current situation. It is rather meant to start a discussion for
> the right approach for mirroring repositories with submodules.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
>  Jonathan, is this something you had in mind?
>
>  Documentation/git-submodule.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
> index 13adebf..b5559e5 100644
> --- a/Documentation/git-submodule.txt
> +++ b/Documentation/git-submodule.txt
> @@ -59,6 +59,22 @@ instead of treating the other project as a submodule. Directories
>  that come from both projects can be cloned and checked out as a whole
>  if you choose to go that route.
>  
> +Submodule operations can be configured using the following mechanisms
> +(from highest to lowest precedence):
> +
> + * the command line for those commands that support taking submodule specs.

Sorry, but have we introduced <submodule spec> as a Git lingo?  What
does it mean?

> +
> + * the configuration file `$GIT_DIR/config`.
> +
> + * the configuration file `config` found in the `refs/submodule/config` branch.
> +   This can be used to overwrite the upstream configuration in the `.gitmodules`
> +   file without changing the history of the project.
> +   Useful options here are overwriting the base, where relative URLs apply to,
> +   when mirroring only parts of the larger collection of submodules.

This smells like something server side people may come up with; how
would an end user with a usual "repository with working tree" layout
futz with this thing?  Can it even be checked out, or would we have
a UI similar to "notes"?

> + * the `.gitmodules` file inside the repository. A project usually includes this
> +   file to suggest defaults for the upstream collection of repositories.
> +
>  COMMANDS
>  --------
>  add::
