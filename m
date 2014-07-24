From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] config.c: fix accuracy of line number in errors
Date: Thu, 24 Jul 2014 11:31:17 -0700
Message-ID: <xmqq1ttaa9sa.fsf@gitster.dls.corp.google.com>
References: <1406140978-9472-1-git-send-email-tanayabh@gmail.com>
	<1406140978-9472-2-git-send-email-tanayabh@gmail.com>
	<xmqqegxbd9u0.fsf@gitster.dls.corp.google.com>
	<53D10B37.3000403@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 24 20:31:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XANne-0000Y1-4t
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jul 2014 20:31:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933154AbaGXSb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2014 14:31:26 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60996 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757603AbaGXSbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2014 14:31:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id F20532A81C;
	Thu, 24 Jul 2014 14:31:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qsNuUNn0PhuR3UqetlC1QEDyMJQ=; b=pnFIBw
	Y2X3zlZcV98EC9m/He4tpr1pMkhajA/ZrWMHDR4JIHDdIHyad4TH2v6LXSMvpKsP
	47RoTf78qRuVgSgsa5LtJDp+YjEk9F9nxBac5uS8XRXRxFLy2tfCtvvBL1IQGUPB
	123urVDZNBUTD0HwkpT9W75a9I6lTPPIL9Tj4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rixIyS6NQDXYPXjQ5dVUt+/OGgIy+L3W
	87s2pyDOQSY6x4xQYVykdP57x62wWcX20dXQM5HgCJM0IRFurCS8bU4taAP5A9W1
	s/8z6PGM0Wk+hq7aw53H0W5huQ9z5L36RiDzcFeKz3Etch48EXau0HR1cT9NUC2n
	EU82IiLKdiI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4A472A81B;
	Thu, 24 Jul 2014 14:31:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E48E22A819;
	Thu, 24 Jul 2014 14:31:18 -0400 (EDT)
In-Reply-To: <53D10B37.3000403@gmail.com> (Tanay Abhra's message of "Thu, 24
	Jul 2014 19:03:43 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B43A4EAA-1360-11E4-BB96-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254173>

Tanay Abhra <tanayabh@gmail.com> writes:

> On 7/24/2014 3:19 AM, Junio C Hamano wrote:
>> Tanay Abhra <tanayabh@gmail.com> writes:
>> 
>>> If a callback returns a negative value to `git_config*()` family,
>>> they call `die()` while printing the line number and the file name.
>>> Currently the printed line number is off by one, thus printing the
>>> wrong line number.
>>>
>>> Make `linenr` point to the line we just parsed during the call
>>> to callback to get accurate line number in error messages.
>>>
>>> Discovered-by: Tanay Abhra <tanayabh@gmail.com>
>>> Signed-off-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
>> 
>> Thanks.
>> 
>> I am not sure what to read in these two lines.  Was the fix done by
>> you or Matthieu?
>>
>
> I misunderstood the meaning of the message trailers. I will correct
> it in the next re roll.

Well, that does not really answer my question, and it does not tell
us if you now understand the meaning of trailers correctly, or
replaced an earlier misunderstanding with a different
misunderstanding ;-)

More importantly, it would not help me interpret what you mean when
you write a sequence like this:

	From: tanay
        S-o-b: matthieu
        S-o-b: tanay

which does not quite make sense and leave the reader puzzled.

If the patch was authored by you and helped by matthieu, the first
S-o-b would be lying.  If the patch was written by matthieu and you
are merely relaying, then the authorship From is lying.  If the
patch was written by you and matthieu is relaying, then the two
S-o-bs are in incorrect order.
