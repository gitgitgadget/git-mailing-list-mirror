From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: A simple script to do the reverse of git-push
Date: Tue, 9 Aug 2005 01:38:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508090135230.3695@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0508082318400.2911@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vslxk125f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 01:39:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2HCo-0008SI-PI
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 01:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbVHHXis (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 19:38:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVHHXis
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 19:38:48 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:40848 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932360AbVHHXir (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 19:38:47 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id A7900E1313; Tue,  9 Aug 2005 01:38:46 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 8BB58AC887; Tue,  9 Aug 2005 01:38:46 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 714A2A7D2B; Tue,  9 Aug 2005 01:38:46 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 49E7DE1313; Tue,  9 Aug 2005 01:38:46 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vslxk125f.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Junio C Hamano wrote:

> We would need something like this.
>
> [...]
>
> +$(patsubst git-%,%.o,$(PROG)): $(LIB_H)

A short

	for i in git-*; do \
		c=$(echo $i|sed "s/git-\(.*\)/\1.c/g")
		if [ -e $c ]; then \
			if ! grep cache\\.h $c; then \
				echo $c does not depend on cache.h \
			fi \
		fi \
	done

(actually tested) reveals that only get-tar-commit-id.c and stripspace.c 
do not depend on cache.h or rev-cache.h. Thus, your patch is the most 
elegant solution to my problem :-)

Ciao,
Dscho
