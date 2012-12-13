From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] index-format.txt: be more liberal on what can
 represent invalid cache tree
Date: Thu, 13 Dec 2012 10:11:46 -0800
Message-ID: <7vk3slzusd.fsf@alter.siamese.dyndns.org>
References: <7v4njr5eac.fsf@alter.siamese.dyndns.org>
 <1355361287-10875-1-git-send-email-pclouds@gmail.com>
 <7v8v921zt6.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 19:12:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TjDGR-0006D7-RQ
	for gcvg-git-2@plane.gmane.org; Thu, 13 Dec 2012 19:12:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755335Ab2LMSLv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 13 Dec 2012 13:11:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56862 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384Ab2LMSLu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Dec 2012 13:11:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75C46A4E5;
	Thu, 13 Dec 2012 13:11:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=6EEsijKBZcrF
	FnOksqnz8utycGI=; b=AcBamhqM7R3JaTjoV4PioQOgwjHD+TN7dyFdQWr2PNVf
	wJgJhZ//ttDqaFyHnKovts6b7WjtqomKSPfwxmDWBXNf73rHJmk7AkQMbOqp1zCU
	yZztx+w4F+SrctXejMoPS7smNQQkI96HJ2ElknuPt7yeqBKgHUuYLFIuuR0QUcI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=cI1Miy
	bFZit9cT4WjjvnEiwy/KsODR+xQStaoXpPnmAxw7xCPP5+HJXekQfb6q4CcDm8eO
	jyRYouPqDxbBIBm9953hVbx3clLPx2A8jVAmFJjhNrDF8VrUbO7IkrNbq8I/Cc8C
	r5fnEbWHdaLNqeB1XogCnCNjOhHihQ4FiGJl4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6409FA4E4;
	Thu, 13 Dec 2012 13:11:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAC90A4E0; Thu, 13 Dec 2012
 13:11:48 -0500 (EST)
In-Reply-To: <7v8v921zt6.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 12 Dec 2012 17:55:01 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8FDADE88-4550-11E2-BFD7-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211461>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>>  How would that work with existing versions? If you write -2 in
>>  cache-tree, the next time 1.8.0 updates cache tree it writes -1 bac=
k.
>>  That loses whatever information you attach to -2. A new cache-tree
>>  extension is probably better.
>
> You can easily imagine a definition like this:
> ...

As we clarified that we do not allow implementations to write
anything but -1 for invalidated entries until we decide what we will
use other values for, the whole log message needs to be updated, I
think.

-- >8 --
=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
Date: Thu, 13 Dec 2012 08:14:47 +0700
Subject: [PATCH] index-format.txt: clarify what is "invalid"

A cache-tree entry with a negative entry count is considered "invalid"
in the current Git; it records that we do not know the object name
of a tree that would result by writing the directory covered by the
cache-tree as a tree object.

Clarify that any entry with a negative entry count is invalid, but
the implementations must write -1 there. This way, we can later
decide to allow writers to use negative values other than -1 to
encode optional information without harming interoperability; we do
not know what is encoded how, so keep these other negative values as
reserved for now.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/technical/index-format.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/index-format.txt b/Documentation/t=
echnical/index-format.txt
index 9d25b30..ce28a7a 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -161,8 +161,9 @@ GIT index format
     this span of index as a tree.
=20
   An entry can be in an invalidated state and is represented by having
-  -1 in the entry_count field. In this case, there is no object name
-  and the next entry starts immediately after the newline.
+  a negative number in the entry_count field. In this case, there is n=
o
+  object name and the next entry starts immediately after the newline.
+  When writing an invalid entry, -1 should always be used as entry_cou=
nt.
=20
   The entries are written out in the top-down, depth-first order.  The
   first entry represents the root level of the repository, followed by=
 the
--=20
1.8.1.rc1.141.g0ffea5d
