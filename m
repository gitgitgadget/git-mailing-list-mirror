From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Mon, 11 Feb 2013 08:17:46 -0800
Message-ID: <7vmwvaomdx.fsf@alter.siamese.dyndns.org>
References: <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
 <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
 <20130211072154.GN15329@elie.Belkin>
 <7vvc9znvk6.fsf@alter.siamese.dyndns.org>
 <20130211081346.GP15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 17:18:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4w57-0002wW-6U
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 17:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757898Ab3BKQRu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 11:17:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53812 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754987Ab3BKQRt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 11:17:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A08BCCFF;
	Mon, 11 Feb 2013 11:17:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZGBwCsYLSdoh+hwmmwl1qDmpz8U=; b=uK2qci
	L4Mo+h3i8Libo1uDU5RThKNtgbSrwN6hak6qUzXObuxRpv6mu1nBblm6fr60cnNQ
	AZHbNVxI5/2tAATRYYzUspW+HODxESOKeamiOUV037gCkFgX3Z2Js9p3zhIoVpBO
	U8SrICR+qwWrqReUu7IQ8iaev98ICJv4nFk7E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Cmc14R4JWQKstr2T+iB0wZm+DQ9+xgbm
	Va6/49A1UJXxYer0U8PWU2vAdga3JsaS5eqnAm5++y80nJ+6AqPUKHwXlh7idXeT
	VZgV/XcycJFVzx+uY+BezVP0A64wc2vVxR1FvMrylBP6vG344HUjLCORulyEfr3u
	kPnafWSixBQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A8ABCCFE;
	Mon, 11 Feb 2013 11:17:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CF9A7CCFD; Mon, 11 Feb 2013
 11:17:47 -0500 (EST)
In-Reply-To: <20130211081346.GP15329@elie.Belkin> (Jonathan Nieder's message
 of "Mon, 11 Feb 2013 00:13:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 93238780-7466-11E2-94CD-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216039>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> The purpose of the directory is to keep custom commands that are
>> allowed.  If the site administrator does not want any command, it
>> would be more natural to expect that the way to disable them would
>> be _not_ to have that directory which is a collection of allowed
>> commands.  Adding that directory and add a "help" that exits with
>> non-zero feels quite a roundabout and counter-intuitive way, no?
>
> I think it comes down to the reason the site admin doesn't want to
> allow interactive logins.  That reason seems to be mostly that
> presenting a
>
> 	git>
>
> prompt at which you can only ask for "help" or "exit" is a bit
> confusing and pointless.  I have sympathy for that, which is why I
> looked for a way for the admin to ask to avoid the prompt altogether
> in that case.

Yeah, the prompt does look pointless.

> I do not think the reason is "because I don't want a
> git-shell-commands directory".  I think it's good to have basically
> one kind of setup instead of significantly different ones with and
> without that special directory --- and it means that starting from a
> setup like this, one can easily drop in additional commands like
> set-head or create-repo without changing anything basic.  It's making
> the admin's later life easier.

I do not think I follow.  If the admin wants to eventually have
extra commands supported at the site, but not yet ready to do so,
isn't it more natural to start with a less elaborate configuration
(i.e. without the directory) now and then add the directory when the
site is ready for offering extra commands later?

> Maybe a better test than "help exits with special exit code" is "there
> are no other custom commands than help".  Would that be more sensible?
>
> From a "make it possible to emulate gitolite" point of view, that
> doesn't permit disabling the interactive mode when there are other
> commands available, so my hunch is that it wouldn't.

A paragraph I had in the message you are responding to before I sent
it out (but removed because it felt somewhat offtopic) said "if the
mechanism to disable weren't the magic 'help exited with failure'
but 'an interactive-disabled flag file exists there', I may find it
less strange to have the directory there", or something like that.

And that flag file could be a custom script that gives a custom
message.
