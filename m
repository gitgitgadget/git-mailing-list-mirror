From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] git-as-svn: subversion frontend server for git repository
Date: Tue, 09 Sep 2014 12:30:23 -0700
Message-ID: <xmqqiokwk2wg.fsf@gitster.dls.corp.google.com>
References: <20140909111903.GA13137@seldon>
	<xmqqy4tsloxs.fsf@gitster.dls.corp.google.com>
	<20140909185711.GA14554@seldon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, bozaro@yandex.ru
To: Marat Radchenko <marat@slonopotamus.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 21:30:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRR7g-00021H-0r
	for gcvg-git-2@plane.gmane.org; Tue, 09 Sep 2014 21:30:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbaIITa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2014 15:30:27 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60448 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbaIITaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2014 15:30:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 299D73811E;
	Tue,  9 Sep 2014 15:30:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wE/UGskxD0uWwbLcn4sCNVLADvM=; b=fsbAnb
	vLzA8o7hq8qmsMJA1iUeUNxBNfXENqOYGlGCef6Wpk7FmI3UyoI7l7sCjcZRUKI0
	gyytFsiXoTQ/4eXXnmtMRLsnnGLOnXJXk8s7T3pXmQ5XfsoNee5RAuBiHY8jJP6J
	LWPyPOsxcsXjwQ64q6HJX02bXJX+7vLh+gSEY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pItVPNC8se/3ikq0ZniEGpEO9xl3HpY2
	D9hMM5njPNPyjKyOS8edYmCO3V6l7s9iy4FI7im4HEccsP/JzaHWrwuEWi7E2Ssp
	x2umMuwVnCEZICAE7Z6uHMTbYp0McFNFARamL0tOSp3NnXnKoCoBy3/WT9NeguuS
	6GObXgeqRJg=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20B3B3811D;
	Tue,  9 Sep 2014 15:30:25 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9A34F3811C;
	Tue,  9 Sep 2014 15:30:24 -0400 (EDT)
In-Reply-To: <20140909185711.GA14554@seldon> (Marat Radchenko's message of
	"Tue, 9 Sep 2014 22:57:11 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF0ACE42-3857-11E4-9374-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256706>

Marat Radchenko <marat@slonopotamus.org> writes:

>> >   * You must not do 'inverted merges'. Old HEAD must be reachable from
>> >     new HEAD by first-parent traversal.
>> 
>> I am not sure what you mean by this to properly assess how
>> significant this limitation is.  Care to draw a simple picture?
>
> SVN doesn't support nonlinear history (except merge-info crutch).
> ...
> And now the *bad* case. You have the same initial history but do *inverted merge*:

That is a bad way to answer a question that asks "what do you mean
by an 'inverted merge', which is not in our normal lexicon?" ;-)

	You must not merge the current tip of SVN server *into* the
	work you did on top of a past state you obtained from the
	SVN server.  Check out the current state from the SVN side,
	and merge your work into it instead.

or something like that is what people would understand without
introducing a new/unused word to the world.  And

> A -- D -- E -- F -- G'
>  \                 /
>   B -- C ---------/
>        ^
>        |
>     Previous branch tip

this illustrates the topology you meant reasonably well, especially
if you marked D, E and F as "your own work" (as opposed to what the
server side did in the meantime while you worked, i.e. B and C).

Thanks for a clarification.
