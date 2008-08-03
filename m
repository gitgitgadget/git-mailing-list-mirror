From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Set up argv0_path correctly, even when argv[0] is just
	the basename
Date: Sun, 3 Aug 2008 22:25:13 +0200
Message-ID: <20080803202513.GC3482@efreet.light.src>
References: <1217065304-27815-1-git-send-email-prohaska@zib.de> <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Aug 03 22:26:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPk9r-0005GK-H2
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 22:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755533AbYHCUZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 16:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755351AbYHCUZ0
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 16:25:26 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:41953 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755345AbYHCUZZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 16:25:25 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 7B5CB57354;
	Sun,  3 Aug 2008 22:25:24 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id CTMT5ggR-KgF; Sun,  3 Aug 2008 22:25:21 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id B912D57278;
	Sun,  3 Aug 2008 22:25:20 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.69)
	(envelope-from <bulb@ucw.cz>)
	id 1KPk8f-0001ht-UM; Sun, 03 Aug 2008 22:25:13 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261613120.26810@eeepc-johanness>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91264>

On Sat, Jul 26, 2008 at 16:14:33 +0200, Johannes Schindelin wrote:
> When the program 'git' is in the PATH, the argv[0] is set to the basename.
> However, argv0_path needs the full path, so add a function to discover the
> program by traversing the PATH manually.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	So it is not easily possible to reuse this function in 
> 	compat/mingw.c, as Junio said that compat/ should not depend
> 	(at least too much) on libgit.a.
> 
> 	Of course, we could try to follow a symlinked git, too, but I 
> 	think this is overkill until someone proves me wrong.

On UNIX, not only that argv[0] can contain the program without path -- it can
contain anything the user thinks of. However most systems provide some way to
get the path of the executable. On Linux (and some other unices, but not all
of them) a reliable way is to readlink("/proc/self/exe", ...). Maybe since
it's only needed for resolving a relative exec dir, relative exec dir could
be supported only on systems that have such method (which is most of them).

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
