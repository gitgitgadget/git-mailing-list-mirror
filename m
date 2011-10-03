From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Do we have a convenient way to refer to a specific commit in an
 already filtered rev-list?
Date: Mon, 03 Oct 2011 12:40:43 -0700
Message-ID: <7v1uutg8xw.fsf@alter.siamese.dyndns.org>
References: <CAEvN+1jPD53-e8a31g+iz6vMB0-e2LECjouBELkBOXBV5=oGBg@mail.gmail.com>
 <20110927213517.GB5176@sigill.intra.peff.net>
 <CAEvN+1gODnGy2v2=d6NXJ8b1nBJgpqj+BkDm2eQC1xqyTKXhEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Tzu-Jung Lee <roylee17@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 03 21:40:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RAoNh-0003mm-FY
	for gcvg-git-2@lo.gmane.org; Mon, 03 Oct 2011 21:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757427Ab1JCTks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Oct 2011 15:40:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47400 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756250Ab1JCTkp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Oct 2011 15:40:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D88A5969;
	Mon,  3 Oct 2011 15:40:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nS9JqeuGn9YACfvTvrDXzUsBOZg=; b=OsZTrZ
	39fcd1Hl91/RclmcdsJXEa0vH8Yd9ch+VCyR8ymekJU1J/J7kU7D1dxlX08KwS4r
	glGp52RTGv/ib6iAR4yE953s/Wzqa1wFfp8f5kf38IF3Tk3V4pIhHjLndICw8O5m
	/5SQ6SgbIlqwQML+6Te6RnAYSR7pjRBUFXLDk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WCk0bsFKnxqGDocoYc/XgUdXS6DUmzUg
	y+dD1DkI1UnRUMFFRNGoRT0rYHnvJ7a+IZ+eKYQQWNU9fXFL/zUW4ilQLi9Dmk0u
	c4i8FlHh1WfZl0laeeCmq0z7yZzVnmketC2twyxDSThZI1hJ0UZk7bHvRJeByNWC
	fKeFjkmM8u0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44DF85968;
	Mon,  3 Oct 2011 15:40:45 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBE605967; Mon,  3 Oct 2011
 15:40:44 -0400 (EDT)
In-Reply-To: <CAEvN+1gODnGy2v2=d6NXJ8b1nBJgpqj+BkDm2eQC1xqyTKXhEg@mail.gmail.com>
 (Tzu-Jung Lee's message of "Tue, 4 Oct 2011 01:19:35 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95E263F2-EDF7-11E0-BFFE-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182704>

Tzu-Jung Lee <roylee17@gmail.com> writes:

> And also teach the rev-list to parse or interpret the 'saved' refs differently.
> So we can have the following use case:
>
>    git log branch_foo --author=some_one -S some_string --saved=cached_ref
>    git log cached_ref
>    git cherry-pick cached_ref~4
>    git format-patch cached_ref~6..cached_ref~2
>
> I often have such use cases. not sure others would be benefited from
> such feature.
> Just asking for comment. :)

It feels too much hackery for too little gain.

$ git log --oneline master..branch --author=A.U.Thor -Spickaxe >foos.txt

and working from the text file foos.txt at least would not contaminate any
ref namespace and you do not have to clean them after you are done.
