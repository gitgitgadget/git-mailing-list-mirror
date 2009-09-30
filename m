From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH 5/6 (v4)] full integration of rev-cache into git,
 completed test suite
Date: Wed, 30 Sep 2009 02:53:49 -0500
Message-ID: <1254297229-14806-1-git-send-email-chris_johnsen@pobox.com>
References: <op.uzv4covmtdk399@sirnot.private>
Cc: Chris Johnsen <chris_johnsen@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Andreas Ericsson <exon@op5.se>,
	Christian Couder <christian@couder.net>
To: Nick Edelen <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 30 09:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Msu2y-00075p-CJ
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 09:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbZI3H4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 03:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753254AbZI3H4O
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 03:56:14 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49639 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752913AbZI3H4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 03:56:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 235EC648AA;
	Wed, 30 Sep 2009 03:56:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=A0dz
	OzSQyf3ehEbKL6QHOkNLrNw=; b=pyebNrxEEsaV7oDEGu63ea6yIp6O/cNVjCzD
	ON5Tx+8+axFNfUASz3YtNrz351rUAJ3QHf4hp505UGYJrCC4f1fub5rW+Ov3JVdG
	Y3ySbX0t+yxUmfU4Je4edaFKe6UDzo06vYZqFsNKjndsAizBjyzbx+qQ1kpe8DB4
	vecByyw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	i9wcyLuJn68czAyY8a2gsaVxM9LTg23VTcGGp6MjKs/aGMCjCPh+XRutPsnPrxlg
	oyH9uGexiWEFFRfgMz6ldEOI/Qu3/sbiZrYVD5VFe0NI7Yg24Yo3gXATQDfrPpZK
	DBqbQkF+XXAAc8fLncOzUNM0WYEaO54xMpnVQEcQ19U=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 842F5648A9;
	Wed, 30 Sep 2009 03:56:05 -0400 (EDT)
Received: from localhost.localdomain (unknown [75.53.42.120]) (using TLSv1
 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate
 requested) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0AAFF648A7;
 Wed, 30 Sep 2009 03:55:49 -0400 (EDT)
X-Mailer: git-send-email 1.6.5.rc1.183.g23fa6
In-Reply-To: <op.uzv4covmtdk399@sirnot.private>
X-Pobox-Relay-ID: B4A250CA-AD96-11DE-BFCE-8B19076EA04E-07245699!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129332>

(The Cc list of the parent message was truncated.
 The Cc list of this message was adopted from later messages.)

I needed something like the following to get the tests to pass.
If you like it, squash it into 5/6.

-->8--
Subject: [PATCH] t6017: use 'tr -d' to strip spaces from 'wc -c' output

The previous use of 'grep -o "[0-9]*"' was producing an empty string
(GNU grep 2.5.1 on Mac OS X 10.4.11). Additionally, since 'wc' echos
its filename arguments when stdin is not the source, the 'grep -o'
might have also extracted additional decimal strings embedded in the
filename (a SHA-1 hash value).

This 'tr -d' style is used in git-filter-branch.sh, and t6003.
Another alternative (in t1006) is to use 'sed' to strip off the
leading spaces.

Signed-off-by: Chris Johnsen <chris_johnsen@pobox.com>
---
 t/t6017-rev-cache-list.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t6017-rev-cache-list.sh b/t/t6017-rev-cache-list.sh
index 6ada7ac..3f49cb3 100755
--- a/t/t6017-rev-cache-list.sh
+++ b/t/t6017-rev-cache-list.sh
@@ -246,7 +246,7 @@ test_expect_success 'make fragmented slices' '
 	test `grep "final return value: 0" output.err | wc -l` -eq 3
 '
 
-cache_size=`wc -c .git/rev-cache/$cache_sha1 | grep -o "[0-9]*"`
+cache_size=`wc -c < .git/rev-cache/$cache_sha1 | tr -d ' '`
 test_expect_success 'test --ignore-size function in fuse' '
 	git-rev-cache fuse --ignore-size=$cache_size 2>output.err &&
 	grep "final return value: 0" output.err &&
-- 
1.6.5.rc1.183.g23fa6
