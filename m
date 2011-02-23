From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: add a --current option to git branch
Date: Wed, 23 Feb 2011 11:47:23 -0800
Message-ID: <7vbp228rec.fsf@alter.siamese.dyndns.org>
References: <AANLkTimDE18XK8NOg++pxqs5LCJZ4m67Ygo4JvYDbw+F@mail.gmail.com>
 <AANLkTikecya+o+rLVHJARv06mCtEv-Ef1nRECQH0saLr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>, git@vger.kernel.org
To: John Jendro <tacliat@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 20:47:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsKgU-0005wa-Uu
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 20:47:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023Ab1BWTre (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 14:47:34 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:55447 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752852Ab1BWTrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 14:47:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B7DDD49C0;
	Wed, 23 Feb 2011 14:48:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7So+KyusXZibI6Rkk5JMRi5durA=; b=t3pei8
	TP6vXbnSp/V9JrgCmcMicjYZU+e0Y7PeQ3OMDBZxIV3JRYAZJwuXCynj+qIVodo/
	C0PdhEOWWm6ZW8OqCxnbAufEoPXOwSiQm1y7qvLG92tO6DnV0+pPnl/vb0CcFcON
	dmc60rVC0Zzs5JA3D0Vq/eUsYKeese2I85gEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OA5goPjyk86FJro/XenkzW2NBBRJ6wmH
	BMK2lHJUycgBQnTcFh2Ftiba4jSc6lMfWDHMLtKCTwnA3owiGJDc3BFHqBJFvmkg
	dU4063kgsV2Hp0pE07EiSNztjY30ntWM21Kin+0nMeucJz5y5lWC2+ulkb0omMhb
	CGsvKVF+rwA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 84EA949BF;
	Wed, 23 Feb 2011 14:48:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 74DD749B6; Wed, 23 Feb 2011
 14:48:37 -0500 (EST)
In-Reply-To: <AANLkTikecya+o+rLVHJARv06mCtEv-Ef1nRECQH0saLr@mail.gmail.com>
 (Jay Soffian's message of "Wed\, 23 Feb 2011 14\:32\:07 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EA49DF04-3F85-11E0-9799-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167718>

Jay Soffian <jaysoffian@gmail.com> writes:

> On Wed, Feb 23, 2011 at 2:08 PM, John Jendro <tacliat@gmail.com> wrote:
>> Yes I know this can be done with sed & grep, but --current should be a
>> standard thing for git branch to have.
>
> I sense you're looking to get the name of the currently checked out
> branch, possibly for use in a script. In that case, you may want "git
> rev-parse --abbrev-ref HEAD" or "git rev-parse --symbolic-full-name
> HEAD" depending upon what you're trying to do.

And if you are not scripting, then the completion script we ship (it was
originally done for use with bash but I was told that it also can be used
with zsh) may help.

Note that the completion script shows how to do this properly---if you
are indeed scripting, it may be a good idea to study it, but the gist of
it is:

	if b=$(git symbolic-ref HEAD 2>/dev/null)
        then
		echo "You are on branch ${b#refs/heads/}"
	else
		echo "You are not on any branch"
	fi
