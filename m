From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] whitespace: more accurate initial-indent highlighting
Date: Mon, 17 Dec 2007 00:04:53 -0800
Message-ID: <7vwsrdd9wa.fsf@gitster.siamese.dyndns.org>
References: <B54C9483-90BE-4B45-A3B7-39FACF0E9F62@wincent.com>
	<1197822702-5262-1-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-2-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-3-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-4-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-5-git-send-email-bfields@citi.umich.edu>
	<1197822702-5262-6-git-send-email-bfields@citi.umich.edu>
	<ACA0791E-189F-4E19-AE87-C7D1163C0366@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@citi.umich.edu>,
	Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ayh-0007b4-VR
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 09:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894AbXLQIFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 03:05:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbXLQIFJ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 03:05:09 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59659 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752440AbXLQIFH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 03:05:07 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA0D55E75;
	Mon, 17 Dec 2007 03:05:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5C0E05E74;
	Mon, 17 Dec 2007 03:04:55 -0500 (EST)
In-Reply-To: <ACA0791E-189F-4E19-AE87-C7D1163C0366@wincent.com> (Wincent
	Colaiuta's message of "Mon, 17 Dec 2007 09:00:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68516>

Wincent Colaiuta <win@wincent.com> writes:

> Basically I would have proposed extracting out each type of whitespace  
> error into an inline function in ws.c, where it could be used by both  
> check_and_emit_line() in ws.c and apply_one_fragment() in builtin- 
> apply.c.
>
> Unfortunately, mixing checking and emission phases makes this proposed  
> refactoring a little bit ugly.

The right refactoring would be what JBF hinted in his message, to record
and return a list of suspicious ranges from the checker function and
have the highlighter and the fixer make use of that list.

Such a refactoring is still possible but I think it is beyond the scope
of pre 1.5.4 clean-up.
