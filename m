From: Junio C Hamano <gitster@pobox.com>
Subject: Re: /* in .gitignore
Date: Tue, 25 Sep 2012 16:13:19 -0700
Message-ID: <7vobktvgq8.fsf@alter.siamese.dyndns.org>
References: <CAE1pOi1vEGVcg5wn9VjkSVmMO_hparmYP0hn86XwpSpMmB=Peg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Users <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 01:13:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGeJp-0001Jo-A5
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 01:13:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751904Ab2IYXNW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 19:13:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58086 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053Ab2IYXNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 19:13:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 685899DE5;
	Tue, 25 Sep 2012 19:13:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jkO8MgssfOy524tEIB3etHqF/JQ=; b=Xu9tE0
	DsCIm1t4padSx4HmK8BBVaVAEO5Yp0FePzfPemC39jMXfaLGIZqTSWcuG7cHdgMX
	VKLfW3hwZ/2TYfuawXQqozu/NNpuyAhbxJOTqXyjIvflaLXkQA5p8UCqEsPOl61m
	a35VbPUnZq9+uk5stNg35Rew5Y9ORwua2JsxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VSnvzOQNHPH9XDlibc0PY+lf+4qioRqJ
	gAOMOwQTwDbnD+/XRiCCVMsFyXdFyUBBJHYT74+QXsMSxS9s4jLfMWFM+fotOmzf
	o/0CREiK0PxIzvJtnc1NoTqCiiPNNQMtuYNhtUtkljkiCVsmawW0GVl1ZKFzCwNO
	BZ2lreh1qYE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55A529DE4;
	Tue, 25 Sep 2012 19:13:21 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C3BC29DE2; Tue, 25 Sep 2012
 19:13:20 -0400 (EDT)
In-Reply-To: <CAE1pOi1vEGVcg5wn9VjkSVmMO_hparmYP0hn86XwpSpMmB=Peg@mail.gmail.com> (Hilco
 Wijbenga's message of "Tue, 25 Sep 2012 13:18:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 98EA8230-0766-11E2-9A76-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206383>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> Naturally, this behaviour makes perfect sense: "/*" means everything.
> Still, I was wondering whether it might be a good idea to make an
> exception for '.gitignore' itself? Then if somebody *really* wanted to
> ignore '.gitignore' they could add "/.gitignore" to '.gitignore'?

If somebody is sick enough to ignore "everything", he can add "/*"
to the .gitignore file and in order to make sure he knows what he is
doing and he is doing what he thinks is doing, he would check with
"git diff --stat HEAD" etc. before committing, and double check with
"git show --stat" etc. after committing.

".gitignore" (or ".gitattributes" for that matter) shouldn't be any
different from your ordinary tracked contents.  If you have "*.o" in
the ignored pattern list, you would need an extra care to defeat the
pattern to add vendor-supplied binary-only object file with "add -f"
and live with the fact that a new vendor-supplied binary-only object
file not appearing on untracked list.  It is exactly the same deal.

Having said that, I guess you could add "!.git*" to your
$GIT_DIR/info/exclude and see if it gives an improved user
experience.
