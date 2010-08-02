From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3 v4] Add a macro DIFF_QUEUE_CLEAR.
Date: Mon, 02 Aug 2010 08:26:18 -0700
Message-ID: <7vvd7tnihx.fsf@alter.siamese.dyndns.org>
References: <1273207949-18500-1-git-send-email-struggleyb.nku@gmail.com>
 <1273207949-18500-2-git-send-email-struggleyb.nku@gmail.com>
 <20100802124729.GK12084MdfPADPa@purples>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bo Yang <struggleyb.nku@gmail.com>, git@vger.kernel.org,
	trast@student.ethz.ch
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Mon Aug 02 17:26:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OfwuS-0004mQ-VL
	for gcvg-git-2@lo.gmane.org; Mon, 02 Aug 2010 17:26:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752969Ab0HBP0b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Aug 2010 11:26:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:36711 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab0HBP0a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Aug 2010 11:26:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E02BC956F;
	Mon,  2 Aug 2010 11:26:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vWEL6d2uLBnPkQMp6yPDaL4IQkY=; b=UcJaRk
	f0q0bjYHqNAY9NSW5ntZK/0ZnB8O60BvXxpm0tdPRv1AwtFyPME3wGv9comAJ5wm
	9rfAxIaBOt1ui/Jhe9pceaUhGkqH/CWCTebC7oolNDPDg7JrIv/A9MxB/8gBBUEi
	7fipthMvY1+kEVRvPjtfSMXQ5UEq3TuEm8p3c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s1wVzeQq6OsbrJOljAnlgjyRzJdmefKu
	g095p8dFH+3fjOAe9eWKJ/KrOFdiel5Dj90zls1MoJFlmPhlepQc9+ZNvphyD0Ti
	3oq15GzD7drCwbX65tMUeN8Hrd5ozuNrVvXlGazm+lCllXaZ1iWbW6qnOClx75kJ
	085d4k6LQs0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DBA62C956E;
	Mon,  2 Aug 2010 11:26:24 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EE267C956B; Mon,  2 Aug
 2010 11:26:19 -0400 (EDT)
In-Reply-To: <20100802124729.GK12084MdfPADPa@purples> (Sven Verdoolaege's
 message of "Mon\, 2 Aug 2010 14\:47\:29 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4FD7533E-9E4A-11DF-8DB4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152414>

Sven Verdoolaege <skimo@kotnet.org> writes:

> On Thu, May 06, 2010 at 09:52:27PM -0700, Bo Yang wrote:
>> Refactor the diff_queue_struct code, this macro help
>> to reset the structure.
>> 
> [..]
>> 
>> diff --git a/diff.c b/diff.c
>> index e40c127..4a350e3 100644
>> --- a/diff.c
>> +++ b/diff.c
>> @@ -2540,6 +2540,7 @@ static void run_checkdiff(struct diff_filepair *p, struct diff_options *o)
>>  void diff_setup(struct diff_options *options)
>>  {
>>  	memset(options, 0, sizeof(*options));
>> +	memset(&diff_queued_diff, 0, sizeof(diff_queued_diff));
>>  
>
> What's this line for?

I don't think this change is warranted.  The macro was supposed to reduce
the repetition of assignment to q->queue, q->nr and q->alloc, and nothing
else.

Also the commit messages in this series are unreadable---I should have
been a bit more careful.

Sorry and thanks for noticing.
