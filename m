From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git:// protocol over SSL/TLS
Date: Fri, 27 Dec 2013 14:21:31 -0800
Message-ID: <7viouaj5p0.fsf@alter.siamese.dyndns.org>
References: <CAErtv27qUMo9LsGAZtk5Zv9qnZRB_YAXhtskvrrNbWGqadQh7Q@mail.gmail.com>
	<20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergey Sharybin <sergey.vfx@gmail.com>,
	Git List <git@vger.kernel.org>
To: Konstantin Khomoutov <flatworm@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Dec 27 23:21:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vwfmd-00007i-2O
	for gcvg-git-2@plane.gmane.org; Fri, 27 Dec 2013 23:21:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754871Ab3L0WV1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Dec 2013 17:21:27 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38792 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754864Ab3L0WV0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Dec 2013 17:21:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A4725CDE4;
	Fri, 27 Dec 2013 17:21:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oyH/lSy83puqKeJw35Ev+i7Ur7g=; b=Eye2xr
	8uy3uUzO3lqfleDHG7Dvsleq75sADvdi8gdJvbHjpMb1RVj2xkYBMh9wlyW0GUU5
	KV+0RlOlkefhGr2SUhMMO8FIqDTpp/gXNFmmakS2Ic8wbMklk2A8Ds2p/haisFm1
	k8pQEAfHX3dA7D8jwJpw+Ghqrrez+yLFjWE8M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ld77Y4An1Cag2es4XE0iV9ahJdwcmqVB
	F+qktfPnZBPpnDykf5AAgFTD6XK8pCjrSbg/ARmu76+a7rVKeC3fIYNkqZYGVAlO
	+SFYS+5CCXyZqKT/jbptLNFkA1mEbE3CL3WIpjIUop7da3bwORBU9dOVIsNuBCpY
	7IHpgNAzNpM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EB76A5CDE3;
	Fri, 27 Dec 2013 17:21:25 -0500 (EST)
Received: from pobox.com (unknown [198.0.213.178])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4C745CDE2;
	Fri, 27 Dec 2013 17:21:24 -0500 (EST)
In-Reply-To: <20131227173655.3f3109e7ba848c90b302e2f9@domain007.com>
	(Konstantin Khomoutov's message of "Fri, 27 Dec 2013 17:36:55 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.4 (gnu/linux)
X-Pobox-Relay-ID: 38DF5440-6F45-11E3-AD42-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239752>

Konstantin Khomoutov <flatworm@users.sourceforge.net> writes:

> On Fri, 27 Dec 2013 18:59:00 +0600
> Sergey Sharybin <sergey.vfx@gmail.com> wrote:
>
>> Quick question is, is it possible to use git:// protocol over
>> SSL/TLS/other secure transport?
>
> The Git protocol does not implement it itself but you can channel it
> over a TLS tunnel (via stunnel for instance).  Unfortunately, this
> means a specialized software and setup on both ends so if the question
> was about a general client using stock Git then the answer is no, it's
> impossible.

Hmph, I somehow had an impression that you wouldn't need anything
more complex than a simple helper that uses git-remote-ext on the
client side. On the remote end, you'd need to have something that
terminates the incoming SSL/TLS and plugs it to your git daemon.

>
>> Or the recommended way to do secure anonymous checkout is to simply
>> use https:// ?
>
> Yes, but it will only be secure if you've managed to verify the
> server's certificate and do trust its issuer (or a CA higher up the
> cert's trust chain) -- people tend to confuse "encrypted" with
> "secure" which is not at all the same thing.
