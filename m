From: Pavel Roskin <proski@gnu.org>
Subject: Re: parsecvs and unnamed branches
Date: Fri, 16 Jun 2006 23:12:23 -0400
Message-ID: <1150513943.29738.15.camel@dv>
References: <9e4733910606161444i2f996096sbd1f9b3f3ff3a32d@mail.gmail.com>
	 <1150496362.6983.34.camel@neko.keithp.com>
	 <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Keith Packard <keithp@keithp.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 17 05:12:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrREu-0002VL-46
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 05:12:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbWFQDMk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 23:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbWFQDMj
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 23:12:39 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:12504 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751592AbWFQDMj
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 23:12:39 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FrREk-0002d8-Fo
	for git@vger.kernel.org; Fri, 16 Jun 2006 23:12:38 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FrREW-00024r-1Z; Fri, 16 Jun 2006 23:12:24 -0400
To: Jon Smirl <jonsmirl@gmail.com>
In-Reply-To: <9e4733910606162002x508ec6ccjbc36e4220ca44fd6@mail.gmail.com>
X-Mailer: Evolution 2.7.2.1 (2.7.2.1-4) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21995>

Hi, Jon!

On Fri, 2006-06-16 at 23:02 -0400, Jon Smirl wrote:
> My parsecvs job died after 5 hours of CPU time. Does this tell you anything?
> 
> Pack pack-e28915a5ea09143a9139e84e24534ed888bf1c45 created
> 
> Error: branch cycle
> *** glibc detected *** parsecvs: munmap_chunk(): invalid pointer: 0x0a820198 ***
> *** glibc detected *** parsecvs: corrupted double-linked list: 0x45b1e158 ***

Obviously, memory corruption.  Valgrind is likely to help, but it may
take 50 hours rather than 5.  It may still be worth it.  Make sure to
use the latest version of Valgrind and compile parsecvs without
optimization with full debug information.  If you can get debug info for
libc, install it (on Fedora: "yum install glibc-debuginfo").

> /lib/libc.so.6(__libc_free+0x179)[0x45a554f0]
> parsecvs[0x804dec8]

You see, even some libc symbols can be found, but parsecvs is opaque.
That's why debug information is useful.  Make sure to keep the sources
around for debugging.

-- 
Regards,
Pavel Roskin
