From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Thu, 5 Jan 2012 17:06:15 +0100
Message-ID: <20120105160612.GA27251@ecki.lan>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
 <20120104204017.GC27567@ecki.lan>
 <7vaa63p11t.fsf@alter.siamese.dyndns.org>
 <20120104222649.GA14727@sigill.intra.peff.net>
 <20120105000713.GA24220@ecki.lan>
 <20120105025559.GB7326@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 05 17:15:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ripy0-0004tP-Vk
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 17:15:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932742Ab2AEQO4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 11:14:56 -0500
Received: from bsmtp5.bon.at ([195.3.86.187]:25158 "EHLO lbmfmo03.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932698Ab2AEQOz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 11:14:55 -0500
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by lbmfmo03.bon.at (Postfix) with ESMTP id 5FC6CCE0A8
	for <git@vger.kernel.org>; Thu,  5 Jan 2012 17:15:47 +0100 (CET)
Received: from localhost (unknown [80.123.242.182])
	by bsmtp.bon.at (Postfix) with ESMTP id 49463CDF85;
	Thu,  5 Jan 2012 17:15:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120105025559.GB7326@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187986>

On Wed, Jan 04, 2012 at 09:55:59PM -0500, Jeff King wrote:
> 
> It so happens that I have just the patch you need. I've been meaning to
> go over it again and submit it:
> 
>   run-command: optionally kill children on exit
>   https://github.com/peff/git/commit/5523d7ebf2a0386c9c61d7bfbc21375041df4989

Thanks, looks great. But if I add this on top (to enable this for
"git daemon"), then t0001 kills my entire X session. Not sure yet
what's going.

diff --git a/run-command.c b/run-command.c
index aeb9c6e..53218df 100644
--- a/run-command.c
+++ b/run-command.c
@@ -497,6 +497,7 @@ static void prepare_run_command_v_opt(struct child_process *cmd,
        cmd->stdout_to_stderr = opt & RUN_COMMAND_STDOUT_TO_STDERR ? 1 : 0;
        cmd->silent_exec_failure = opt & RUN_SILENT_EXEC_FAILURE ? 1 : 0;
        cmd->use_shell = opt & RUN_USING_SHELL ? 1 : 0;
+       cmd->clean_on_exit = 1;
 }
 
 int run_command_v_opt(const char **argv, int opt)
