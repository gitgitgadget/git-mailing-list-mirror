From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] unpack-trees: print "Aborting" to stderr
Date: Wed, 21 Sep 2011 15:40:06 -0700
Message-ID: <7v39fp1pvd.fsf@alter.siamese.dyndns.org>
References: <4E7996AA.4040909@drmicha.warpmail.net>
 <8b522de3711f339eea264dd7d8e44682af6c4865.1316590874.git.git@drmicha.warpmail.net> <7v7h511rl9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Joshua Jensen <jjensen@workspacewhiz.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 22 00:40:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6VSk-0002EA-EO
	for gcvg-git-2@lo.gmane.org; Thu, 22 Sep 2011 00:40:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600Ab1IUWkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Sep 2011 18:40:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751018Ab1IUWkL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2011 18:40:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D1F2681B;
	Wed, 21 Sep 2011 18:40:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=71I08iBriVSGrGAgPj2PAngpBWE=; b=pOpVrh
	c8Mk0gXvRdp8UMeeukujZUc4ZOjXnuhgT6fL6c7dwFeQOCBHDNPfYMG81YjJ/oe8
	j9MxPplAyo2x4h9Vts/tZrsBj6jsomia1Nf1RdNmbPPCi7m8XmSZeNsY70U8hc7/
	jDyH8oH70wrwI8GMucOKv3Gi1v7Alg0tEA7bg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q3EXabIpX7rA5luuK7A9yg5fToi6+oIV
	3rkoNGgU47RIIx/ELTRQ9rmM8V+EXfR5wYxWy26ysWS0Mhz/sMU57QErHtv9MUhw
	ZliUZic/8+ZnqgVsQIxU1NLTTYP3jE+DT6lGbrWuMXsrYsbCNB+ZkfLiNC8733W2
	XSFJhOS7w7M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 22FC5681A;
	Wed, 21 Sep 2011 18:40:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 759846818; Wed, 21 Sep 2011
 18:40:07 -0400 (EDT)
In-Reply-To: <7v7h511rl9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 21 Sep 2011 15:02:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7F71708-E4A2-11E0-93E9-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181866>

Junio C Hamano <gitster@pobox.com> writes:

> Forgot to update a test or two that this breaks?

In the meantime I've squashed this in.

 t/t7607-merge-overwrite.sh     |    1 +
 t/t7609-merge-co-error-msgs.sh |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/t/t7607-merge-overwrite.sh b/t/t7607-merge-overwrite.sh
index 72a8731..aa74184 100755
--- a/t/t7607-merge-overwrite.sh
+++ b/t/t7607-merge-overwrite.sh
@@ -107,6 +107,7 @@ error: The following untracked working tree files would be overwritten by merge:
 	sub
 	sub2
 Please move or remove them before you can merge.
+Aborting
 EOF
 
 test_expect_success 'will not overwrite untracked file in leading path' '
diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-msgs.sh
index c994836..0e4a682 100755
--- a/t/t7609-merge-co-error-msgs.sh
+++ b/t/t7609-merge-co-error-msgs.sh
@@ -32,6 +32,7 @@ error: The following untracked working tree files would be overwritten by merge:
 	three
 	two
 Please move or remove them before you can merge.
+Aborting
 EOF
 
 test_expect_success 'untracked files overwritten by merge (fast and non-fast forward)' '
@@ -56,6 +57,7 @@ Please, commit your changes or stash them before you can merge.
 error: The following untracked working tree files would be overwritten by merge:
 	five
 Please move or remove them before you can merge.
+Aborting
 EOF
 
 test_expect_success 'untracked files or local changes ovewritten by merge' '
@@ -71,6 +73,7 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please, commit your changes or stash them before you can switch branches.
+Aborting
 EOF
 
 test_expect_success 'cannot switch branches because of local changes' '
@@ -92,6 +95,7 @@ error: Your local changes to the following files would be overwritten by checkou
 	rep/one
 	rep/two
 Please, commit your changes or stash them before you can switch branches.
+Aborting
 EOF
 
 test_expect_success 'not uptodate file porcelain checkout error' '
@@ -105,6 +109,7 @@ error: Updating the following directories would lose untracked files in it:
 	rep
 	rep2
 
+Aborting
 EOF
 
 test_expect_success 'not_uptodate_dir porcelain checkout error' '
