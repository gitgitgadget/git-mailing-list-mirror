From: Marco Roeland <marco.roeland@xs4all.nl>
Subject: Re: [PATCH] fix for "index-pack: rationalize delta resolution code"
Date: Mon, 20 Oct 2008 22:12:51 +0200
Message-ID: <20081020201251.GC22123@fiberbit.xs4all.nl>
References: <alpine.LFD.2.00.0810201357340.26244@xanadu.home> <20081020191400.GA18743@fiberbit.xs4all.nl> <20081020192051.GA21770@fiberbit.xs4all.nl> <alpine.LFD.2.00.0810201525540.26244@xanadu.home> <20081020193652.GA22123@fiberbit.xs4all.nl> <alpine.LFD.2.00.0810201601480.26244@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Oct 20 22:51:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks19b-0001rf-Fs
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 22:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754184AbYJTUN3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 16:13:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753142AbYJTUN3
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 16:13:29 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4663 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754691AbYJTUN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 16:13:28 -0400
Received: from fiberbit.xs4all.nl (fiberbit.xs4all.nl [80.101.187.211])
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id m9KKCpra072686;
	Mon, 20 Oct 2008 22:12:51 +0200 (CEST)
	(envelope-from marco.roeland@xs4all.nl)
Received: from marco by fiberbit.xs4all.nl with local (Exim 4.69)
	(envelope-from <marco.roeland@xs4all.nl>)
	id 1Ks17T-0005ur-3M; Mon, 20 Oct 2008 22:12:51 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0810201601480.26244@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98705>

On Monday Oktober 20th 2008 at 16:04 Nicolas Pitre wrote:

> If you want to make the difference really visible, try with
> 'git repack -a -f --window=100'.

Impressive, yes. Thanks very much.

marco@sirius:~/src/git (next) $ time git repack -a -f --window=100
Counting objects: 85713, done.
Compressing objects: 100% (84207/84207), done.
Writing objects: 100% (85713/85713), done.
Total 85713 (delta 62371), reused 0 (delta 0)

real    1m2.775s
user    1m1.848s
sys     0m0.176s
marco@sirius:~/src/git (next) $ git config pack.threads 0
marco@sirius:~/src/git (next) $ time git repack -a -f --window=100
Counting objects: 85713, done.
Compressing objects: 100% (84207/84207), done.
Writing objects: 100% (85713/85713), done.
Total 85713 (delta 62363), reused 0 (delta 0)

real    0m21.348s
user    1m2.948s
sys     0m0.432s
marco@sirius:~/src/git (next) $ git config --unset pack.threads
marco@sirius:~/src/git (next) $ time git repack -a -f --window=100
Counting objects: 85713, done.
Compressing objects: 100% (84207/84207), done.
Writing objects: 100% (85713/85713), done.
Total 85713 (delta 62371), reused 0 (delta 0)

real    1m1.904s
user    1m1.476s
sys     0m0.184s

This on Intel(R) Core(TM)2 Quad  CPU   Q9450  @ 2.66GHz.
-- 
Marco Roeland
