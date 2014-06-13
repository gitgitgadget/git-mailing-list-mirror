From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add an explicit GIT_DIR to the list of excludes
Date: Fri, 13 Jun 2014 09:50:33 -0700
Message-ID: <xmqqfvj84uue.fsf@gitster.dls.corp.google.com>
References: <CACsJy8Cgu792Tamej3+_9w=Krg8nezYYA6k604gikebHG=yVUg@mail.gmail.com>
	<1402529308-3940-1-git-send-email-pasha.bolokhov@gmail.com>
	<53994667.90209@kdbg.org>
	<CAKpPgvf=OGRHFv81x2b_PVqzALbSWHaJvejyy5w7aS_P+QFA6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 18:50:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvUge-0003sO-L6
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 18:50:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbaFMQul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 12:50:41 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51678 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752507AbaFMQuk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 12:50:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 87A211E510;
	Fri, 13 Jun 2014 12:50:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=shaiAB2/DMhl66V8GNKr9t5ZPC0=; b=Pd0wgq
	2uwdJf6dFvIjVyt9Kp20g/L+jYWboOFkB172QlFRmE2v/ZU63dnfl+mdXVWNUuVK
	y5Agwt6ZL3/p/wezFZ36erV3YnehfDOfdaKX44lKheBcso3p9DlMalR698XZS04B
	roQILZgckcQ4CroZKE3HFo2bWYE0EQnjuzjis=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=If0bg4YjobUvTgw9yD1xGzXaoHYMFRq9
	6yG3QQ4wF8mI28xthruzKn2Qfa1DszirwpswQ7ixqGTJ1g6OKK2quopS7VOF5d8z
	SfrssH1vE/pA2LVL9DFGoYEYAPmufpPdFY2wB2OPd6hHMIyThXtLzegcLjLVFpf4
	w//IY7lsOeY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7CA011E50F;
	Fri, 13 Jun 2014 12:50:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 504061E50C;
	Fri, 13 Jun 2014 12:50:35 -0400 (EDT)
In-Reply-To: <CAKpPgvf=OGRHFv81x2b_PVqzALbSWHaJvejyy5w7aS_P+QFA6w@mail.gmail.com>
	(Pasha Bolokhov's message of "Fri, 13 Jun 2014 09:10:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D70F4964-F31A-11E3-ADFC-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251612>

Pasha Bolokhov <pasha.bolokhov@gmail.com> writes:

>>> +             test_cmp status.actual.2 status.expect.2
>>
>> It is customary to call the files 'expect' and 'actual'. Furthermore,
>> swap the order so that in case of a failure the diff shows how the
>> actual text was changed from the expected text:
>>
>>                 test_cmp status.expect.2 status.actual.2
>
> So, is naming the files "status.expect.2" instead of just
> "expect"/"actual" ok or not?

Unless there is a compelling reason not to, just use expect/actual,
without "status." or ".<number>".  When debugging, people pass the
"-i" (and often "-v") to the script which would stop at the first
breakage.  If they can inspect the result in "actual", that is far
more pleasant than having to know that it is status.actual.43 they
have to inspect while ignoring clutters in status.actual.{1-42} that
have nothing to do with the breakage they are dealing with.

> Ok, no problem, will change that. The only thing, I saw this in other
> tests, so decided to use it too. Those tests use "test_mighf_fail rm"

"might_fail" and "must_fail" are totally different beasts.
"must_fail" is about controlled failure exit (i.e. no segfaulting
allowed) and we avoid using it on non-git things.

When you run clean-up commands without knowing if there is anythning
to clean-up, e.g. you may or may not have successfully created a
junk file and you want to make sure that file does not exist.  It
happens that "rm junk" has a convenient option "-f" to make it not
barf upon missing "junk", so you can do so with "rm -f junk" instead
of saying "test_might_fail rm junk", but "might_fail" is designed to
be useful for commands that do not have such a convenient option.
