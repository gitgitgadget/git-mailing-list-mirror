From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Mon, 02 Jul 2012 01:22:11 -0700
Message-ID: <7v4npq374c.fsf@alter.siamese.dyndns.org>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com>
 <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de>
 <7vobo5c0n0.fsf@alter.siamese.dyndns.org> <4FEA380D.8070001@web.de>
 <7vzk7p8z38.fsf@alter.siamese.dyndns.org>
 <CAD77+gSyhR+4vdv3dEVSuEvyt7mT9ojT-F2BrwTL4FsXpNFeHA@mail.gmail.com>
 <7v8vf551iu.fsf@alter.siamese.dyndns.org>
 <7vvci93k6k.fsf@alter.siamese.dyndns.org>
 <CAD77+gSu-RxtcyXqpF6+VanLh==_BJymTAnY2M_EiMz=b63F6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 02 10:23:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SlbuS-0003ub-Uc
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 10:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445Ab2GBIWi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 04:22:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53257 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753289Ab2GBIWO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 04:22:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1753F6C48;
	Mon,  2 Jul 2012 04:22:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dhGUeORlxTJEw9Ek2gBF5119s9s=; b=hLd5F4
	DfKQ8EWsYcrIYcXI3dZT4TTZZF4ZCiN519lV8RjxUY7Y6kq2yM2XDA1G6K5K6/c7
	TENbVL1jPCz/Znn7Unt8SRpUJZh4FFrOfUt0zqtSSOhoScNo8NBgsYAMtc/Y6afL
	IDcZppjPOqtkbHp9ais/pMlXQxA+12fTCNQsw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AuFcejGabzHMXTZK3M8sRS/F4NsI77BB
	qUxcauHf0/R2jkxPOpQZEODQjP4tJSp7euINucGvthws86q/HZJCmJ5PlC3Hn/9z
	v0yIRLDE5hGENbCu5z5JTKRdCeeUyECreW2VFIL1GcXFYY7Pw3PNRGXFlQryCvIs
	YK3PRQTNb3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0FFEF6C46;
	Mon,  2 Jul 2012 04:22:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53D876C45; Mon,  2 Jul 2012
 04:22:13 -0400 (EDT)
In-Reply-To: <CAD77+gSu-RxtcyXqpF6+VanLh==_BJymTAnY2M_EiMz=b63F6g@mail.gmail.com> (Richard
 Hartmann's message of "Sun, 1 Jul 2012 12:34:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06B7756A-C41F-11E1-8BAA-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200850>

Richard Hartmann <richih.mailinglist@gmail.com> writes:

> First of all, thanks for your detailed analysis; it cleared things up
> for me quite a bit.
>
> I am not sure if this would work in all cases, but let's assume there
> is a new GIT_WORK_ROOT which will always point to the top level of a
> given repository (it would stay the same for submodules, as well).

I do not think such a variable is necessary, and I do not think it
helps anything either.

As a submodule is an independent project and does not care if it is
embedded inside another project (i.e. superproject), when you are
working in $HOME/a/b repository (going back to the example in the
previous message), whether using b/.git or GIT_WORK_TREE=$HOME/a/b
as the clue to mark the root of the working tree of the project you
are working in, there is no reason for Git to figure out that there
is a containing superproject at $HOME/a, let alone that its
controlling repository is at $HOME/a/.git (or somewhere else).

The problem is going the other way around.

When you are working in the superproject, i.e. $HOME/a, there is a
need to know when you cross the project boundary at $HOME/a/b (and
if you know $HOME/a/b is the project boundary, that automatically
means $HOME/a/b is the root level of the working tree of the other
project, so Git with "--recursive" option _ought_ to be aboe to
export GIT_WORK_TREE one it goes into the working tree of the
submodule without anything else).

But even if you can know where the project boundary is in the
working tree space, that does not automatically mean you will be
able to know where the controlling repository for $HOME/a/b is, if
you moved it away from its natural location $HOME/a/b/.git to
somewhere else.  There needs to be a way to tell Git about that.

And an obvious way to do so is to have $HOME/a/b/.git; it can be a
real repository, which would make things simple, but it does not
have to be.  It can be the "gitfile:" thing that points at somewhere
else.  In recent versions of git, submodule working trees have this
as a "gitfile:" that points at $GIT_DIR/modules/$name of the
superproject, so that the working tree can be removed when checking
out an old version of superproject before such a submodule was added
to the project without losing the controlling repository.

So I do not see a need for either WORK_ROOT or DIR_ROOT at all.

The superproject (e.g. $HOME/a) may have its controlling repository
elsewhere (you are naming its location with $GIT_DIR when you name
the working tree of it with $GIT_WORK_TREE), and that controlling
repository can have modules/b directory that is the controlling
repository for the submodule whose working tree is at $HOME/a/b;
there is no need for anything else as long as there is enough clue
for the system to find out that $HOME/a/b is the project boundary.
