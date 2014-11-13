From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] builtin: move builtin retrieval to get_builtin()
Date: Thu, 13 Nov 2014 10:19:55 -0800
Message-ID: <xmqq389n2cac.fsf@gitster.dls.corp.google.com>
References: <5463DA20.3080703@inventati.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, sschuberth@gmail.com
To: slavomir vlcek <svlc@inventati.org>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:20:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xoz0F-000369-JK
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933778AbaKMSUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:20:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62684 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932648AbaKMSUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:20:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CE27A1DFEB;
	Thu, 13 Nov 2014 13:19:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lcNxqx6pJwWyCe/UNVsSyYo4aZY=; b=sU0CAm
	mH6gfOEWeTb7jti2Ah5Wo1HPC7XC+mEHGdR0weANgz8iHDS3z/flpBcdAWCrdwVN
	YbVeC0ZyLdB1eWjnqgOnRBniEPnhZevllNSBSc8n0awQ5zy5ieedF23HzUdbkA4n
	QRhqBZoaOlneD//t0tL5riRDCFVGZiCJjXoFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c97Qx/RIli9Sz+4SrM8G12K6yfA17vCv
	L4YtgZ8hb+n9PKprL4LWFrBZ1JEbxbG0XKBY8v8h7Sc0ZSMYTJieMcoUw7MJZWy+
	5h5RbTBL4fyjzDQEcTwVE3XWEwiht03nOG68g5bXjz5iCLKSmBw/6zKi+KUQ+jmk
	QXJ32OlUVek=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C5A721DFEA;
	Thu, 13 Nov 2014 13:19:59 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1A4FF1DFE7;
	Thu, 13 Nov 2014 13:19:58 -0500 (EST)
In-Reply-To: <5463DA20.3080703@inventati.org> (slavomir vlcek's message of
	"Wed, 12 Nov 2014 23:07:28 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AD48EB48-6B61-11E4-8785-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

slavomir vlcek <svlc@inventati.org> writes:

> Hi,
> found a small code redundancy in a builtin command retrieval ('git.c').
>
> For the "master" branch.
>
> Thanks in advance for any suggestions.
>
> Signed-off-by: slavomir vlcek <svlc@inventati.org>
> ---

Thanks.  Please do realize that all of the above before the
three-dash line and nothing else will be made into the commit log
message (together with what you wrote on the Subject: line).

Which means these lines...

> From 78228e3f7c3029d07827f973fa7992777d6e0cb9 Mon Sep 17 00:00:00 2001
> From: slavomir vlcek <svlc@inventati.org>
> Date: Wed, 12 Nov 2014 14:10:22 +0100
> Subject: [PATCH] builtin: move builtin retrieval to get_builtin()
>
> There was a redundant code for a builtin command retrieval
> in 'handle_builtin()' and 'is_builtin()'.
>
> This was solved by adding a new function 'get_builtin()'
> and by making a boolean wrapper out of the 'is_builtin()'.
> ---

... will not be part of the log message, which is definitely wrong.

To correct this:

$ git checkout 78228e3f7c3029d0
$ git commit --amend -s --no-edit

to add your sign-off in the log message, then do

$ git format-patch -1 --stdout >patch.mail

Slurp patch.mail into your MUA, move the content on "Subject: " to
where your MUA expects to see the subject line, remove other header
material starting from "From 7822..." so that the message body
begins with "There was a redundant code for...".  And send it out.

>  git.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/git.c b/git.c
> index 18fbf79..e32c5b8 100644
> --- a/git.c
> +++ b/git.c
> @@ -487,15 +487,20 @@ static struct cmd_struct commands[] = {
>  	{ "write-tree", cmd_write_tree, RUN_SETUP },
>  };
>  
> -int is_builtin(const char *s)
> +struct cmd_struct *get_builtin(const char *s)

I do not think this has to be extern.

	static struct cmd_struct *get_builtin(const char *s)

perhaps.

> @@ -519,15 +525,12 @@ static void handle_builtin(int argc, const char **argv)
>  		argv[0] = cmd = "help";
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(commands); i++) {
> -		struct cmd_struct *p = commands+i;
> -		if (strcmp(p->cmd, cmd))
> -			continue;
> -		if (saved_environment && (p->option & NO_SETUP)) {
> +	builtin = get_builtin(cmd);

Nice.

> +	if (builtin) {
> +		if (saved_environment && (builtin->option & NO_SETUP))
>  			restore_env();
> -			break;
> -		}
> -		exit(run_builtin(p, argc, argv));
> +		else
> +			exit(run_builtin(builtin, argc, argv));

This change does not seem to have anything to do with the topic of
the change.  Why is it necessary?

>  	}
>  }
