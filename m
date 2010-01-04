From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Mon, 4 Jan 2010 02:26:59 -0500
Message-ID: <20100104072659.GA10611@coredump.intra.peff.net>
References: <7v7hs09tpi.fsf@alter.siamese.dyndns.org>
 <87ljgfgbl0.fsf@catnip.gol.com>
 <fc339e4a1001021847hf1e1a7fq894de7908839ff77@mail.gmail.com>
 <877hrzga16.fsf@catnip.gol.com>
 <alpine.LFD.2.00.1001031124420.3630@localhost.localdomain>
 <7v3a2mzzg4.fsf@alter.siamese.dyndns.org>
 <20100104053125.GA5083@coredump.intra.peff.net>
 <7vbphaquwl.fsf@alter.siamese.dyndns.org>
 <20100104064408.GA7785@coredump.intra.peff.net>
 <7vhbr2pcsh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 04 08:27:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NRhLO-0007BS-La
	for gcvg-git-2@lo.gmane.org; Mon, 04 Jan 2010 08:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752990Ab0ADH1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2010 02:27:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923Ab0ADH1G
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jan 2010 02:27:06 -0500
Received: from peff.net ([208.65.91.99]:45608 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785Ab0ADH1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2010 02:27:05 -0500
Received: (qmail 13069 invoked by uid 107); 4 Jan 2010 07:31:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 04 Jan 2010 02:31:47 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2010 02:26:59 -0500
Content-Disposition: inline
In-Reply-To: <7vhbr2pcsh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136100>

On Sun, Jan 03, 2010 at 11:08:46PM -0800, Junio C Hamano wrote:

> > I have to wonder, though...did anybody ever actually profile our
> > internal grep to find out _why_ it was so much slower than GNU grep?
> 
> I vaguely recall that somebody fairly competent mentioned that modern grep
> implementations are based on DFA engines, but I offhand don't remember if
> the discussion had concrete numbers.

Probably this:

  http://article.gmane.org/gmane.comp.version-control.git/41685

Also of interest is:

  http://article.gmane.org/gmane.comp.version-control.git/50174

The pcre analysis there came from just using the "pcreposix" header, I
think. From my limited research, modern pcre may have some tuning
options (including a DFA engine!) that could do a lot better.

-Peff
