From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help.c: rename function "pretty_print_string_list"
Date: Fri, 28 Feb 2014 13:24:02 -0800
Message-ID: <xmqqfvn3szgt.fsf@gitster.dls.corp.google.com>
References: <1393615649-29248-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 22:24:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJUuq-0000i6-OZ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 22:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034AbaB1VYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 16:24:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753021AbaB1VYM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 16:24:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CC63470BF5;
	Fri, 28 Feb 2014 16:24:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fW6hoiVqs92GdkpqWd1koGR1Dig=; b=gtk+Ph
	WZMft24y9vWq5rbJOS9JtAhRgCJOklHU0moj3vdyUpPdmntnfF0tGLKA7sU/80tS
	SR7Z2EsOw6zAB+S4vFQZ6jmdbtzbJRSU8MMFqo+MF4Tg1e8IC4Qi7jMaJFemPuNo
	8ElhjpXFZhkPfliBn6cZTu/NbAXaI4K1TtcNM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HXk1Rhgt/MDXZxOIM84emZK8UwGZZuVV
	elMrFEbfdP6DiaaWVMGCivc9H9iWfGl1YGEWnxdeqdd5ebdl9vVZ6l1dwTW3xoQm
	1GIDIBUjdB88fofE6IX9V8hnxOrLl5W+3WRRsvat11uI5T4SrijJs3MlYxSOE2nm
	2xyyO/ndv9A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B844470BF4;
	Fri, 28 Feb 2014 16:24:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A1A70BF0;
	Fri, 28 Feb 2014 16:24:10 -0500 (EST)
In-Reply-To: <1393615649-29248-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Fri, 28 Feb 2014 20:27:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AA121602-A0BE-11E3-8E04-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243018>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> The part "string_list" of the name of function
> "pretty_print_string_list" is just an implementation
> detail. The function pretty-prints command names so
> rename it to "pretty_print_cmdnames".
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---
> Just noticed this while digging through Git codebase.

Thanks.  This is a leftover from 7dbc2c04 (git wrapper: basic
fixes., 2005-11-15); it used to be that this function was to pretty
print the contents of a string_list but it was updated to use its
own structure type.

>
>  help.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/help.c b/help.c
> index df7d16d..b266b09 100644
> --- a/help.c
> +++ b/help.c
> @@ -78,8 +78,7 @@ void exclude_cmds(struct cmdnames *cmds, struct cmdnames *excludes)
>  	cmds->cnt = cj;
>  }
>  
> -static void pretty_print_string_list(struct cmdnames *cmds,
> -				     unsigned int colopts)
> +static void pretty_print_cmdnames(struct cmdnames *cmds, unsigned int colopts)
>  {
>  	struct string_list list = STRING_LIST_INIT_NODUP;
>  	struct column_options copts;
> @@ -209,14 +208,14 @@ void list_commands(unsigned int colopts,
>  		const char *exec_path = git_exec_path();
>  		printf_ln(_("available git commands in '%s'"), exec_path);
>  		putchar('\n');
> -		pretty_print_string_list(main_cmds, colopts);
> +		pretty_print_cmdnames(main_cmds, colopts);
>  		putchar('\n');
>  	}
>  
>  	if (other_cmds->cnt) {
>  		printf_ln(_("git commands available from elsewhere on your $PATH"));
>  		putchar('\n');
> -		pretty_print_string_list(other_cmds, colopts);
> +		pretty_print_cmdnames(other_cmds, colopts);
>  		putchar('\n');
>  	}
>  }
