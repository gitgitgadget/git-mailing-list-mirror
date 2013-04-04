From: Junio C Hamano <gitster@pobox.com>
Subject: Re: reverting changes
Date: Thu, 04 Apr 2013 15:19:17 -0700
Message-ID: <7v8v4ygcre.fsf@alter.siamese.dyndns.org>
References: <CACnwZYe45poRihJToDY5yrLeY-wc=6HSjZBanjGvtiopbuAAFw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 00:19:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNsVb-0005e8-6J
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 00:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765087Ab3DDWTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 18:19:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48604 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765089Ab3DDWTU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 18:19:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B0D6135E2;
	Thu,  4 Apr 2013 22:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TK14VZh65ig+mu2cRrkW9BNETNU=; b=AN5YzX
	v3rTngvEOagnSGN34mhXedBEl1PG2R2xTj1UgXn4KzbBDvolXb8iINU7pd5l/SdW
	ZU6TxAIsaBao4l9zmzu1SlYQ6sd3kw/ltgMa8Mm0eWrtjbfs0mLKRqoMveIhM9eP
	uVICtKKocRy4qe0hcBh1v9wlBsg8SOxTNDDdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R6Ki0vkDLsemAzAK+YOL1IszARlgKCwU
	eK53cxYcSUK1/XEGNg47JazW2egaCq/zjPRCXdB3ol4ET3wT6TT8qkIV56/v6LJ5
	u19DumZY2RMOLs/rKE7jHhclsGvAvdeGk1m5rAVbTCwgfaUCRLGvwFIbGf6fFW9f
	8GK+YAeP0wU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F03C4135E0;
	Thu,  4 Apr 2013 22:19:19 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 72929135DE; Thu,  4 Apr
 2013 22:19:19 +0000 (UTC)
In-Reply-To: <CACnwZYe45poRihJToDY5yrLeY-wc=6HSjZBanjGvtiopbuAAFw@mail.gmail.com> (Thiago
 Farina's message of "Thu, 4 Apr 2013 19:03:57 -0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1D485C0-9D75-11E2-AEC4-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220116>

Thiago Farina <tfransosi@gmail.com> writes:

> When I want to revert a change to a file that is already committed
> what is the best way?
>
> The way I found was:
>
> $ git checkout HEAD /path/to/my/file
> $ git reset HEAD /path/to/my/file
>
> Is this the canonical/best way or there other (easier-faster) ways?

If the issue you are solving is:

  What I committed to path/to/my/file is in good state.  I then
  edited path/to/my/file but it turns out that I do not like what I
  did.  I want the version I committed back (perhaps to start over,
  perhaps to do nothing further).

then you can checkout the path out of the commit, i.e.

	git checkout HEAD path/to/my/file

is the canonical and best way.

But I am not sure if that is what you are asking with "want to
revert a change to a file that is already commited".  It can be
read:

    I started from one state, made changes and have already
    committed them.  These changes were bad ones that I regret, and
    I do not want them.

and if so, "git checkout HEAD path/to/my/file" will happily grab the
state after these bad changes are applied out of the commit.
