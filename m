From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log vs git diff vs --name-status
Date: Thu, 23 Aug 2007 02:33:38 -0700
Message-ID: <7vr6lutx1p.fsf@gitster.siamese.dyndns.org>
References: <20070823084315.GA31174@genesis.frugalware.org>
	<20070823084512.GB31174@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: VMiklos <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 11:34:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO94h-0006TJ-B7
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 11:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759765AbXHWJdn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Aug 2007 05:33:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759754AbXHWJdn
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Aug 2007 05:33:43 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:58503 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759293AbXHWJdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2007 05:33:42 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A6253126930;
	Thu, 23 Aug 2007 05:34:02 -0400 (EDT)
In-Reply-To: <20070823084512.GB31174@genesis.frugalware.org>
	(vmiklos@frugalware.org's message of "Thu, 23 Aug 2007 10:45:12
	+0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56484>

VMiklos <vmiklos@frugalware.org> writes:

> Na Thu, Aug 23, 2007 at 10:43:15AM +0200, VMiklos <vmiklos@frugalware.org> pisal(a):
>> M       dir
>
> sorry, i needed the -r option

I know.

I've been debating myself if --name-status should imply -r
(recursive behaviour) for "git log".  More specifically, I think
a reasonable guiding principles would be something like:

 * Anything that looks at the file contents level change (that
   is, -p, --stat and --numstat) should always imply recursive;

 * Anything that is Porcelain should always imply recursive.

I am fairly certain about the first one, but not absolutely sure
about the latter.  The first principle does not justify making
your example to recurse, but the second, if we accept it, would.
