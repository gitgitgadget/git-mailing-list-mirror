From: David Kastrup <dak@gnu.org>
Subject: Re: If you would write git from scratch now, what would you change?
Date: Mon, 26 Nov 2007 18:11:43 +0100
Message-ID: <858x4l2apc.fsf@lola.goethe.zz>
References: <200711252248.27904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 26 18:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwhVN-00082q-3E
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 18:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755929AbXKZRMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Nov 2007 12:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755819AbXKZRMA
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Nov 2007 12:12:00 -0500
Received: from mail-in-07.arcor-online.net ([151.189.21.47]:51984 "EHLO
	mail-in-07.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755496AbXKZRL7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Nov 2007 12:11:59 -0500
Received: from mail-in-15-z2.arcor-online.net (mail-in-15-z2.arcor-online.net [151.189.8.32])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id A935024B065;
	Mon, 26 Nov 2007 18:11:57 +0100 (CET)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-15-z2.arcor-online.net (Postfix) with ESMTP id 86AA07240D2;
	Mon, 26 Nov 2007 18:11:50 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-029-090.pools.arcor-ip.net [84.61.29.90])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 1BA6429D4E2;
	Mon, 26 Nov 2007 18:11:35 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 7DE401C4D3AA; Mon, 26 Nov 2007 18:11:44 +0100 (CET)
In-Reply-To: <200711252248.27904.jnareb@gmail.com> (Jakub Narebski's message
	of "Sun, 25 Nov 2007 22:48:27 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4926/Mon Nov 26 14:21:22 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66086>

Jakub Narebski <jnareb@gmail.com> writes:

> If you would write git from scratch now, from the beginning, without
> concerns for backwards compatibility, what would you change, or what
> would you want to have changed?

Get rid of plumbing at the command line level.  It is confusing to
users, and command line arguments, exec calls and I/O streams are not
efficient and reasonably typed mechanisms for the kind of operations
done in plumbing.  Instead using a good extensible portable scripting
language (I consider Lua quite suitable in that regard, but it is
conceivable that something with a native list type supporting easy
sorts, merges and selections could be more efficient) and implementing
plumbing in that or in C would have been preferable for creating the
porcelain.

That would keep plumbing out of the hair of users and make it easier to
cobble together extensions and variations with non-trivial internal
dataflow.

Shell scripts have also proven to be a constant hassle with regard to
portability and bugs (like underquoting).

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
