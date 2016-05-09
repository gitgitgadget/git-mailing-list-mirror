From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t4151 missing quotes
Date: Mon, 09 May 2016 11:56:00 -0700
Message-ID: <xmqq37pruklb.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEiBsU+jQ8VoRsniMdztCpVDemQ3r00W-OXdRP6ZEt9CFg@mail.gmail.com>
	<CAPig+cTbAA8xDWvCXbBF+HJpxONS38hcjAiNuocC+PUBro9ALg@mail.gmail.com>
	<CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Armin Kunaschik <megabreit@googlemail.com>
X-From: git-owner@vger.kernel.org Mon May 09 21:00:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azqLn-0005vn-1g
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbcEIS4F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 14:56:05 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751217AbcEIS4E (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 14:56:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 794CE1A03E;
	Mon,  9 May 2016 14:56:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hn+QvffhMhhlXD/zUyd9gKWdDKQ=; b=L5/XD9
	fed+BDhX2cnXHnw3ACXNnceHzuD/kJd11rhb32unlgQ0MKg08RxFVA3VAGhesWXw
	DfPh0MzKFSZm69nfZDHYSxKKpsX5o7lPauQqvKlXEHHp691GEQd6YPPjNiDm8YxW
	go7tQeHotXTsuwCZAD7EuJHTv1aOj3dpVaqng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jOS9n/7N876JkG2owyRW2qIf8W42xgkf
	XaY01ERd18+JBgAk4+i1GqEZlJfcJEFKXfKGGLveK3jmbRUyO1SLvL1LkNGG1R46
	dWfFQc9vSKIY48kQsFumq+gQHfSYZEvHRPPogr1+XM/yvZXz1RbXSDAFJIZMK1S1
	/RAsRs/cX10=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 71CA61A03D;
	Mon,  9 May 2016 14:56:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFF3D1A03C;
	Mon,  9 May 2016 14:56:01 -0400 (EDT)
In-Reply-To: <CALR6jEgaNSAQOpxSK46h71PMRhakDa=UCC5gbTyg77BcaOaoPg@mail.gmail.com>
	(Armin Kunaschik's message of "Mon, 9 May 2016 18:35:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ACBA23E2-1617-11E6-9AC8-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294039>

Something like this follows Documentation/SubmittingPatches, except
that it further needs your Sign-off before mine, which I can forge
if you say it is OK.

Thanks for a report and an analysis of the issue.

-- >8 --
From: Armin Kunaschik <megabreit@googlemail.com>
Subject: t4151: make sure argument to 'test -z' is given

88d50724 (am --skip: revert changes introduced by failed 3way merge,
2015-06-06), unlike all the other patches in the series, forgot to
quote the output from "$(git ls-files -u)" when using it as the
argument to "test -z", leading to a syntax error.

Note that $(git ls-files -u | wc -l) are deliberately left unquoted,
as some implementations of "wc -l" includes extra blank characters
in its output and cannot be compared as string, i.e. "test 0 = $(...)".

Signed-off-by: 
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4151-am-abort.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 833e7b2..b878c21 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -82,7 +82,7 @@ test_expect_success 'am -3 --abort removes otherfile-4' '
 	test 4 = "$(cat otherfile-4)" &&
 	git am --abort &&
 	test_cmp_rev initial HEAD &&
-	test -z $(git ls-files -u) &&
+	test -z "$(git ls-files -u)" &&
 	test_path_is_missing otherfile-4
 '
 
