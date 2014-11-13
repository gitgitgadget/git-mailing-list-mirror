From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git archiving only branch work
Date: Thu, 13 Nov 2014 13:36:48 -0800
Message-ID: <xmqqa93uzssv.fsf@gitster.dls.corp.google.com>
References: <5464a4e8.4a0.2bfa0e00.3067f800@geldenhuys.co.uk>
	<20141113133615.GA28346@lanh> <20141113200640.GB3869@peff.net>
	<xmqqvbmizu12.fsf@gitster.dls.corp.google.com>
	<20141113213318.GA7563@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	Graeme Geldenhuys <mailinglists@geldenhuys.co.uk>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 22:37:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp24Y-0005dX-Ti
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 22:36:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934616AbaKMVgy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 16:36:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934308AbaKMVgv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 16:36:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9BC381DAFF;
	Thu, 13 Nov 2014 16:36:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YmXPpC0luzfUZOrBy6Ys/nqlp7Y=; b=xKh7z/
	462B3j7Mt7M7SGxVcdnkXNgJAXEPbR7Nm1xpeTKk6eL9K9SMkgB9iDifBKDfwsch
	V0aacs40swfxHSyJ79NnW/U2X1k6wGOM1PPmpALDXGct0tFhkhnl1JrP3iG8wAPx
	MOqCdFPSRbgVASy5hTjHBIXQYyeNpLSFBsfv8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WAdpIqFH1e89th55ujfwVuyzE8TnDKDh
	mwMv04AJuKUqEW3qTfZkSeW/SfVrWpDhHWO43apgV2fm9m+ol8radgzXF0Hdf16I
	R6siF5jO5o4lBwtKbMZ9MTu9rDVw/5Bk6GU+paNVPn7+PcmDlz7PP0xRZMKrGYrT
	aRPZRnshZXM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 923D01DAF3;
	Thu, 13 Nov 2014 16:36:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 058101DAF1;
	Thu, 13 Nov 2014 16:36:49 -0500 (EST)
In-Reply-To: <20141113213318.GA7563@peff.net> (Jeff King's message of "Thu, 13
	Nov 2014 16:33:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2D235202-6B7D-11E4-8F85-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 13, 2014 at 01:10:17PM -0800, Junio C Hamano wrote:
>
>> > How about just adding --stdin, which matches other git commands?
>> 
>> How about doing nothing and use the correct $IFS instead?
>
> Can you cover all cases with $IFS, including filenames with newlines?

You didn't say "--stdin -z", so I presume --stdin is not solving
anything ;-)

> I agree it is probably OK in practice and for the OP's question, but it
> is nice to have "-z" variants so you do not have to worry about quoting
> at all. I'd argue that a "--stdin -z" should probably also accept raw
> filenames, not pathspecs, too (so you do not have to use
> "--literal-pathspecs" elsewhere).

I agree "--stdin -z" is a good thing but what makes you think that
the producer of the data is _always_ walking the directory hierarchy
and showing the pathnames it sees?  I think use of literal-pathspecs
should not be tied to the use of either --stdin or -z.
