From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v1 3/6] cleanup of write_entry() in entry.c
Date: Wed, 28 Jan 2009 13:31:54 -0800
Message-ID: <7vy6wvkth1.fsf@gitster.siamese.dyndns.org>
References: <1233004637-15112-1-git-send-email-barvik@broadpark.no>
 <1233004637-15112-4-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Wed Jan 28 22:33:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSI2I-0003oZ-PI
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 22:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752914AbZA1VcB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 16:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZA1VcA
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 16:32:00 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783AbZA1Vb7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 16:31:59 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id F2C6E1D80B;
	Wed, 28 Jan 2009 16:31:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 435DC1D800; Wed,
 28 Jan 2009 16:31:56 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 17FB05C4-ED83-11DD-9097-0372113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107580>

Kjetil Barvik <barvik@broadpark.no> writes:

> The switch-cases for S_IFREG and S_IFLNK was so similar that it will
> be better to do some cleanup and use the common parts of it.
>
> Also fold the longest lines such that no line is longer then 80 chars
> or so.
>
> And the entry.c file should now be clean for 'gcc -Wextra' warnings.
>
> Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
> ---
>
> If people do not like this approach I can be willing to drop it from
> this patch-series, but then I get some source code duplication from
> the next patch (4/6).

Merging of the two similar codepaths looked good from a cursory reading,
but if you have doubts about one patch, it usually is easier for other
people to work with you if the series is reordered to have it near the
end, iow, undisputably good ones first.

> -			return error("git checkout-index: unable to read sha1 file of %s (%s)",
> -				path, sha1_to_hex(ce->sha1));
> +			return error("git checkout-index: "\
> +				     "unable to read sha1 file of %s (%s)",
> +				     path, sha1_to_hex(ce->sha1));

You lost greppability when somebody calls for help saying "I am getting an
error message that says 'git checkout-index: unable to read sha1 file'".
