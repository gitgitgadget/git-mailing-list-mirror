From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [RFH] GSoC 2015 application
Date: Fri, 20 Feb 2015 11:06:53 +0100
Message-ID: <vpqwq3cdhhe.fsf@anie.imag.fr>
References: <20150218191417.GA7767@peff.net> <vpqzj8ary29.fsf@anie.imag.fr>
	<20150220020022.GC16124@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 11:07:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOkUL-0007pA-PC
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 11:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbbBTKHG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 05:07:06 -0500
Received: from mx1.imag.fr ([129.88.30.5]:42706 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753735AbbBTKHF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 05:07:05 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id t1KA6qUF019500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Feb 2015 11:06:52 +0100
Received: from anie.imag.fr (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id t1KA6rOx031020;
	Fri, 20 Feb 2015 11:06:53 +0100
In-Reply-To: <20150220020022.GC16124@peff.net> (Jeff King's message of "Thu,
	19 Feb 2015 21:00:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Feb 2015 11:06:52 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: t1KA6qUF019500
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1425031615.29673@6fczvY+b9oqdEmttgI1G7g
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264144>

Jeff King <peff@peff.net> writes:

>> * Be nicer to the user on tracked/untracked merge conflicts
>> [...]
>
> Sounds OK to me, though I agree the merging of untracked files is a
> little controversial.

Yes. To me, part of the project is to identify cases where this is
actually not controversial (OTOH, it's a bit frustrating when I do a
trivial pull and Git complains because I already have the file).

>> +### Move ~/.git-credentials and ~/.git-credential-cache to ~/.config/git
>> +
>> +Most of git dotfiles can be located, at the user's option, in
>> +~/.<file> or in ~/.config/git/<file>, following the [XDG
>> +standard](http://standards.freedesktop.org/basedir-spec/basedir-spec-latest.html).
>> +~/.git-credentials and ~/.git-credential-cache are still hardcoded as
>> +~/.<file>, and should allow using the XDG directory layout too
>> +(~/.git-credentials could be allowed as ~/.config/git/credential and
>> +~/.git-credential-cache could be allowed as ~/.cache/git/credential,
>> +possibly modified by $XDG_CONFIG_HOME and $XDG_CACHE_HOME).
>> +
>> +Each of these files can be a microproject of its own. The suggested
>> +approach is:
>> +
>> +* See how XDG was implemented for other files (run "git log --grep
>> +  XDG" in Git's source code) and read the XDG specification.
>> +
>> +* Implement and test the new behavior, without breaking compatibility
>> +  with the old behavior.
>> +
>> +* Update the documentation
>
> I think these might be getting a little larger than "micro".

The ~/.git-credential-cache may be a bit harder, but the case of
~/.git-credentials should follow the same pattern as files for which
this is already done. So, doing it by mimicking existing code shouldn't
be too hard.

But maybe that's me being optimistic ;-).

>> +### Add configuration options for some commonly used command-line options
>> +
>> +This includes:
>> +
>> +* git am -3
>> +
>> +* git am -c
>> +
>> +Some people always run the command with these options, and would
>> +prefer to be able to activate them by default in ~/.gitconfig.
>
> The direction here seems reasonable, though I think we have
> mailinfo.scissors already, so "-c" may not be a good example.

Ah, indeed. The documentation makes it a bit hard to find, but I'll send
a patch.

>> +### Add more builtin patterns for userdiff
>> +
>> +"git diff" shows the function name corresponding to each hunk after
>> +the @@ ... @@ line. For common languages (C, HTML, Ada, Matlab, ...),
>> +the way to find the function name is built-in Git's source code as
>> +regular expressions (see userdiff.c). A few languages are common
>> +enough to deserve a built-in driver, but are not yet recognized. For
>> +example, CSS, shell.
>
> I am not sure that understanding the horrible regexes involved in some
> userdiff counts as "micro", but OK. :)

I agree the regexes are horrible, but here also the project is not about
doing something really new, but reproducing what has already been done
for others.

At least, students not fluent with regular expressions have a pointer to
userdiff.c and can quickly see that the microproject is not meant for
them ;-).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
