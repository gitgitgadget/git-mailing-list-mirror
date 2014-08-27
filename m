From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] checkout --to: no auto-detach if the ref is already checked out
Date: Wed, 27 Aug 2014 09:08:41 -0700
Message-ID: <xmqq4mwxgbjq.fsf@gitster.dls.corp.google.com>
References: <1406115795-24082-1-git-send-email-pclouds@gmail.com>
	<1406115795-24082-4-git-send-email-pclouds@gmail.com>
	<53CFBD2A.9030803@drmicha.warpmail.net>
	<CACsJy8DwPM68j-=LDDbq1H_bT1gD=aLQ8x6C1qiwF79=ai14dg@mail.gmail.com>
	<xmqq8uni8mx4.fsf@gitster.dls.corp.google.com>
	<53D1FE76.5080708@drmicha.warpmail.net>
	<xmqqmwbqzptt.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3+9Rzz7ZEC3jgz0aQngT06Xi85gf6u2KS8VQUqkChvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>,
	Max Kirillov <max@max630.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 18:08:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XMfmL-0008TW-2z
	for gcvg-git-2@plane.gmane.org; Wed, 27 Aug 2014 18:08:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935064AbaH0QIw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2014 12:08:52 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58318 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934744AbaH0QIv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2014 12:08:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D5E433C12;
	Wed, 27 Aug 2014 12:08:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QwnxlMWS1InFmnn2SjXTr3P5Hio=; b=H2eDfc
	CsoqoHvAAVtZ6SjKyGLEHbdLn5uZ9IFSi9N6JAZEVaG601ROi9TXQ26FqukdKHSZ
	r5XDJANzHSLPlO5Q2TQ/AtLobmE8wCqzW6lNWC9iP/vZRdou7XDKVci1cOhG22XG
	lyi+BsmERLhyNWr/9UzQns0O1hyiK70OyMwaY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E1zerxItWcCKqHjl/zyZIcVrJnWeedv9
	q4qLdlV0zDPBAP3g60nvE9Qk3e3GJE320pVz+hCE5izrSpcp3/l/PjWpYqtIafcr
	Kt89ZiRIMloL5+lYK2Kb0GvEnM35BnIKD7tleZ0/tmFhkPOwsDGkwiPbes89Cxfk
	VP7FCzmhW5M=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2385C33C11;
	Wed, 27 Aug 2014 12:08:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1139833C07;
	Wed, 27 Aug 2014 12:08:43 -0400 (EDT)
In-Reply-To: <CACsJy8A3+9Rzz7ZEC3jgz0aQngT06Xi85gf6u2KS8VQUqkChvg@mail.gmail.com>
	(Duy Nguyen's message of "Wed, 27 Aug 2014 18:58:35 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6AA0B14E-2E04-11E4-8F4F-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256005>

Duy Nguyen <pclouds@gmail.com> writes:

> On Thu, Jul 31, 2014 at 1:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Michael J Gruber <git@drmicha.warpmail.net> writes:
>>
>>> As an error message that is completely sufficient.
>>>
>>> The advice messages are meant to teach the user about the normal parts
>>> of the toolchest to use in a situation of "conflict", aren't they?
>>
>> Not really.  They are to remind (to those who learned but forgot)
>> and to hint (to those who haven't realized they have things to learn
>> in this area).  Wall of text that tries to do more than that, like
>> "teaching", risks not getting read by anybody.
>
> Last call to all. Keep this 'advice' or drop it?

I think you quoted what I needed to say already so I won't repeat
myself.  Earlier you said:

    If you have two checkouts associated to the same repo, "git
    checkout foo" on one checkout when "foo" is held by another
    checkout would cause the same error. I'll need to think of a
    better name than advice.checkoutTo.

and I agree; the patch needs rerolling in any case.
