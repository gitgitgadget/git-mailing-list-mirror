From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 21:22:33 -0800
Message-ID: <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
References: <CAE_TNikk-9sYVRQRwRecNpp3otQ+oc=uV9SPu+7pAkCUNbcUoQ@mail.gmail.com>
 <20130210212538.GA11720@elie.Belkin>
 <20130210224345.GA32318@sigill.intra.peff.net>
 <7vfw13rd9x.fsf@alter.siamese.dyndns.org>
 <CAMK1S_jFUXiHM6teVwoxO9gv77B1KBQoSi-B32dwVKemXnDx9w@mail.gmail.com>
 <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 06:23:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4lrD-0000vl-Ib
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 06:23:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798Ab3BKFWj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 00:22:39 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56432 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750717Ab3BKFWi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 00:22:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BA644B804;
	Mon, 11 Feb 2013 00:22:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8d6VvZ5cbeG5eAr0nl/6Jb6DbRs=; b=hEfpcr
	PVz592Ol556s6N1IUEWfQXvGn1p+MqXwE9hThHuqMI92LIGTBDkmVxXT+xWxdnh+
	zQ8yeha9Bc8YP984NYYbHjQ1pOjQ9KVQnlZbuCkfl+CxAyWFMr6psR9luhAReIp3
	fXP+G7XgeB0KDk6cHRdCkTHzQKWpFC2CTCPc4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qjpMecjmx8iJ4rcNZQDZHO0/U78asfkH
	eJMoPmgNzu2gj6MOSJx5sG80liNTnhKDDgBKcaZde2IUyp5yCvsFpYzYNgMhDGsL
	XocD46Blmd0etzd45mmOygmVwyUJ4D9Niy3J4jnQksv+5I9xb7Dfe68jwJ99Fyfe
	Md5Ewkfs/8g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEA24B801;
	Mon, 11 Feb 2013 00:22:37 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D7369B7F3; Mon, 11 Feb 2013
 00:22:35 -0500 (EST)
In-Reply-To: <20130211043247.GD15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 20:32:47 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0BF9CD10-740B-11E2-BC04-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215992>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>               Are you shooting for customizability?
>
> Yes, and the ability to generate the message dynamically.

Hmph, if that is the case, wouldn't it be a better direction to give
a better help for majority of the case where git-shell is used as
the login shell to allow push and fetch but not for interactive
access at all?

The first step in that direction may be to give a better canned
message, followed by a mechanism (perhaps a hook) that lets a
message customized for the site's needs, no?  Why should a site
administrator create an otherwise empty directory for each and every
user and add an executable in there that shows an error message,
only to improve the default message because it is not friendly
enough?

I may be being slower than usual, but I am still not convinced...
