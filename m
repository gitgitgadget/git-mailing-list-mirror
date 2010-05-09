From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
	end-of-line conversion
Date: Sun, 9 May 2010 22:09:37 +0200
Message-ID: <20100509200935.GA22563@pvv.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 09 22:10:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBCp9-0002fz-SJ
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 22:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178Ab0EIUJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 16:09:47 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:33051 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750701Ab0EIUJq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 16:09:46 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OBCoj-0004Z3-UA; Sun, 09 May 2010 22:09:38 +0200
Content-Disposition: inline
In-Reply-To: <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146741>

On Sun, May 09, 2010 at 12:42:17PM +0200, Eyvind Bernhardsen wrote:

> I guess I should nail my flag to the mast: Here's what I would have
> done, with the benefit of plenty of hindsight, had we not had
> core.autocrlf, and also what I think we should do to approach that
> ideal.
> [...]

After some meditation, I think the following:

The most important thing is how we can fix git on Windows to operate
well by default. This is what we really should try to fix.

The way git on Windows would work best, while at the same time cause
the minimum amount of damage, would IMHO be:

- Convert LF-only text files to CRLF on checkout
- Convert those same files (but only those!) back to LF on commit
- Optionally: Convert new CRLF text files to LF on commit

And all this should happen without setting any configuration, and not
setting any attributes.

So maybe, just maybe, we can make everything sufficiently good by
repairing "core.autocrlf = {input,true}" so that git will not convert
a CRLF already in the repo. This would make autocrlf = true a safe
default value (and probably input too, but you'd have to "do
something" to get a new text file with CRLF into the repo then).

Then we go from a situation that didn't work, to a working situation,
and break nothing that used to work. You no longer have to normalise
your repos to work from Windows.

- Finn Arne
