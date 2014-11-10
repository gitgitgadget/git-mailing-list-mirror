From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Add a few more values for receive.denyCurrentBranch
Date: Mon, 10 Nov 2014 08:00:41 -0800
Message-ID: <xmqqwq739hau.fsf@gitster.dls.corp.google.com>
References: <cover.1415368490.git.johannes.schindelin@gmx.de>
	<f82aedcb632571d0b756d62c58479c0aab35b026.1415368490.git.johannes.schindelin@gmx.de>
	<xmqqvbmqg81g.fsf@gitster.dls.corp.google.com>
	<alpine.DEB.1.00.1411101305510.13845@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 10 17:00:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnrOb-00089l-Fy
	for gcvg-git-2@plane.gmane.org; Mon, 10 Nov 2014 17:00:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbaKJQAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2014 11:00:45 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59753 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751726AbaKJQAo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2014 11:00:44 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CD851A5E1;
	Mon, 10 Nov 2014 11:00:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mF5EHNIM3iMzONij46DNjmKIyu8=; b=sSmIPE
	q35nmmRA58hMlDei7mVp6UV0i0FMjRyAENupObnIsoQNYNkCjqFnKpDXLyxt/Wqv
	fpHuNR47l9tGOCcJG9k5DoCVOVLR7N8vkC0UaM4km3CmCTYkDguanNv2wewv8wlp
	Zda1ImtsT2eWPjeZPfMX1UWjezggfUWiudYys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Lb1JbTu5hOM6y4fLblBAWnb9FXQlnTbG
	kq54bdrtSQSHcnl1F0EBk2l1N7xYuQjy6Ke4D82abiDE49eo5WODkNNpQycNteUU
	Kb82wesfvtIeDkjr6qQ86NLU3GH1z7EUUIECfZJdipECoFWKkuse6qX0Nrf0jtEv
	oKfFaiiCFP0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 409EA1A5E0;
	Mon, 10 Nov 2014 11:00:43 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 98E4C1A5DF;
	Mon, 10 Nov 2014 11:00:42 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.1411101305510.13845@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Mon, 10 Nov 2014 13:54:34 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B93149EE-68F2-11E4-A818-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I do not think of a good justification of detachInstead offhand, but
>> you must have thought things through a lot more than I did, so you
>> can come up with a work flow description that is more usable by mere
>> mortals to justify that mode.
>
> The main justification is that it is safer than updateInstead because it
> is guaranteed not to modify the working directory. I intended it for use
> by developers who are uncomfortable with updating the working directory
> through a push, and as uncomfortable with forgetting about temporary
> branches pushed, say, via "git push other-computer HEAD:refs/heads/tmp".
>
> However, I have to admit that I never used this myself after the first few
> weeks of playing with this patch series.
>
>> Without such a description to justify why detachInstead makes sense, for
>> example, I cannot even answer this simple question:
>> 
>>     Would it make sense to have a third mode, "check out if the
>>     working tree is clean, detach otherwise"?
>
> I imagine that some developer might find that useful. If you insist, I
> will implement it, even if I personally deem this mode way too complicated
> a concept for myself to be used safely.

You have been around long enough to know that adding a feature of an
unknown value is the last thing I would ask, don't you?

I am essentially saying this:

    I do not see why and the patch and its documentation do not
    explain why it is useful, but Dscho wouldn't have added the
    feature without a reason better than "just because we can do
    so", so let's assume the mode is useful for some unknown reason.
    Would people find "updateInstead if able otherwise
    detachInstead" even more useful for that same unknown reason?

So a good answer would have been one of these:

 * detachInstead is not backed by a use case as useful as
   updateInstead, and was done more from "because we can while at
   it".  Let's drop it for now.

 * detachInstead is a good thing and here is an updated patch to
   better explain the readers of our documentation the workflow to
   use to the feature well.  updateIfAbleOrDetachInstead would be
   useful for the same reason stated in the updated documentation,
   but let's not make the scope of the topic too wide and stop at
   mentioning the possibility in the log message for now.
   

 * detachInstead is a good thing and here is an updated patch to
   better explain the readers of our documentation the workflow to
   use to the feature well.  Once a reader understands this, she
   would realize why updateIfAbleOrDetachInstead would not be
   useful, so it is not even worth mentioning the possibility.

>> > +	if (run_command(&child))
>> > +		die ("Could not merge working tree with new HEAD.  Good luck.");
>> 
>> Drop "Good luck." and replace it with a more useful info.  At least,
>> tell the user what state you left her repository in by this botched
>> attempt, so that she can manually recover.
>
> The best information Git can give at that point is that the working tree
> could not be merged with the new HEAD. I stripped "Good luck." in the next
> iteration, although I mourn the loss of comedy in Git.

Being humourous is good, but "Good luck" while refusing to be
helpful is not humourous; it is just being hostile to the user.

We would be showing the string as the reason for push failure to
"git push" in the new code that does not die but signal the failure
to our caller, so "could not merge working tree with new HEAD" is
good (we shouldn't be doing the "advice" thing here).

Thanks.
