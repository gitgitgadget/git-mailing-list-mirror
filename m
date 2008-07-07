From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] run_command(): respect GIT_TRACE
Date: Mon, 07 Jul 2008 13:00:26 -0700
Message-ID: <7v4p7131np.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807071441190.18205@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 07 22:01:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFwu2-0001Rv-HJ
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 22:01:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755183AbYGGUAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 16:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755290AbYGGUAl
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 16:00:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37228 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093AbYGGUAk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 16:00:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 723B31366C;
	Mon,  7 Jul 2008 16:00:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D79651366A; Mon,  7 Jul 2008 16:00:36 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807071441190.18205@racer> (Johannes
 Schindelin's message of "Mon, 7 Jul 2008 14:41:34 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5F3EDF16-4C5F-11DD-AF22-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87647>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When GIT_TRACE is set, the user is most likely wanting to see an external
> command that is about to be executed.

I haven't checked to see if none of the callers of start_command() assumes
the current behaviour and is printing this information itself instead, but
other than that, your justification feels very sensible.

Thanks.

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  run-command.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/run-command.c b/run-command.c
> index 2ce8c2b..6e29fdf 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -65,6 +65,8 @@ int start_command(struct child_process *cmd)
>  		cmd->err = fderr[0];
>  	}
>  
> +	trace_argv_printf(cmd->argv, "trace: run_command:");
> +
>  #ifndef __MINGW32__
>  	cmd->pid = fork();
>  	if (!cmd->pid) {
> -- 
> 1.5.6.2.402.g95b5ab.dirty
