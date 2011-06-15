From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test 9500 - unhelpful without Perl::CGI
Date: Wed, 15 Jun 2011 10:05:41 -0700
Message-ID: <7vei2vja8q.fsf@alter.siamese.dyndns.org>
References: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com>
 <7vmxhjk539.fsf@alter.siamese.dyndns.org>
 <BANLkTinAfqysABm+t_NkOGO2U+iy57WbVQ@mail.gmail.com>
 <7vips7jaws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 19:05:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWtXK-00018k-18
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 19:05:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617Ab1FORFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 13:05:45 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65041 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274Ab1FORFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 13:05:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7F4DA45C0;
	Wed, 15 Jun 2011 13:07:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f0RU0K66cdhZOA2GTJtfh8rrp20=; b=lf/3iM
	5Jwv8mi1gyoUQRvaJHIR9/1qboIOE2ayJLpHCTV9qmlncb5BYzgCFv8vOLXLHJVt
	2imCjtJN5JhCAIrsbl/oCiNFRiUtswJKEqUszeyE8hbpHFWUprqhk4dylL+HTiXs
	FqJif4UGXktsKOtj0+sQgpBKsuL3G1wdkFcVQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=r7iwDWiNbBIJl/qUtcb5DUB5G00DMmYz
	uDDR7u915ucjne7mqfN52mxxEqWZ5w2UlWVzbsxs/AJY0+N1OP/h4rqCqP72rDxU
	k1NpgLBEVnDyNX7cXGCFmIdi3jsy4Gpi4qBjMix2H4K6XIDuMwSGQuxfspe9hnua
	pPBy5CMqGsA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7757745BF;
	Wed, 15 Jun 2011 13:07:54 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BCE3645BE; Wed, 15 Jun 2011
 13:07:53 -0400 (EDT)
In-Reply-To: <7vips7jaws.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Jun 2011 09:51:15 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0210B4FC-9772-11E0-A5E5-2C88C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175841>

Junio C Hamano <gitster@pobox.com> writes:

> Sverre Rabbelier <srabbelier@gmail.com> writes:
>
>> Isn't the new style to use test_must_succeed CGI_AVAILABLE '...' '...'
>> rather than skip_all+test_done?
>
> I do not think that adds any value, at least in this case.  Besides, look
> at the context line above what you quoted ;-)

In any case, I'd justify it like this and queue.  Thanks for noticing.

-- >8 --
Subject: [PATCH] t/gitweb-lib.sh: skip gitweb tests when perl dependencies are not met

Linus noticed that we go ahead testing gitweb and fail miserably on a
box with Perl but not perl-CGI library. We already have a code to detect
lack of Perl and refrain from testing gitweb in t/gitweb-lib.sh (by the
way, shouldn't it be called t/lib-gitweb.sh?), so let's extend it
to cover this case as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/gitweb-lib.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 143eb1f..292753f 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -107,4 +107,9 @@ perl -MEncode -e '$e="";decode_utf8($e, Encode::FB_CROAK)' >/dev/null 2>&1 || {
 	test_done
 }
 
+perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
+	skip_all='skipping gitweb tests, CGI module unusable'
+	test_done
+}
+
 gitweb_init
-- 
1.7.6.rc1.119.g85fc2
