From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch documentation problem or bug
Date: Mon, 08 Oct 2012 12:18:25 -0700
Message-ID: <7vbogclqm6.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9Ac06sfFMGizRq6Ztqd2tKS7BBqGOC891=z4615J3f4hA@mail.gmail.com>
 <7vfw5olqp9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 08 21:18:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLIqc-00005P-TQ
	for gcvg-git-2@plane.gmane.org; Mon, 08 Oct 2012 21:18:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735Ab2JHTS3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2012 15:18:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753498Ab2JHTS2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2012 15:18:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C66E88714;
	Mon,  8 Oct 2012 15:18:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vo6I9OX+yy3b7xxMIZ/2ussDx0Y=; b=ExJTXn
	XbYo9uLYVQwrL8EBxdK07/219MQYEu6O+36cZpEqYvgV72vo8CM6o4ELDuokR2Br
	9djyG9UdKsGYSY95vHoBpDB4NuQNVPoeXy2gjeNKOAdh7rqdzsRjesYdUS4tK/t6
	hsRyNHvSeKLbcQoZBBBJMX1t+I9OmRkXRlbl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DJlxkiu85HqMeNirqMZcV4yxrpnF177d
	qkP8yxVIg+RsOElQA0jGrTf1O5wBq4EUAizygeEmxAsfcuy7TkUDZz8sb73sl9VG
	h9PM9inEpau+OfFDZHVZ4EWW+C/Nv/JWW8ESJCiRpJeAkURe5tJlodyUjRBcQKW7
	RY2GA4MEFP4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B41818713;
	Mon,  8 Oct 2012 15:18:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 138BC8711; Mon,  8 Oct 2012
 15:18:26 -0400 (EDT)
In-Reply-To: <7vfw5olqp9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon, 08 Oct 2012 12:16:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EFC5C7A2-117C-11E2-98E0-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207261>

Junio C Hamano <gitster@pobox.com> writes:

> Angelo Borsotti <angelo.borsotti@gmail.com> writes:
>
>> git fetch <repository> <refspec> does not create the remote refs in
>> the current (local)
>> repository...
>> However, if a git fetch origin is executed, the refs are properly created:
>
> Working as designed and documented.
>
>  $ git fetch origin master
>
> is giving the refspec "master" from the command line which is a
> short-hand for "refs/heads/master".
>
> When you run
>
>  $ git fetch origin
>
> configured refspec is looked up from your config (because you didn't
> give any from the command line).  The default refspec in your config
> is likely to be "refs/heads/*:refs/remotes/origin/*".
>
> The former, "refs/heads/master" refspec, tells Git not to update the
> remote tracking branch.  The latter has colon and right-hand-side of
> the colon tells Git what to update with what was fetched.
>
> It would hlep to read up on refspec by running "git fetch --help"
> and looking for a string "colon".

Addendum.  Your claim

>> git fetch <repository> <refspec> does not create the remote refs in
>> the current (local)
>> repository...

is incorrect.  The behaviour depends on what <refspec> you give.

In other words, you can do this from the command line if you want
to do the update.

  $ git fetch origin master:refs/remotes/origin/master
