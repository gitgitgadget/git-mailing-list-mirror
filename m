From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add tests for rev-list --graph with options that
 simplify history
Date: Fri, 21 Aug 2009 13:15:27 -0700
Message-ID: <7vbpm8exeo.fsf@alter.siamese.dyndns.org>
References: <1250628954.114121983@192.168.1.201>
 <20090818211812.GL8147@facebook.com>
 <7vk5103chi.fsf@alter.siamese.dyndns.org>
 <20090819022918.GO8147@facebook.com> <20090819023433.GP8147@facebook.com>
 <7vhbw41g3f.fsf@alter.siamese.dyndns.org>
 <7v4os41frm.fsf@alter.siamese.dyndns.org>
 <20090819225547.GR8147@facebook.com> <20090819225852.GA21187@facebook.com>
 <7v7hwzt94p.fsf@alter.siamese.dyndns.org>
 <20090821182034.GW8147@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Adam Simpkins <simpkins@facebook.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 22:15:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeaWV-0007Bh-RC
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 22:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbZHUUPd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 16:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbZHUUPd
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 16:15:33 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64805 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932433AbZHUUPc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 16:15:32 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53609133DB;
	Fri, 21 Aug 2009 16:15:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0/UrI/Pv/KDpSfYa+8DaHPrvzSE=; b=DGozVz
	I47u/I7SVVsHcJL1cLWlSfcVK+nEaHaQv3JlNppMfpVf185KS41xIglp4VpKoZO+
	6hsGLacSqS27+dacKuQWFbCOjZCzWAtqseLdGwMirIhq9xM32sHe/UAzLQy5W4jF
	90o9erlzm3dFjuqtHEvMvN6nkkEpHpR9lX+cA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ap9b6O9RXWeabiov/EbOhGR9kEMyayn2
	ujXr3ZdyqpWWyAfgQxx+00e83u3d1/F05jv4KTVhw7qZ0S+ALndfG1Xkoq9xEPHW
	/EhG7TGZ2UHsBv9AZxdFxdOncIPy6WScEZx75O6fE2g+uQyzAs/p9NWbAUmpHTU/
	hDe9bgl1cIA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2F72E133DA;
	Fri, 21 Aug 2009 16:15:32 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6E443133D7; Fri, 21 Aug
 2009 16:15:29 -0400 (EDT)
In-Reply-To: <20090821182034.GW8147@facebook.com> (Adam Simpkins's message of
 "Fri\, 21 Aug 2009 11\:20\:34 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 60B2F0C6-8E8F-11DE-BCCA-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126748>

Adam Simpkins <simpkins@facebook.com> writes:

> These tests help make sure graph_is_interesting() is doing the right
> thing.
>
> Signed-off-by: Adam Simpkins <simpkins@facebook.com>
> ---
>  t/t6016-rev-list-graph-simplify-history.sh |  276 ++++++++++++++++++++++++++++
>  1 files changed, 276 insertions(+), 0 deletions(-)
>  create mode 100755 t/t6016-rev-list-graph-simplify-history.sh
>
> diff --git a/t/t6016-rev-list-graph-simplify-history.sh b/t/t6016-rev-list-graph-simplify-history.sh
> new file mode 100755
> index 0000000..5ac8fc9
> --- /dev/null
> +++ b/t/t6016-rev-list-graph-simplify-history.sh
> @@ -0,0 +1,276 @@
> +#!/bin/sh
> +
> +# There's more than one "correct" way to represent the history graphically.
> +# These tests depend on the current behavior of the graphing code.  If the
> +# graphing code is ever changed to draw the output differently, these tests
> +# cases will need to be updated to know about the new layout.

An ideal solution to such a problem would be not to write the tests that
way to require _the exact layout_ of the output.

What was the bug you were trying to fix?  Was it that in a simplified
history some arcs are not connected whey they should be?

Can you test that without relying on other aspect (say, commits are marked
with '*' right now but a patch might change it to '^' for some commits) of
the output?

I am just wondering how feasible it is the problem you are trying to
solve, not demanding you to solve it.
