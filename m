From: Junio C Hamano <gitster@pobox.com>
Subject: RFD: should we do another 2.3-rc for t9001-noxmailer? I'd say not
Date: Sun, 01 Feb 2015 14:48:00 -0800
Message-ID: <xmqqr3u98d0f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 01 23:48:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI3JK-000531-Ds
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 23:48:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753726AbbBAWsF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 17:48:05 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:65470 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753456AbbBAWsC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 17:48:02 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 09764337B0;
	Sun,  1 Feb 2015 17:48:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=j
	+ghqMPC9JjgKYa22v+yMz6R/c4=; b=QsVi0KQYJ6jU/BjMwItGWUcwPUxaYUYwH
	arMYr41bhyEi24vcsecjr9afwVzo3XXA98gFmBLv2JWphTM6TE08mmijAsYTx4MB
	d80VirTCZbkn6Du8GUO1k7BYm+QwCihuUAuRArUEqY213OZhoPhy2/Pe7IjaUh5s
	hDTgBcgAJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=UIY
	XuDHhRgwEYaDIWLFltQqlmPhReKPDwXw13oiTiXV7IP3eE1KNEQrHSl1fE4UR7iq
	eueL7tfHvERMUP8jIla/HCCH0UlLvfyGTe3U2MoGdAeb+Xm6LMkjNKuGNvoM6xmD
	bFpTPpeqWk9XMS5thvbTO6k6td0BIe/yQtZfongk=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F1C0A337AF;
	Sun,  1 Feb 2015 17:48:01 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 784DF337AD;
	Sun,  1 Feb 2015 17:48:01 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 602DA0C8-AA64-11E4-8344-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263244>

I was reviewing the recent bugs and fixes for the last time, and was
wondering if we want to do 2.3-rc3 with build fix for those with
ancient cURL (tc/curl-vernum-output-broken-in-7.11) and workaround
for those with Perl with older Getopt::Long (tc/t9001-noxmailer).

 - The former is not a regression between 2.2 and 2.3 (i.e. 2.2
   already had the same use of curl-config output).

 - The latter, strictly speaking, is a regression in that tests used
   to pass but tests in 2.3 no longer pass for those with older
   Getopt::Long.

But the latter is about a test script that lacks work-around, and
more importantly, everybody has lived with unconditional X-mailer:
output, and the minority with ancient Getopt::Long will survive
without being to able to give the new --no-xmailer (or --noxmailer)
option just fine.

So currently I am leaning to keep these two fixes where they are and
tag 2.3 final without them in a few days.
