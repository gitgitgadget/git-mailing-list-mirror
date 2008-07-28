From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [Fundamental problem with relative system paths] [PATCH 2/2] run-command (Windows): Run dashless "git <cmd>"
Date: Mon, 28 Jul 2008 22:37:33 +0200
Message-ID: <1217277453.488e2e0db0f41@webmail.nextra.at>
References: <1217224228-31303-1-git-send-email-prohaska@zib.de> <1217224228-31303-2-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Jul 28 22:38:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNZUN-0000O2-Rw
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 22:38:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbYG1Uhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 16:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYG1Uhj
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 16:37:39 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:35992 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbYG1Uhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 16:37:38 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp5.srv.eunet.at (Postfix) with ESMTPS id 9ED3613A28C;
	Mon, 28 Jul 2008 22:37:36 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m6SKbXea019819;
	Mon, 28 Jul 2008 22:37:34 +0200
Received: from 77.117.178.94 ([77.117.178.94]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon, 28 Jul 2008 22:37:33 +0200
In-Reply-To: <1217224228-31303-2-git-send-email-prohaska@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.117.178.94
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90503>

Zitat von Steffen Prohaska <prohaska@zib.de>:

> This might solve a fundamental problem we have with the
> computation of system directories based on relative paths
> in combination with the new gitexecpath 'libexec/git-core'.
> The problem is that the program 'git' is hardlinked to
> directories with different depth.  It is either used as
> 'bin/git' (1 directory) or as 'libexec/git-core/git-*'
> (2 directories).  Thus, using the same relative path
> in system_path() yields different results when starting from the
> two locations.  I recognized the problem because /etc/gitconfig
> is no longer be read.
>
> The patch below might fix the problem by always calling 'bin/git'
> for builtin commands.  The computation in system_path() would
> always start from 'bin' and thus yields predictable results.  I
> am not sure however if it fully solves the problem because other
> code paths might run the dashed forms directly.

This paragraph should go into the commit message.

> I think the only way to verify correctness would be to stop
> installing the dashed forms for builtins.  If they were not
> installed they could not be called.  The only entry point for all
> builtins would be 'bin/git'.  I don't think we want to stop
> installing the dashed forms right away.
>
> So what shall we do?

Your patches make a lot of sense.

> -- 8< --
> We prefer running the dashless form, so we should use it in
> MinGW's start_command(), too.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>

Acked-by: Johannes Sixt <johannes.sixt@telecom.at>

-- Hannes
