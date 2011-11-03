From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fsck: print progress
Date: Thu, 03 Nov 2011 13:28:42 -0700
Message-ID: <7v8vnxeyrp.fsf@alter.siamese.dyndns.org>
References: <20111103033325.GA10230@sigill.intra.peff.net>
 <1320310234-11243-1-git-send-email-pclouds@gmail.com>
 <20111103193826.GB19483@sigill.intra.peff.net>
 <7vd3d9f0u8.fsf@alter.siamese.dyndns.org>
 <20111103195147.GA21318@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 03 21:28:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RM3u6-0001eC-OC
	for gcvg-git-2@lo.gmane.org; Thu, 03 Nov 2011 21:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439Ab1KCU2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Nov 2011 16:28:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:32977 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366Ab1KCU2p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2011 16:28:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C564E5D5B;
	Thu,  3 Nov 2011 16:28:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fI1b1+zZ5AzELxBWPVLWm7uLDgY=; b=IGLHJq
	WdISz/GEeFBbMkgSGLFSiC3Hki6fB29Y0NEjacUXloNm788MN38FqeltGvQSLWAU
	Z76Aa7GGMuoVLhzzmyrCzJNbyxGKPbF3/KpquaNdoreEc3LGR2sd4NrM0UD/1qtZ
	gq2E851KFyPm5znAC6+FoOAyv6fHugoZ21BOA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w8ENT48Nu6GAbhMTcOoz1lnrMl0Bo49W
	aQLmL9zoBg3FfiR/SbRkDRzKLqzg4LMDluHSjbHgfEQ79TFE2lwdrmwmpGJohEko
	/PGnfnnvb+qmZTNIOhva+cOXAIs+i0AqWf1BPPiryz6LdaCTkaI3KdaCzivQva4e
	lpju3eoHh80=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA5CE5D5A;
	Thu,  3 Nov 2011 16:28:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E4035D59; Thu,  3 Nov 2011
 16:28:44 -0400 (EDT)
In-Reply-To: <20111103195147.GA21318@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 3 Nov 2011 15:51:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CFF357A-065A-11E1-9232-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184745>

Jeff King <peff@peff.net> writes:

>> Hmm, once you do this kind of thing I would expect two (or more) progress
>> bars to be shown, something like:
>> 
>> 	$ git fsck --progress
>> 	checking packs: 3 of 7 (42% done)
>>      checking objects in pack: 12405 of 332340 (4% done)
>
> I don't think we can do multiple lines portably, though, because the
> progress code just uses "\r" to return to the beginning of the line.

It was meant to be a tongue-in-cheek comment. I personally hate those
"Installing n of N packages / Installation of package n p% done" progress
meters when we know the weight of each of these N packages varies.

I also agree with your "how would you know which one is throughput and
which one is counts" comment, which would mean the particular abstraction
you mentioned is too premature even though it looks nice on the surface.
