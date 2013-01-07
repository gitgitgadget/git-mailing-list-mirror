From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Moving (renaming) submodules, recipe/script
Date: Mon, 07 Jan 2013 08:08:49 -0800
Message-ID: <7vlic5j7qm.fsf@alter.siamese.dyndns.org>
References: <20130107003603.GA25698@odin.tremily.us>
 <20130107013952.GE3823@elie.Belkin> <50EA7269.1080006@web.de>
 <7vwqvpjv2n.fsf@alter.siamese.dyndns.org> <50EA84E9.9030702@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Peter Collingbourne <peter@pcc.me.uk>, mbranchaud@xiplink.com,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 07 17:09:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsFGF-0003x6-9N
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 17:09:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab3AGQIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 11:08:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48774 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317Ab3AGQIx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 11:08:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E2A80A6A5;
	Mon,  7 Jan 2013 11:08:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uEvqfxy6QJPkJobswuQxkAcvnVk=; b=JQBqua
	o/iBVsrSZjmfBfMiI4kIE4H4X7RKKKrFdSucv0RaNe+srRSFgktyMlGQNPOshmcT
	krarZCSAdqbHhhCW9gQmBS64sogTcKFmTDy+//oZ/r4jcbuEgEG/hPqO020O/46j
	l5bYwAQ6HIG+x91/HJlqljy1r5SMt15lF96Xk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wpbLA4VLFL4Fnek+8F5CSEAxgoM6a3DT
	Z22jJaIigniJ6gyKVFCDz4n4QbSHULi/yjZ98FQrQQIlJTh6XUTA02/Ny3wz/AXb
	8Izzkuugk48kxcpqTwfq2bBsowPlyI9pHyocF0oQ+msAoSJfGZk6BgPKlyWytnlU
	WXdgx1hKJpo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D4208A6A3;
	Mon,  7 Jan 2013 11:08:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 48303A69E; Mon,  7 Jan 2013
 11:08:52 -0500 (EST)
In-Reply-To: <50EA84E9.9030702@web.de> (Jens Lehmann's message of "Mon, 07
 Jan 2013 09:18:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 877ADCFA-58E4-11E2-B277-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212900>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Right, and me thinks that would warrant a --force option for deinit
> to do that even if the submodule contains local changes (which would
> make deinit fail otherwise).

Probably.

> Additionally Michael and Marc spoke up
> that they would rather have a --all option to deinit all initialized
> submodules and "git submodule deinit" without any arguments should
> just produce a usage message. As I saw no voices against it that'll
> be part of the next iteration too.

Yeah, I forgot about that possible surprise of deiniting everything
under the sun by default.

I am not sure if "--all" is a good way forward, though.

Can you defeat it with "git submodule deinit ./--all" or something
to limit the target only to one submodule whose unfortunate location
is named as such?  If you have such a support, I have this suspicion
that you already get a short and explicit way to say "everything
under the current directory" with "git submodule deinit ." for free.
