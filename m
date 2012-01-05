From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] More on pulling signed tags
Date: Wed, 04 Jan 2012 16:10:57 -0800
Message-ID: <7vsjjvnh4e.fsf@alter.siamese.dyndns.org>
References: <1325715058-11984-1-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 01:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiavB-000837-Kn
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 01:11:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757435Ab2AEALB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 19:11:01 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757416Ab2AEAK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 19:10:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1062D697A;
	Wed,  4 Jan 2012 19:10:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QBxtrNar77s4zy6xOy8C6/A5oks=; b=lGMx/U
	6k7V8px7rvy4PAafRrjLZtVSNXM/9pGMHxabUSvVx8M4e8V4RlfagxV/39IEylM0
	VMSj5xSo9xbza9WIpqEwoFZtP/KqOowJ+n/x2zpCb+voPCOudwycdCVT2Vgqu4XS
	dIa4byYK5gGDHMHVg0ync6r3kel0jx/juFMzg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wO7qZzLbjt2xdh9Lq9HcCA55yPUod0RJ
	Bhcew+uyhsFuCDCMvr2F1pu6+NoxgIC98k3Dp2H5O7csOl6PmQmtxXJQnuhEv8av
	GWaRaSRI4HNnh7r2uDTLH42PIkjDalF3kWNIOGKSrAwS1Qm7LMIMvfQQ0Ujm081H
	ILoktquJrWs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 078196979;
	Wed,  4 Jan 2012 19:10:59 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8AA536978; Wed,  4 Jan 2012
 19:10:58 -0500 (EST)
In-Reply-To: <1325715058-11984-1-git-send-email-gitster@pobox.com> (Junio C.
 Hamano's message of "Wed, 4 Jan 2012 14:10:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE704E00-3731-11E1-A1ED-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187955>

Junio C Hamano <gitster@pobox.com> writes:

> A sample workflow with the command may look like this:
> ...
>   $ git show -s --show-signature

With this, in the Linux kernel repository, you could do this.

    $ git show -s --show-signature 2240a7bb47
    commit 2240a7bb479c38434bd636da9ce6afbd3f49447a
    parent #2, tagged 'tytso-for-linus-20111214'
    gpg: Signature made Wed 14 Dec 2011 11:15:13 AM PST using RSA key ID C11804F0
    gpg: Good signature from "Theodore Ts'o <tytso@mit.edu>"
    gpg:                 aka "Theodore Ts'o <tytso@debian.org>"
    gpg:                 aka "Theodore Ts'o <tytso@google.com>"
    Merge: 30aaca4 5a0dc73
    Author: Linus Torvalds <torvalds@linux-foundation.org>
    Date:   Wed Dec 14 18:25:58 2011 -0800

        Merge tag 'tytso-for-linus-20111214' of git://git.kernel.org/pub/scm/linu...

        * tag 'tytso-for-linus-20111214' of git://git.kernel.org/pub/scm/linux/ke...

      8< snip 8<

        .. using the new signed tag merge of git that now verifies the gpg
        signature automatically.  Yay.  The branchname was just 'dev', which is
        prettier.  I'll tell Ted to use nicer tag names for future cases.

We might want to reword "parent #2", by the way. The code was designed to
apply even to an Octopus, but I suspect 99.9% of the mergetag will be on
the second parent of a two-parent commit. You will never see "parent #1"
(i.e. direct parent you pulled into) unless you hand-craft the merge
commit object, and you are not likely to create an Octopus that pulls
multiple signed tags into one commit.
