From: Junio C Hamano <gitster@pobox.com>
Subject: Re: cvs import and internal plumbing commands
Date: Tue, 21 Jul 2009 17:43:08 -0700
Message-ID: <7vmy6x35ur.fsf@alter.siamese.dyndns.org>
References: <B9FEA72A-882C-4CF9-97A3-A353F282ACBB@gmail.com>
 <20090716100121.GA6742@coredump.intra.peff.net>
 <7590CBC0-25BA-41D4-9BB5-40550A6CDDF6@gmail.com>
 <20090717214523.GA29955@coredump.intra.peff.net>
 <7vprbwvzu7.fsf@alter.siamese.dyndns.org>
 <20090720153400.GE5347@coredump.intra.peff.net>
 <24155F0E-E467-48EC-9E83-254877B4E786@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Antony Stubbs <antony.stubbs@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 22 02:43:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTPvX-0004mJ-17
	for gcvg-git-2@gmane.org; Wed, 22 Jul 2009 02:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706AbZGVAnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 20:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751625AbZGVAnP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 20:43:15 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34722 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751021AbZGVAnO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jul 2009 20:43:14 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F8AFF252;
	Tue, 21 Jul 2009 20:43:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4BD85F24F; Tue,
 21 Jul 2009 20:43:10 -0400 (EDT)
In-Reply-To: <24155F0E-E467-48EC-9E83-254877B4E786@gmail.com> (Antony
 Stubbs's message of "Wed\, 22 Jul 2009 11\:24\:20 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A3928130-7658-11DE-9A86-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123727>

Antony Stubbs <antony.stubbs@gmail.com> writes:


> On 21/07/2009, at 3:34 AM, Jeff King wrote:
> ...
>> But I guess the plan was softened, and we have no deprecation plan for
>> dashed forms in exec-path. So maybe my thinking was outdated.
>>
>>> So the preferred fix might be just the matter of adding one line
>>>
>>> 	$ENV{'PATH'} = `git --exec-path`. ":$ENV{'PATH'}";
>>>
>>> at the beginning of the script.
>>
>> I can see that for a totally third-party script which wanted to use
>> git
>> plumbing.  But why do that for a git-* script? The "git" wrapper
>> sets up
>> the environment like that already.
>>
>> -Peff

[note: do not top post]

> But regardless, surely calling straight into git is simpler/nicer and
> more likely to just work (as on OSX)?
>
> From the 1.6.0 release notes
> (http://www.kernel.org/pub/software/scm/git/docs/RelNotes-1.6.0.txt ):
> """With the default Makefile settings, most of the programs are now
> installed outside your $PATH, except for "git", "gitk" and some server
> side programs that need to be accessible for technical reasons.
> Invoking a git subcommand as "git-xyzzy" from the command line has
> been deprecated since early 2006 (and officially announced in 1.5.4
> release notes); use of them from your scripts after adding output from
> "git --exec-path" to the $PATH is still supported in this release, but
> users are again strongly encouraged to adjust their scripts to use
> "git xyzzy" form, as we will stop installing "git-xyzzy" hardlinks for
> built-in commands in later releases. """

In case you are too new to the git land, I'd point out that "... as we
will stop installing" part was rescinded after a big fiasco that
immediately followed 1.6.0 release.

> note the "but users are again strongly encouraged to adjust their
> scripts to use "git xyzzy" form". Why not just apply the patch and be
> done with it?

Note that my suggestion on $PATH=$(git --exec-path):$PATH was a response
to Jeff's message, which was the same message your patch was response to.
In other words, our messages crossed, and I do not have an issue with
fixing this either way.  If your patch fixes the issue correctly that
would be great.

Has anybody reviewed the submitted patch?  I do not use cvsimport these
days anymore for anything real, so the only assurance I have on your patch
so far are my eyeballs and whatever tests done in test scripts in the t/
directory.  Independent "Yeah, it looks good and it works for me" would
make me feel a bit safer.
