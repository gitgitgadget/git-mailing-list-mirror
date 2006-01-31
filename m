From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Tue, 31 Jan 2006 14:58:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v8xsxa70o.fsf@assigned-by-dhcp.cox.net> <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 14:58:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3w1e-0001pu-Qc
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 14:58:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750871AbWAaN6X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 08:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750876AbWAaN6X
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 08:58:23 -0500
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:48049 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1750871AbWAaN6W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 08:58:22 -0500
Received: from virusscan.mail (amavis1.rz.uni-wuerzburg.de [132.187.3.48])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id AA441146711; Tue, 31 Jan 2006 14:58:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by virusscan.mail (Postfix) with ESMTP id 9CF45A58;
	Tue, 31 Jan 2006 14:58:21 +0100 (CET)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 5BA221466EB; Tue, 31 Jan 2006 14:58:21 +0100 (CET)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new at uni-wuerzburg.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15315>

Hi,

apart from my thinking this is not backward-compatible (you are supposed 
to be able to pull from a complete repo, even if it has a 
non-shallow-capable upload-pack), here are my comments:

- it is good that MAXPARENT and struct commit_graft are in more public 
	places now.

- reparse_* is misleading. Nothing is reparsed, but rather "unparsed".

- I'd hesitate to let git-daemon write temporary files. That is a whole 
	new can of security worms.

- It looks wrong to me to define MAX_PARENTS as 20 in upload-pack.c, when 
	MAXPARENT is defined as 16 in cache.h.

- The custom_graft issue could be handled in a more elegant manner if 
	git was lib'ified (no temporary file). Since that is already the 
	plan, why not do that first, and come back later?

Ciao,
Dscho
