From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: error out when seeing -b/--binary
Date: Mon, 12 Mar 2012 15:12:13 -0700
Message-ID: <7vy5r5o4ea.fsf@alter.siamese.dyndns.org>
References: <20120312024948.GB4650@kroah.com> <20120312063027.GB8971@1wt.eu>
 <20120312064855.GB16820@burratino> <20120312085820.GA11569@1wt.eu>
 <20120312152004.GB9380@kroah.com> <20120312152453.GB12405@1wt.eu>
 <87aa3l4vqq.fsf@thomas.inf.ethz.ch> <20120312165703.GB18791@burratino>
 <7vvcm9snko.fsf@alter.siamese.dyndns.org> <87399dpk48.fsf@thomas.inf.ethz.ch>
 <20120312215607.GB11362@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 23:12:33 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S7DTk-0000Rq-G8
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 23:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757754Ab2CLWMU (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 18:12:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37943 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757697Ab2CLWMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 18:12:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7BBD64C8;
	Mon, 12 Mar 2012 18:12:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l2B9bdf6wWGW0YxGJB7Pl5sDE9I=; b=OzanvW
	pIh4x8BiPo0Qx62QpvdThK6MUagPzDbh6vrk/ARZUwiZUXmQT/TN1yVpdYdbVmf6
	JLWLbUh9qKoX2MNUqwmAcbASD0cB4dFncf8kJrJ/UF2SmRcDlf0hOWzm9zE8M9Yz
	9O3WRyUAqvxvdlcPoCZXSahBWRdzdGKQpyA0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bz/9b5T2UvJ/m2n4cmd1nBzUJ6H32bYv
	HAbG4xDTQxZXrTBxEItLXxzrVNRotvPN+eVZcilxufusEkALYn5qT04SPUxXL7Vl
	w3u8siAo6sEOo4v3HiaMqpokaTJDTFbOHUZWov1AxFdaNdHcrAH4AVB8Bt6+oJ+I
	mAz0BDKGKOA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BDAF864C7;
	Mon, 12 Mar 2012 18:12:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4DC5964C4; Mon, 12 Mar 2012
 18:12:15 -0400 (EDT)
In-Reply-To: <20120312215607.GB11362@burratino> (Jonathan Nieder's message of
 "Mon, 12 Mar 2012 16:56:07 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6CC097E2-6C90-11E1-BD62-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192961>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Hm, on second thought, if people are seeing this message, I would
> prefer if they write to the mailing list so we can find out about it.
> So I really would rather see this say
>
> 	--binary)
> 		: ;;
>
> and have "-b" completely unrecognized, without any words in our
> defense except for a note in the release notes mentioning the option's
> removal and that it has been an unadvertised backward-compatibility
> no-op since 1.6.0.

I do not mind keeping --binary working intact, but I think an
approach to say that "-b" no longer works and is finally removed
very firmly is a very sane one.  We would be getting a slightly
better feel of how stale the people's script could be with your
approach, but at the same time, we would be annoying far more people
who do not even know that there are some people passionately trying
to make the users' Git life better, or where these people are
hanging out.

I do not think removal of a no-op "-b" is something subject to
voting at this point, so the only thing you would get from the
better feel of the user universe is when we can repurpose the option
safely.
