From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Introduce the GIT_HOME environment variable
Date: Mon, 21 Dec 2009 11:25:45 +0100
Message-ID: <vpqhbrkd3o6.fsf@bauges.imag.fr>
References: <4B2C0828.4010505@signalbeam.net>
	<20091219013246.GD25474@genesis.frugalware.org>
	<7vhbrnodd9.fsf@alter.siamese.dyndns.org>
	<4B2C5A1A.8000201@signalbeam.net>
	<7vzl5fik3o.fsf@alter.siamese.dyndns.org>
	<20091219153046.GG25474@genesis.frugalware.org>
	<vpqeimq51pq.fsf@bauges.imag.fr>
	<7vskb6bwvu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, Moe <moe@signalbeam.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 21 11:29:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMfW5-0003I8-Pc
	for gcvg-git-2@lo.gmane.org; Mon, 21 Dec 2009 11:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754547AbZLUK3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2009 05:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbZLUK3Y
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Dec 2009 05:29:24 -0500
Received: from imag.imag.fr ([129.88.30.1]:55153 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754451AbZLUK3X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2009 05:29:23 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id nBLAPjgw009251
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Mon, 21 Dec 2009 11:25:48 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1NMfST-0003YR-MD; Mon, 21 Dec 2009 11:25:45 +0100
In-Reply-To: <7vskb6bwvu.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Sat\, 19 Dec 2009 11\:13\:09 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.1.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Mon, 21 Dec 2009 11:25:53 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135553>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
>
>> http://standards.freedesktop.org/basedir-spec/basedir-spec-0.6.html
>>
>> It solves the same problem ("set on environment variable, and change
>> my whole Git config"), but
>>
>> * It's a standard. It's really nice to be able to ...
>> * It avoids hidden files. With $GIT_CONFIG, a user doing
>
> I think the above are actually three bullet points (i.e. you lack line
> break and bullet before "It's really nice").

No, I don't.

You can do

| cd ~/.config
| ls
| 
| to see a user's configuration for many applications at a time,

_because_ it's a standard, and because it's followed by several
applications.

> And the third bullet is more or less a small subset of the second
> one, since you need "ls -a" without making them non-dot,

The standard may not write black-on-white
$XDG_CONFIG_HOME/subdir/filename _with filename being non-hidden_, but
in practice, this is what's happening.

> And I personally don't care very much about that second "It's really
> nice to be able to" point.

You may not care about consistancy between applications, but I do.
Currently, to version-control my user's configuration, I have
$HOME/etc containing my user's config files, and the actual config
files are symlinks to it. If applications were agreeing on a directory
where configuration files would be stored (is it is the case on
systems like MS Windows, and I think Mac OS), I would just had done
"cd this-config-directory; git init".

With the proposed $GIT_HOME, I have a way to specify _Git_'s path to
config files. Another application may propose $WHATEVER_ELSE_HOME, and
yet another would say $HOME_YET_ANOTHER_ONE, and so on. There's a
proposal to have a single environment variable for all this, why
reject it?

> As to the particular "standard" cited, I don't know how relevant it is to
> us at this moment, or in this topic.  Judging from the fact that it
> doesn't even define the scope of the standard (e.g. what classes of
> applications are expected to follow it, for what benefit do they follow
> it, how are they expected to handle differences between their historical
> practice and the new world order it introduces, etc. etc....), I suspect
> it is a very early draft that will be heavily copyedited before final,
> once professional standard writers start looking at it.

I mostly agree on the critics, but do you have any better "standard"
(actually, not necessarily an official standard, but "something that
various applications can agree on") to propose?

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
