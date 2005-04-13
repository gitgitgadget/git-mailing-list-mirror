From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Index/hash order
Date: Wed, 13 Apr 2005 22:02:37 +0200
Message-ID: <20050413200237.GA26635@elte.hu>
References: <20050412230027.GA21759@elte.hu> <20050412230729.GA22179@elte.hu> <20050413111355.GB13865@elte.hu> <425D4E1D.4040108@zytor.com> <20050413165310.GA22428@elte.hu> <425D4FB1.9040207@zytor.com> <20050413171052.GA22711@elte.hu> <Pine.LNX.4.58.0504131027210.4501@ppc970.osdl.org> <20050413182909.GA25221@elte.hu> <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 22:01:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLo25-0003gv-DQ
	for gcvg-git@gmane.org; Wed, 13 Apr 2005 22:00:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVDMUD1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 16:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261155AbVDMUD0
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 16:03:26 -0400
Received: from mx1.elte.hu ([157.181.1.137]:55005 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261151AbVDMUDW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 16:03:22 -0400
Received: from chiara.elte.hu (chiara.elte.hu [157.181.150.200])
	by mx1.elte.hu (Postfix) with ESMTP id CC0D531D248;
	Wed, 13 Apr 2005 22:02:07 +0200 (CEST)
Received: by chiara.elte.hu (Postfix, from userid 17806)
	id 6D4101FC2; Wed, 13 Apr 2005 22:02:41 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504131144160.4501@ppc970.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > with a plaintext repository we could do the 'hardlink trick' (which 
> > brings in other manageability problems and limitations but is at least a 
> > partially good idea), which would make the working tree and the 
> > repository share the same inode in most cases.

> However, the real issue is that you're really asking for trouble. 
> There are tons of tools that modify files without breaking the 
> hardlink. Even some editors do. So you just use the wrong tool on the 
> tree by mistake, and not only is your archive corrupt, you've 
> corrupted all other archives that might have shared the same object 
> directory.

that's what i loosely meant under 'manageability problems'.

I mentioned one solution earlier: to make the repository object an 
immutable file (the +i flag on the inode) - it really wants to be 
immutable after all. That would solve a whole range of 'accidental 
corruption' issues.

Another solution (suggested by Christer Weinigel) was to enforce 
immutability by making it owned by another user/group (git:git or 
whatever).

but having a binary compressed format is 'soft immutability', done 
cleverly.

	Ingo
