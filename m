From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 09:34:45 +0200
Message-ID: <48858D95.7060409@viscovery.net>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:35:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCPa-0001h3-1n
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:35:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212AbYGVHev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751309AbYGVHev
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:34:51 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:21640 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbYGVHev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:34:51 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KLCOU-0003Dq-3l; Tue, 22 Jul 2008 09:34:46 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D6C706D9; Tue, 22 Jul 2008 09:34:45 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080722044157.GA20787@sigill.intra.peff.net>
X-Spam-Score: 1.2 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_95=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89460>

Jeff King schrieb:
> @@ -231,6 +232,8 @@ static int run_command(struct cmd_struct *p, int argc, const char **argv)
>  		use_pager = check_pager_config(p->cmd);
>  	if (use_pager == -1 && p->option & USE_PAGER)
>  		use_pager = 1;
> +	if (use_pager ==  1 && p->option & FORBID_PAGER)
> +		use_pager = 0;
>  	commit_pager_choice();
>  
>  	if (p->option & NEED_WORK_TREE)
> @@ -286,7 +289,7 @@ static void handle_internal_command(int argc, const char **argv)
>  		{ "count-objects", cmd_count_objects, RUN_SETUP },
>  		{ "describe", cmd_describe, RUN_SETUP },
>  		{ "diff", cmd_diff },
> -		{ "diff-files", cmd_diff_files, RUN_SETUP },
> +		{ "diff-files", cmd_diff_files, RUN_SETUP | FORBID_PAGER },

Every now and then I want to use 'git -p diff-files', and I think that is
a valid use-case. But your suggested patch seems to forbid the pager even
in this case. :-(

-- Hannes
