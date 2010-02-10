From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Suggestion on git-push --porcelain
Date: Wed, 10 Feb 2010 11:14:41 -0800
Message-ID: <7vaavgaony.fsf@alter.siamese.dyndns.org>
References: <be6fef0d1002091834i1c4b202cp5afacc326bd1a4d6@mail.gmail.com>
 <7vmxzhn6fp.fsf@alter.siamese.dyndns.org>
 <be6fef0d1002100318v902689xc937cd332ac752b3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	"Larry D'Anna" <larry@elder-gods.org>, Jeff King <peff@peff.net>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 20:15:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfI1a-0005dH-Gf
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 20:14:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995Ab0BJTOx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 14:14:53 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:57580 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751131Ab0BJTOw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 14:14:52 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E341D988D3;
	Wed, 10 Feb 2010 14:14:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Orfe7i8iBgTQ4kNUbIB4YG0cZyQ=; b=Aw53WG
	84FzkTTGqOkqB1jM7MWbwSu2ioOs2nd+AaFR2SBdfBNsdWiZtTeqVjZw0ADOlhUF
	yn+HbLMuD+bUFRSl/SKTrLC4VyYBPOUOU9HIvltHFHiGL7ObZt4mTaKmRCmyk3Ka
	Nq3/Bf/MLnP73ERRaYIePExJFE5pj+vz8nmYo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ekqm064XOCRYcrfX9FRLPQG/z+H1HrE6
	viZnAENG5DgQvSYY+ygMYDwgw1j+Fm7K3Swy5+PIMxqR068N2F0vfEL4frtlIOh7
	Pt14n8j/hB2EOZCgnOMOIDNw1NO2namI3iDJ4jfznjFVwLKBak9X5Pd8/L2AA6aT
	eoR3frV2qwE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B4E8988D2;
	Wed, 10 Feb 2010 14:14:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1D0C988D1; Wed, 10 Feb
 2010 14:14:42 -0500 (EST)
In-Reply-To: <be6fef0d1002100318v902689xc937cd332ac752b3@mail.gmail.com> (Tay
 Ray Chuan's message of "Wed\, 10 Feb 2010 19\:18\:32 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 8DD7DA6E-1678-11DF-AE38-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139534>

Tay Ray Chuan <rctay89@gmail.com> writes:

> I sense a chicken-and-egg situation here.
>
> Printing a "To: <destination>" to stdout is a correction as far as the
> current non-prefixed output scheme is concerned.
>
> If a prefixed scheme (or some other output scheme) is adopted, then
> where, or whether, the "To: <destination>" is printed, is not relevant
> to porcelain script writers - they just get ignored.

Sorry.  I don't get this.  Are you saying that you will write "To" without
the prefix in order to make older scripts ignore it?  What then would newer
scripts that want to use the information do?  Pay attention to lines that
do not start with your prefix?  Then what good does it do to introduce
such a prefix to the output?

I think what you need is not a prefix or any syntax but a rule that says
"ignore things that you do not understand" and possibly a way for the
output stream to say "if you do not understand this, you are too old to
correctly process this stream---please abort, because ignoring this will
make you produce an incorrect result".
