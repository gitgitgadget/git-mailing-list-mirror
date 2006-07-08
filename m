From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Close the index file between writing and committing
Date: Sat, 08 Jul 2006 03:28:09 -0700
Message-ID: <7vbqs0qtl2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0607081055520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 12:28:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzA2o-0007xk-Qd
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 12:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932323AbWGHK2L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 06:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932327AbWGHK2L
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 06:28:11 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:17062 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932323AbWGHK2K (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Jul 2006 06:28:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060708102810.EESZ27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 8 Jul 2006 06:28:10 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0607081055520.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 8 Jul 2006 10:56:28 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23486>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	Alternatively, write_cache() could be taught to close the file
> 	itself, but maybe there will be a user of write_cache() who wants
> 	to write something after the cache data?

Currently I suspect nobody would want to append stuff to the
index file, because anybody who wants to add something to the
cache can do so with the index extension mechanism.

However, it is conceivable that later we might invent a new
program that writes the index file and other things to a single
stream, and closing the fd in write_cache() would inconvenience
such a program.
