From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix git_setup_directory_gently when GIT_DIR is set
Date: Tue, 6 Jun 2006 00:57:19 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606060053440.25344@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0606051943540.29608@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 06 00:57:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FnO0s-0007yi-V4
	for gcvg-git@gmane.org; Tue, 06 Jun 2006 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWFEW5V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Jun 2006 18:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbWFEW5V
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Jun 2006 18:57:21 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:19433 "EHLO
	mailrelay.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750725AbWFEW5U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Jun 2006 18:57:20 -0400
Received: from virusscan.mail (localhost [127.0.0.1])
	by mailrelay.mail (Postfix) with ESMTP id 1D380237A;
	Tue,  6 Jun 2006 00:57:19 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 11CE0236E;
	Tue,  6 Jun 2006 00:57:19 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by mailmaster.uni-wuerzburg.de (Postfix) with ESMTP id E70C81C9C;
	Tue,  6 Jun 2006 00:57:18 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vodx74ca9.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21347>

Hi,

On Mon, 5 Jun 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When calling git_setup_directory_gently, and GIT_DIR was set, it just
> > ignored the variable nongit_ok.
> 
> Hmph.  Is this really a breakage?  That is, gently() is meant
> for a case where you do not know if you even find a git
> repository and tell it not to complain because you are prepared
> for the case where you are not in a git repository.

Yes, it is a breakage: in git-clone, line 212, we explicitely set GIT_DIR 
(to the not-yet-existing repository path), and call git-init-db. Now, with 
the alias thing we need to get the config if it exists, so we _got_ to 
call gently(). Boom.

Ciao,
Dscho
