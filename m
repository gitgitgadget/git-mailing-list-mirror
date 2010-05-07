From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH/RFC 0/3] Per-repository end-of-line normalization
Date: Fri, 7 May 2010 21:41:40 +0200
Message-ID: <20100507194140.GC7963@pvv.org>
References: <x2s40aa078e1005061340vaf404ab3g30b2b98ca408205@mail.gmail.com> <cover.1273183206.git.eyvind.bernhardsen@gmail.com> <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, hasan.aljudy@gmail.com,
	kusmabite@googlemail.com, torvalds@linux-foundation.org,
	prohaska@zib.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 07 22:02:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OATkb-0004Pe-VF
	for gcvg-git-2@lo.gmane.org; Fri, 07 May 2010 22:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab0EGUCQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 May 2010 16:02:16 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:59389 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756943Ab0EGUCQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 May 2010 16:02:16 -0400
X-Greylist: delayed 1228 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 May 2010 16:02:15 EDT
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1OATQa-0002Tt-7e; Fri, 07 May 2010 21:41:40 +0200
Content-Disposition: inline
In-Reply-To: <7v4oijhdsi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146577>

On Fri, May 07, 2010 at 09:33:49AM -0700, Junio C Hamano wrote:
> Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> writes:
> 
> > - An attribute called "auto-eol" is set in the repository to turn on
> >   normalization of line endings.  Since attributes are content, the
> >   setting is copied when the repository is cloned and can be changed in
> >   an existing repository (with a few caveats).  Setting this attribute
> >   is equivalent to setting "core.autocrlf" to "input" or "true".
> 
> In what way is this attribute different from existing "crlf" attribute?

The crlf attribute says whether to enable autocrlf functionality for a
file, but that is not what is really wanted. auto-eol instead says how
line endings should be stored in the repository. Also, auto-eol will
only affect files auto-detected as text (or forced to be treated as
text by the crlf attribute) it seems.

> This may be a worthy goal.  But if a "auto-eol" attribute "fixes"
> this, perhaps "crlf" attribute can be taught to fix it the same way,
> no?

Maybe it is sufficient to add a new value to "crlf" that means:

- If the file is autodetected as text:
  - Convert to LF only on commit, and
  - Convert to your preferred EOL style on checkout.

I don't think autocrlf is a good place to specify preferred EOL
style, it is too dangerous to set autocrlf to true by default, but it should
not be dangerous to say that your preferred EOL style is CRLF.

- Finn Arne
