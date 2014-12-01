From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] ls-tree: disable negative pathspec because it's not supported
Date: Mon, 01 Dec 2014 11:40:36 -0800
Message-ID: <xmqqfvczp39n.fsf@gitster.dls.corp.google.com>
References: <1417338302-8208-1-git-send-email-pclouds@gmail.com>
	<1417338302-8208-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 20:40:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvWpw-0001PT-4J
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 20:40:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932112AbaLATkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Dec 2014 14:40:40 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61851 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753643AbaLATkj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Dec 2014 14:40:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1347820547;
	Mon,  1 Dec 2014 14:40:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Bv4O2n/Z5X0m
	ckOE44g9w8hJ63U=; b=dnOX46fWcBH7kdHW6OZVDaMsZNEg2t8efabOKh7E6ucf
	drvBtQdoyedMws/hT/D5M/IbDgUpMR2ZqIILVZNJM9+xGI7J68FYCODq/Ugq1Pdw
	JSbp6lAK9FhJ1Gq9vcFUcBCXljgoVLzk4c7DyR7U7/gFDL13g2uuD1rdn9w+6L4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jUIVf4
	RKtbQxe2qVNpG/GJeybIWpr8+/i7TnF7RHNGYhkl3xp0Zphcxbv1o4Yj6nJXbpwl
	a2+hi7bke+/+AwnQxfqJ7w5v9wGh+nLR3S90+FXR04ojQP98bQnGaLo/dGwwikUA
	S+56Pr5rA5LqAdLcDcJBiM+thcI/PuuTJSWfU=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0760020546;
	Mon,  1 Dec 2014 14:40:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 86FD520544;
	Mon,  1 Dec 2014 14:40:37 -0500 (EST)
In-Reply-To: <1417338302-8208-4-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sun, 30
 Nov 2014 16:05:02 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ECA87162-7991-11E4-9159-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260508>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Hmph, that's sad.  Should the below say "test_expect_failure"
without "test_must_fail", anticipating a fix later?

 t/t3102-ls-tree-wildcards.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.s=
h
index 83fca8d..93127a0 100755
--- a/t/t3102-ls-tree-wildcards.sh
+++ b/t/t3102-ls-tree-wildcards.sh
@@ -27,4 +27,8 @@ EOF
 	test_cmp expected actual
 '
=20
+test_expect_success 'ls-tree rejects negated pathspec' '
+	test_must_fail git ls-tree -r HEAD ":(exclude)a" "a*"
+'
+
 test_done
