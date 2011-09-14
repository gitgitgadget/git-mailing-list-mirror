From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bundler service
Date: Wed, 14 Sep 2011 12:13:23 -0700
Message-ID: <7vhb4fszsc.fsf@alter.siamese.dyndns.org>
References: <4E70F6E8.80408@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Sep 14 21:13:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R3utr-00012m-1l
	for gcvg-git-2@lo.gmane.org; Wed, 14 Sep 2011 21:13:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757397Ab1INTN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Sep 2011 15:13:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42809 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757306Ab1INTN2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2011 15:13:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 648545724;
	Wed, 14 Sep 2011 15:13:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DyIHfwo6cxnS0TkGVptH388O3pY=; b=H5qWoh
	GlX5v8wzZCli6OZmE17P8b4AIB4JED4oVsqx5QNVnviFpVQbHhJG5pyFeBBUz0cj
	eyaN+lwofA5Js1zc4Yv9nPh/8F6rJdWqkdns0oQCFZvMCkt1lX58RnHUy2hGH+Mb
	EPoa1J4ue/kwFTGf1NkLE2I2j1Sz3os2mR6Ik=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LKM5t8EUnhpIsBofBSTObEKBf+WvGhje
	jqbSdUMwd+8tt19wlnQoJCYT4t/um+easQlLJXNb2dLqzl4BXDNximN2zPL87+a/
	CZ/bFiejc4NBNIeHzlQtCAgiDZP7IXOPMDopeJQVa+pnEhQyNoUUGp1NcwsiXUO1
	K3kWqlPUdbU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CCD25723;
	Wed, 14 Sep 2011 15:13:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9465A5722; Wed, 14 Sep 2011
 15:13:24 -0400 (EDT)
In-Reply-To: <4E70F6E8.80408@dbservice.com> (Tomas Carnecky's message of
 "Wed, 14 Sep 2011 20:48:08 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9E6242B4-DF05-11E0-A7D7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181387>

Tomas Carnecky <tom@dbservice.com> writes:

> I do a fair amount of end-user support in our official IRC channel and
> every now and then someone with a really slow or unreliable internet
> connection stumbles over the fact that git can't resume clones. In the
> past I would real quick clone the repo and make a bundle for them (if
> the repo was public). Now I made a service out of it:
> https://bundler.caurea.org/. The site is really simple: you enter a
> git url and after a while you'll be able to download the
> bundle.

Interesting, as I was talking with others on a related solution to a
similar issue of priming the well for large clones.

The basic idea is to allow a site automatically to redirect fresh-clone
clients to a URL to HTTP reachable mirror network, and force them to grab
a bundle, extract it and then re-contact the server for only incremental
updates relative to the bundle (and of course that exchange would happen
inside the updated client without end-user intervention).
