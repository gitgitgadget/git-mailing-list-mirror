From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Sun, 09 Sep 2012 03:20:18 -0700
Message-ID: <7v7gs3sdjx.fsf@alter.siamese.dyndns.org>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun Sep 09 12:21:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAedg-0001pX-1Y
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 12:21:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472Ab2IIKUX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 06:20:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47345 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752831Ab2IIKUX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Sep 2012 06:20:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AE0F7CA8;
	Sun,  9 Sep 2012 06:20:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4Ta46gsoJ2oZfE40cZsXZQS7z3s=; b=rrltqK
	YEHbOH0Hf9MQA40o8hI8tk3LdsbXCtWrxvan9iaCI5C2gWe0bWXSYX6dzvZ97Yax
	WQtsRHVvwc01gf3rcP+3dxYmv2EXSyx0PJDFwdvRGajmr34y4vkP8sCq1x9+k2P8
	3FfLjnrel2pI4BpFyId5qW4gJFD3gdEB4PS44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Mo3rXK9v1GaoJ47aOhWwF4FGAm0X6xct
	ulP/sYkyAAfTqQ/7LojCL22lnvodG45NtBrgT1I9EzER+zqV8+ZgtlCwxqlOAgw7
	sPrmoZWGcMWBHyZnZ+p7P2boiCgs+jAYA+SIL0JM8wMardcblh4QkdXvU10saVnN
	RcwxqmloWV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1641A7CA7;
	Sun,  9 Sep 2012 06:20:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B4A07CA5; Sun,  9 Sep 2012
 06:20:19 -0400 (EDT)
In-Reply-To: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu>
 (Michael Haggerty's message of "Sun, 9 Sep 2012 08:19:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4F059C6-FA67-11E1-8C1E-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205074>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> This patch series depends on the "Add some string_list-related
> functions" series that I just submitted.

Makes sense.  The only worry (without reading the series first) I
have is that the use of string list may make the responsiblity of
sorting the list fuzzier. I am guessing that we never sorted the
refs we asked to fetch (so that FETCH_HEAD comes out in an expected
order), so use of unsorted string list would be perfectly fine.

Queued and pushed out in 'pu' without reading, but will take a look
sometime tomorrow (eh, today, that is).
