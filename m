From: Junio C Hamano <gitster@pobox.com>
Subject: Re: linux-next: unneeded merge in the security tree
Date: Tue, 12 Mar 2013 14:30:04 -0700
Message-ID: <7vtxog5msj.fsf@alter.siamese.dyndns.org>
References: <20130312100950.e45ef0e721492ff0d5fd7c8d@canb.auug.org.au>
 <alpine.LRH.2.02.1303121510270.25612@tundra.namei.org>
 <20130312041641.GE18595@thunk.org>
 <CA+55aFzFLDcN-1GKae6Xqrns59K1xOD_HPzuv2Lv1__fZpqFMw@mail.gmail.com>
 <20130312212027.GE14792@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	James Morris <jmorris@namei.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Ts'o <tytso@mit.edu>
X-From: linux-next-owner@vger.kernel.org Tue Mar 12 22:30:33 2013
Return-path: <linux-next-owner@vger.kernel.org>
Envelope-to: glkn-linux-next@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-next-owner@vger.kernel.org>)
	id 1UFWmG-0007Oi-By
	for glkn-linux-next@plane.gmane.org; Tue, 12 Mar 2013 22:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932723Ab3CLVaI (ORCPT <rfc822;glkn-linux-next@m.gmane.org>);
	Tue, 12 Mar 2013 17:30:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43565 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932707Ab3CLVaH (ORCPT <rfc822;linux-next@vger.kernel.org>);
	Tue, 12 Mar 2013 17:30:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2EBADA44D;
	Tue, 12 Mar 2013 17:30:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CtzZsSAtkhY5v88GH/JXZYKFJmg=; b=K7TCkU
	0wb05Q7Sl+pAxpDb0MOV3PKp1nOZId51o6KnyGuW6vw8zrg/+OJx339GEYazWhVV
	F5IZ4UuDhML1ZG3thnducVx5AVjB2PzEaVPH+YLEjnhfeEGAh+zxFCUhzRZKTzPP
	k3QdPSWfv4QB00TR/OoCbCbYfG++XCk/0PV6g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MQpJBbHQjd5RCPfKGBe1SMcGknvuH+Vb
	B//64o9P/RlTJH57VCs/Xp8lDpEnKwvp4bV++H2SUo2wXsunvZBNVuv9umw+0qEo
	GRUfo8ewVtbrXSxsPY31I2KwX9cGIjLL2i91tKdeZ3z5OKRJzRGtczX7moxPrCK+
	2ZhNAWTTf3w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F9B0A44C;
	Tue, 12 Mar 2013 17:30:07 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E81EA44B; Tue, 12 Mar 2013
 17:30:06 -0400 (EDT)
In-Reply-To: <20130312212027.GE14792@thunk.org> (Theodore Ts'o's message of
 "Tue, 12 Mar 2013 17:20:27 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 023C2454-8B5C-11E2-9021-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-next-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-next.vger.kernel.org>
X-Mailing-List: linux-next@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217998>

Theodore Ts'o <tytso@mit.edu> writes:

> What if we added the ability to do something like this:
>
> [remote "origin"]
> 	url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> 	fetch = +refs/heads/master:refs/heads/master
> 	mergeoptions = --ff-only
>
> This would be an analog to branch.<name>.mergeoptions, but it would
> apply to the source of the pull request, instead of the destination.
>
> That way, people who do a "git pull" from Linus's tree would get the
> protection of --ff-only, while pulls from submaintainer trees would
> automatically get a merge commit, which is what we want.
>
> It doesn't handle the case of a submaintainer pulling from a
> maintainer in a back-merge scenario, but that should be a pretty rare
> case, so maybe that's OK.

Is there an escape hatch for that rare case?  IOW, how does a
submaintainer who configured the above to override --ff-only?
