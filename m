From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replace misleading message during interactive rebasing
Date: Wed, 28 Nov 2007 12:41:09 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711281237250.27959@racer.site>
References: <1196111891-18518-1-git-send-email-win@wincent.com>
 <474BD5CA.7050407@viscovery.net> <7vve7n9eaa.fsf@gitster.siamese.dyndns.org>
 <47D3817B-AA0D-4949-99ED-C36611604D5E@wincent.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	tsuna@lrde.epita.fr, mcostalba@gmail.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 13:41:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxMEd-00041R-7A
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 13:41:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760219AbXK1MlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2007 07:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760160AbXK1MlT
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Nov 2007 07:41:19 -0500
Received: from mail.gmx.net ([213.165.64.20]:46196 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759989AbXK1MlS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2007 07:41:18 -0500
Received: (qmail invoked by alias); 28 Nov 2007 12:41:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp037) with SMTP; 28 Nov 2007 13:41:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fZAsFu7PftIPef5x1SLysBrGB61YcTF4/If4QXx
	CEGe0POcmL2Wyu
X-X-Sender: gene099@racer.site
In-Reply-To: <47D3817B-AA0D-4949-99ED-C36611604D5E@wincent.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66309>

Hi,

On Wed, 28 Nov 2007, Wincent Colaiuta wrote:

> @@ -352,11 +352,13 @@ static int revert_or_cherry_pick(int argc, const char
> **argv)
> 		}
> 		if (close(msg_fd) || commit_lock_file(&msg_file) < 0)
> 			die ("Error wrapping up %s", defmsg);
> +		help_message = getenv("_GIT_CHERRY_PICK_HELP");
> 		fprintf(stderr, "Automatic %s failed.  "
> 			"After resolving the conflicts,\n"
> 			"mark the corrected paths with 'git add <paths>' "
> -			"and commit the result.\n", me);
> -		if (action == CHERRY_PICK) {
> +			"and %s.\n", me,
> +			help_message ? help_message : "commit the result");
> +		if (action == CHERRY_PICK && !help_message) {
> 			fprintf(stderr, "When commiting, use the option "
> 				"'-c %s' to retain authorship and message.\n",
> 				find_unique_abbrev(commit->object.sha1,

What about Junio's remark that _GIT_CHERRY_PICK_HELP should rather replace 
the _complete_ message?

You could still provide the "me" and unique_abbrev parameters, so that the 
first %s in _GIT_CHERRY_PICK_HELP would be replaced by the operation, and 
the second by the sha1.  Hmm?

Ciao,
Dscho
