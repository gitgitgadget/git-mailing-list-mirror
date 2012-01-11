From: Sergio <sergio.callegari@gmail.com>
Subject: Re: rsync a *bunch* of git repos
Date: Wed, 11 Jan 2012 13:22:54 +0000 (UTC)
Message-ID: <loom.20120111T141805-791@post.gmane.org>
References: <20120110211548.GD10255@titan.lakedaemon.net> <201201102124.q0ALOowL026941@no.baka.org> <25207BDC675840DEA94AA2B04D6783BD@PhilipOakley> <7v39bn9onl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 11 14:23:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rky9A-0002jM-EX
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 14:23:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505Ab2AKNXP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 08:23:15 -0500
Received: from lo.gmane.org ([80.91.229.12]:39872 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756547Ab2AKNXO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 08:23:14 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Rky8y-0002d8-FC
	for git@vger.kernel.org; Wed, 11 Jan 2012 14:23:12 +0100
Received: from i2-ve060.ingce.unibo.it ([137.204.107.60])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 14:23:08 +0100
Received: from sergio.callegari by i2-ve060.ingce.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 11 Jan 2012 14:23:08 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.107.60 (Mozilla/5.0 (Ubuntu; X11; Linux x86_64; rv:9.0.1) Gecko/20100101 Firefox/9.0.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188365>

Junio C Hamano <gitster <at> pobox.com> writes:

> 
> "Philip Oakley" <philipoakley <at> iee.org> writes:
> 
> > I think there is an exception for certain git submodule setups with
> > local repos, where the gitdir link is hard coded to the absolute
> > machine path. There has been some discussion on the list recently
> > about trying to cover this case.
> 
> But if you read the original post carefully, all repositories involved are
> under /home before the transition, and they will move to the exact same
> place under /home anyway, so I do not think the discussion you have in
> mind would apply to this case.
> 
> The only thing that is needed after the move would be to run
> 
> 	git update-index --refresh
> 
> in all of the repositories, I think.
> 
> 

I keep a desktop and a laptop in sync with unison (which uses rsync) and I
confirm that git is entirely happy about that.

the git update-index --refresh is necessary, otherwise git status will
incorrectly report dirty trees.

I wonder if it would not make sense to incorporate the update-index --refresh in
the git status command.

As an aside: git works fine when repos are transferred with rsync, but git packs
are not rsync friendly nor friendly with backup strategies using binary deltas.
