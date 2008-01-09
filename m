From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Decompression speed: zip vs lzo
Date: Wed, 09 Jan 2008 14:55:44 -0800
Message-ID: <7v4pdmfw27.fsf@gitster.siamese.dyndns.org>
References: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 09 23:56:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCjqP-0003qx-L9
	for gcvg-git-2@gmane.org; Wed, 09 Jan 2008 23:56:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555AbYAIWzx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jan 2008 17:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752942AbYAIWzx
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jan 2008 17:55:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751026AbYAIWzw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jan 2008 17:55:52 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 663854E21;
	Wed,  9 Jan 2008 17:55:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id DF4734E20;
	Wed,  9 Jan 2008 17:55:46 -0500 (EST)
In-Reply-To: <e5bfff550801091401y753ea883p8d08b01f2b391147@mail.gmail.com>
	(Marco Costalba's message of "Wed, 9 Jan 2008 23:01:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70023>

"Marco Costalba" <mcostalba@gmail.com> writes:

> P.S: Compression size is better for zip but a more realistic test
> would be to try with a delta packaged repo instead of a simple tar of
> source files. Because delta packaged is already compressed in his way
> perhaps difference in final file sizes is smaller.

Note that the space nor time performance of compressing and
uncompressing a single huge blob is not as interesting in the
context of git as compressing/uncompressing millions of small
pieces whose total size is comparable to the specimen of "huge
single blob" experiment.  Obviously loose object files are
compressed individually, and packfile contents are also
individually and independently compressed.  Set-up cost for
individual invocation of compression and uncompression on
smaller data matters a lot more than an experiment on
compressing and uncompressiong a single huge blob (this applies
to both time and space).
