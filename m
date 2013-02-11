From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:01:41 -0800
Message-ID: <7vliavpc4q.fsf@alter.siamese.dyndns.org>
References: <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:02:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4nOz-00026h-VL
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:02:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752385Ab3BKHBq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:01:46 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60989 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751926Ab3BKHBq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:01:46 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D8BFBA0B;
	Mon, 11 Feb 2013 02:01:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZqwgJPuAXXYhxwXLem8Enp4M8sM=; b=hXX/2L
	HmgmE7qFrO9nQdsVvS4q9nkwiY4/4QZ4H1u3sMJH9Rd5QPiGsXfIR0Z/7U3/qucD
	XkWrYWIriTaQtgyZmf8cEtwp57/rkt3HzetgxBwAAPC939vVQRPWW3nM0R6fWM/M
	8dyMuQStAMylZMLQp2Eoj1tgHa+IW8WehNSVk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TAfXzfPG4EJtyLXlOxa0ewXJ/tlZogsZ
	WauMxNduVFOK/7kgu1DGJmhGTfexGe8kUDrY3Ijgxa5FCTBqKhrht/oTFRL1QmA0
	mu/ArG39F55vU8sM59D+mFJKCij1WlHafuMYZBkX4AfYPMX+/cJaFMUDqlFO5++c
	h1M9md5m2gQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31A00BA0A;
	Mon, 11 Feb 2013 02:01:45 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84140BA09; Mon, 11 Feb 2013
 02:01:44 -0500 (EST)
In-Reply-To: <20130211061442.GI15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 22:14:43 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E5112460-7418-11E2-B6DF-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216006>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Junio C Hamano wrote:
>
>>>>               Are you shooting for customizability?
>>>
>>> Yes, and the ability to generate the message dynamically.
>>
>> Hmph, if that is the case, wouldn't it be a better direction to give
>> a better help for majority of the case where git-shell is used as
>> the login shell to allow push and fetch but not for interactive
>> access at all?
>>
>> The first step in that direction may be to give a better canned
>> message, followed by a mechanism (perhaps a hook) that lets a
>> message customized for the site's needs, no?
>
> The trouble is that I can't imagine a canned message that everyone
> will like.  (For example, I quite dislike the current one.)  That's
> exactly the situation in which some configurability is helpful.

I am not saying we should have a perfect canned message everybody
likes and not have any configurability.  I however think we can aim
to come up with a message that covers 80% of site administrators who
do not care too much and just want git-shell to allow the standard
services without giving any custom command.

And for the remaining 20% of those who do not like the canned
message but still do not need any custom command, I think it is way
suboptimal to force them to create git-shell-commands directory for
47 users his host gives git-shell access to, and copy the "help"
script to all of them, only to get a customized message.  It would
help them quite a lot if you just called /etc/git/shell-disabled or
some hook that generates a customized message; then there is no need
to add any git-shell-commands directory and a "help" script every
time he gets one new user, no?

For those who _do_ want to give customized commands to their users,
they can already have "help" script to give a friendly message.  It
just felt silly to force sites to create the directory only to
refuse an access to the "custom commands" feature, especially when
the existence of that directory is a signal that the site may want
to give its users an acess to that feature.
