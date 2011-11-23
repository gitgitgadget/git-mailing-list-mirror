From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix revert --abort on Windows
Date: Wed, 23 Nov 2011 11:21:41 +0100
Message-ID: <4ECCC935.7010407@viscovery.net>
References: <20111120073059.GA2278@elie.hsd1.il.comcast.net> <CALkWK0=45OwcBoH2TorsgwTbaXjnffVuh0mGxh2+ShN9cuF-=A@mail.gmail.com> <20111120094650.GB2278@elie.hsd1.il.comcast.net> <20111122111207.GA7399@elie.hsd1.il.comcast.net> <20111122112001.GF7399@elie.hsd1.il.comcast.net> <7vr50zd5x0.fsf@alter.siamese.dyndns.org> <20111123012721.GA14217@elie.hsd1.il.comcast.net> <4ECCB3A2.5030102@viscovery.net> <20111123100452.GA30629@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Phil Hord <phil.hord@gmail.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 23 11:21:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT9xh-0005BK-PC
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 11:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160Ab1KWKVs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 05:21:48 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:57442 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab1KWKVr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 05:21:47 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1RT9xW-00074h-6B; Wed, 23 Nov 2011 11:21:42 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D8E9E1660F;
	Wed, 23 Nov 2011 11:21:41 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.24) Gecko/20111103 Thunderbird/3.1.16
In-Reply-To: <20111123100452.GA30629@elie.hsd1.il.comcast.net>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185835>

Am 11/23/2011 11:04, schrieb Jonathan Nieder:
> ... "git reset --merge <commit>" renames the
> .git/sequencer directory as a secondary effect --- after moving to
> <commit>, or so the logic goes, it is unlikely but possible that the
> caller of git reset wants to continue the series of cherry-picks that
> was in progress, so git renames the sequencer state to
> .git/sequencer-old to be helpful while allowing the cherry-pick to be
> resumed if the caller did not want to end the sequence after all.
> ...
> By the way, as the length of [this paragraph] might
> have hinted, I am not convinced that allowing "git reset --hard" as an
> escape route from a cherry-pick sequence was very sensible.  It
> _would_ be nice to have a command to return to a known state,
> discarding progress in all pending multiple-command guided workflows
> (am, rebase, bisect), but git reset is not that command.

IMO, it doesn't make sense that git-reset aborts a cherry-pick sequence:
When I messed up a difficult conflict in the middle of a cherry-pick
sequence, it might be useful to be able to 'git reset --hard && git
cherry-pick that-one-commit' to restart the conflict resolution.

(But does a single-commit cherry-pick during a multi-commit cherry-pick
work to begin with?)

-- Hannes
