From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t0050-filesystem.sh unicode tests borked on dash shell
Date: Tue, 21 Dec 2010 12:43:16 -0800
Message-ID: <7v8vzi97rv.fsf@alter.siamese.dyndns.org>
References: <4D1105B5.5070703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: prohaska@zib.de, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue Dec 21 21:43:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PV93Y-0000sP-Q7
	for gcvg-git-2@lo.gmane.org; Tue, 21 Dec 2010 21:43:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471Ab0LUUnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Dec 2010 15:43:32 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42892 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751799Ab0LUUnb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Dec 2010 15:43:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 643CB3182;
	Tue, 21 Dec 2010 15:43:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WkLRg4iyKH72hgKMIk2srXaNHdQ=; b=QExitX
	VOEY6EYJ8zWj0s0w7aTNpbPQDXF4+dl9coN+4KWcp0vxUNdKXiK490TBoITJD2ID
	qnMbps7j/XIPhB4tSQCQ/ELvIeO9RzV7OpV3VpKgIjhy1vSoypC+WgRB9CsbQAEm
	ZY6oUCFKfXZnQI/zbzDKwOqjfxA6+UgF9IYB8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cstMTsCFCxgNArS/19tOg9PXryFpxtO6
	GsGpwvfXtWQkQD5HmioUADRrqBU3hjLnT5tjcAukEcUcOXLO8fGBk5rDxAkDVkis
	0f0/9wEK/Uzy9Fy2Nn/zv4FRY7LL2zO49jcakSouuY+3WUB+pebPrDP9SOQB2LB4
	y9eU6ij5akc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2BF7D3181;
	Tue, 21 Dec 2010 15:43:55 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1AF5F3180; Tue, 21 Dec 2010
 15:43:45 -0500 (EST)
In-Reply-To: <4D1105B5.5070703@ramsay1.demon.co.uk> (Ramsay Jones's message
 of "Tue\, 21 Dec 2010 19\:53\:25 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 06EE2DCE-0D43-11E0-B74F-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164058>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

>     $ ls trash\ directory.t0050-filesystem/unicode/
>     \x61\xcc\x88

The built-in printf in dash seems to lack understanding of '\xXX'.
It is tempting to patch it by using /usr/bin/printf but it is unclear how
portable it would be.

 t/t0050-filesystem.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 41df6bc..8ad102b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -4,8 +4,8 @@ test_description='Various filesystem issues'
 
 . ./test-lib.sh
 
-auml=`printf '\xc3\xa4'`
-aumlcdiar=`printf '\x61\xcc\x88'`
+auml=$(/usr/bin/printf '\xc3\xa4')
+aumlcdiar=$(/usr/bin/printf '\x61\xcc\x88')
 
 case_insensitive=
 unibad=
