From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] git-merge-one-file: revise merge error reporting
Date: Thu, 14 Mar 2013 07:56:00 -0700
Message-ID: <7vr4jiyqrj.fsf@alter.siamese.dyndns.org>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
 <1363137142-18606-1-git-send-email-kevin@bracey.fi>
 <1363137142-18606-3-git-send-email-kevin@bracey.fi>
 <7vehfj2neh.fsf@alter.siamese.dyndns.org> <51416DD5.2030805@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Alex Riesen <raa.lkml@gmail.com>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Thu Mar 14 15:56:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG9a6-00045F-BI
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 15:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636Ab3CNO4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 10:56:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39649 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755972Ab3CNO4E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 10:56:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AC921B419;
	Thu, 14 Mar 2013 10:56:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SuIH2qrTDNKy+v7y4XcpwDlcDHY=; b=ljgWGX
	k06rrbscxmBiuRzwxym/QEKupWiwB7BvPh/W07vBFeH8RGHorwNSt1rOsOx/H5W0
	VnmcUKeqD9uxcE3xycLa6EFoZD73rjFXOfU54ren2mDGWh5w0vMBl5gH5LyV7GxR
	7urMDd6pLjEDj5pQV0CmsHADNm7RJ+rPY906c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tlyQYmpVw2BYZJlxRN0JABUiVQD74th7
	xW5yLHbpaGT9/dwZ3hU1EUeIcG7M+aw+4/HkdufPUBhM8PAFzpiK9vv56eVYVFdN
	ZyoPfHrpWb7CpYLDgU0NEsBbA6L6eqblUqdmTkMW0/HqYxRXsQeO03osHcEr9bE8
	BfMRYmapX0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0F1FB418;
	Thu, 14 Mar 2013 10:56:03 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 219CFB416; Thu, 14 Mar 2013
 10:56:03 -0400 (EDT)
In-Reply-To: <51416DD5.2030805@bracey.fi> (Kevin Bracey's message of "Thu, 14
 Mar 2013 08:27:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4A81EAA8-8CB7-11E2-91AE-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218141>

Kevin Bracey <kevin@bracey.fi> writes:

> I disagree here. At the minute, it does set ret to 1 (but further down
> the code - bringing it up here next to the "ERROR" print clarifies
> that), and will report the merge as failed, conflict in the 3-way
> merge or not. Which I think is correct.

OK.  I agree that forcing users to always inspect the result of
"both side added" resolution sounds like a good safety measure.

> Maybe the virtual base itself should be different. Maybe it should put
> a ??????? marker in place of every unique line. So you get:
>
> Left   ABCEFGH
> Right XABCDEFJH  -> Merge result <|X>ABC<|D>EF<G|J>H
> VBase ?ABC?EF??H
>
> That actually feels like it may be the correct answer here.

Interesting, though the approach has downsides with the diff3
conflict style, no?
