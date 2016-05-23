From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git reset --hard with staged changes
Date: Mon, 23 May 2016 14:16:39 -0700
Message-ID: <xmqqeg8s8og8.fsf@gitster.mtv.corp.google.com>
References: <loom.20160523T023140-975@post.gmane.org>
	<CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Yotam Gingold <yotam@yotamgingold.com>, git <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 23 23:16:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4xDV-0006gT-5R
	for gcvg-git-2@plane.gmane.org; Mon, 23 May 2016 23:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbcEWVQo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2016 17:16:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51760 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751299AbcEWVQo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2016 17:16:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8C6A81C894;
	Mon, 23 May 2016 17:16:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AvRQZQ0Rc6rexQKJlHbmLz5xHpw=; b=t2AhfV
	9ClU/3cnp0su+uyGZELYiy48PGTFr8rrMMRytbb/C99NYyZ9xjuDCRL0G/FbMsiC
	hcSlqi8B8KoCagpWih/a4Fh5mDwfOA8hGwUtCsWiR+ztek7ueEuuKTFwhmYk6WwL
	etiUNezLE7Mt4uH6k6/s5d5DpFAEm5EoeDwjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s4ME1QmdYe35MV3AsKWLF7b+S7lXHp+u
	8UqJtrDpKSAW/8DuifUS3ktVosHGa8K4O+l7moxSxH/1+2AB0qv/ovJ9hCHaubp4
	fUKsScRBi18iAH+n8nsM16YwGwX/F/ZRuZutDP1qn+4lvn7a8uGHpE7HrdwZ0bEV
	p/0K77XnN14=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8401D1C893;
	Mon, 23 May 2016 17:16:42 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 013FE1C892;
	Mon, 23 May 2016 17:16:41 -0400 (EDT)
In-Reply-To: <CAP8UFD0dQGmfhPuHjEGRZjEZHwUHR_XzAASwq+87Obf26yi+BQ@mail.gmail.com>
	(Christian Couder's message of "Mon, 23 May 2016 21:31:16 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A531A84C-212B-11E6-8282-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295391>

Christian Couder <christian.couder@gmail.com> writes:

>> This should be clarified to define what a tracked file is. I propose appending:
>>
>>     A file is considered tracked if it exists in a prior commit or in the
>>     staging area. Note that a newly added file not in any prior commit will be
>>     removed.
>
> Would you like to send a patch with something like the above?

I am not sure if that is a good addition, though.

> I don't know if something about why it is like this, or why it is the
> right thing to do, at least for recovering from merges, should be
> added though.

I excuse you as it seems that you haven't read my response ;-)

>> I would also like to propose that the staging area's tree object be saved,
>> ..
> Yeah, it might be a good idea.

Two issues with that "proposal" is that

 1. the index may not be writable as a tree (think: during a
    conflict resolution); and

 2. the sole point of "reset --hard" is to "discard the changes".
    If you want to instead save them away, there is another command
    that was designed to do just that.

It wasn't all that surprising that those on stackoverflow would
think such a proposal is a good idea, but I somehow was hoping you
have been around here long enough to know "git stash" ;-)
