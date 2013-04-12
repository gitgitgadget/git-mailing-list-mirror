From: Junio C Hamano <gitster@pobox.com>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 09:08:31 -0700
Message-ID: <7vk3o7g29s.fsf@alter.siamese.dyndns.org>
References: <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
 <20130411200330.GA15667@odin.tremily.us>
 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
 <20130411222301.GA11283@sigill.intra.peff.net>
 <20130412005748.GA17116@odin.tremily.us>
 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
 <20130412043501.GA12942@sigill.intra.peff.net>
 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
 <20130412050550.GA15724@sigill.intra.peff.net>
 <20130412112636.GC20178@odin.tremily.us>
 <20130412144855.GA17968@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Mike Galbraith <bitbucket@online.de>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 18:08:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQgWn-0005WF-L7
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 18:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752910Ab3DLQIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 12:08:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46790 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591Ab3DLQIg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 12:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7882137C2;
	Fri, 12 Apr 2013 16:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B6qRfHHNn1S+rrxpQNhJXkG9MLc=; b=W2vgOs
	yyrpfbbhON1GthJ6k8yAACj28EZW2+vTJ1gr6daW17gWEmsegch/pxb/QBo1fyy2
	VvpCscR2iL/ly3aRTq4LRmsPK0NYj/evH1Wr7NoHx0RKjwKVReOz/91RZN+rAmVe
	AR+DLRWC2P/JOZkSDsoGBthBRr1aUc1obj1XQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=E1FInviC+iTVD2AP5q9YFUgxRqrS0wzJ
	hTXzkwvroIO9peqZ86KfIGXGETmKzUp3L1XavZAL/9sgEkGQydXH5JBut69JnWmD
	/jLJg+qAXi0vuPhBzATwo3ewLenWwdBN3eVUe+yASKo0zpRMad6+XHRh1Icawc+o
	ygGsTTNreJE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF20A137BF;
	Fri, 12 Apr 2013 16:08:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3319A137B4; Fri, 12 Apr
 2013 16:08:35 +0000 (UTC)
In-Reply-To: <20130412144855.GA17968@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 12 Apr 2013 10:48:55 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3A926C0E-A38B-11E2-9B9D-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220992>

Jeff King <peff@peff.net> writes:

>> How about "and make sure any Git configuration files", since there
>> might not be any Git configuration files.
>
> Yeah, that is better. Thanks.

OK, then...

-- >8 --
Subject: [PATCH] doc: clarify that "git daemon --user=<user>" option does not export HOME=~user

Signed-off-by: Jeff King <peff@peff.net>
Helped-by: W. Trevor King <wking@tremily.us>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-daemon.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 7e5098a..2ac07ba 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -147,6 +147,13 @@ OPTIONS
 Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
 'git daemon' if needed.
++
+Like many programs that switch user id, the daemon does not reset
+environment variables such as `$HOME` when it runs git programs,
+e.g. `upload-pack` and `receive-pack`. When using this option, you
+may also want to set and export `HOME` to point at the home
+directory of `<user>` before starting the daemon, and make sure any
+Git configuration files in that directory are readable by `<user>`.
 
 --enable=<service>::
 --disable=<service>::
-- 
1.8.2.1-472-g6c5785c
