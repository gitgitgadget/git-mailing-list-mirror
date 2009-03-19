From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git Large Object Support Proposal
Date: Thu, 19 Mar 2009 15:31:41 -0700
Message-ID: <7veiwt6t6a.fsf@gitster.siamese.dyndns.org>
References: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 23:33:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkQo4-000505-0u
	for gcvg-git-2@gmane.org; Thu, 19 Mar 2009 23:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761979AbZCSWbt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 18:31:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761311AbZCSWbs
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 18:31:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43256 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761988AbZCSWbr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 18:31:47 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id AF8457849;
	Thu, 19 Mar 2009 18:31:45 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 1968B7847; Thu,
 19 Mar 2009 18:31:42 -0400 (EDT)
In-Reply-To: <d411cc4a0903191514n1e524ebava5895d708a2927c4@mail.gmail.com>
 (Scott Chacon's message of "Thu, 19 Mar 2009 15:14:52 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: BA7DDC08-14D5-11DE-B332-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113852>

Scott Chacon <schacon@gmail.com> writes:

> But where Git instead stores a stub object and the large binary object
> is pulled in via a separate mechanism. I was thinking that the client
> could set a max file size and when a binary object larger than that is
> staged, Git instead writes a stub blob like:
>
> ==
> blob [size]\0
> [sha of large blob]
> ==

An immediate pair of questions are, if you can solve the issue by
delegating large media to somebody else (i.e. "media server"), and that
somebody else can solve the issues you are having, (1) what happens if you
lower that "large" threashold to "0 byte"?  Does that somebody else still
work fine, and does the git that uses indirection also still work fine?
If so why are you using git instead of that somebody else altogether?  and
(2) what prevents us from stealing the trick that somebody else uses so
that git itself can natively handle large blobs without indirection?

Without thinking the ramifications through myself, this sounds pretty much
like a band-aid and will nend up hitting the same "blob is larger than we
can handle" issue when you follow the indirection eventually, but that is
just my gut feeling.

This is an off-topic "By the way", but has another topic addressed to you
on git-scm.com/about resolved in any way yet?
