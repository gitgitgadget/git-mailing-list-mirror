From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Cannot push some grafted branches
Date: Mon, 17 Dec 2012 00:56:06 -0800
Message-ID: <7vfw35m509.fsf@alter.siamese.dyndns.org>
References: <20121211153903.7522d6b0@chalon.bertin.fr>
 <7vd2yg8ngk.fsf@alter.siamese.dyndns.org>
 <20121212094432.6e1e48c8@chalon.bertin.fr>
 <7v38zb3ux0.fsf@alter.siamese.dyndns.org>
 <20121217085242.02a77243@chalon.bertin.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Yann Dirson <dirson@bertin.fr>
X-From: git-owner@vger.kernel.org Mon Dec 17 09:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkWUt-0007EK-Cl
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 09:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791Ab2LQI4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2012 03:56:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36664 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751448Ab2LQI4I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2012 03:56:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5BF5C88D1;
	Mon, 17 Dec 2012 03:56:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0j2yXXSW3jUzNllEEwxxuT4CGjA=; b=Q5Nw+1
	k5nesx5Ylt4375xuemZbTSjfuQva1xq20HCpuz6/9kRF7o9k5TWS83WY61dZRVjI
	Xq8Onk7geM+cRsf0JnAqnW4Cmgse96j5bCydKTUAHZB4ymXRQGYz1uRZp/Kv6PuR
	trzO47ChLPdgCM1YRGEdI2wgYAeNqchOdoeSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ktnMe0/+9Hg2clUYHfqUWERqpNRgeADx
	9ch+oIepdkkWVwBvSJd5qODsnuxlwndlVnBt/GZpBjnG0JV3EInJtEspdPqnURcp
	rt88AtONyWvihlv7qv9QaPXm6IYS7vMCWsRznNTO0mTC9DySviDG6vAsBOKMitcD
	zWUyoAoT9ls=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 482D788D0;
	Mon, 17 Dec 2012 03:56:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9C13988C5; Mon, 17 Dec 2012
 03:56:07 -0500 (EST)
In-Reply-To: <20121217085242.02a77243@chalon.bertin.fr> (Yann Dirson's
 message of "Mon, 17 Dec 2012 08:52:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98A5E3BC-4827-11E2-AAC8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211663>

Yann Dirson <dirson@bertin.fr> writes:

> And we may still want the bug fixed, or would we just list it as a known bug ?
> At least it does not seem to occur with "replace" refs:

The "replace" was designed to "fix" known limitation of grafts,
which is _inherent_ to it; the graft information was designed _not_
to be shared across repositories.  The fix was done by by using a
different mechanism to allow propagating the information across
repositories.

So there is nothing further to fix, except that there is a documentation
bug you can fix if you didn't find it documented.

Thanks.

>
> git-test$ rm .git/info/grafts 
> git-test$ echo "fake merge" | git commit-tree master^{tree} -p master^ -p maint
> b821b2aa00973a47936d7cd25c9a5978b1c839c6
> git-test$ git replace master b821b2aa00973a47936d7cd25c9a5978b1c839c6
> git-test$ git push origin maint
> ...
>    50b03b0..79211fe  maint -> maint
