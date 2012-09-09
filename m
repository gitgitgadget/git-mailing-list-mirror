From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Sun, 09 Sep 2012 11:15:04 -0700
Message-ID: <7vhar7qd07.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 <7v7gs3sdjx.fsf@alter.siamese.dyndns.org>
 <20120909130532.GA27754@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Philip Oakley <philipoakley@iee.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Sep 09 20:15:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAm2Q-000250-NO
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 20:15:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754240Ab2IISPJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 14:15:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55595 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754050Ab2IISPH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 14:15:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE1F0963D;
	Sun,  9 Sep 2012 14:15:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pnnxdCmlZKbLXufbvXtd5lxLJ24=; b=gsbhzB
	29i9ibtWFTwb63IaGBpU8Aaq/5mYYzdNDRlJNFMCaOhJN++3Y5R/UKanEaRSRYOy
	KZg3M4tBsA1uPDZKYaklcPNYrkytkzvqAGVBqtnIPXGGtrZ9W42hFd4V3YN2djuf
	s2KBTw5tE6S4TysR9j6+rT+1iK0pJlbqZHTAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Rq2G+ehg5sAW8qzEh58Mm6+gB8s8ycJa
	NRbSsY1u4NMoRX1ABVnMaOZ6+FHBqPeZVHYueyDnzDXrSyg9L75i+kTi4S/70i9N
	CQ2S0aAyjn/et5I5mCmi4Lmt1Kep5dWxKwK6mOTxII+l0eiLP14Mryrl0KX2kBKT
	Vi23PWT3nmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F42963C;
	Sun,  9 Sep 2012 14:15:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 373B3963A; Sun,  9 Sep 2012
 14:15:06 -0400 (EDT)
In-Reply-To: <20120909130532.GA27754@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 9 Sep 2012 09:05:33 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 484EE2B2-FAAA-11E1-9E52-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205085>

Jeff King <peff@peff.net> writes:

> On Sun, Sep 09, 2012 at 03:20:18AM -0700, Junio C Hamano wrote:
>
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> 
>> > This patch series depends on the "Add some string_list-related
>> > functions" series that I just submitted.
>> 
>> Makes sense.  The only worry (without reading the series first) I
>> have is that the use of string list may make the responsiblity of
>> sorting the list fuzzier. I am guessing that we never sorted the
>> refs we asked to fetch (so that FETCH_HEAD comes out in an expected
>> order), so use of unsorted string list would be perfectly fine.
>
> I haven't read the series yet, but both the list of heads from the user
> and the list of heads from the remote should have been sorted by 4435968
> and 9e8e704f, respectively.

OK.  As long as the sort order matches the order string-list
internally uses for its bisection search, it won't be a problem,
then.

Thanks.
