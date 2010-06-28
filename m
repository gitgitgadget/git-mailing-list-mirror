From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH] Add known breakage for 'git notes copy'
Date: Mon, 28 Jun 2010 11:12:01 +0200
Message-ID: <AANLkTimap7ziJ-NuAV6h7bGP3cX2cDY7rqEbgJ2unQSP@mail.gmail.com>
References: <41768aafce7a581e8b601e70826ce77381458a23.1277708369.git.bert.wesarg@googlemail.com>
	<20100628085907.GA14014@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 28 11:12:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OTANv-0000Dx-Qn
	for gcvg-git-2@lo.gmane.org; Mon, 28 Jun 2010 11:12:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803Ab0F1JMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jun 2010 05:12:06 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39045 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750732Ab0F1JMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jun 2010 05:12:03 -0400
Received: by iwn7 with SMTP id 7so20259iwn.19
        for <git@vger.kernel.org>; Mon, 28 Jun 2010 02:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=iP6vhsd1yWJ+lHjW4QZoMivTjkaD++Da9vFscMK7574=;
        b=ROeIHz8MieJHXWb7Ezfe1xTqWSpIlOV3TJTca/YOwxZinIHPDJrOepk0D7rd0b2L8x
         lneoev7EJZCBIxHr8NX4WlSiz2dA/Y8t0WrO1JY3idFBVCgu4m3azrI02jJhafNtjt6R
         5OL8w9LCc8zJ+K5FJivk71TGRAkSb1//i5dPo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=XjnavvLE4hQ3JB1/d6mWU6cCpEODY4AhXI83bQvWGGwXI8FPCgaz4Od/13V8zWjj8u
         1JCC/SioWlOOYjlH40V0D70oohxr8TwblfaSyKRpb3HFe3DsvpaXv853VKXfeFxRikEZ
         rJzKDCHfJh+SxgjG2wPWpHMo/HDCII1qEkELs=
Received: by 10.231.85.147 with SMTP id o19mr4747580ibl.82.1277716321856; Mon, 
	28 Jun 2010 02:12:01 -0700 (PDT)
Received: by 10.231.34.198 with HTTP; Mon, 28 Jun 2010 02:12:01 -0700 (PDT)
In-Reply-To: <20100628085907.GA14014@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149824>

On Mon, Jun 28, 2010 at 10:59, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 28, 2010 at 09:01:57AM +0200, Bert Wesarg wrote:
>
>> 'git notes copy' dumps core when no arguments are given.
>
> How about:

Thanks.

Tested-by: Bert Wesarg <Bert.Wesarg@googlemail.com>

FWIW, here is the correct and updated test for this:

-- >8 --
Subject: [PATCH] notes: add test for git-notes copy with too few arguments

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 t/t3301-notes.sh |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index 64f32ad..dcd962a 100755 t/t3301-notes.sh
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -1044,4 +1044,9 @@ test_expect_success 'GIT_NOTES_REWRITE_REF
overrides config' '
 	git log -1 > output &&
 	test_cmp expect output
 '
+
+test_expect_success 'git notes copy does not segfaults with too few
arguments' '
+	test_must_fail git notes copy
+'
+
 test_done
