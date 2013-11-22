From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Revamp git-cherry(1)
Date: Fri, 22 Nov 2013 11:39:09 -0800
Message-ID: <xmqqy54gz0o2.fsf@gitster.dls.corp.google.com>
References: <xmqqli0h4kvj.fsf@gitster.dls.corp.google.com>
	<dde93c10b7f6cb7b8cf94e9a0310c8e05aca2517.1385137650.git.tr@thomasrast.ch>
	<xmqqa9gw1bne.fsf@gitster.dls.corp.google.com>
	<87li0gi5xx.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, a.huemer@commend.com,
	"Michael S. Tsirkin" <mst@kernel.org>, Jeff King <peff@peff.net>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Fri Nov 22 20:39:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjwZS-00017n-8f
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 20:39:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756031Ab3KVTjO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 14:39:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38220 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755605Ab3KVTjN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 14:39:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F7F854594;
	Fri, 22 Nov 2013 14:39:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6TT5ZgbfDteCoAiLZ8enY6neGd4=; b=IJXnF+
	UCZGNMtatUe+qUK+N5NshcCPRzsUDTAmRDXKb3/H7idWfuMFt4Nhiow5BYQpTwkL
	yCd5v0W2QoMK4QlloEPY2k4yb4CwAKGENjg89CM3Hp0aVggq2m2yHJxMeq451o2v
	BeiFz4BDJcLNp0oP+xKz9RoXbVXaFICa/kozM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=osjVyePoVIt22aKSX73ZZRCC41AJZ0cf
	afcmyv8j37nFx0ZOwwY+1uGGrs5moo989RN4hSMGFfPWbCJuc/uHkKISXiCHzCiS
	agEnI96DPNgNbkNXa2ZcLxHG2Zpn4C4Vt55RK2uKo2gUoMk9iOYAvS+vupVOYRG1
	G7B2SKlTe+M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2705654592;
	Fri, 22 Nov 2013 14:39:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CC7E54590;
	Fri, 22 Nov 2013 14:39:12 -0500 (EST)
In-Reply-To: <87li0gi5xx.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Fri, 22 Nov 2013 20:37:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C3653598-53AD-11E3-A587-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238208>

Thomas Rast <tr@thomasrast.ch> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> We are listing those that need to be added to the upstream with "+",
>> while listing those that can be dropped from yours if you rebase
>> with "-".  Hinting the rationale behind the choice of "+/-"
>> somewhere may help as a mnemonic to the readers (see below).
> [...]
>> And the earlier "why +/-" could be done after this picture,
>> perhaps like:
>>
>> 	Here, we see that the commits A and C (marked with `-`) can
>> 	be dropped from your `topic` branch when you rebase it on
>> 	top of `origin/master`, while the commit B (marked with `+`)
>> 	still needs to be kept so that it will be sent to be applied
>> 	to `origin/master`.
>>
>> or somesuch?
>
> Good idea, thanks.  Will integrate this more "what still needs to be
> integrated"-minded wording into a v3.

Just to possibly save one round-trip, here is what I tentatively
queued on top of yours.

 Documentation/git-cherry.txt | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 6d14b3e..0ea921a 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -3,7 +3,7 @@ git-cherry(1)
 
 NAME
 ----
-git-cherry - Find commits not applied in upstream
+git-cherry - Find commits yet to be applied to upstream
 
 SYNOPSIS
 --------
@@ -56,6 +56,7 @@ $ git checkout -b topic origin/master
 $ git format-patch origin/master
 $ git send-email ... 00*
 ------------
+
 Later, you can see whether your changes have been applied by saying
 (still on `topic`):
 
@@ -84,8 +85,8 @@ $ git log --graph --oneline --decorate --boundary origin/master...topic
 o 1234567 branch point
 ------------
 
-In such cases, git-cherry shows a concise summary of what has been
-applied:
+In such cases, git-cherry shows a concise summary of what has yet to
+be applied:
 
 ------------
 $ git cherry origin/master topic
@@ -94,6 +95,12 @@ $ git cherry origin/master topic
 - aaaa000... commit A
 ------------
 
+Here, we see that the commits A and C (marked with `-`) can be
+dropped from your `topic` branch when you rebase it on top of
+`origin/master`, while the commit B (marked with `+`) still needs to
+be kept so that it will be sent to be applied to `origin/master`.
+
+
 Using a limit
 ~~~~~~~~~~~~~
 
-- 
1.8.5-rc3-362-gdf10213
