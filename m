From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-commit --amend: respect grafted parents.
Date: Wed, 26 Sep 2007 13:24:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709261322150.28395@racer.site>
References: <11908086961933-git-send-email-johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Wed Sep 26 14:25:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaVxR-0007Kb-TX
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 14:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752465AbXIZMZa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2007 08:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752329AbXIZMZa
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Sep 2007 08:25:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:38365 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752462AbXIZMZa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2007 08:25:30 -0400
Received: (qmail invoked by alias); 26 Sep 2007 12:25:27 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 26 Sep 2007 14:25:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/jIHE2QujjFPv07WVeyJ1nLjcFge9ia3XpXrbhF3
	K6zJWJe3pQIESS
X-X-Sender: gene099@racer.site
In-Reply-To: <11908086961933-git-send-email-johannes.sixt@telecom.at>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59226>

Hi,

On Wed, 26 Sep 2007, Johannes Sixt wrote:

> This allows a poor-mans-filter-branch of the top-most commit.
> 
> Specifically, I had this history:
> 
>    --o--o--A'    <-- amended version of A
>          \
>           A
>            \
>     --o--B--M
> 
> I now wanted to "amend" M to pull in A' instead of A as its second 
> parent. For various reasons I didn't want to redo the merge M again, in 
> particular, it already contained the changes that were amended into A'. 
> So I figured I would just install a graft that lists B and A' as parents 
> of M and then do a simple git commit --amend. Alas, git commit looks at 
> the real parents instead of the grafted ones, so the amended M' would 
> still have A as its second parent. Here is the fix that picks the 
> grafted parents instead.

I do not think that this is a "fix".

I'd really suggest that you fix it up (before the amend!) by installing 
the graft, and running git-filter-branch -1 <branch>.  (Note: I did not 
test this, but it _should_ work.  If it does not, please let me know.)

Ciao,
Dscho
