From: Junio C Hamano <gitster@pobox.com>
Subject: Re: checkout extra files
Date: Mon, 03 Sep 2012 12:36:43 -0700
Message-ID: <7vsjayew50.fsf@alter.siamese.dyndns.org>
References: <CAB9Jk9BvQmFfTq3a+e-7t-66s06jLK4fWuZB+MJHrAtbznBvHw@mail.gmail.com>
 <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Angelo Borsotti <angelo.borsotti@gmail.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 03 21:37:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T8cS8-0003RN-Td
	for gcvg-git-2@plane.gmane.org; Mon, 03 Sep 2012 21:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab2ICTgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Sep 2012 15:36:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53235 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755001Ab2ICTgq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2012 15:36:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C8AC5942F;
	Mon,  3 Sep 2012 15:36:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P/SyDQXENZBNeVF8i23cmOq35CI=; b=WkzA26
	+0FmUoAcdtN5zHDw30QVOnSuI4tQyCOE578dBGQx6y2mEINEqiNn9pY84NGOUP9M
	gn1TVxf+dwbDNJxHpizIpaGfD7vxBB4zO/aCL3DdZ0weQd0iOPJuRYmXoKy32tEB
	wvi0F2A8yluLR3wVFT/MvMl+lPBcPL84Fn2NQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mdRz6BOQL65PJpVDXyjl0Cmz74eYlEgd
	99opVWMulqDiGTYjKK9jwAx8ocpdMWy0q/6Ep0oanb7cO2xgoPRBeMjM3RGCqd61
	ZAZwCG3vR90aD7Kc71+J37dls6QIlXZXd99XqI1AanIFz2V81GFWWDWbPs0NxJ1M
	nxuQhpbAHaY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6707942E;
	Mon,  3 Sep 2012 15:36:45 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 17A3C942D; Mon,  3 Sep 2012
 15:36:44 -0400 (EDT)
In-Reply-To: <CACsJy8A6-Ok34QDqgSVavFDBE81UdcK4rLzkHe7P7UO=fXptGw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 3 Sep 2012 20:59:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B1C8B25A-F5FE-11E1-930B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204707>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Mon, Sep 3, 2012 at 8:42 PM, Angelo Borsotti
> <angelo.borsotti@gmail.com> wrote:
>> $ git checkout 94d8 -- *
>> $ ls
>> f1
>>
>> Note that the work directory is empty when the checkout is done, and
>> that the checkout restores f1
>> in it, a file that is not denoted by the * pathspec.
>
> I think in this case '*' remains unexpanded by the shell. Which means
> it is still a pathspec to checkout (iow equivalent to "git checkout
> 94d8 -- '*'"). Checkout in turns matches the pathspec '*' against the
> tree and decides to restore 'fl'.
>
> It's confusing but I don't think there's much we can do about it.

The user can, by telling the shell to expand '*' that does not match
to nothing, though.

Is there anything that is confusing in our documentation?  I am not
looking for a change to the documentation that protects it from
getting misunderstood by deliberately twisted interpretations (such
a change would make the resulting text would harder to read), but I
do want to make sure it is not prone to confusion even to a casual
and careless reader.

For this particular scenario, I do not see anything offhand that is
unclear about the behaviour of Git in the documentation, even though
as you pointed out, if the user is unaware that the shell passes
globs unmodified when they do not match, it may lead to a confusion
like this.  I certainly do not want to do a full "introduction to
shell" in our documentation, but if adding a short sentence or two
helps to avoid confusion like this, I do not strongly object to it.
