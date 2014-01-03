From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/4] completion: prioritize ./git-completion.bash
Date: Fri, 03 Jan 2014 15:03:00 -0800
Message-ID: <xmqqtxdkllcr.fsf@gitster.dls.corp.google.com>
References: <1388736031-6068-1-git-send-email-artagnon@gmail.com>
	<1388736031-6068-2-git-send-email-artagnon@gmail.com>
	<20140103225541.GG3338@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Jan 04 00:03:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VzDlz-00032w-Ck
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jan 2014 00:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbaACXDN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 18:03:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753385AbaACXDI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 18:03:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4330A5F127;
	Fri,  3 Jan 2014 18:03:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yQn8Ztzvk/2sgxgf6+0gD8GkssA=; b=qnxU10
	wHK3WKQx3oZD9R65t2WmXWeLq37TynW8oaJF4gl+cazotaqlbUW6AQOqrWZzNueN
	S4RavdERJhIVZNCDMg7RfqWUWbsundOGobmt5laITOMboxORqeeywIGyDSLfkAp+
	wfg0ie7cdBgv7HjNfnF52qpOvFJZYL/KuFkRw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ANyOl1B79z5+0vX/5iAXv+XG0i3kOHge
	2a5BI9Tdn4qhY/zrDxw/LZG4vVNQK0KU4tUix+R62LeRHgjsd5nZ+GpvuNxI+0qi
	1Xvk5tQClGbQ+StMAEDKqpfQkcdT9SBVBT0gcpnSYx7u0xwceNWKdVOFt75d6XOS
	P+zjKo0is+I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 224055F126;
	Fri,  3 Jan 2014 18:03:07 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2810D5F122;
	Fri,  3 Jan 2014 18:03:05 -0500 (EST)
In-Reply-To: <20140103225541.GG3338@vauxhall.crustytoothpaste.net> (brian
	m. carlson's message of "Fri, 3 Jan 2014 22:55:41 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 340DAFE4-74CB-11E3-9913-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239941>

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On Fri, Jan 03, 2014 at 01:30:28PM +0530, Ramkumar Ramachandra wrote:
>> To ease development, prioritize ./git-completion.bash over other
>> standard system paths.
>> 
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  contrib/completion/git-completion.zsh | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
>> index fac5e71..6fca145 100644
>> --- a/contrib/completion/git-completion.zsh
>> +++ b/contrib/completion/git-completion.zsh
>> @@ -30,10 +30,10 @@ if [ -z "$script" ]; then
>>  	local -a locations
>>  	local e
>>  	locations=(
>> +		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>>  		'/etc/bash_completion.d/git' # fedora, old debian
>>  		'/usr/share/bash-completion/completions/git' # arch, ubuntu, new debian
>>  		'/usr/share/bash-completion/git' # gentoo
>> -		$(dirname ${funcsourcetrace[1]%:*})/git-completion.bash
>>  		)
>>  	for e in $locations; do
>>  		test -f $e && script="$e" && break
>
> I'm not clear on this change.  It looks like this loads
> git-completion.bash from the same directory as git-completion.zsh.  Is
> this correct?

I think the idea is to help those who have installed a closer to
bleeding-edge version of completion scripts --- they will not be
reading their zsh completions from the system default locations,
and the place next to it would be a place more likely to have the
matching bleeding-edge version of bash completion than the system
default place.

> Your commit message says "./", and if that's the case, it
> has the same security problems as putting "." first in your PATH.

A correct observation. I think

	Subject: zsh completion: find matching custom bash completion

	If zsh completion is being read from a location that is
	different from system-wide default, it is likely that the
	user is trying to use a custom version, perhaps closer to
	the bleeding edge, installed in her own directory. We will
	more likely to find the matching bash completion script in
	the same directory than in those system default places.

would probably a lot closer to what the patch really does.
