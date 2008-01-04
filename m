From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-diff-* --color oddness
Date: Fri, 04 Jan 2008 00:26:55 -0800
Message-ID: <7vabnmm1ww.fsf@gitster.siamese.dyndns.org>
References: <20080104081429.GA30635@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, win@wincent.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 04 09:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAhtx-0006BV-HY
	for gcvg-git-2@gmane.org; Fri, 04 Jan 2008 09:27:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376AbYADI1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 03:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752577AbYADI1J
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 03:27:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49033 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751426AbYADI1H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 03:27:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 11AE64CC6;
	Fri,  4 Jan 2008 03:27:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 92FEA4CC5;
	Fri,  4 Jan 2008 03:27:02 -0500 (EST)
In-Reply-To: <20080104081429.GA30635@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 4 Jan 2008 03:14:29 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69557>

Jeff King <peff@peff.net> writes:

> The first two lines of meta-info will be in the stock colors, but
> everything after will be in the custom colors. So we are actually
> reading the diff_ui options _during_ the diff. The culprit is
> funcname_pattern, which calls read_config_if_needed.

Yuck.  Why is funcname_pattern do ui-config stuff?  I know it
wants to get custom regexp crap, but that should belong to the
plumbing part, not Porcelain-only thing, shouldn't it?
