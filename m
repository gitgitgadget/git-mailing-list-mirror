From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sun, 16 Dec 2007 16:19:44 -0500
Message-ID: <20071216211944.GA25178@fieldses.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <1197776919-16121-1-git-send-email-bfields@citi.umich.edu> <1197776919-16121-2-git-send-email-bfields@citi.umich.edu> <1197776919-16121-3-git-send-email-bfields@citi.umich.edu> <1197776919-16121-4-git-send-email-bfields@citi.umich.edu> <1197776919-16121-5-git-send-email-bfields@citi.umich.edu> <20071216035440.GM14377@fieldses.org> <7vodcqjrtw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 22:20:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J40uB-00023A-Sy
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 22:20:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760321AbXLPVTr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 16:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760315AbXLPVTr
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 16:19:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:37980 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757829AbXLPVTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 16:19:46 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J40tk-0006lF-Eo; Sun, 16 Dec 2007 16:19:44 -0500
Content-Disposition: inline
In-Reply-To: <7vodcqjrtw.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68490>

On Sun, Dec 16, 2007 at 12:40:59PM -0800, Junio C Hamano wrote:
> "J. Bruce Fields" <bfields@fieldses.org> writes:
> 
> > One slightly weird thing about this: I'd expect indent-with-non-tab to
> > catch any sequence of 8 or more contiguous spaces, not just such
> > sequences at the end of the indent.  This doesn't quite do that.
> 
> +-------+-------+-------+-------+-------+-------+-------+-------+-------+
> Personally, I would hate that.  That would muck with two spaces I
> deliberately typed after the full stop before this sentence).  Please
> don't.

Right, I was only thinking of literal sequences of 8 contiguous spaces,
and only in the initial indent.  So it's the failure to flag

	"^\t         \t"

that I find a little unexpected.  Whatever--I don't think it's
particularly important.  Like I say, I think there's really only two
cases anyone really cares about:

	1. The kernel or git style, where all initial whitespace is
	tabbed as much as possible.
	2. Various other styles which may be harder to check completely,
	but which are likely to share the "no spaces before tabs in
	initial indent" rule as a least common denominator.

> Emacs "M-x tabify" tends to do this and I found it unsuitable especially
> for code (I am not complaining, it probably was invented for other
> purposes and not reformatting code):
> 
> If you have original (the run of '>>..>>' is a single tab, '.' is a SP)
> 
>         dcba....123
>         fedcba..123
>         gfedcba.123
> 
> and "tabify" the region, you would get:
> 
>         dcba>>>>123
>         fedcba>>123
>         gfedcba.123
> 
> That is fine if you are shooting for minimum number of bytes, but often
> it is not what you want in your code, especially when the part that
> conains the whitespace "..cba 123.." is inside a string constant.

Yeah, that sounds pretty irritating.

--b.
