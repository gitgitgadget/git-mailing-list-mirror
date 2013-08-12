From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] status: always show tracking branch even no change
Date: Sun, 11 Aug 2013 23:15:53 -0700
Message-ID: <7vd2pj1lk6.fsf@alter.siamese.dyndns.org>
References: <7vob964l6v.fsf@alter.siamese.dyndns.org>
	<8b2e7fa581846aca3209b430ac46950ff9d92924.1376146168.git.worldhello.net@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git List <git@vger.kernel.org>
To: Jiang Xin <worldhello.net@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 08:16:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8lQ9-0003VU-Lr
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 08:16:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab3HLGP5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 02:15:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44125 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754164Ab3HLGP5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 02:15:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3164B34BC5;
	Mon, 12 Aug 2013 06:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2iCaNUPbd4S7KR5usb1dknsQNLM=; b=yREcwN
	v4MWCtjRePvLPYNVTqN5ZfSuyZUpaLo99qRQngCrMk9MRUaR+/zkL6mmfPUgzVHN
	3gvbd/K9EvZi3yvCbZa5wqMBeLXB5tkQRiMVw2+7TFSGY0cQlegyIx13d8+NG8k4
	VNywXSRuK0uykRkYH5oA65YTwFL9DVc8XUsKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BJJDlJ8ZXGikIHpCDq2FAUqqy/YXtwdL
	8GjfNA8dVnU2raCko+toZ3pj4G30e6+sORF8zNQzj51ADswwLNy/TjO56sea8QEJ
	faqGNgwfvQ1QKrAauh0i9kta98JadByHEM4CcfSkKatwjjLFOu8vUjtOZSGwavrX
	vbB5aaUR2VM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2481F34BC4;
	Mon, 12 Aug 2013 06:15:56 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D587A34BC0;
	Mon, 12 Aug 2013 06:15:54 +0000 (UTC)
In-Reply-To: <8b2e7fa581846aca3209b430ac46950ff9d92924.1376146168.git.worldhello.net@gmail.com>
	(Jiang Xin's message of "Sat, 10 Aug 2013 23:05:09 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A54F70CE-0316-11E3-A7D2-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232155>

Jiang Xin <worldhello.net@gmail.com> writes:

> 2013/8/10 Junio C Hamano <gitster@pobox.com>:
>> Jiang Xin <worldhello.net@gmail.com> writes:
>>
>>> So always show the remote tracking branch in the output of "git status"
>>> and other commands will help users to see where the current branch
>>> will push to and pull from. E.g.
>>> ...
>>
>> Hmmph.
>>
>> I do not know if this will help any case you described above, even
>> though this might help some other cases.  The added output is to
>> always show the current branch and its upstream, but the thing is,
>> the original issue in $gmane/198703 was *not* that the current
>> branch was pushed and up to date.  It was that there was no current
>> branch to be pushed.  The same thing would happen if you are on a
>> local branch that is not set to be pushed to the other side
>> (e.g. the configuration is set to "matching" and there is no such
>> branch on the other end).
>>
>
> How about write the commit log like this:
> ...
> Then if there is no tracking info reported, the user may need to do
> something. Maybe the current branch is a new branch that needs to be
> pushed out, or maybe it's a branch which should add remote tracking
> settings.

Would that help anybody, though?

A user who does not notice the _lack_ of mention of the current
branch in the feedback from "git push" would not notice the lack of
"ahead, behind or the same".

We could contemplate on saying "your current branch is not set to be
pushed out to anywhere" instead of being silent in the case where
the output with your patch is silent, but that would make "status"
output irritatingly chatty when you are on a private topic branch
that you never intend to push out except as a part of an integration
branch after merging into it, so it is not a good solution either,
but at least that would solve the original problem.

Isn't it the real solution to the original poster's problem to make
"git push" explain "Everything is up to date, and nothing is pushed"
case better?

Perhaps "git push" can learn an option to show what the command
would push out if there were something to push.  If push.default is
set to matching and the user is on a branch that does not exist on
the receiving end, matching branches will be listed as "up to date"
and the user could notice that his current branch is _not_ among the
ones that are listed.  When there is _no_ branch to be pushed out
(e.g. there is no matching branches, or you are on a detached HEAD)
that "please explain" option could really explain whey there is no
branch to be pushed out".
