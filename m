From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Paper cut bug: Why isn't "git clone xxxx" recursive by default?
Date: Tue, 03 Jun 2014 14:05:45 -0700
Message-ID: <xmqqoay9wvo6.fsf@gitster.dls.corp.google.com>
References: <CAJdEhSa20ODuN4LkdvaWi0cSztgbJ+p50AYbtZs2oYWLitnjbA@mail.gmail.com>
	<xmqqvbshwz2e.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Mara Kim <mara.kim@vanderbilt.edu>
X-From: git-owner@vger.kernel.org Tue Jun 03 23:05:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wrvu8-0001D1-Av
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 23:05:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933343AbaFCVFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 17:05:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64591 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933057AbaFCVFv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 17:05:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D8B921CCF7;
	Tue,  3 Jun 2014 17:05:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9vsIq2uA1agtVJuaHF0p1o/34Sw=; b=BIukuF
	Z0BqHdSzid4iABvPIe0ZXR8N4v0L+S4E5EikEODyKci1icpGodVlO7dWDUmeri/G
	Sx8wzS9AwhZDS4TZb8Wtk7WIwI5IZOhasHWaURR2vldOS5bj+Trl0GM21dRqw3IF
	2iDt39pPhAZRXfINZ9wzGqArTe2NY9RQQjYgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lHfTNq4zSx1fwJq7CigII9IWZdTFNlB/
	2zVqLKmk26dHAL5f85N5jAlBQUmpVPl6XxtRtXNqA7fI27ABaH+hdcsWmVbDFMuG
	2H37lwgNGlZAUpQkJ+j+DvR1i5nEXbTfQMwYOG8sCf3+DSkeM/Z50P9aAZ4/tWAV
	IbmJZle9ZIk=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CEBBD1CCF4;
	Tue,  3 Jun 2014 17:05:50 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E4B511CCE9;
	Tue,  3 Jun 2014 17:05:46 -0400 (EDT)
In-Reply-To: <xmqqvbshwz2e.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 03 Jun 2014 12:52:25 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D5519632-EB62-11E3-9AB6-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250645>

Junio C Hamano <gitster@pobox.com> writes:

> Mara Kim <mara.kim@vanderbilt.edu> writes:
>
>> Apologies if this question has been asked already, but what is the
>> reasoning behind making git clone not recursive (--recursive) by
>> default?
>
> The primary reason why submodules are separate repositories is not
> to require people to have everything.  Some people want recursive,
> some others don't, and the world is not always "majority wins" (not
> that I am saying that majority will want recursive).
>
> Inertia, aka backward compatibility and not surprising existing
> users, plays some role when deciding the default.
>
> Also, going --recursive when the user did not want is a lot more
> expensive mistake to fix than not being --recursive when the user
> wanted to.

Having said all that, I do not mean to say that I am opposed to
introduce some mechanism to let the users express their preference
between recursive and non-recursive better, so that "git clone"
without an explicit --recursive (or --no-recursive) can work to
their taste.  A configuration in $HOME/.gitconfig might be a place
to start, even though that has the downside of assuming that the
given user would want to use the same settings for all his projects,
which may not be the case in practice.
