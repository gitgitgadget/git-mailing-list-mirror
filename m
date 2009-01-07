From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Wed, 7 Jan 2009 12:25:27 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0901071222300.3057@localhost.localdomain>
References: <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>  <20081104152351.GA21842@artemis.corp>  <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de>  <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain>  <20081104004001.GB29458@artemis.corp>
  <alpine.DEB.1.00.0811040627020.24407@pacific.mpi-cbg.de>  <20081104083042.GB3788@artemis.corp>  <alpine.DEB.1.00.0811041447170.24407@pacific.mpi-cbg.de>  <20081104152351.GA21842@artemis.corp>  <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> 
 <20090106111712.GB30766@artemis.corp>  <alpine.DEB.1.00.0901062037250.30769@pacific.mpi-cbg.de> <1231359317.6011.12.camel@maia.lan>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jan 07 21:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKezb-0005rs-Os
	for gcvg-git-2@gmane.org; Wed, 07 Jan 2009 21:27:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760480AbZAGUZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 15:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760344AbZAGUZm
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 15:25:42 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33544 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760184AbZAGUZl (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Jan 2009 15:25:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07KPRjH025250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 7 Jan 2009 12:25:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n07KPRap022707;
	Wed, 7 Jan 2009 12:25:27 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <1231359317.6011.12.camel@maia.lan>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.947 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104829>



On Thu, 8 Jan 2009, Sam Vilain wrote:
> 
> Whatever happens, the current deterministic diff algorithm needs to stay
> for generating patch-id's... those really can't be allowed to change.

Sure they can.

We never cache patch-id's over a long time. And we _have_ changed xdiff to 
modify the output of the patches before, quite regardless of any patience 
issues: see commit 9b28d55401a529ff08c709f42f66e765c93b0a20, which 
admittedly doesn't affect any _normal_ diffs, but can generate subtly 
different results for some cases.

It's true that we want the diff algorithm to be deterministic in the sense 
that over the run of a _single_ rebase operation, the diff between two 
files should give similar and deterministic results, but that's certainly 
true of patience diff too.

			Linus
