From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gitk: replace SHA1 entry field on keyboard paste
Date: Tue, 04 Mar 2014 10:15:07 -0800
Message-ID: <xmqqmwh5ltjo.fsf@gitster.dls.corp.google.com>
References: <1393570297-6012-1-git-send-email-ilya.bobyr@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ilya Bobyr <ilya.bobyr@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 19:15:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKtsE-0007U4-ER
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 19:15:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbaCDSPO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 13:15:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751988AbaCDSPM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 13:15:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F5F66F396;
	Tue,  4 Mar 2014 13:15:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5lpxq06++VHX/Dw/dkxl7qR+VK8=; b=hKP0Zp
	9KM0QIA9M47fzTbFhAL6DpGV9F3ZlKYvUp4RAM1zHKAzgLv8cAp0nGq4W0/1Y+ID
	tdV6Mw7xNSM+aRK0aFPF1GJwDZMcXDWCQpeQqlWwfQ2Q5ksahwYXPqMFaeSlCT1B
	uxJw9Q9USuH57jIV9ua4KrL52MgUkkhOrpSDg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IjuErkQIyoIhWyjpUgD+TcFx7D5MJkfj
	sr1AkjjSbCmw1pWZJmpNixsfuT0TKvBPsRbuOP2WYeTTYJwij1p022V/R5Yvvk9j
	MOzuttBVJ89rY5WkJ9HeqqqtxXcICh6GKCr5uzMQ3ISK8fI4WsgXGjTh87hYmbFB
	gemfIAK5NnA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 350326F394;
	Tue,  4 Mar 2014 13:15:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7F1936F393;
	Tue,  4 Mar 2014 13:15:11 -0500 (EST)
In-Reply-To: <1393570297-6012-1-git-send-email-ilya.bobyr@gmail.com> (Ilya
	Bobyr's message of "Thu, 27 Feb 2014 22:51:37 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: ECF1BFEC-A3C8-11E3-97B2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243365>

From: Ilya Bobyr <ilya.bobyr@gmail.com>
Date: Thu, 27 Feb 2014 22:51:37 -0800

We already replace old SHA with the clipboard content for the mouse
paste event.  It seems reasonable to do the same when pasting from
keyboard.

Signed-off-by: Ilya Bobyr <ilya.bobyr@gmail.com>
---

 * Paul?  I do not use <<Paste>> on my keyboard, so I am not in the
   position to say that this patch is correct (or not).  I am just
   forwarding it in case you think gitk users will find it useful.

   The original patch was done against my tree, so I hand tweaked it
   to apply to your tree.
   
   Thanks.

 gitk |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 90764e8..2f58bcf 100755
--- a/gitk
+++ b/gitk
@@ -2585,6 +2585,7 @@ proc makewindow {} {
     bind $fstring <Key-Return> {dofind 1 1}
     bind $sha1entry <Key-Return> {gotocommit; break}
     bind $sha1entry <<PasteSelection>> clearsha1
+    bind $sha1entry <<Paste>> clearsha1
     bind $cflist <1> {sel_flist %W %x %y; break}
     bind $cflist <B1-Motion> {sel_flist %W %x %y; break}
     bind $cflist <ButtonRelease-1> {treeclick %W %x %y}
