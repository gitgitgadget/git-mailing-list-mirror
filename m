From: Junio C Hamano <gitster@pobox.com>
Subject: Re: A design for subrepositories
Date: Sat, 13 Oct 2012 21:36:24 -0700
Message-ID: <7vzk3p1xh3.fsf@alter.siamese.dyndns.org>
References: <20121013163322.685276teuhqhjc82.lealanko@webmail.helsinki.fi>
 <7vd30m2sbr.fsf@alter.siamese.dyndns.org>
 <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Lauri Alanko" <la@iki.fi>
X-From: git-owner@vger.kernel.org Sun Oct 14 06:39:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNFz7-0006mb-Lv
	for gcvg-git-2@plane.gmane.org; Sun, 14 Oct 2012 06:39:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045Ab2JNEg2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2012 00:36:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52271 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750902Ab2JNEg1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2012 00:36:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 310E79F24;
	Sun, 14 Oct 2012 00:36:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2BTTKkzGaoBNalbbDOrLU4qH4o0=; b=YyLJuH
	zR9Jv1EuDJj7eEyXfKylH8t1iTVXHfBi1/7Jg9x34v0IJk36NnS4rds3MXSgOy4P
	PeSVnKiHTWgRpEzKshtbO1h27ph/cordMxMlsRqdz1l9hYU0EryDD/a3ZAwmHYeU
	FYpu/UlNtdgWLDUE7AEPyzBSqhtuBZH/07U2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gbTGraXYm3DHD9tPCAlt8Izzd1eLCUbl
	jALwOi/zJedS8j/Dz+GYeg3r88tmnjr3yk0MhdLJsTTK7N+2b499KsTzJcWjTPRh
	xPNZ1qI/OTdVTid+1/2uLlYQ5o2kHO2MA8OtWJHTJC8kDsnFxmlGsHCwTNuyPWGs
	4A+YdRjFAHI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F0D99F23;
	Sun, 14 Oct 2012 00:36:27 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 648729F20; Sun, 14 Oct 2012
 00:36:26 -0400 (EDT)
In-Reply-To: <20121014002304.14167k2j2ctspiuw.lealanko@webmail.helsinki.fi>
 (Lauri Alanko's message of "Sun, 14 Oct 2012 00:23:04 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B7133F94-15B8-11E2-8413-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207606>

"Lauri Alanko" <la@iki.fi> writes:

> Firstly, if you simply do "git submodule add ./foo" (the obligatory
> "./" being quite an unobvious pitfall), you get something quite
> fragile, since now we have submodule.foo.url = ./foo. If the
> submodules ever get reorganized and foo is moved to ./bar, then it is
> impossible to check out older versions or alternate branches, since
> the submodule is no longer where it is expected to be at the origin.

Isn't that exactly what the "module name" vs "module path" mapping
in .gitmodules file is meant to address?

> But still, "git submodule update" only looks at the modules in the
> currently checked-out tree. If we have other branches or old tags that
> refer to other submodules, there's no simple way to fetch those, too.

Didn't I already suggest you to think about how you can improve
existing "git submodule" to suit your use case better?
