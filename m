From: Junio C Hamano <gitster@pobox.com>
Subject: Re: FLEX_ARRAY=1 causes SIGSEGV on SPARC
Date: Mon, 17 Dec 2007 17:08:44 -0800
Message-ID: <7vtzmg3j37.fsf@gitster.siamese.dyndns.org>
References: <20071218010126.GP14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 02:09:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Qxf-00022p-1U
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 02:09:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbXLRBJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 20:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751944AbXLRBJE
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 20:09:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901AbXLRBJD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 20:09:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A67DC4D25;
	Mon, 17 Dec 2007 20:08:56 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 407B04D23;
	Mon, 17 Dec 2007 20:08:52 -0500 (EST)
In-Reply-To: <20071218010126.GP14735@spearce.org> (Shawn O. Pearce's message
	of "Mon, 17 Dec 2007 20:01:26 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68681>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I'll try to track it down tomorrow.  But the immediate workaround was
> to just add '-DFLEX_ARRAY=/* empty */' to my CFLAGS and recompile
> the world.  This compiler accepts the empty FLEX_ARRAY macro but
> I'm not sure what feature test(s) would be necessary to make Git
> able to automatically set that, seeing as how the tests defined in
> 8e97 are perfectly reasonable and didn't pass.
> ..., but will try to come up with a reasonable
> detection patch....

Actually I would be more worried about the breakage in FLEX_ARRAY=1 case
than misdetection.  Even if your compiler supports the flexible array
members, the fallback to FLEX_ARRAY=1 ought to work and you are seeing a
case where it doesn't.
