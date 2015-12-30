From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug] Graph log and orphan branches
Date: Wed, 30 Dec 2015 13:24:40 -0800
Message-ID: <xmqqa8oreijr.fsf@gitster.mtv.corp.google.com>
References: <CAELgYhe4u2qU0-+mBKGwf8CpdZ=MuWMFZmeOhojtdMQZ3-nfhQ@mail.gmail.com>
	<xmqqziwremqh.fsf@gitster.mtv.corp.google.com>
	<1451508209.9251.13.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos Pita <carlosjosepita@gmail.com>, git@vger.kernel.org
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 22:25:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aEOF4-00005q-5x
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 22:25:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754880AbbL3VYp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2015 16:24:45 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753899AbbL3VYm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2015 16:24:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 18F95356F7;
	Wed, 30 Dec 2015 16:24:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gQlCzlatSKDwxtk+QpLbelPsufI=; b=RGz5Fi
	Lj7IcZPaSJSihswYakquS3iW5HCqCAVysw1XQSF1BDMxIWVthhIGpZB/LwWJc+RN
	9r5qoZ8evc1plUgGip2gSqkTWw5xlWRETB372lcj9hD/eVUPW5++VYtb8QIEsW08
	TnIrxcHb8I4xoTH4wTwAfVrqKOwOV4SYxgIEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kfj6auu0kWiNJqUgVfAN/VZgdkkSpv9x
	V22YiKUAGbv1ZgXIWAYMUhO7Mjrmztd6vrau/U5sKYuuHFwSK2+MY42wQHSe9Qe4
	/vPlMbhJyfGr3MWpoN/rTkq+VzSq8/Jh6tAEJXCxaB2bELlRtUDWBEb7roTtFSVn
	bkCxjd+BgYI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 105D8356F6;
	Wed, 30 Dec 2015 16:24:42 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 887C5356F4;
	Wed, 30 Dec 2015 16:24:41 -0500 (EST)
In-Reply-To: <1451508209.9251.13.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Wed, 30 Dec 2015 21:43:29 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BD21D51A-AF3B-11E5-9803-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283199>

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On wo, 2015-12-30 at 11:54 -0800, Junio C Hamano wrote:
>> Carlos Pita <carlosjosepita@gmail.com> writes:
>> 
>> > the graph output of log show orphan branches in a way that suggests
>> > they have a parent.
>> 
>> Reminds me of this ancient RFH topic
>> 
>>   http://thread.gmane.org/gmane.comp.version-control.git/236708/focus
>> =239580
>> 
>> which unfortunately got no help...
>
> Instead of a blank line, why not something like this to make root
> commits stand out a bit?
>

That approach will lose information when a root commit is at the
boundary, marked as uninteresting, or on the left/right side of
traversal (when --left-right is requested).  As these pieces of
information that will be lost with such an approach are a lot more
relevant than "have we hit the root?", especially in the majority of
repositories where there is only one root commit, I do not think it
is acceptable.
