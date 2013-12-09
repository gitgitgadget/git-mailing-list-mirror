From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-submodule.sh respects submodule.$name.update in .git/config but not .gitmodules
Date: Mon, 09 Dec 2013 15:40:47 -0800
Message-ID: <xmqqlhztvbi8.fsf@gitster.dls.corp.google.com>
References: <CABYr9QtSeX=Euf73MZPq6suo+GpVA=f+tH73Ct0tP-3LYogh9w@mail.gmail.com>
	<20131209223506.GF9606@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Charlie Dyson <charlie@charliedyson.net>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 10 00:40:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VqARc-0001O3-4G
	for gcvg-git-2@plane.gmane.org; Tue, 10 Dec 2013 00:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942Ab3LIXkw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Dec 2013 18:40:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36508 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707Ab3LIXkv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Dec 2013 18:40:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EBE3E59133;
	Mon,  9 Dec 2013 18:40:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gYcO5ksxFzArbOM5z41HL9C6MuI=; b=NCvyNL
	Q6WUhxChA6Bd0e8BN9rLdb/gFMnhMVtN5/6aLjWAMgABlnQnsqQskt3cQR1zS4JJ
	xf3BiqmE22DImVYIV6ctBaf+WepjJr7B3XhpObpXLJSRJWEHClFcbV72dDHFrCPA
	MswcIEymqIvw3Z7NHx4dAe7arhilC1NSCk7zM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O7ROHfhTU6sARe88f7UdFvRNulmOlJnM
	Zp++Xns8f9XoQEjrOwVop6TjfT09CpCRUdMbA6PZRDgzHfaHvt/FlzbVJX+f0QAN
	1OoPP71CVwEGg8NcduNH9wT/we2nkRhnpOSLpsE8M/Cdel0DnPd6oFrfGQR5uM0a
	y1RkS5OLPJk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCC4859132;
	Mon,  9 Dec 2013 18:40:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 312405912F;
	Mon,  9 Dec 2013 18:40:50 -0500 (EST)
In-Reply-To: <20131209223506.GF9606@sandbox-ub> (Heiko Voigt's message of
	"Mon, 9 Dec 2013 23:35:06 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 55CB084C-612B-11E3-AFE5-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239122>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> This notion has changed in a way that only the url (by that the name)
> should be copied on init. The default for everything else should come
> from .gitmodules or gits own default.

I think you need to be a bit careful here.  I do not think
everything should blindly default to .gitmodules (otherwise there
are obvious security implications as well as usability ones).

> The update configuration option was implemented before we realized that.
> So currently it is still copied when submodule init is called. The main
> reason is that we have not found the time to change that.

And 'update', as it allows any custom way to run it, is unlikely to
be allowed to be used blindly from .gitmodules, no?
