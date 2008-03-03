From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Redirect stderr to a pipe before redirecting stdout to
   stderr
Date: Mon, 03 Mar 2008 09:07:35 +0100
Message-ID: <47CBB1C7.8010201@viscovery.net>
References: <20080303082111.24d3ea73.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Xavier Maillard <xma@gnu.org>,
	git@vger.kernel.org, nanako3@bluebottle.com, pascal@obry.net
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 09:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW5iq-0003CM-TM
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 09:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752212AbYCCIHm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 03:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYCCIHm
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 03:07:42 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:44749 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbYCCIHl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 03:07:41 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JW5hK-0001bj-9m; Mon, 03 Mar 2008 09:06:58 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 97155A33B; Mon,  3 Mar 2008 09:07:35 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080303082111.24d3ea73.chriscool@tuxfamily.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75905>

Christian Couder schrieb:
> With this patch, in the 'start_command' function after forking
> we now take care of stderr in the child process before stdout.
> 
> This way if 'start_command' is called with a 'child_process'
> argument like this:
> 
> 	.err = -1;
> 	.stdout_to_stderr = 1;
> 
> then stderr will be redirected to a pipe before stdout is
> redirected to stderr. So we can now get the process' stdout
> from the pipe (as well as its stderr).

Makes sense. All current users of .stdout_to_stderr don't modify the
stderr channel, so this patch should not make a difference.

But please also adjust Documentation/technical/api-run-command.txt because
it documents the behavior that you are modifying.

-- Hannes
