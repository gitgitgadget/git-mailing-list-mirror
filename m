From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-am doesn't apply the rest of the email after a partial patch
 fail?
Date: Mon, 08 Apr 2013 10:49:53 -0700
Message-ID: <7vppy4ykse.fsf@alter.siamese.dyndns.org>
References: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Constantine A. Murenin" <mureninc@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 19:50:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPGCf-0006RL-FA
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935388Ab3DHRt4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:49:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35207 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935057Ab3DHRt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:49:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9000713AA7;
	Mon,  8 Apr 2013 17:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rO1UlRFc9PpEmVM6EbmA9hrp8Ys=; b=Zpmcwx
	8F902IOXeVceNRGH0bSUUqvFWWFPcGY5x4WHfs4IXCthWCPYQgL0FnJQep940Q8p
	hruv9jSxWpMAVADxLzB773SBoNx89Yi1vGwJmtIniQn8z0rfBJY2Wla3MX52fZG5
	eK3uDpZGLiw4keTkzvCTW1LYV1t/empPhU53g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h9u+KBun+0zeVcNuFaNu71Nm6dZ2AKMi
	asVFDNiZVPqQ9zOOsd78p5PQbI9mcdFsW0DIPvsyx5QY+YLd9hSjw8SXCJMdSF/j
	btGO53NKMI8aoInC+ahw2Yki8h4mOEHXTY9AgB7oXktCqCMPB26UEB5wsxgUzsQh
	pRNDFlaraGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8725113AA6;
	Mon,  8 Apr 2013 17:49:55 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DF8E113AA4; Mon,  8 Apr
 2013 17:49:54 +0000 (UTC)
In-Reply-To: <CAPKkNb43bWupbOaAntF8VJQ8ZJjt8SG-mZa3GohxZEAZQm-evQ@mail.gmail.com>
 (Constantine A. Murenin's message of "Sun, 7 Apr 2013 11:00:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B8A8855C-A074-11E2-A8D5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220474>

"Constantine A. Murenin" <mureninc@gmail.com> writes:

> However, what I've faced with, is that when a conflict happens, and I
> resolve, and do `git add`, and `git am --resolved`, then the rest of
> the `format-patch` email where the conflict has occurred is discarded,

That is unusual.  Are you using any other options when running "git
am"?  You said `git add`, but what did you add?

By default, its patch application is all-or-none, so when it stops,
saying "I cannot apply this patch---please help me with it", it
expects that all the changes the email wanted to give you has been
applied by you to your working tree, perhaps using GNU patch or "git
apply --reject", followed by manual editing, and to your index using
"git add", when you run "git am --resolved".  Not just the file (or
hunk) it detected issues with.
