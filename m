From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: Git string manipulation functions wrong?
Date: Mon, 21 May 2007 16:59:25 +0200
Message-ID: <20070521145925.GA6474@diana.vm.bytemark.co.uk>
References: <20070521131103.GN8200@gateway.home> <20070521143616.GG4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Mouw <mouw@nl.linux.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon May 21 17:00:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq9Mb-00062T-Hb
	for gcvg-git@gmane.org; Mon, 21 May 2007 16:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757356AbXEUO7q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 10:59:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757419AbXEUO7q
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 10:59:46 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1123 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757356AbXEUO7p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 10:59:45 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hq9M5-0001i7-00; Mon, 21 May 2007 15:59:25 +0100
Content-Disposition: inline
In-Reply-To: <20070521143616.GG4489@pasky.or.cz>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48021>

On 2007-05-21 16:36:16 +0200, Petr Baudis wrote:

> It's the opposite for me - we don't properly set the NUL byte for
> smoe of our strncpy() calls, but I don't really see his problem with
> snprintf(), we seem to handle its return value correctly everywhere
> (except diff.c, but there the buffer sizes should be designed in
> such a way that an overflow should be impossible).

I think this kind of detailed case-by-case analysis defeats Timo's
point, though: that the C library functions make it too easy to write
bugs. If it's necessary to do non-trivial bounds checking etc. at
every call site, it doesn't really matter if we currently do get them
all right; at some point, we _are_ going to miss one. Instead of using
our collective C-fu to get difficult calls right, we should be using
it to construct string routines that have low enough overhead that
it's lost in the noise, and are dead simple to use (and, of course,
that can be cleanly bypassed in the 1% of cases where it's necessary).

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
