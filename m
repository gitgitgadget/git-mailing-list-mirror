From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: store converted URL
Date: Mon, 14 Jan 2013 10:14:19 -0800
Message-ID: <7vmwwbd43o.fsf@alter.siamese.dyndns.org>
References: <1357760618-81222-1-git-send-email-max@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 19:14:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuoYU-0003Mm-RL
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 19:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab3ANSOW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jan 2013 13:14:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756978Ab3ANSOV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jan 2013 13:14:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 374C1B918;
	Mon, 14 Jan 2013 13:14:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=P2nQxHlwmzGn1cZB5hNmLvjfUvI=; b=Fs9ivCiBLc9mpPqVnifw
	J+PLxv/o4tVQJvRBw2MhVf9phxB7rCkWD/IWpVlV79mY/SE6s5C0A37GOmwh59wx
	b/NmFiVSi9pEIvIJXYhZlsMc+UXclkTE68OxO13bbex9QkOxM72xrLIs4zgcPcej
	VfdPVRwaW7r4sGzR/TsDleo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=RCfB3NkXc4hK4gtXCCWP07bneTZ+qLHbKcNqlXJ0SDhw4+
	ibicaRpKZLNFOHmwhNeuFBlNa7rWjoi3GBlL6WJxSV1gKHyqf5Hv2ZpovfmAILXU
	XEqsffTy1UnP8XwyLPcenO2apbLdUY6GJeIYpU4a5I26Tp2n83z9AoQw63QeA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A3BEB916;
	Mon, 14 Jan 2013 13:14:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEF60B914; Mon, 14 Jan 2013
 13:14:20 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37A4ECBA-5E76-11E2-8EB1-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213512>

Max Horn <max@quendi.de> writes:

> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> Mercurial might convert the URL to something more appropriate, like an
> absolute path.

"What it is converted *TO*" is fairly clear with ", like an ...",
but from the first reading it was unclear to me "what it is
converted *FROM*" and "*WHEN* the conversion happens".  Do you mean
that the user gives "git clone" an URL "../hg-repo" via the command
line (e.g. the argument to "git clone" is spelled something like
"hg::../hg-repo"), and that "../hg-repo" is rewritten to something
else (an absolute path, e.g. "/srv/project/hg-repo")?

> Lets store that instead of the original URL, which won't
> work from a different working directory if it's relative.

What is lacking from this description is why it even needs to work
from a different working directory.  I am guessing that remote-hg
later creates a hidden Hg repository or something in a different
place and still tries to use the URL to interact with the upstream,
and that is what breaks, but with only the above description without
looking at your original report, people who will read the "git log"
output and find this change will not be able to tell why this was
needed, I am afraid.

Of course, the above guess of mine may even be wrong, but then that
is yet another reason that the log needs to explain the change
better.

> Suggested-by: Max Horn <max@quendi.de>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Max Horn <max@quendi.de>
> ---
> For a discussion of the problem, see also
>   http://article.gmane.org/gmane.comp.version-control.git/210250

I do not see any discussion; only your problem report.

Was this work done outside the list?  I just want to make sure this
patch is not something Felipe did not want to sign off for whatever
reason but you are passing it to the list as a patch signed off by
him.
