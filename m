From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git status --porcelain is a mess that needs fixing
Date: Fri, 09 Apr 2010 13:30:39 -0700
Message-ID: <7vmxxc1i8g.fsf@alter.siamese.dyndns.org>
References: <20100409184608.C7C61475FEF@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Raymond <esr@snark.thyrsus.com>
X-From: git-owner@vger.kernel.org Fri Apr 09 22:30:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0Kqt-00061B-JS
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 22:30:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757055Ab0DIUaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 16:30:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:59797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757021Ab0DIUar (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 16:30:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3DBDFA99C6;
	Fri,  9 Apr 2010 16:30:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Nh97trb5AZHvDJtBxcTJeUoWVLo=; b=ZDU+0K
	W3egy0M8aAumFA0Xm6MKVPUsSL2cVerhLc0DuOgDjkmjPmt92glRF86CbIdXtjYv
	rgQa38kqReTD9PgeQGlnB3G5Fwv8qv/l1YC64US7w4Bw8YuRZtJzaaoxGU/JCkFl
	LdggVFH2rAtqzkc/xK9usdgRjfE8Fj3IBxO/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XjOljgeIsloOsojsFXugnBVOt/to5NKU
	jn4Ql8Ihn156U/3DjCGDdiFxrMB3CgKbbpilunINgx+RlsVnTskKqEIK+32p8vJ8
	rDi1iGeX9E5FHBdQQO/8qJgLOuFUJGZ03szYVzwdJvvTRAQxRBI84YMmsys9d7el
	f7HSrYrXz8k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4CFA99C0;
	Fri,  9 Apr 2010 16:30:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 37282A99BF; Fri,  9 Apr
 2010 16:30:41 -0400 (EDT)
In-Reply-To: <20100409184608.C7C61475FEF@snark.thyrsus.com> (Eric Raymond's
 message of "Fri\,  9 Apr 2010 14\:46\:08 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C5AC6A74-4416-11DF-BF79-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144468>

Eric Raymond <esr@snark.thyrsus.com> writes:

> First, the documentation issues, in roughly increasing order of severity:
> ...

These all fall within "Patches welcome" category (meaning: I agree the
documentation can be improved and I don't object to changing them).

> D. How do I tell the conflict/no-conflict cases apart?
> ...
> Illustrative case: I see the status code "DD". How do I distinguish
> between case 4 ("deleted from index") and case 10 ("unmerged, both
> deleted")?

Is that DD really "illustrative", or did you mean to say "only/sole"?

You should never get "DD" in non-conflicting case.  I think I was fairly
careful not to make them ambiguous when I did that code, but apparently I
wasn't so careful about the documentation.

Thanks for going through this area with fine comb.

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 1cab91b..313dd04 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -86,7 +86,7 @@ and `Y` shows the status of the work tree.  For untracked paths, `XY` are
               [MD]   not updated
     M        [ MD]   updated in index
     A        [ MD]   added to index
-    D        [ MD]   deleted from index
+    D         [ M]    deleted from index
     R        [ MD]   renamed in index
     C        [ MD]   copied in index
     [MARC]           index and work tree matches
