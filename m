From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin/describe.c: ignore untracked changes in
 submodules
Date: Sun, 12 Sep 2010 13:07:16 -0700
Message-ID: <7vy6b6d8uj.fsf@alter.siamese.dyndns.org>
References: <CC-1wlyJRzGfkPwn1Ra8d4Ot7mMnUGxYChGZHdqp-lQ5URlUFhNp4Ilyrh4bGk1dWF6drZXvim0@cipher.nrlssc.navy.mil> <7vy6bajvnd.fsf@alter.siamese.dyndns.org> <1464835923.7527323.1284144028047.JavaMail.fmail@mwmweb047> <1529126586.2758911.1284228699341.JavaMail.fmail@mwmweb045> <7v39tgf5zw.fsf@alter.siamese.dyndns.org> <1982035721.2791029.1284236591083.JavaMail.fmail@mwmweb045> <7vfwxeeu19.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	johannes.schindelin@gmx.de, Brandon Casey <drafnel@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Sun Sep 12 22:07:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ousq1-0004Nw-LX
	for gcvg-git-2@lo.gmane.org; Sun, 12 Sep 2010 22:07:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab0ILUHd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Sep 2010 16:07:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64597 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752972Ab0ILUHc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Sep 2010 16:07:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DAD40D5D33;
	Sun, 12 Sep 2010 16:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RyFYSYv97dZ8RlMJmaFZOzOdYJ8=; b=U4aNlm
	OdXrOLRsvemN5FS5/CNscIXhhQ7/O+BnJc+XWg8ixjzGuQhI/e2neJ47myb4Nl5a
	ZjbszWXoFiDqNRCtyO/d3PBJbqbtYAaS/ctxXfY6kdNoQO5eCK5V7wcVFNIzgC99
	XTXOiKo1UcHofxkw3ZObXVSarKzDIg43RhSt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=em18BxSvfi4+L0s/TgzBSrN/6hiD6mOs
	Wc0p7hqkqh8f/P+NHFBw13oEGgoPlYjNvz2IUhdEgxOm3+tm12Yz97sbhPHYkEIK
	lm6Of55l+hO95espg5qb9CROo7u6Z23J6X4B98PR1WLbXs/G9H1SkGebWyEsDCGb
	LsyN7oOjkrQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 813CBD5D32;
	Sun, 12 Sep 2010 16:07:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 63C54D5D25; Sun, 12 Sep
 2010 16:07:18 -0400 (EDT)
In-Reply-To: <7vfwxeeu19.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun\, 12 Sep 2010 10\:44\:18 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5BE67694-BEA9-11DF-BFFA-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156050>

Junio C Hamano <gitster@pobox.com> writes:

> Jens Lehmann <Jens.Lehmann@web.de> writes:
>
>>>Jens Lehmann <Jens.Lehmann@web.de> writes:
>>>> And maybe we should teach "git describe" the "--ignore-submodules" option, then
>>>> you could tell describe what to pass to the diff-index command. Thoughts?
>>>
>>>It is sensible to add the option, and handle_ignore_submodules_arg() call
>>>to grab "diff.ignoresubmodules" configuration) to the command, perhaps.
>>
>> Ok, I'll look into that and prepare a patch.

By the way, I think that route of action would make the resulting git
internally consistent in that everything by default will report submodules
with untracked paths in its working tree as dirty, but sidesteps the
original issue Brandon raised, which I think is a valid concern.

 - In the "Untracked" section of "git status" output, we list an untracked
   path in the superproject (i.e. the one in which "git status" was run)
   to remind the user that the path might be a new file forgotten to be
   added (unless of course it is ignored).  But it does not make the
   working tree dirty.

 - When you have an untracked path in a submodule:

   - the submodule is listed in the "Changed but not updated" section.
     This also makes the working tree of the superproject dirty, even
     though the working tree of the submodule is _not_.

   - "git diff" output at the superproject level shows that the submodule
     has modifications (i.e. "-dirty" is shown), but when run inside the
     submodule, there is no change shown.

I think this is a misdesign at the UI level; reporting an untracked and
unignored path as potential mistake to remind the user is a good thing,
but the current way "status" and "diff" does so does not make much sense
to me.

In the "git status" output, there are three sections.  The way to view
them at the user level has always been:

 - "Changes to be committed": they are included if you say "git commit"
   without any pathspec nor option (aka "What you would commit");

 - "Changed but not updated": they are included if you say "git commit -a"
   (aka "What you could commit");

 - "Untracked files": they may be paths you forgot to add, and you might
   want to say "git add" on some of them and add ignore patterns to cover
   the others.

I have a suspicion that the change we made in 1.7.1 to say an untracked
path in a submodule counts as a "Changed but not updated" was a mistake.
In a project with submodules, if a "git commit" were to be run without any
other option, with the "-a" option, and with the "-A" option, shouldn't
the above three category behave exactly like how they behave in a project
without submodules?

IOW, for a submodule that is not pristine, shouldn't we be doing this?

 - "Changes to be committed": show a submodule path for which the
   superproject index records a commit that is different from what is
   recorded in the superproject HEAD tree (currently we are doing this
   correctly);

 - "Changed but not updated": show a submodule path for which the HEAD in
   the submodule differs from what is recorded in the superproject HEAD
   tree (we are contaminating this list with "untracked content");

 - "Untracked files": show a submodule path that is not in the index.

A submodule with untracked files may be worth knowing, but I don't think
they should fall into any of the above categories.  Perhaps they should be
listed in their own separate section (they may be listed in multiple
sections just like "edit F; git add F; edit F" may result in a path listed
both in to-be-committed and not-updated sections)?

I haven't formed an opinion as to what to do with "git diff" output that
adds "-dirty" for untracked paths.  c.f.

  8e08b41 (Teach diff that modified submodule directory is dirty, 2010-01-16)
  721ceec (Teach diff --submodule that modified submodule directory is dirty, 2010-01-24)
  
