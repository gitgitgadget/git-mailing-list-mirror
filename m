From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git and Amazon S3
Date: Tue, 2 Feb 2010 20:44:55 +0100
Message-ID: <20100202194455.GO9553@machine.or.cz>
References: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aneurin Price <aneurin.price@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 20:45:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcOgJ-0001Uz-FJ
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 20:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755113Ab0BBTo6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 14:44:58 -0500
Received: from w241.dkm.cz ([62.24.88.241]:55748 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744Ab0BBTo6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 14:44:58 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id 7372886208C; Tue,  2 Feb 2010 20:44:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <501db8661002020556k2f65add2rf06b289f2c9cbcac@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138744>

On Tue, Feb 02, 2010 at 01:56:41PM +0000, Aneurin Price wrote:
> Does anyone have any remarks about these options? Is there a better option - how
> difficult would it be to add native support to git?

  I'm not really familiar with Amazon S3 _or_ the current transport
code, but by cursory examination of both, it seems that it would be
fairly easy to add support for another transfer. And it might be even
better idea to actually just add generic support to invoke an external
helper to perform all the heavy lifting.

  Basically, all the abstraction is already pre-cooked in the form of
rsync protocol support. I would just cut'n'paste that and replace rsync
magic with simple calls to external helper along some sensible simple
API, then code up an easy wrapper for S3 there. Or just add S3 API
support directly to core Git - it doesn't seem to be licence-encumbered.
Should take just a couple of hours including debugging, if you just
copy the existing rsync support functions.

  Another idea might be to actually use the rsync protocol support
itself. ;-) There seems to be some sort of commercial rsync-S3 interface,
though I can't tell from their terribly strange pricing policy how
expensive it is to use it in practice.

-- 
				Petr "Pasky" Baudis
If you can't see the value in jet powered ants you should turn in
your nerd card. -- Dunbal (464142)
