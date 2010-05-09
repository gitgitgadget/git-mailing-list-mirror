From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC v2 1/4] Add "core.eolStyle" variable to control
	end-of-line conversion
Date: Sun, 9 May 2010 20:18:53 +0200
Message-ID: <20100509181853.GA4676@pvv.org>
References: <cover.1273352819.git.eyvind.bernhardsen@gmail.com> <c8ef28b72709013f17e093954a0f4e2ad1fb9652.1273352819.git.eyvind.bernhardsen@gmail.com> <alpine.LFD.2.00.1005081455450.3711@i5.linux-foundation.org> <E2A9C4D2-010F-44B2-BF6A-627DE8B72FB5@gmail.com> <BFFD3CAC-E7D9-49D8-9B67-C3F5157646F3@gmail.com> <20100509070043.GB14069@dpotapov.dyndns.org> <CD080D38-811C-4BBF-A5CB-6B613555FE72@gmail.com> <7v632x9dfk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	"git@vger.kernel.org List" <git@vger.kernel.org>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	mat <matthieu.stigler@gmail.com>,
	hasen j <hasan.aljudy@gmail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Robert Buck <buck.robert.j@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun May 09 20:19:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBB5k-0003z9-B4
	for gcvg-git-2@lo.gmane.org; Sun, 09 May 2010 20:19:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248Ab0EISS6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 May 2010 14:18:58 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:60754 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751063Ab0EISS5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 May 2010 14:18:57 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OBB5Z-0000xK-JW; Sun, 09 May 2010 20:18:53 +0200
Content-Disposition: inline
In-Reply-To: <7v632x9dfk.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146734>

On Sun, May 09, 2010 at 10:45:35AM -0700, Junio C Hamano wrote:
> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
> > My user interface would have been:
> >
> > - an attribute "eolconv" that enables or disables line ending conversion
> > - a config variable "core.eolconv" that sets "eolconv" for all files where it is unset
> > - a config variable "core.localeol" that decides whether LF or CRLF is preferred
> 
> I am puzzled about this second item; what is its type and what is its
> purpose?  If it is to allow project-wide default to be specified, then
> isn't having "* eolconv=true" in .gitattributes a much better option and
> is already supported by the first item?

The way I understood it core.eolconv has exactly the same possible
values as the "eolconv" attribute, and serves as a default value for
"eolconv" if it isn't set. This would (mostly, I guess) be for Windows
users who would like to check out a project that is primarily
developed on Unix and didn't bother to set any eolconv attributes, and
still get CRLF line endings. core.eolconv has some of the drawbacks
of autocrlf, so shouldn't really be used if you can convince projects
to add eolconv attributes instead.

Are you thinking we could live completely without it? Most other
popular vcs-systems have eol-conversion/normalisation on by default,
while git has it disabled by default. The config variable can change
the default behaviour, but is isn't as helpful as it should have been
perhaps.

To do a better job with old un-normalised repos, we could for each
file remember what their eol-style was (CR, LF, CRLF, mixed), and then
even if doing output conversion on checkout, convert back to the same
eol style on commit. This would perhaps break down a bit for renames,
but would be lovely if it worked for merges for example...

- Finn Arne
