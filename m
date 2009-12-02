From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Tue, 01 Dec 2009 22:35:58 -0800
Message-ID: <7vy6llnar5.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Wed Dec 02 07:36:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFiov-0000T0-Oe
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 07:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752046AbZLBGgB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 01:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbZLBGgA
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 01:36:00 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751048AbZLBGgA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 01:36:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7D27BA3FD9;
	Wed,  2 Dec 2009 01:36:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=Bv2ueh3OzkoxQsmyzvBKzQDmvVg=; b=C8c8ZZ
	4iVAuEEdmla4IAPDhdwdIxP0ql4kdxOLl+aunpucxGIA4rM4hd71kMVhxfXriAVs
	pvtuSLpLOgr3imHOwHT/Ap5Rv06QdrzvvowLXu0vgNGObfwKlS/ivf4IxmXJYOse
	jtbV8b+nKJs0eOWTIZB/YWEcotQnRQFnm2Q1k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kjotbx9Djz7ntUKfR7CthQqTlycauri3
	YldZNl5uuqhTiVUI0jDwrkgZLVTsPhi9S0YV6AOevMz/xFqqLOQofJAU9mTM+sFt
	/5pYkpDL7rrdNgT+O96TLWeG3LUQWvRlvEtW7P40eGNsev+QRyMhpcQOQLI29aPH
	2VTekQ3LP9c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B5FEA3FD7;
	Wed,  2 Dec 2009 01:36:04 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1719DA3FD4; Wed,  2 Dec 2009
 01:35:59 -0500 (EST)
In-Reply-To: <20091202055632.GD31244@Knoppix> (Ilari Liusvaara's message of
 "Wed\, 2 Dec 2009 07\:56\:32 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F6F13DFE-DF0C-11DE-96BB-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134305>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> On Tue, Dec 01, 2009 at 12:42:29PM -0800, Junio C Hamano wrote:
>> 
>> It is somewhat unfortunate that a few changes I liked (e.g. the "debug"
>> bit), even though it was somewhat painful to read them due to coding style
>> differences, were not at the beginning of the series but instead buried
>> after changes that are much bigger and controversial (e.g. [6/8]).
>
> Funny, I considered some other stuff in series much more controversial than
> the 6/8 one.

I didn't mean the line count by "large".  I was referring to the size of
change at the conceptual level.  As Daniel already explained, it has been
one of the design assumption so far that there are built-in mappings from
some common <scheme>:// to backend "helpers".

I am _not_ saying that that particular design assumption must be cast in
stone (nothing is)---that is a totally different matter to be debated.
But the fact that it needs to be debated means it is not "a trivial 8-line
reduction", but rather a large conceptual change (perhaps improvement).
