From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Certificate validation vulnerability in Git
Date: Sun, 24 Feb 2013 21:35:47 -0800
Message-ID: <7v8v6d3qh8.fsf@alter.siamese.dyndns.org>
References: <CAA5xPpmmZuMK7q3-pTOx4L6DxFtyw5HWYdH7kHEsK=96KM5kAQ@mail.gmail.com>
 <512A601B.80807@op5.se> <20130225031847.GB31988@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Zubin Mithra <zubin.mithra@gmail.com>, git@vger.kernel.org,
	"Dhanesh K." <dhanesh1428@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 25 06:36:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U9qjX-00082s-B8
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 06:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825Ab3BYFfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 00:35:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47676 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750808Ab3BYFfu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 00:35:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89E8B8954;
	Mon, 25 Feb 2013 00:35:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rEo0EM4v8ddvZXkhKpJLnsL4Xy8=; b=skD5AM
	4JgbKh2+wxDrpauA7EfF2M3r5SEP8j3toKfexwVD7oQaiQ7ZiSg8Gouw3M6ZNl8r
	qkhaL8jtaBIQceX9cu3SWlmx7jKZRgvqpsfHdld33eyGPN/xWxnxJn7CjXJf11mg
	copcou8xzD/iMdOItozeWpgbHhjoyAQEg/7Ys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XYmoi/Vde1SIYmIMizMY82flhssumBUA
	RAl7Ei0KRUVcQXTWLvdls7m4ExoEob6tcelcx4fSoB5ZbmLPZvfM57P3dHVDCTOR
	iGUX54pvLxh15o+Or0030qMT4y5i1edL19aADNxsGbaGlBqdoRqtUi/DVE+Zw0Oq
	G1PjNqIUdIw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7F2458953;
	Mon, 25 Feb 2013 00:35:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF56F8951; Mon, 25 Feb 2013
 00:35:48 -0500 (EST)
In-Reply-To: <20130225031847.GB31988@sigill.intra.peff.net> (Jeff King's
 message of "Sun, 24 Feb 2013 22:18:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 35E0E80E-7F0D-11E2-8299-27D12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217031>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 24, 2013 at 07:46:51PM +0100, Andreas Ericsson wrote:
>
>> The lack of certificate authority verification presents no attack vector
>> for git imap-send. As such, it doesn't warrant a CVE. I'm sure you'll
>> be credited with a "reported-by" line in the commit message if someone
>> decides to fix it though. Personally, I'm not fussed.
>
> Sure it presents an attack vector. I can man-in-the-middle your
> imap-send client and read your otherwise secret patches. Or your
> otherwise secret imap password.

Yes, the lack of verification alone will not hurt the victim; you
would need to also be able to insert yourself in the middle, perhaps
by poisoning the victim's DNS.  But one of the points of using
SSL/TLS is to resist such an attack, and it certainly is an attack
surfce, even though it may be of a lessor kind than other kinds of
attacks.
