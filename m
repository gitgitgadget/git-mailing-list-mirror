From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Fri, 28 Jun 2013 10:22:57 -0700
Message-ID: <7vli5up2tq.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130628080953.GD2232@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jun 28 19:23:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UscO2-0006S2-55
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 19:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940Ab3F1RXB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 13:23:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34321 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755063Ab3F1RXA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 13:23:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 23CC729CAC;
	Fri, 28 Jun 2013 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ut83tXSjmI8HlLPoNct6lU9BAD8=; b=gQYFTi
	JJ/TJutNbyyS34tYqY1YXwYvxwmN2yGjMliaaeDKQqECK92nOFduGde0YJOOV8Gj
	PCZkCP7M5kdwqI4ATTqGIOP6NBCV6piFeAgmmQGIpxE/t+Rn2gOM4e/hnI8zYI7g
	EUV3MbiEk5GDk1WT8HVc+WdhPTYFmrXoXaOgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BfsTZzwOOOkhj3XyiOXnrqesyCNnsx4B
	zEpiB042vTYMtwTSjZ7MyqMXk5H2JCh7AGamU6NRr02Y59gLOruIPkhwOFptrap4
	Qd8kZz9nyiphvkiBGP0LjHbs7Ro67xmQWCshbprGNUHF3Eke5gVfisBpOJJcBJAu
	90bghiIhB2I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1534F29CAB;
	Fri, 28 Jun 2013 17:23:00 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 610C329CA8;
	Fri, 28 Jun 2013 17:22:59 +0000 (UTC)
In-Reply-To: <20130628080953.GD2232@serenity.lan> (John Keeping's message of
	"Fri, 28 Jun 2013 09:09:53 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 613E5444-E017-11E2-B7AD-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229218>

John Keeping <john@keeping.me.uk> writes:

>>  test_expect_success \
>>      'merge-setup part 3' \
>> -    'git pull . branch1'
>> +    'git pull --merge . branch1'
>
> I think the "--merge" should be implied here because the suer has
> specified an explicit remote and branch.

The whole point of the topic is "It used to be that when you said
'git pull' and did not tell us your preferred way to integrate your
work and work by the others', we default to merging, but we no
longer do so---you have to choose."

Here, "git pull . branch1" is merely saying "I want to integrate
the work on my current branch with that of branch1" without saying
how that integration wants to happen.

Even though, as an old timer, I find it mildly irritating that we
now have to be explicit in these tests, this change is in line with
the spirit of the topic.  If we didn't have to change this example
and the pull silently succeeded without complaining, we achieved
nothing.

>  Similarly, if "--ff",
> "--no-ff" or "--ff-only" are given then we can infer "--merge" in the
> absence of any other configuration.

Isn't that already there in the patch to git-merge?
