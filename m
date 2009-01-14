From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 14:27:03 -0800
Message-ID: <7vvdshzfpk.fsf@gitster.siamese.dyndns.org>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
 <1231944876-29930-2-git-send-email-drizzd@aon.at>
 <1231944876-29930-3-git-send-email-drizzd@aon.at>
 <1231944876-29930-4-git-send-email-drizzd@aon.at>
 <7vljtd20m6.fsf@gitster.siamese.dyndns.org>
 <20090114192341.GA26703@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, johannes@familieschneider.info
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 14 23:29:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNEEL-0001Br-QJ
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 23:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754616AbZANW1X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 17:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754621AbZANW1V
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 17:27:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57728 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754510AbZANW1T (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 17:27:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 9C8371C894;
	Wed, 14 Jan 2009 17:27:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 00E0F1C893; Wed,
 14 Jan 2009 17:27:09 -0500 (EST)
In-Reply-To: <20090114192341.GA26703@localhost> (Clemens Buchacher's message
 of "Wed, 14 Jan 2009 20:23:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7F129398-E28A-11DD-A719-2E3B113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105718>

Clemens Buchacher <drizzd@aon.at> writes:

> I think we could at least add an option to disable globbing. Then we can
> also disable the above check conditioned on that. If we allowed globbing
> pattern for following renames wouldn't that result in following the first
> file (or last in history) to match the pattern, which is potentially
> confusing?

Yeah, I agree that would be a reasonable thing to do.  

In places we read paths from the index or from the work tree and add them
as pathspec elements---you would want to mark them as non-globbing, too.
Which probably means that "is it Ok to glob this" setting has to be per
pathspec array elements.
