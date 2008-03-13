From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/4] builtin-status: submodule summary support
Date: Thu, 13 Mar 2008 15:11:10 +0100
Message-ID: <47D935FE.8010107@viscovery.net>
References: <1205416085-23431-1-git-send-email-pkufranky@gmail.com> <1205416085-23431-2-git-send-email-pkufranky@gmail.com> <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 13 15:12:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZo9v-0003ic-OA
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 15:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514AbYCMOLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 10:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752189AbYCMOLN
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 10:11:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63861 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752078AbYCMOLM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 10:11:12 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZo8Y-0005Ek-4Q; Thu, 13 Mar 2008 15:10:26 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C8C096B7; Thu, 13 Mar 2008 15:11:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1205416085-23431-3-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77091>

Ping Yin schrieb:
> +	memset(&sm_summary, 0, sizeof(sm_summary));
> +	sm_summary.argv = argv;
> +	sm_summary.env = env;
> +	sm_summary.git_cmd = 1;
> +	sm_summary.no_stdin = 1;
> +	fflush(s->fp);
> +	sm_summary.out = dup(fileno(s->fp));    /* run_command closes it */

The fflush() at this point makes a lot of sense, and doesn't even need a
comment (IMHO).

>  	wt_status_print_changed(s);
> +	// must flush s->fp since following call will write to s->fp in a child process
> +	fflush(s->fp);
> +	wt_status_print_submodule_summary(s);
>  	wt_status_print_untracked(s);

But then we don't need the fflush() here. Right?

-- Hannes
