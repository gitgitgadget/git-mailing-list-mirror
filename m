From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add --no-rename to git-apply
Date: Thu, 27 Sep 2007 11:24:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709271107530.28395@racer.site>
References: <11908420041596-git-send-email-robin.rosenberg@dewire.com>
 <7vbqbozo7t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 12:29:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iaqcp-0002Ky-31
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 12:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753629AbXI0K1E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 06:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752196AbXI0K1D
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 06:27:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:48638 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751043AbXI0K1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 06:27:00 -0400
Received: (qmail invoked by alias); 27 Sep 2007 10:26:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp047) with SMTP; 27 Sep 2007 12:26:58 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+DwcU+eTmDtYdSiZ/32q0IU8HFL3gMlntvqpXmJ4
	CfyUmztW/ACYkO
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbqbozo7t.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59281>

Hi,

On Wed, 26 Sep 2007, Junio C Hamano wrote:

> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
> 
> > With this option git-apply can apply a patch with a rename
> > onto the original file(s).
> 
> This is troubling from both design and implementation point of
> view.
> 
>  * Why would this be useful?  What's the point of producing the
>    renaming patch if you know you would want to apply while
>    ignoring the rename?

Robin said in a follow-up mail that he needs it for a payed-for SCM 
(let's describe it as TransparentBox here), which insists on explicit 
renames.

But I suggest a simple script here which extracts from the diff the 
renames, which outputs a script which renames the file(s) back and then 
uses the TransparentBox' mv command:

sed -n -e "/^rename from/N" \
  -e "s/^rename from \(.*\)\nrename to \(.*\)/mv \2 \1 \&\& tb mv \1 \2/p" \
  < diff.patch

Ciao,
Dscho
