From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Sun, 10 Feb 2013 23:44:57 -0800
Message-ID: <7vvc9znvk6.fsf@alter.siamese.dyndns.org>
References: <20130211012016.GA13243@elie.Belkin>
 <7v7gmfqzt1.fsf@alter.siamese.dyndns.org>
 <20130211041706.GB15329@elie.Belkin>
 <7vwqufpj50.fsf@alter.siamese.dyndns.org>
 <20130211043247.GD15329@elie.Belkin>
 <7vpq07pgpy.fsf@alter.siamese.dyndns.org>
 <20130211061442.GI15329@elie.Belkin>
 <7vliavpc4q.fsf@alter.siamese.dyndns.org>
 <20130211071235.GL15329@elie.Belkin>
 <7v8v6vpbej.fsf@alter.siamese.dyndns.org>
 <20130211072154.GN15329@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, Jeff King <peff@peff.net>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 08:45:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4o4q-0004Iz-Ji
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 08:45:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710Ab3BKHpA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 02:45:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47366 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752595Ab3BKHpA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 02:45:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A40C69E3;
	Mon, 11 Feb 2013 02:44:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9RUCKreAwGKVUFOW5+scqpjCqKg=; b=YQrfa8
	XbDiQt0KihphkECMfLaKdW0PHwa487p0YajR/klK9qAgmCfZwkWNvd2nf9BfdALL
	+cVrdms4WqF22fC6d0zIE1dXZ7+AFbD1ozz7J0iatZ48FmOg5tCtCxKFOu9/q9jl
	qPeM+O44uuMnKosOVGHNintPTt5x6MkAR1Os8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Dodbe2tFhmuxO/5617RWYBcrILDJXReU
	U5GDEcs37lbKAUCTGeC7ahhS0I2v1lya19yl+9l6medtNPO5mtqj1n4wl1U1uQTA
	d9AQ5Aty1ofpR0yOwSdCH6GILNKmz7aKQj0PqNk9L3uRlJvMPChPcKTg7FhOkZI8
	CJASJxOvAY4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4DBC669E2;
	Mon, 11 Feb 2013 02:44:59 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D423C69E1; Mon, 11 Feb 2013
 02:44:58 -0500 (EST)
In-Reply-To: <20130211072154.GN15329@elie.Belkin> (Jonathan Nieder's message
 of "Sun, 10 Feb 2013 23:21:54 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EF672FE4-741E-11E2-8BB0-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216018>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>>> Isn't that a criticism of the git-shell-commands facility in general?
>>> If it is common to have a lot of users with distinct home directories
>>> but all with git-shell as their login shell, then the
>>> git-shell-commands should not go in their home directory to begin
>>> with, no?
>>
>> You can give one set of commands to some users while restricting
>> others, no?
>
> Yes, I assume one goal of the current design was to let you set up
> multiple configurations by making multiple home directories.

Even if the site configures its 47 git-shell users to share the same
home directory /home/gituser, I still think it is a bad design to
force the administrator to create a directory in it, only to add a
script called "help".

The purpose of the directory is to keep custom commands that are
allowed.  If the site administrator does not want any command, it
would be more natural to expect that the way to disable them would
be _not_ to have that directory which is a collection of allowed
commands.  Adding that directory and add a "help" that exits with
non-zero feels quite a roundabout and counter-intuitive way, no?
