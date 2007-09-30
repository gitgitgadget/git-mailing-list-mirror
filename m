From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: Re: [PATCH 0/5] fork/exec removal series
Date: Sun, 30 Sep 2007 23:34:36 +0200
Message-ID: <200709302334.37129.johannes.sixt@telecom.at>
References: <1191183001-5368-1-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0709302212160.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 30 23:34:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ic6R5-00080w-4U
	for gcvg-git-2@gmane.org; Sun, 30 Sep 2007 23:34:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752474AbXI3Vek (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Sep 2007 17:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752171AbXI3Vek
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Sep 2007 17:34:40 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:38188 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752519AbXI3Vej (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Sep 2007 17:34:39 -0400
Received: from dx.sixt.local (at00d01-adsl-194-118-045-019.nextranet.at [194.118.45.19])
	by smtp5.srv.eunet.at (Postfix) with ESMTP id B90AD13A83B;
	Sun, 30 Sep 2007 23:34:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 819641226F;
	Sun, 30 Sep 2007 23:34:37 +0200 (CEST)
User-Agent: KMail/1.9.3
In-Reply-To: <Pine.LNX.4.64.0709302212160.28395@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59572>

On Sunday 30 September 2007 23:14, Johannes Schindelin wrote:
> On Sun, 30 Sep 2007, Johannes Sixt wrote:
> > - The fork()s are not followed by exec(). These need a different
> >   implementation. I am thinking of a start_coroutine()/finish_coroutine()
> >   API that is implemented with threads in MinGW. (Suggestions of a better
> >   as well as implementations are welcome.)
>
> Is there more than the case I introduced with shallow clones?

I don't know which one you are refering to.

These cases I hope to be able to treat as "coroutine":

- sideband demultiplexer in builtin-fetch-pack.c
- internal rev-list in upload-pack
- the two-way pipe handling in convert.c and builtin-upload-archive.c

There are probably more in daemon.c and imap-send.c.

BTW, the convert.c case (apply_filter) is most interesting for me, since I 
have a real-world use-case for a clean-filter.

-- Hannes
