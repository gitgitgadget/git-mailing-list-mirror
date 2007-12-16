From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] whitespace: fix initial-indent checking
Date: Sat, 15 Dec 2007 22:54:40 -0500
Message-ID: <20071216035440.GM14377@fieldses.org>
References: <7vodd4fb2f.fsf@gitster.siamese.dyndns.org> <1197776919-16121-1-git-send-email-bfields@citi.umich.edu> <1197776919-16121-2-git-send-email-bfields@citi.umich.edu> <1197776919-16121-3-git-send-email-bfields@citi.umich.edu> <1197776919-16121-4-git-send-email-bfields@citi.umich.edu> <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 16 04:55:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3kap-0004FU-Oq
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 04:55:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759535AbXLPDyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 22:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759446AbXLPDyo
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 22:54:44 -0500
Received: from mail.fieldses.org ([66.93.2.214]:47943 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759416AbXLPDyn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 22:54:43 -0500
Received: from bfields by fieldses.org with local (Exim 4.68)
	(envelope-from <bfields@fieldses.org>)
	id 1J3kaO-0004Nf-5d; Sat, 15 Dec 2007 22:54:40 -0500
Content-Disposition: inline
In-Reply-To: <1197776919-16121-5-git-send-email-bfields@citi.umich.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68438>

On Sat, Dec 15, 2007 at 10:48:37PM -0500, J. Bruce Fields wrote:
> After this patch, "written" counts the number of bytes up to and
> including the most recently seen tab.  This allows us to detect (and
> count) spaces by comparing to "i".
> 
> This allows catching initial indents like '\t        ' (a tab followed
> by 8 spaces), while previously indent-with-non-tab caught only indents
> that consisted entirely of spaces.
> 
> This also allows fixing an indent-with-non-tab regression, so we can
> again detect indents like '\t \t'.
> 
> Also update tests to catch these cases.

One slightly weird thing about this: I'd expect indent-with-non-tab to
catch any sequence of 8 or more contiguous spaces, not just such
sequences at the end of the indent.  This doesn't quite do that.

You could make it do that with a few more lines of code.  But really I
don't think the combination of indent-with-non-tab without
space-before-tab makes any sense.

The only reason I didn't just modify it to turn on the latter whenever
the former is turned on is because I couldn't figure out how to modify
t/t4124-apply-ws-rule.sh to pass.....

But, whatever, that's an extremely minor point.  If people try that
combination who knows what they expect.

--b.
