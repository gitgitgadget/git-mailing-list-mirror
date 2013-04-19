From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: tighten IS_STASH_LIKE logic
Date: Fri, 19 Apr 2013 11:54:23 -0700
Message-ID: <7vd2tq1hcw.fsf@alter.siamese.dyndns.org>
References: <1366270717-19929-1-git-send-email-artagnon@gmail.com>
	<7vk3nz4h20.fsf@alter.siamese.dyndns.org>
	<CALkWK0m_Nt8SFdjGKWWHtBJ+HVsk095ukjZ0N=KBt5q+or5XFQ@mail.gmail.com>
	<7v38um2yvr.fsf@alter.siamese.dyndns.org>
	<CALkWK0maM5ocSoSGy8OdL+hNW9mm_s1m1h+xJeCq-JKfTMW0Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Brandon Casey <drafnel@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 20:54:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTGS7-0001BZ-LM
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 20:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753942Ab3DSSy1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 14:54:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753926Ab3DSSy0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 14:54:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99354179AB;
	Fri, 19 Apr 2013 18:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yiGsMWJnpl3i8ZJOpFVSBYRgKkA=; b=L9HSZ7
	DPfVlI4GL9xAmNGWHjDFQzoEJUIrgZGw6C0I1WPuyza9zrFuqk8ul1hhcupbVKwy
	CHORzmc8GiEAparpWF9a/58HND0NGil12woCc1BWD5sMBCTaWbcgBHz6P84XUzzq
	zgaYuA4Qj2IzwcmTVC9iL0RRgjJnAMwkENwwY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lApu+s61mFr16F1mZg9GIamNETowKsfx
	1rOAR6k3YhgOVzNAWr6exU3NOQ17E1Q+je9CNyl+FA5bkIOVGQJgtviBprnFV4uY
	hQUKbUtnQ4HQ06VjHrFzjG5Q2+SfgWE+JmMR5qaxDjVuKJmv7lq8TMA4G7sAuH+8
	t1hDJv4Ud7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D0F9179AA;
	Fri, 19 Apr 2013 18:54:25 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12561179A9;
	Fri, 19 Apr 2013 18:54:24 +0000 (UTC)
In-Reply-To: <CALkWK0maM5ocSoSGy8OdL+hNW9mm_s1m1h+xJeCq-JKfTMW0Uw@mail.gmail.com>
	(Ramkumar Ramachandra's message of "Fri, 19 Apr 2013 23:52:00 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8DFF2DF4-A922-11E2-AFAF-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221794>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> The risk of actually closing the door for future developers.  That
>> is a downside of this patch, if we were to apply it.
>
> Okay, no issues.  Drop it.
>
> Consider documenting the fact that IS_STASH_LIKE is merely a
> contextual synonym for IS_MERGE_COMMIT somewhere though.

Documenting what IS_STASH_LIKE means and what it is meant to be used
for would add a lot of value, if it is not done already, but I doubt
it adds much value to document that it _happens to be implemented_
as "is it a merge commit?" in the current version.
