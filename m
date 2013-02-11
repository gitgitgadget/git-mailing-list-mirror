From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] shell: allow 'help' command to disable interactive
 shell
Date: Mon, 11 Feb 2013 09:18:18 -0800
Message-ID: <7v38x2ojl1.fsf@alter.siamese.dyndns.org>
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
 <20130211160057.GA16402@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Ethan Reesor <firelizzard@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Greg Brockman <gdb@mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:18:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4x1j-0003AT-IV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:18:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758144Ab3BKRSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:18:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63706 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838Ab3BKRSX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:18:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F3E7CFD6;
	Mon, 11 Feb 2013 12:18:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TlmF9kYp2vbkGmcRkpzXiAhm7SI=; b=GJVKBp
	/Y8bk63pr4+Lnu89Wg7hXRkW2LxtgX29MLbodfbWpg8vABv1bBy70JOcur6mOM1J
	MVlZ8m845bG+mjmEVu6u0H9txNLoeljDeWpA+I90Daqy/DPyqRFz54/sL6fWv+Fp
	Uuao+bWU4Z9EF1Y532gQr6sy9ar2OrmmD2hg0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KneR8yi+l9NPrt26Yx+dbZIx2XvzT48E
	gI6EHuM7HDsnYftx/28qF50JH6A+wcdWWc1ZDXoUG6yfotqK5Y+h5R+N65DFgaav
	V2zTEyNbqWgfoDbLWUsIaGJUAKYopVv1FqpJ36+X5TKgB4eyzxrfaAaIfF5gCItZ
	8Fc/8ZUOc8M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 53037CFD4;
	Mon, 11 Feb 2013 12:18:20 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 91871CFCD; Mon, 11 Feb 2013
 12:18:19 -0500 (EST)
In-Reply-To: <20130211160057.GA16402@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 11 Feb 2013 11:00:57 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 07D3F9E0-746F-11E2-81C1-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216061>

Jeff King <peff@peff.net> writes:

> On Sun, Feb 10, 2013 at 11:17:24PM -0800, Junio C Hamano wrote:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>> 
>> > Isn't that a criticism of the git-shell-commands facility in general?
>> > If it is common to have a lot of users with distinct home directories
>> > but all with git-shell as their login shell, then the
>> > git-shell-commands should not go in their home directory to begin
>> > with, no?
>> 
>> You can give one set of commands to some users while restricting
>> others, no?
>
> But that seems to me to argue against /etc/git/shell-disabled or
> similar, which would apply to every user. Or are you proposing that the
> check be:
>
>   if -d ~/git-shell-commands; then
>           : ok, interactive
>   elif -x /etc/git/shell-disabled; then
>           exec /etc/git/shell-disabled
>   else
>           echo >&2 'go away'
>           exit 1
>   fi

That "shell-disabled" thing was to allow customizing the existing
die() that triggers here:

	} else if (argc == 1) {
		/* Allow the user to run an interactive shell */
		cd_to_homedir();
		if (access(COMMAND_DIR, R_OK | X_OK) == -1) {
			die("Interactive git shell is not enabled.\n"
			    "hint: ~/" COMMAND_DIR " should exist "
			    "and have read and execute access.");
		}
		run_shell();
		exit(0);

so it is more like

	if ! test -d $HOME/git-shell-commands
	then
		if test -x /etc/git/shell-disabled
                then
			exec /etc/git/shell-disabled
		else
			die Interactive is not enabled
		fi
	fi
        ... do whatever in run_shell() ...


> That at least means you can apply _whether_ to disable the shell
> selectively for each user (by providing or not a git-shell-commands
> directory), but you cannot individually select the script that runs for
> that user.  But it's probably still flexible enough;...

Such a flexibility is not a goal of /etc/git/shell-disabled.  The
sole goal is to make the life easier for those site owners that do
not want any interactive shell access to give more friendly and
customized error message.

Those who want further flexibility can exit with non-zero from the
"help" (which is still a misnomer for a hook to disable interactive
for the user).

My primary objection is that implementing only that "more flexible
but requires more configuration work" solution without giving
simpler solution (i.e. just one thing to configure) to the majory of
site owners who only have simpler problem to solve (i.e. just want
to customize "no interactive here"), and saying that the latter can
be done on top.  It is backwards mentality.
