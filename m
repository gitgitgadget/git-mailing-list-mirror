From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: a plugin architecture for git extensions?
Date: Wed, 27 Apr 2011 16:27:07 -0700
Message-ID: <7vsjt35l84.fsf@alter.siamese.dyndns.org>
References: <BANLkTinh3v1o7t4HRwzZtFW--zu-j4U3kw@mail.gmail.com>
 <4DB80747.8080401@op5.se>
 <BANLkTimUHrHqS-Ssj+mK=0T8QHKg34pkaw@mail.gmail.com>
 <4DB82D90.6060200@op5.se> <7vbozr8uo8.fsf@alter.siamese.dyndns.org>
 <7vpqo77dlr.fsf@alter.siamese.dyndns.org>
 <1303930175.25134.38.camel@drew-northup.unet.maine.edu>
 <20110427194233.GA16717@gnu.kitenet.net>
 <7vwrif5q93.fsf@alter.siamese.dyndns.org> <20110427220748.GA19578@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Joey Hess <joey@kitenet.net>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 28 01:27:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFE8l-0007o7-VX
	for gcvg-git-2@lo.gmane.org; Thu, 28 Apr 2011 01:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760234Ab1D0X1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2011 19:27:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43970 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757170Ab1D0X1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2011 19:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 461C654A8;
	Wed, 27 Apr 2011 19:29:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5mpLnK4P0xPubyq4OstDuqSNw1I=; b=TH5UqA
	AOGzbXluyO8FsehbstePtRMllS694ZZkTtjTGm2DNfpILpVu20xtlAuva1/ycdzb
	1Zi4zTxIuC/NlthWkH8tQr7NRVK7kVGAeidZ0jDL+1qX5lOtnUBI7a9voB/gZT6P
	8ixRZyej09oKNIczJCcxkA5izWfb1Az8QCM0I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Jy1JUZXpcEW1Q8maPDe1Xk23UU4I7WeQ
	B9wbjq3J7Fl4udbUHdTEtzGd9iq8XVmdF8G1K9z3/yy2bXu3jVHu8xSjTjsjOpTs
	BqgfA1injbHuYUGIhdsh4f0XeGCPVOe37S26Rx/h3yQRZJDRgG6RUuYXjTLDKh3Y
	e/O3cihjsUc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 120AA54A6;
	Wed, 27 Apr 2011 19:29:18 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CB2154A3; Wed, 27 Apr 2011
 19:29:12 -0400 (EDT)
In-Reply-To: <20110427220748.GA19578@elie> (Jonathan Nieder's message of
 "Wed, 27 Apr 2011 17:08:27 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2BDEB094-7126-11E0-B5D5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172290>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> For example, on my primary development box, I do not have any git
>> installed from distribution, but I do have git on my $PATH.  For such
>> users, "make install" should be able to find out that the right place to
>> install git-work.1 is in $HOME/some/where/man/man1 directory.
>
> Sorry to be dense, but: isn't the right place to install git-work.1
> one of
>
> 	/usr/local/share/man
> 	/usr/share/man
> 	/opt/man
> 	$HOME/man
> 	$prefix/man
>
> depending on where the git-work binary was installed?

I was thinking it, and the location git-work binary gets installed, should
depend on where "git" and its subcommand binaries are installed.  The word
plug-in mentioned in the thread implied that whatever plugs in is not by
itself full fledged thing that is useful standalone, so it seemed a very
natural thing to do.

> In the $prefix
> case, the same snippet in .profile that adds $prefix/bin to the $PATH
> would also say
>
> 	MANPATH=$prefix/man:$(manpath)

You are correct only if "git" the user is building is _not_ changed to
look for other places for its own manpages.  If "git" was built to look at
somewhere else, the relationship between the output of "git --exec-path"
and that location shouldn't be assumed to be ../../share/man or anything.

The layout should be discoverable, by exposing system_path(GIT_MAN_PATH)
and friends (see builtin/help.c), just like we expose GIT_EXEC_PATH.

> Or is the idea to blindly install (a symlink to) git-work to $(git
> --exec-path)/ rather than a place on the $PATH?

You can call it _blindly_ if you like, but that is what I meant.  "git"
tells where the binary and help material for a "plugin" to be installed,
so that it can find them where it expects to.

After all, I am not interested at all in adding "git pm" or other crap.  I
am just trying to help people write their own "make install" of a plugin
project, like "git work".  And writing "make uninstall" for that project
should be doable with the same information I am trying to give in this
thread, no?
