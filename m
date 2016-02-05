From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Clarification on the git+ssh and ssh+git schemes
Date: Fri, 05 Feb 2016 14:11:52 -0800
Message-ID: <xmqq1t8qdcyf.fsf@gitster.mtv.corp.google.com>
References: <62DF0D5B-83DF-465D-9786-A4E7DA97F2BA@dwim.me>
	<20160205193027.GC7245@sigill.intra.peff.net>
	<CA+55aFyWqK0bu2V1SYagrYCBGpj0=2orobK2vT-KRkqpq=kgtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 23:12:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRobg-0003ZM-7Y
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 23:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753542AbcBEWL4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 17:11:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:56340 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751637AbcBEWLz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 17:11:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F78F412BD;
	Fri,  5 Feb 2016 17:11:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RrylQhnr32yZ3FVhGR3Clo4QqJw=; b=fqc8iJ
	I+yEEnJaapsjUkhAThZaAusYPxAyFghKAfxK+W7fFQn4tnDUM1FT8xioiSmEVe4q
	lnWd2NDXLI7UmCL62mw0CfWA/IqjHbA0Mq578UIoNX5m6G4I6mVTaJdEloGlcGSi
	Uxxp18xvFDCT7Tj+blWQSkanGQ70e9oRX7XCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QHcTYZyPABk6wJTEW89o7aYgcpZ4X/Uy
	vBxW0e0sY3y5bV9rtfpxtW2NLfrpO9mYKsD613MY2GmBb+CHMII4YXEtYnpA4/gG
	3WHhQsjzPt2GYOyS7tm6DsYHe+1LSbn7qTAdUZ8fY74d4RfvcSbeUbLgP6wXem+E
	mbDO5c/m/74=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 961BD412BC;
	Fri,  5 Feb 2016 17:11:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 12AD8412BB;
	Fri,  5 Feb 2016 17:11:54 -0500 (EST)
In-Reply-To: <CA+55aFyWqK0bu2V1SYagrYCBGpj0=2orobK2vT-KRkqpq=kgtw@mail.gmail.com>
	(Linus Torvalds's message of "Fri, 5 Feb 2016 11:36:25 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76BAA5C0-CC55-11E5-BD55-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285643>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, Feb 5, 2016 at 11:30 AM, Jeff King <peff@peff.net> wrote:
>>
>> I suspect they were not really documented because nobody wanted to
>> encourage their use. I don't think it would be wrong to document that
>> they exist and are deprecated, though.
>
> They exist because some people seemed to think that people shouldn't
> use "ssh://" since they thought that only ssh should use that.
>
> Which is obviously bullshit, since by that logic all the other formats
> should have that idiotic "git+" format too ("git+https", anybody?). It
> doesn't actually help anything, and it only pushes somebodys broken
> agenda.
>
> So there was a push for that silly thing by a couple of people, but it
> was always wrong. Don't even document it.

"git+https://" is actually an interesting thing to think about.

Those who argued that "ssh://" should only be used by ssh would say
for the same reason that "http://" is OK only when Git is using the
old "commit walker" aka "dumb" HTTP transport, and the modern "Git
protocol over HTTP" aka "smart" HTTP should not use "http://".

Which is a problematic stance to take.  It would force inconvenience
on our users, especially when the server side support for the modern
"Git over HTTP" is done in such a way that it can co-exist with the
commit walker transport.

So in that sense, "git+https://" does not help anybody.  I however
wouldn't use such strong words like you did ;-)

 - If we see "hg+http://" or "svn+http://" URL, that would help
   people to immediately know that "git clone" would not work
   against them, so for us who live in Git world, "git+http:// does
   not buy anything (assuming that we know better than assuming all
   "http://" are clonable, e.g. "git clone http://nytimes.com"), it
   would help if others marked their non-Git URL as such.

 - During technical discussion inside Git circle when we need to
   differentiate the "smart" and "dump" HTTP transports, it may help
   to be able to say "git+http://" and "http://".  And people who
   heard such a conversation may be tempted to say "git+http://" to
   talk to a Git repository that is known to talk the "smart HTTP"
   protocol.

Devil's advocate mode off.

> Leave it in the source code as an option, and maybe add a comment
> about "This is stupid, but we support it for hysterical raisins".

Sounds good.
