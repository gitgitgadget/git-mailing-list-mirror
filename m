From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce the GIT_CONFIG_EXTRA environment variable
Date: Fri, 18 Dec 2009 21:55:07 -0800
Message-ID: <7vzl5fik3o.fsf@alter.siamese.dyndns.org>
References: <4B2C0828.4010505@signalbeam.net>
 <20091219013246.GD25474@genesis.frugalware.org>
 <7vhbrnodd9.fsf@alter.siamese.dyndns.org> <4B2C5A1A.8000201@signalbeam.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Moe <moe@signalbeam.net>
X-From: git-owner@vger.kernel.org Sat Dec 19 07:15:45 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLsbP-0005IW-Q9
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 07:15:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbZLSFzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 00:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbZLSFzV
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 00:55:21 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46744 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751052AbZLSFzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 00:55:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A7961A89FF;
	Sat, 19 Dec 2009 00:55:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NsBKxaVVxtAY0b9conkl/nz+96E=; b=hvGhQw
	TKRDK3ALErS/hwTce91EtNd02hoCFPfWXdzptwX7ZCIx3+0+QiJOYK3qqYpA9g/b
	uS/f2b8La0jhqmnFJvQcgcqKXTdkDnStIIRnwqUVzurNf8HnWoGf+6AVSIGAVZMq
	Pm46tcqNiQ/kUNqmdXEudKQCRw2cd/vz4KnTo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VTp8WE3ogiKCov3hnwDWdUQsdQB9lTek
	y3CK2O7KAAXRmFu9Z7I1Mnwn2Xr0QKhRkUgA1o72gYCkzg3+H9YFn0J0XoynaHBb
	jBBqaaY6rTnAYA31vvAoWl/m5zbT0w4k8rDfKjIBsBcoj5mk9urNZzrwPqCYxb01
	oz9d/kHoU80=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 77ED0A89F9;
	Sat, 19 Dec 2009 00:55:13 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 3139AA89F8; Sat, 19 Dec 2009
 00:55:08 -0500 (EST)
In-Reply-To: <4B2C5A1A.8000201@signalbeam.net> (moe@signalbeam.net's message
 of "Sat\, 19 Dec 2009 05\:44\:10 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 132099D0-EC63-11DE-8E0E-B34DBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135464>

Moe <moe@signalbeam.net> writes:

>> I find the original use case highly moronic.
>>
>> For people to be sharing an account, hence $HOME, there must be a reason.
>> They want to (rather, the administrator wants them to) use a common shared
>> set of settings, so $HOME/.gitconfig should be shared among them, just
>> like $HOME/.emacs and $HOME/.login are, unless there is some strong reason
>> to treat .gitconfig any differently from all the other $HOME/.whatever
>> files.  But I don't think there wasn't any argument to defend that.
>
> I'm not arguing to treat .gitconfig differently from other
> dot-files, but to treat it differently from .git/config.
>
> The former is user-specific, the latter is repository-specific.

That is something we already do, like everybody else.  $HOME/.emacs is
user specific, /etc/emacs.d/* are site-wide, and "Local Variables:..End:"
section is per-document.  Have you asked emacs guys (and vim folks) about
a change similar to the one on topic here?  This question is rhetoric and
you do not have to answer it.

>> Wouldn't it be just a matter of giving different HOME after they log-in?
>> 
>> After all, Moe will be giving _some_ way to his users set different value
>> to GIT_CONFIG_EXTRA depending on who they really are, and that same
>> mechanism should be usable to set different HOME to them, no?
>
> The individual users are identified by their ssh key. Ssh sets a
> distinct environment variable for each, which in turn is used in
> .bash_profile to read an additional user-profile.
>
> Yes, we could overwrite $HOME but that would defeat the purpose.
> The goal of this setup is to share almost all settings.

You haven't answered the crucial question, and repeating yourself is not
an explanation.  I've already said sharing the account is to share things,
you know I understand you want to _share_.  I asked why $HOME/.gitconfig
has to be treated differently from others like $HOME/.mailrc, $HOME/.gitk,
etc. that are shared.  You are not answering the question.

What makes $HOME/.gitconfig different from $HOME/.ssh/., $HOME/.vimrc, and
all the other things?  Why do you want to share all the other dot files,
most of which lack the support for you to do the "set-up" you have to do
in $HOME/.bashrc to switch based on something other than the UID (I would
call that a "set-up", not a "hack", because you have to do that
somewhere)?  Why do your users tolerate that they cannot have their own
private $HOME/.rpmmacros nor $HOME/.newsrc but it is not Ok that they have
to share $HOME/.gitconfig with others?

Knowing that is very important for us, as $HOME/.gitconfig will not stay
the only thing you would need to single out with future versions of git.

For example, we have discussed a support for $HOME/.git-excludes that sits
between $GIT_DIR/info/exclude and the file pointed at by core.excludesfile
configuration variable.  Should it be shared, or separated?  Why?

I do not want to count on you, who I have never seen on this list before,
being around to ask if such a change would break your use case when the
day comes.  If we do not know the _criteria_ you are using, the reason why
you want to single out $HOME/.gitconfig when it is Ok for your users to
share $HOME/.vimrc, we will not be able to make good design decisions to
support this "shared account" configuration [*1*].  Will we introduce
GIT_EXCLUDE_EXTRA at the time like Miklos added GIT_CONFIG_EXTRA?  Where
does it end?

> I hope this can still make it, considering the small size of
> the patch and the .git/config vs ~/.gitconfig argument.

That is not an argument at all.  We handle .git/config vs $HOME/.gitconfig
just fine; see above.

One plausible answer you could have given is that your users do not have
an account in the usual sense of the word at all, and the _only_ thing
they can do with your system is to run git and nothing else.  IOW they
have no business with even having $HOME/.vimrc or $HOME/.rhosts, so these
other dotfiles do not matter at all.  That makes $HOME/.gitconfig special.

A possible solution might be for us to honor $GIT_HOME that is favoured
over $HOME, just like $GIT_EDITOR overrides $EDITOR.  That allows us to
extend the notion more naturally in the future.  For example, when we
start reading from $HOME/.git-excludes, if the GIT_HOME environment is
set, we would instead read from $GIT_HOME/.git-excludes.  That would be a
much cleaner solution than Miklos's patch [*2*].

But you have given us too little for us to be able to judge what the best
longer-term course of action is.  How could you even _hope_ it can "make
it"?


[Footnote]

*1* Of course, before doing so, we need to decide if this "shared account"
configuration makes sense or not to begin with, but you haven't given us
enough to work with to even decide that.

*2* I am not criticizing Miklos's patch in particular.  The patch was done
in the same void without any usable information from you what you really
needed, so the lack of provision for future we can see in the patch is not
Miklos's fault.  Also he is not the git maintainer and is not used to
worry about the future like I do.
