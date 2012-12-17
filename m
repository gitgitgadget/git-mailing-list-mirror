From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] log --format: teach %C(auto,black) to paint it black
 only on terminals
Date: Mon, 17 Dec 2012 12:03:40 -0800
Message-ID: <7vmwxcla3n.fsf@alter.siamese.dyndns.org>
References: <72BB37CB88C48F4B925365539F1EE46C182613A9@icexch-m3.ic.ac.uk>
 <72BB37CB88C48F4B925365539F1EE46C18261403@icexch-m3.ic.ac.uk>
 <20121213131329.GA5042@sigill.intra.peff.net>
 <CACsJy8AgtwtJfMXzArJLiHQtR+WNRJxRdRgUts30EN-QvgGT=g@mail.gmail.com>
 <20121215101659.GB21577@sigill.intra.peff.net>
 <7v7gojtbgr.fsf@alter.siamese.dyndns.org>
 <7vobhtm5pk.fsf_-_@alter.siamese.dyndns.org>
 <CACsJy8Dt4vEpO+EcAhWnko=XAajQ9OMgbDbVx78Eb=sZTjmKQA@mail.gmail.com>
 <20121217121354.GB21858@sigill.intra.peff.net>
 <7v4njkmq07.fsf@alter.siamese.dyndns.org>
 <20121217194926.GA5209@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	"Srb\, Michal" <michal.srb11@imperial.ac.uk>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:04:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkguv-0005gW-JT
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 21:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753189Ab2LQUDo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 15:03:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53905 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752276Ab2LQUDn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 15:03:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D506C9A34;
	Mon, 17 Dec 2012 15:03:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=crE/CtcWRqQhWOkY0dMV72vfNCs=; b=aqRQZE
	mT0QgQPxXI1ne6MwrQHLI38GFOd/3xjqFCdwXoUrdZ8N7qJmU0KMXysAyr3Ibu28
	aFeVwd6RoYMR0INAsZDw6O+4ClqiDgwzxtm7Ekvbhj89jHjNzGTIXsVOvX1/G4SU
	cZ5SUrXKa67NZuv57V04Db/Vxts3V0II7VyUg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tnrE8m6FKRp/1dUvEP36DFbjbb7YQ75n
	d+FrkzWi89JlCDenehrldka/ODTgh3MjLnP7lv4YISXjAqLaiSFK7/aOF01Mv/19
	h+AxhXJFgJEwdiW4oseuCHPA8ZTNoxMy+L6TPpSn5szeNf+h3AZ8yUv0sKejEZzK
	sbiIypSVxbE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C1A439A33;
	Mon, 17 Dec 2012 15:03:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1EEFD9A31; Mon, 17 Dec 2012
 15:03:42 -0500 (EST)
In-Reply-To: <20121217194926.GA5209@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 17 Dec 2012 14:49:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DAFBD8EA-4884-11E2-AA1D-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211697>

Jeff King <peff@peff.net> writes:

> If "git frotz" wants to have a separate "color.frotz" option to override
> that, then they would need to implement that themselves either with or
> without your patch. I do not think its presence makes things any harder.

That _was_ (but no longer is) exactly my point.  Eh, rather, its
absense does not make things any harder.

> So no, I do not think you can cover every conceivable case. But having
> git-log respect --color and the usual color.* variables for this feature
> seems like the only sane default. It makes the easy cases just work, and
> the hard cases are not any worse off (and they may even be better off,
> since the script can manipulate --color instead of rewriting their
> format strings, but that is a minor difference).

OK, care to reroll the one with your patch in the other message
squashed in, possibly with fixes to the test (the result should now
honor --color={always,never}, I think)?

Thanks.
