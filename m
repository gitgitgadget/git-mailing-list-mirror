From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug?  git format-patch -M -D then git am fails
Date: Tue, 13 Nov 2012 14:55:09 -0800
Message-ID: <7vsj8dcdv6.fsf@alter.siamese.dyndns.org>
References: <1352846721.17444.24.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, David Miller <davem@davemloft.net>
To: Joe Perches <joe@perches.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:55:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYPOE-0004sY-90
	for gcvg-git-2@plane.gmane.org; Tue, 13 Nov 2012 23:55:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755903Ab2KMWzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2012 17:55:13 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64253 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755410Ab2KMWzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2012 17:55:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A101EA320;
	Tue, 13 Nov 2012 17:55:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=o20y+uu+sPxMggHGvxbPiUqc5WA=; b=omzNs9
	6g12QCwhlNy7YCxURMs/3XMul43fM72Z15MekccM8ll8RjUTrLspadvL5aqp+Pxr
	fo2RwUKygMbAEoLDN6VSoVN7jZ+u24ph3vxQMZyFcUPGk9KrnpH5tJAWs4lf4Bp4
	RFh0OT+aYTh4owtsTaf9rlhI/UbjKk2y6Cw3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yfddDjcXaFPy7Cf/DNeS87ffaAUcdiQo
	AThyN9zCg3mgL4cgZl3Vwwa1YLYOXp9hbCp25XxqIqUxRQRId4sxoeYOF1cLYQju
	dpA8wNo/bp3lLjki7O/8wiCKQXwrLwsNLM7f5UYr9oCrjgeEFQUthcwED7mDfIM1
	LJqMyXMKufA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F3D7A31F;
	Tue, 13 Nov 2012 17:55:11 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DC90A31E; Tue, 13 Nov 2012
 17:55:10 -0500 (EST)
In-Reply-To: <1352846721.17444.24.camel@joe-AO722> (Joe Perches's message of
 "Tue, 13 Nov 2012 14:45:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D9E4192-2DE5-11E2-B258-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209680>

Joe Perches <joe@perches.com> writes:

> (Sorry about the partial message.
>  evolution and ctrl-enter sends, grumble...)
>
> If a file is deleted with git rm and a patch
> is then generated with git format-patch -M -D
> git am is unable to apply the resultant patch.
>
> Is this working as designed?

I would say it is broken as designed and it is even documented.

Please run "git format-patch --help | less" and then type
"/--irreversible-delete" to find:

    The resulting patch is not meant to be applied with patch nor
    git apply; this is solely for people who want to just
    concentrate on reviewing the text after the change.
