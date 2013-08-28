From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [RFC/PATCH] status: introduce status.displayCommentChar to disable
 display of #
Date: Wed, 28 Aug 2013 13:03:08 +0200
Message-ID: <521DD8EC.6050800@viscovery.net>
References: <1377678752-16302-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 28 13:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEdX3-0000IC-0w
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 13:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753052Ab3H1LDP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Aug 2013 07:03:15 -0400
Received: from so.liwest.at ([212.33.55.24]:14877 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752627Ab3H1LDN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Aug 2013 07:03:13 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1VEdWn-0006nA-61; Wed, 28 Aug 2013 13:03:09 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E8DBC1660F;
	Wed, 28 Aug 2013 13:03:08 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130801 Thunderbird/17.0.8
In-Reply-To: <1377678752-16302-1-git-send-email-Matthieu.Moy@imag.fr>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233182>

Am 8/28/2013 10:32, schrieb Matthieu Moy:
> Historically, "git status" needed to prefix each output line with '#' so
> that the output could be added as comment to the commit message. This
> prefix comment has no real purpose when "git status" is ran from the
> command-line, and this may distract users from the real content.
> 
> Allow the user to disable this prefix comment. In the long run, if users
> like the non-prefix output, it may make sense to flip the default value
> to true.
> 
> Obviously, status.displayCommentChar applies to "git status" but is
> ignored by "git commit", so the status is still commented in
> COMMIT_EDITMSG.
> 
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> As a beginner (long ago), I found this comment-prefixed output really
> weird. I got used to it,...

You have my sympathy.

How does your solution work when dirty submodules are involved and
submodule status is included?

> +test_expect_success 'status with status.displayCommentChar=false' '
> +	"$PERL_PATH" -pi -e "s/^\# //; s/^\#$//; s/^#\t/\t/" expect &&

Perl's -i does not work on Windows when no backup file extension is given.
Therefore, please use a temporary file or "... -pi.bak ..."

> +	git -c status.displayCommentChar=false status >output &&
> +	test_i18ncmp expect output
> +'

-- Hannes
