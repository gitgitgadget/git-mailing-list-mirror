From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH 1/4] Refactoring: remove duplicated code from
 transport.c and builtin-send-pack.c
Date: Mon, 15 Feb 2010 10:46:43 +0200
Message-ID: <20100215084643.GA26012@Knoppix>
References: <1266182863-5048-1-git-send-email-michael.lukashov@gmail.com>
 <20100215052853.GJ3336@coredump.intra.peff.net>
 <7v7hqfknwz.fsf@alter.siamese.dyndns.org>
 <20100215075514.GB5347@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Lukashov <michael.lukashov@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:50:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgweA-0004M8-Di
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 09:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0BOIqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 03:46:52 -0500
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:59616 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750750Ab0BOIqv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 03:46:51 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh04-2.mail.saunalahti.fi (Postfix) with SMTP id A878D13BEE3;
	Mon, 15 Feb 2010 10:46:50 +0200 (EET)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A074B99B994; Mon, 15 Feb 2010 10:46:50 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh07.mail.saunalahti.fi (Postfix) with ESMTP id EB0C11C6395;
	Mon, 15 Feb 2010 10:46:43 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100215075514.GB5347@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140001>

On Mon, Feb 15, 2010 at 02:55:15AM -0500, Jeff King wrote:
> On Sun, Feb 14, 2010 at 10:34:20PM -0800, Junio C Hamano wrote:
> 
> Actually, I wonder if we can simply get rid of some of the calls in
> send-pack. I think that the code in send-pack isn't even called anymore
> via "git push"; it only gets called when you call send-pack directly.

Actually, its also seemingly called by git-remote-http(s) (at least it
contains references to "stateless RPC", which is related to smart HTTP).

> And arguably send-pack as plumbing shouldn't be generating all sorts of
> user-facing output. But it is a behavior change. I wonder if anybody
> actually calls send-pack directly anymore. It seems like even scripts
> use "git push" because of the transport agnosticism.

For non-stateless case, it seems that the only protocols builtin-send-pack
can deal with are ssh://, git:// and file://, it can't deal with any
sort of remote helper, not even one provoding smart transport.

-Ilari
