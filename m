From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Implement unstage and reset modes for
 git-add--interactive
Date: Fri, 24 Jul 2009 16:25:58 -0700
Message-ID: <7vzlat64u1.fsf@alter.siamese.dyndns.org>
References: <200907231041.32567.trast@student.ethz.ch>
 <2d756f643fc7d1b50cf590c95467fa029b49ff46.1248426652.git.trast@student.ethz.ch> <7vocrakpbo.fsf@alter.siamese.dyndns.org> <20090725065822.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sat Jul 25 01:26:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUU9i-0003iR-Ht
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 01:26:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbZGXX0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 19:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbZGXX0G
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 19:26:06 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751362AbZGXX0F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 19:26:05 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id B586F12227;
	Fri, 24 Jul 2009 19:26:04 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C22A81221D; Fri,
 24 Jul 2009 19:25:59 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5B7B78AE-78A9-11DE-B4A7-F699A5B33865-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123975>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>
>
>> "resetting index entries selectively" makes perfect sense.  So do
>> "checking out index entries selectively" and "adding to index
>> selectively".
>
> Are you saying that you are fine with the concept of Thomas'es patch
> series but you don't want to see different words used to name these
> operations?

Essentially, yes.

Could you please wrap your lines to a reasonable length, by the way?

> In other words, do you mean the following would be a pair of better
> companions to "git add -p $file" than Thomas'es discard and unstage?
>
>  - "git checkout -p $file" and "git checkout -p $commit $file" that let
>  you view the patch to bring the file in the working tree to the version
>  in the index (or the commit) and selectively apply that to the working
>  tree and the index, to implement "discarding changes selectively".
>
>  - "git reset -p $file" and "git reset -p $commit $file" that let you
>  view the patch to bring the version of the file in the index to the
>  version in the HEAD (or the commit) and selectively apply that to the
>  index, to implement "undoing changes made to the index selectively".
>
> I think it preserves the UI consistency better to enhance checkout and
> reset than adding new commands to do conceptually the same
> thing...

I didn't read Thomas's series beyond the cover letter, but I'd say the
above three (counting "add -p" in the mix) extends the existing concepts
in a natural way:

 - "add" goes from work tree to the index;

 - "checkout" goes from commit or index to the work tree; and

 - "reset" goes from commit to index.

The "-p" variant (which exists to "add" but new to "checkout" and "reset")
allows you to do these movements in a finer grained manner than per
whole-file.

> ... Unfortunately I don't know how hard the necessary change will be,
> because these two commands are now implemented in C...

That's OK.  There are others on the list who groks C, like Thomas ;-)
