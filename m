From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make 'remote show' distinguish between merged and
 rebased remote branches
Date: Tue, 10 Feb 2009 13:17:07 -0800
Message-ID: <7v3aemm1po.fsf@gitster.siamese.dyndns.org>
References: <20090210202046.8EBEC3360AC@rincewind>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX00H-0000Z8-TR
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:18:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755268AbZBJVRR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754749AbZBJVRR
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:17:17 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64895 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbZBJVRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:17:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1F29498B27;
	Tue, 10 Feb 2009 16:17:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EF15998B24; Tue,
 10 Feb 2009 16:17:10 -0500 (EST)
In-Reply-To: <20090210202046.8EBEC3360AC@rincewind> (Marc Branchaud's message
 of "Tue, 10 Feb 2009 12:08:58 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2FEC1C6A-F7B8-11DD-A655-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109310>

Marc Branchaud <marcnarc@xiplink.com> writes:

> Prints "rebased" instead of "merged" if branch.<name>.rebase is true.
>
> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
> ...
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 1f59960..be0316a 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -112,6 +112,8 @@ cat > test/expect << EOF
>    URL: $(pwd)/one
>    Remote branch merged with 'git pull' while on branch master
>      master
> +  Remote branch rebased with 'git pull' while on branch rebaser
> +    side
>    New remote branch (next fetch will store in remotes/origin)
>      master
>    Tracked remote branches

I sympathize with what you are trying to do but I do not think this is
correct.  You will *never* rebase remote on top of your changes; rather
you will replay your changes on top of what the updated remote has.

It is more like "if you start git pull while on branch rebaser, it will
rebased on top of this branch from the remote".
