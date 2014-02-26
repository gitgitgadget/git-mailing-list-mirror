From: Junio C Hamano <gitster@pobox.com>
Subject: Re: `git stash pop` UX Problem
Date: Wed, 26 Feb 2014 11:36:09 -0800
Message-ID: <xmqqd2i94qfq.fsf@gitster.dls.corp.google.com>
References: <530B0395.5030407@booking.com>
	<CANUGeEbPrPp8Sa-KEKSxNDWJShdkDBTkQyXv7tDJ6ReH6MXrHw@mail.gmail.com>
	<530C953F.9050805@booking.com> <vpqlhwz5o58.fsf@anie.imag.fr>
	<530CA4C9.60601@booking.com> <vpqeh2r43kx.fsf@anie.imag.fr>
	<530D97BA.1080107@booking.com> <vpqzjlez3c4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Omar Othman <omar.othman@booking.com>,
	Brandon McCaig <bamccaig@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 26 20:36:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIkHH-00059M-Su
	for gcvg-git-2@plane.gmane.org; Wed, 26 Feb 2014 20:36:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754008AbaBZTgS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Feb 2014 14:36:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45242 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbaBZTgP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Feb 2014 14:36:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 058BD6DD0E;
	Wed, 26 Feb 2014 14:36:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cM5H9id0Af6b36E07VVViGz5mVg=; b=YgcGya
	iUImp9+p4ckumjMkpO7yejwvghGrqksoVTfCL20/hrpqadN9AIswXl4C+5HvAsZI
	r/wp8uCCOL9z/fgSy9QqR0Cc6f4C408yAnf50sgnTPfP5OP2cVhciHOlhBiUJGdZ
	Scw8dJaFzeJXm0lT8l1HhPiQPGGTGJt4NY1dk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ADp99cLuF0E7z0Kb/TjDS1XAkx3VDT7r
	ZidH51CxX4ospQcTVX7ki1ia+cHog5lGH/js4+aGadLi/GdGTbAbXobblm9xUfs1
	lmz1Vvklf7vBPFYqg14dRTAKMeiw++3cXob5v5ytasuXANvGoIVGfZ6LlfW7oFGW
	yHmvWmzZMf0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E19736DD0D;
	Wed, 26 Feb 2014 14:36:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2C4EA6DD0A;
	Wed, 26 Feb 2014 14:36:13 -0500 (EST)
In-Reply-To: <vpqzjlez3c4.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	26 Feb 2014 09:27:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 403DFB58-9F1D-11E3-BB09-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242748>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Omar Othman <omar.othman@booking.com> writes:
>
>> Though I don't know why you think this is important:
>>> Now, the real question is: when would Git stop showing this advice. I
>>> don't see a real way to answer this, and I'd rather avoid doing just a
>>> guess.
>> If it is really annoying for the user, we can just have a
>> configuration parameter to switch this message on/off.
>
> Just saying "You have X stash" is OK to me as long as there is an option
> to deactivate it.
>
> Hinting "You should now run "git stash drop"." OTOH is far more dangerous
> if guessed wrong. Keeping a stash active when you don't need it does no
> real harm, but droping one you actually needed is data loss.

Yes, definitely.

I'm inclined to say that we should go in the direction you suggested
earlier in Message-ID: <vpqlhx0a3cb.fsf@anie.imag.fr>, that is:

>> One easy thing to do OTOH would be to show a hint at the end of "git
>> stash pop"'s output, like
>> 
>> $ git stash pop
>> Auto-merging foo.txt
>> CONFLICT (content): Merge conflict in foo.txt
>> 'stash pop' failed. Please, resolve the conflicts manually. The stash
>> was not dropped in case you need to restart the operation. When you are
>> done resolving the merge, you may run the following to drop the stash:
>> 
>>   git stash drop
>> 
>> or so (I couldn't find a concise yet accurate wording).

I'd however have to say that even "please resolve the conflicts
manually" is over-assuming.

I often start some WIP of a fix, realize that the fix should apply
to a lot older maintenance branch than where I happened to have
started the WIP (which typically is at the tip of somebody else's
branch where I received the series from the list---and then noticed
some existing breakage that needs to be fixed), stash the WIP, and
then repeat:

 (1) checkout an old maintenance track;
 (2) try to pop;
 (3) if it succeeds, stop the iteration;
 (4) otherwise, reset and go back to (1) to checkout a bit newer
     maintenance track.

to decide.  So "resolve the conflicts" is assuming the intention of
the user who issued "pop" too much (let alone "manually"---it does
not matter how the user resolves conflicts---the only thing we want
to say is Git did all it would and no further automated help in
resolving is availble, but "manually" is not quite the word).

"The stash was not dropped" is the most important thing in your
additional text.  How about rephrasing like this?

    $ git stash pop
    Auto-merging foo.txt
    CONFLICT (content): Merge conflict in foo.txt

    The stashed change could not be replayed cleanly, leaving
    conflicts in the working tree. The stash was not dropped in case
    you need it again.

    After you are done with the stash, you may want to "git stash
    drop" to discard it.
