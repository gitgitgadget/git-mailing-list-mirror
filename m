From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Wed, 09 Jan 2008 15:49:46 -0800
Message-ID: <7vprwaeezp.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	<7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
	<47855765.9090001@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 00:50:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCkgn-0005VL-Ka
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 00:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755845AbYAIXuA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 18:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754296AbYAIXuA
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 18:50:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:47588 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752818AbYAIXt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 18:49:59 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7092B28B6;
	Wed,  9 Jan 2008 18:49:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6E028B5;
	Wed,  9 Jan 2008 18:49:52 -0500 (EST)
In-Reply-To: <47855765.9090001@vilain.net> (Sam Vilain's message of "Thu, 10
	Jan 2008 12:23:17 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70028>

Sam Vilain <sam@vilain.net> writes:

> I think to go forward this would need a prototype and benchmark figures
> for things like "annotate" and "fsck --full" - but bear in mind it would
> be a long road to follow-up to completion, as repository compatibility
> would need to be a primary concern and this essentially would create a
> new pack type AND a new *object* type.  Not only that, but currently
> there is no header in the objects on disk which can be used to detect a
> gzip vs. an lzop stream.  Not really worth it IMHO - gzip is already
> fast enough on even the most modern processor these days.

For the compression type detection, I was hoping that we could
do something like sha1_file.c::legacy_loose_object(), but I tend
to agree it is not probably worth it.
