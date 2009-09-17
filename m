From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/4] reset: add option "--merge-safe" to "git reset"
Date: Thu, 17 Sep 2009 13:43:53 -0700
Message-ID: <7v1vm5i9o6.fsf@alter.siamese.dyndns.org>
References: <20090917040835.4048.51057.chriscool@tuxfamily.org>
 <20090917041440.4048.16353.chriscool@tuxfamily.org>
 <7vk4zykv7o.fsf@alter.siamese.dyndns.org> <4AB1D957.20902@viscovery.net>
 <7vr5u6jbgk.fsf@alter.siamese.dyndns.org> <4AB1E41F.6050304@viscovery.net>
 <c07716ae0909170512k3c2ec7m21e69e9acfdfd81f@mail.gmail.com>
 <4AB23410.6080508@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 22:44:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoNq8-0003CG-1a
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 22:44:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbZIQUoQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 16:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753361AbZIQUoQ
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 16:44:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52216 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753235AbZIQUoP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 16:44:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5C61654E25;
	Thu, 17 Sep 2009 16:44:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FhakbND6h6OO4NGSsFW4+wN28Gw=; b=UPvVE7
	3U+98izA7jTjEvRBUX7NM5vVFqEEwFCTMoaV+2KNtI5AdXRRHnWIjoeweRhPUWw+
	ZYv5Ze3WPWikEk4tOF9QtRmS0QgeKKqaj1s1QfDHPITdb1KsmXfB5Ogeimj4ULx9
	uep2gZXCnESTbaAB96/nPUeUTO7hv/JfXjpqA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fxg3v/tAZGAc/QUyw9xLKsVMxGOq4Hsn
	25VH3ccOZO9/TKaDH8vHtWKN2RGVxwd2XQnylKcrN+0vtcbbYEZ5vg4dVodCpdpE
	z8jRRssJXQm4gZ0Jdp0Fq/vjjwG9lRHLjd39aj9f03cWVVRF53lursknsqmgOBpF
	3wm/v2MZxAI=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D1EFE54E21;
	Thu, 17 Sep 2009 16:44:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 4815F54E16; Thu, 17 Sep 2009
 16:43:54 -0400 (EDT)
In-Reply-To: <4AB23410.6080508@viscovery.net> (Johannes Sixt's message of
 "Thu\, 17 Sep 2009 15\:05\:20 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: D90F26CA-A3CA-11DE-ADFE-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128770>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Christian Couder schrieb:
>> On Thu, Sep 17, 2009 at 9:24 AM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>> Junio C Hamano schrieb:
>>>> Johannes Sixt <j.sixt@viscovery.net> writes:
>>>  $ git stash
>>>  $ git reset --hard $target
>>>  $ git stash pop
>>
> It "can"? Do you say that you intend --merge-safe for something else in
> addition to the above stash + reset --hard + stash pop sequence? What?

I think I am starting to understand.  The use case in a larger picture
would look like

    $ (edit/add/commit)+ to work towards something
    ... And you _finished_ that something.
    $ (edit/add)+ to work towards something else that is wonderful
    ... Now you notice that all the commits for that earlier something
    ... are crap and you would want to discard them, while still keeping
    ... changes for "something else that is wonderful".
    ... Luckily, you haven't committed anything you would want to keep,
    ... and you can afford to reset the tip commits away.
    $ git reset --keep-local-changes HEAD~7
    ... or howmanyever commits you want to discard.

The reset in this case is done purely to discard the crap, not to redo
them (you have something else you want to work on in your work tree and
index, and they are not fixups---if they were you wouldn't have resetted
but used "commit --amend" or "rebase -i").

It is more like switching branches but in this case you are switching to
your own branch immediately after rewinding that same branch.

In other words, as far as the index, the work tree and where HEAD will
point at are concerned, the new mode of reset works exactly like this:

    $ (edit/add)+ to work towards something wonderful
    ... notice that the work does not belong to the current branch
    ... and you would want to switch to another branch while carrying
    ... your local changes.
    $ git checkout another-branch

The only difference being that reset will stay on the same branch and
remove some commits from the tip of it, while checkout will leave the
original branch intact.

It makes sense that it has the same "safety" as "checkout" has when
switching branches; when you have modification in the index for a path,
and the path is different between switched-to commit and the current
commit, the command errors out with "cannot merge" (or a better message).

One drawback is that you can use this new mode of resetting only until you
make a commit that is part of the new "something else that is wonderful"
topic.  After that "git reset" with this new option is not useful for this
workflow, and you would need to stash then rebase -i then unstash.
