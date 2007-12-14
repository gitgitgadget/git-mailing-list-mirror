From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] xdi_diff: trim common trailing lines
Date: Fri, 14 Dec 2007 11:15:40 -0800
Message-ID: <7v8x3xrstf.fsf@gitster.siamese.dyndns.org>
References: <7vve7tuz3a.fsf@gitster.siamese.dyndns.org>
	<7v4pfakr4j.fsf@gitster.siamese.dyndns.org>
	<7vzlwv6sxr.fsf@gitster.siamese.dyndns.org>
	<7vy7ca6ea9.fsf@gitster.siamese.dyndns.org>
	<7vzlwps8zf.fsf@gitster.siamese.dyndns.org>
	<7vejdy4yuw.fsf@gitster.siamese.dyndns.org>
	<7v7ijorwnc.fsf@gitster.siamese.dyndns.org>
	<7vabof5mze.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712122219160.20487@xanadu.home>
	<7vmysez0oa.fsf@gitster.siamese.dyndns.org>
	<20071214090614.GB15610@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 14 20:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3G1D-0005qL-09
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 20:16:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755537AbXLNTPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Dec 2007 14:15:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755439AbXLNTPz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 14:15:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755166AbXLNTPy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 14:15:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 14ACB950A;
	Fri, 14 Dec 2007 14:15:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 810549508;
	Fri, 14 Dec 2007 14:15:42 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68328>

Peter Baumann <waste.manager@gmx.de> writes:

> So you are loosing some values in your trim_common_tail function by
> making ctx only an int. (Not sure that it matters, but I noticed it
> while glancing over your code).

While it is true that this does not matter in practice (because the
context value initially comes from the end user via -U parameter that is
stored in a field of type int in diff_options structure), I agre that it
is the right thing to do to use the same type as underlying xdiff
library uses at the interface level.  From the layering point of view.
xdiff-interface.[ch] are meant to be a thin usability wrapper, it should
not needlessly deviate from how the underlying xdiff operates.
