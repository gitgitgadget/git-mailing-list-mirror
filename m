From: Paul Jackson <pj@sgi.com>
Subject: Re: Storing permissions
Date: Sat, 16 Apr 2005 18:30:23 -0700
Organization: SGI
Message-ID: <20050416183023.0b27b3a4.pj@sgi.com>
References: <20050416230058.GA10983@ucw.cz>
	<118833cc05041618017fb32a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: mj@ucw.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 03:27:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMyZ5-00035q-Q7
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 03:27:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVDQBas (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 21:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261237AbVDQBas
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 21:30:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:53914 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261236AbVDQBam (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 21:30:42 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3H1s28x031964;
	Sat, 16 Apr 2005 18:54:05 -0700
Received: from vpn2 (mtv-vpn-hw-pj-2.corp.sgi.com [134.15.25.219])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with SMTP id j3H1USlU15263939;
	Sat, 16 Apr 2005 18:30:30 -0700 (PDT)
To: Morten Welinder <mwelinder@gmail.com>
In-Reply-To: <118833cc05041618017fb32a2@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Morten wrote:
> It makes some sense in principle, but without storing what they mean
> (i.e., group==?) it certainly makes no sense. 

There's no "they" there.

I think Martin's proposal, to which I agreed, was to store a _single_
bit.  If any of the execute permissions of the incoming file are set,
then the bit is stored ON, else it is stored OFF.  On 'checkout', if the
bit is ON, then the file permission is set mode 0777 (modulo umask),
else it is set mode 0666 (modulo umask).

You might disagree that this is a good idea, but it certainly does
'make sense' (as in 'is sensibly well defined').

> I suspect a non-readable file would cause a bit of a problem in the low-level
> commands.

Probably so.  If someone sets their umask 0333 or less, then they are
either fools or QA (software quality assurance, or test) engineers.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@engr.sgi.com> 1.650.933.1373, 1.925.600.0401
