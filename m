From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Make Gitweb behave like Apache mod_userdir
Date: Tue, 17 Nov 2009 16:14:06 -0800
Message-ID: <7vr5rw8zap.fsf@alter.siamese.dyndns.org>
References: <7fce93be0911150204h259b7424md251c54186d05b7d@mail.gmail.com>
 <7vhbssewm7.fsf@alter.siamese.dyndns.org>
 <7fce93be0911171224r1cfc438ay7b38b81646154a23@mail.gmail.com>
 <7vd43gerak.fsf@alter.siamese.dyndns.org> <4B032AC8.4@eaglescrag.net>
 <7vskccaf4q.fsf@alter.siamese.dyndns.org> <4B0338F9.9000608@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sylvain Rabot <sylvain@abstraction.fr>,
	git <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Wed Nov 18 01:14:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NAYBp-0004P2-Pl
	for gcvg-git-2@lo.gmane.org; Wed, 18 Nov 2009 01:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756250AbZKRAOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2009 19:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756211AbZKRAOQ
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Nov 2009 19:14:16 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40017 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886AbZKRAOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2009 19:14:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DE8329F416;
	Tue, 17 Nov 2009 19:14:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hUvqWnGsCNVsFM6vjO/R/C8Zy7s=; b=r/oc0w
	LO+5weM1Me8O+LOTn29h27K1nrWnk6OajesTyh9ERmVcsbKQ9IloI0dK213mzCZe
	v2Lp1rUZqI/aYQQ6Vm1tDRJpgWvykxt9Xrp3Isc4T39NgirvsNYOwX7/yvDrGo/3
	xBI23TVuQsFPxwmTLFQ+OzsaTeh3p2gni5qhg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wzXguJ5JV4PUZJpfdXZBYIFS7MvTfCiq
	bzVnnAsgXE5XBNdVz1mVbJjxDnmd/Eb74p74s8rGa59Eb8B0IY5pYjjYNCkz/zil
	4JEJEKhmWXDQffl9suLMnO5mOWIjo+VC1gRSk2Wkw1897DC/rILosoyNVjQ6HxXG
	en5kZ3zht/0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A03BC9F412;
	Tue, 17 Nov 2009 19:14:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C1CB39F403; Tue, 17 Nov 2009
 19:14:08 -0500 (EST)
In-Reply-To: <4B0338F9.9000608@eaglescrag.net> (J. H.'s message of "Tue\, 17
 Nov 2009 15\:59\:53 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4E7FE674-D3D7-11DE-A2FE-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133116>

"J.H." <warthog19@eaglescrag.net> writes:

> Junio C Hamano wrote:
>
>> I am not objecting but showing my ignorance, but why is it a bad idea to
>> allow
>>
>> 	http://git.kernel.org/~junio/git.git
>>
>> to map to /home/junio/pubilic_git/git.git when
>>
>> 	http://www.kernel.org/~junio/index.html
>>
>> maps to /home/junio/public_html/index.html already?
>
> I'm not objecting to the mapping, I'm objecting to the use of the ~
> specifically, since that's the default for mod_userdir - it's more or
> less a race condition waiting to happen with respect to does
> mod_rewrite get to and process it first or does mod_userdir.

Yeah, thanks for explaining it to me.  I realized the overlap between them
immediately after I sent the message out X-<.

	http://site.xz/users/gitster/git.git

(or anything that does not override "~name") sounds good to me.
