From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH 6/7] mergetools: Fix difftool/mergetool --tool-help
 listing for vim
Date: Fri, 25 Jan 2013 10:38:45 +0000
Message-ID: <20130125103845.GX7498@serenity.lan>
References: <1359107034-14606-1-git-send-email-davvid@gmail.com>
 <1359107034-14606-7-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 11:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyggm-00071m-N8
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 11:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab3AYKiz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2013 05:38:55 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:57639 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756444Ab3AYKix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2013 05:38:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id CC93ECDA620;
	Fri, 25 Jan 2013 10:38:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id V7ynCqtxjDzY; Fri, 25 Jan 2013 10:38:52 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id 37E46CDA625;
	Fri, 25 Jan 2013 10:38:52 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 2B22E161E5A0;
	Fri, 25 Jan 2013 10:38:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PyKJbJoSynN1; Fri, 25 Jan 2013 10:38:52 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 6DB35161E590;
	Fri, 25 Jan 2013 10:38:46 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <1359107034-14606-7-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214541>

On Fri, Jan 25, 2013 at 01:43:53AM -0800, David Aguilar wrote:
> "git difftool --tool-help" and "git mergetool --tool-help" incorreclty
> list "vim" as being an unavailable tool.  This is because they attempt
> to find a tool named according to the mergetool scriptlet instead of the Git-
> recognized tool name.

Actually, after my patches both git-difftool and git-mergetool get this
right since list_merge_tool_candidates lists vimdiff and gvimdiff.

> vimdiff, vimdiff2, gvimdiff, and gvimdiff2 are all provided by the "vim"
> scriptlet.  This required git-mergetool--lib to special-case it when
> setting up the tool.
> 
> Remove the exception for "vim" and allow the scriptlets to be found
> naturally by using symlinks to a single "vimdiff" scriptlet.

I wonder if it would be better to make these single-line scripts instead
of symlinks:

    . "$MERGE_TOOLS_DIR"/vimdiff

where we make git-mergetool--lib.sh export:

    MERGE_TOOLS_DIR=$(git --exec-path)/mergetools


John
