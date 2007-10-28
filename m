From: Florian Weimer <fw@deneb.enyo.de>
Subject: Re: [RFH] gcc constant expression warning...
Date: Sun, 28 Oct 2007 11:21:32 +0100
Message-ID: <87ir4rletv.fsf@mid.deneb.enyo.de>
References: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 28 11:21:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im5HG-0008Hx-L0
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 11:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbXJ1KVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 06:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXJ1KVj
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 06:21:39 -0400
Received: from mail.enyo.de ([212.9.189.167]:2939 "EHLO mail.enyo.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751004AbXJ1KVi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 06:21:38 -0400
Received: from deneb.vpn.enyo.de ([212.9.189.177] helo=deneb.enyo.de)
	by mail.enyo.de with esmtp id 1Im5Gw-0005Sq-AW
	for git@vger.kernel.org; Sun, 28 Oct 2007 11:21:34 +0100
Received: from fw by deneb.enyo.de with local (Exim 4.68)
	(envelope-from <fw@deneb.enyo.de>)
	id 1Im5Gu-0002Rg-DB
	for git@vger.kernel.org; Sun, 28 Oct 2007 11:21:32 +0100
In-Reply-To: <7vy7dnvd6w.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sun, 28 Oct 2007 01:46:47 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62550>

* Junio C. Hamano:

> The offending lines are:
>
>         if (idx_size != min_size) {
>                 /* make sure we can deal with large pack offsets */
>                 off_t x = 0x7fffffffUL, y = 0xffffffffUL;
>                 if (x > (x + 1) || y > (y + 1)) {
>                         munmap(idx_map, idx_size);

x and y must be unsigned for this test to work (signed overflow is
undefined).
