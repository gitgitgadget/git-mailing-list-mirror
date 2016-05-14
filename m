From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] t9107: use "return 1" instead of "exit 1"
Date: Sat, 14 May 2016 10:37:07 -0700
Message-ID: <xmqqbn488rss.fsf@gitster.mtv.corp.google.com>
References: <20160513204654.GA10684@sigill.intra.peff.net>
	<20160513204721.GC15391@sigill.intra.peff.net>
	<CAPig+cQKkkP=Go=w65mGcgqZN6ckz21kG2=KCJS8L+0D3mgC+g@mail.gmail.com>
	<20160513234704.GA20238@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Armin Kunaschik <megabreit@googlemail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 14 19:37:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1dV8-0004fc-6h
	for gcvg-git-2@plane.gmane.org; Sat, 14 May 2016 19:37:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752730AbcENRhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 May 2016 13:37:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752128AbcENRhK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2016 13:37:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D045918227;
	Sat, 14 May 2016 13:37:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DsPDWWMdZvgC7ClMrobtvc+/CVs=; b=hS38hq
	rE/r5jiEMMvUeDJ5A58FKimE3dZOlTE+LHxApR6BL3CmzbCRqDKKt/ZLjqt28SuM
	3Eatb3XADYwCo0rclOFmP55/mPH2qkb3xRBogDwHDZFTCJZSjKgqSp4bO+ZJFB+Y
	LtCHVwl8PpPj6EzZMvqW4oK4RPUcZmOxt2lmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SeqYWG4gZI5NgKLAUTWtMPVIV0o0QIFX
	CpZVqAzeTJw3H7AOrNQ7bpfOU0gLiZGJCeYAULTXLjzRljuTi8S8JxcBkuDTUN2a
	Vj/BUmu0dvNFtxWLmTsTq/7M4Dbk05O+fEK5mT8rRMZvuQp2pJOMVXdp3Zfmj0jL
	LH9E+Wqv61Q=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C81E118226;
	Sat, 14 May 2016 13:37:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4262918225;
	Sat, 14 May 2016 13:37:09 -0400 (EDT)
In-Reply-To: <20160513234704.GA20238@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 13 May 2016 19:47:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7BEA555C-19FA-11E6-A91F-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294618>

Jeff King <peff@peff.net> writes:

> On Fri, May 13, 2016 at 07:45:42PM -0400, Eric Sunshine wrote:
>
>> > +       >expect &&
>> 
>> What's this 'expect' file for? Is it leftover gunk from before you
>> settled on 'diff --exit-code'?
>
> Oops, yes, that's exactly it.
>
> -Peff

Thanks for sharp eyes.  Let's squash this in, perhaps?

 t/t9107-git-svn-migrate.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9107-git-svn-migrate.sh b/t/t9107-git-svn-migrate.sh
index 2908aef..b6a99b8 100755
--- a/t/t9107-git-svn-migrate.sh
+++ b/t/t9107-git-svn-migrate.sh
@@ -80,12 +80,12 @@ test_expect_success 'multi-fetch works on partial urls + paths' '
 		git rev-parse --verify refs/remotes/origin/$i^0 || return 1;
 	done >refs.out &&
 	test -z "$(sort <refs.out | uniq -d)" &&
-	>expect &&
 	for i in $refs
 	do
 		for j in $refs
 		do
-			git diff --exit-code refs/remotes/origin/$i refs/remotes/origin/$j ||
+			git diff --exit-code refs/remotes/origin/$i \
+					     refs/remotes/origin/$j ||
 				return 1
 		done
 	done
