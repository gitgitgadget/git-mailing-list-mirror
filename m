From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-log.txt,rev-list-options.txt: put option blocks
 in proper order
Date: Wed, 09 Mar 2011 15:38:20 -0800
Message-ID: <7vbp1j985v.fsf@alter.siamese.dyndns.org>
References: <4D75E92C.1090506@drmicha.warpmail.net>
 <f34ebc6211ead3fa6698ff9b7a92903723715a28.1299572814.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 10 00:38:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PxSxk-0006zJ-0c
	for gcvg-git-2@lo.gmane.org; Thu, 10 Mar 2011 00:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205Ab1CIXic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2011 18:38:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979Ab1CIXib (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2011 18:38:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8F2274676;
	Wed,  9 Mar 2011 18:39:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=uA+Vh/Tp8StEEBZ7GTBCqrKlShU=; b=A4mXUf
	/M8WrHJSdc1ve5msakHuEoJoUKu5LW2D43fBi4hJ5T9OQT+q20hLVp+jGl7LcN4M
	pRa4EBZaMJUN4NclyGHYMG0pC3ouMEGSasZPxnBKadHcZl800Dm5117aGdbBrVcG
	Rnmo+3x37sq+DOTHAQ9+1OVX7G7LswpaE8Src=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sol8dIjm+Vkvah7TAMh0FHjV4yIMIhbo
	skn504zO3wRUaQ8vOyQWcMie842119AGXHP+vr76faZ7bwAbboEXKAuWxmBanjLx
	8TJpgy1+0tYZzEio1xXCiWI9jrYL0IYRy4I3xPYTykBFKTTPhvxtE4OpQPlgTFxX
	73x+Yria/QU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D3244675;
	Wed,  9 Mar 2011 18:39:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2AB954660; Wed,  9 Mar 2011
 18:39:49 -0500 (EST)
In-Reply-To: <f34ebc6211ead3fa6698ff9b7a92903723715a28.1299572814.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Tue, 8 Mar 2011 09:31:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 88E71D9A-4AA6-11E0-8518-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168775>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
> index 48c1715..6ae57dc 100644
> --- a/Documentation/git-log.txt
> +++ b/Documentation/git-log.txt
> @@ -77,12 +77,12 @@ Common diff options
>  ~~~~~~~~~~~~~~~~~~~
>  
>  :git-log: 1
> -include::diff-options.txt[]
> -
>  include::rev-list-options.txt[]
>  
>  include::pretty-formats.txt[]
>  
> +include::diff-options.txt[]
> +
>  include::diff-generate-patch.txt[]

This is wrong.  The title "Common diff options", telling the AsciiDoc that
we are formatting for git-log manual page with ":git-log: 1" and inclusion
of diff-options.txt form a single group.  With your patch, the "Common
diff options" section will become ampty and makes AsciiDoc barf.

You would need _at least_ something like the attached patch on top, which
for now I'll squash in.

 Documentation/git-log.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 6ae57dc..c43aa43 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -73,14 +73,14 @@ produced by --stat etc.
 	to be prefixed with "\-- " to separate them from options or
 	refnames.
 
-Common diff options
-~~~~~~~~~~~~~~~~~~~
-
-:git-log: 1
 include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
 
+Common diff options
+-------------------
+
+:git-log: 1
 include::diff-options.txt[]
 
 include::diff-generate-patch.txt[]
