From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-help: add "help.format" config variable.
Date: Wed, 12 Dec 2007 01:04:57 -0800
Message-ID: <7vr6hs8erq.fsf@gitster.siamese.dyndns.org>
References: <20071212063320.3cbb1698.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Dec 12 10:06:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2NY2-0001xn-N8
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 10:06:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756529AbXLLJGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 04:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756176AbXLLJGJ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 04:06:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:58286 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755275AbXLLJGH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 04:06:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2539E62DB;
	Wed, 12 Dec 2007 04:06:02 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BA9362D4;
	Wed, 12 Dec 2007 04:05:04 -0500 (EST)
In-Reply-To: <20071212063320.3cbb1698.chriscool@tuxfamily.org> (Christian
	Couder's message of "Wed, 12 Dec 2007 06:33:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68016>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/git.c b/git.c
> index 4f9876e..d46b63d 100644
> --- a/git.c
> +++ b/git.c
> @@ -324,7 +324,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "gc", cmd_gc, RUN_SETUP },
>  		{ "get-tar-commit-id", cmd_get_tar_commit_id },
>  		{ "grep", cmd_grep, RUN_SETUP | USE_PAGER },
> -		{ "help", cmd_help },
> +		{ "help", cmd_help, RUN_SETUP },
>  #ifndef NO_CURL
>  		{ "http-fetch", cmd_http_fetch, RUN_SETUP },
>  #endif

It would be _NICE_ if we read configuration when we are in a git
repository, but I am afraid this change is unnice -- the users used to
be able to say "git help" from anywhere didn't they?  Now they will get
"Not a git repository".  It needs to do an optional repository
discovery, not a mandatory one RUN_SETUP causes.
