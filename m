From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 0/4] Introduce diff.submodule
Date: Fri, 16 Nov 2012 16:15:02 +0530
Message-ID: <CALkWK0k65oyz1FWdyjjHLjj-DS75cdfk_8Vd3NV4OwzS+--VaA@mail.gmail.com>
References: <1352821367-3611-1-git-send-email-artagnon@gmail.com>
 <20121115162331.GD6157@sigill.intra.peff.net> <20121115162524.GE6157@sigill.intra.peff.net>
 <20121115163356.GF6157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 16 11:47:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZJSO-0002mT-Rb
	for gcvg-git-2@plane.gmane.org; Fri, 16 Nov 2012 11:47:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751029Ab2KPKpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Nov 2012 05:45:24 -0500
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61080 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817Ab2KPKpX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Nov 2012 05:45:23 -0500
Received: by mail-ob0-f174.google.com with SMTP id wc20so2639711obb.19
        for <git@vger.kernel.org>; Fri, 16 Nov 2012 02:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=DOrnqypDElTuy+VLzVNxjYLHgUYuXE08SZl49ix41/w=;
        b=gKbksfu4xD6nI77ICARb6bzuCHr1jERfoete+yKRY8bPvBoaSh+ZNSHHduV8Shx9hY
         n3OTSBGxh27vR44a0ObNFrzfiO5bR047CSrMad1ElHsjDgZeUOpYzt7I6feY05NPkkWa
         hYvo/ScfU2awNQefZyLq3vyqPj2zmZA7ZyTSXB31oA3wTvV7FeThBvVpcX2rbujKHQhq
         VqieRIZ1veBa3cebmow7/LY2JUewRVHAVMyCNzLpK4tu1rq/+P1sP3WP6fWCiTGvl5VT
         1Q+0VHBMhfv+dpvf8cy24sjqrPSuLBHbEvR43Irfj72fFoiO6gMgD0vB7kOdZtnE+7OH
         4rFg==
Received: by 10.60.171.201 with SMTP id aw9mr3403708oec.126.1353062722590;
 Fri, 16 Nov 2012 02:45:22 -0800 (PST)
Received: by 10.76.168.40 with HTTP; Fri, 16 Nov 2012 02:45:02 -0800 (PST)
In-Reply-To: <20121115163356.GF6157@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209870>

Jeff King wrote:
> It may be worth squashing this test into patch 3:

Looks good.  Thanks.

> BTW, while writing the test, I noticed two minor nits with your tests:
>
>   1. They can use test_config, which is simpler (you do not need to
>      unset yourself after the test) and safer (the unset happens via
>      test_when_finished, so it works even if the test fails).

I see.  Can you squash this in?

-- 8< --
diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
index e401814..876800f 100755
--- a/t/t4041-diff-submodule-option.sh
+++ b/t/t4041-diff-submodule-option.sh
@@ -56,7 +56,7 @@ EOF
 "

 test_expect_success '--submodule=short overrides diff.submodule' "
-	git config diff.submodule log &&
+	test_config diff.submodule log &&
 	git add sm1 &&
 	git diff --submodule=short --cached >actual &&
 	cat >expected <<-EOF &&
@@ -68,7 +68,6 @@ index 0000000..a2c4dab
 @@ -0,0 +1 @@
 +Subproject commit $fullhead1
 EOF
-	git config --unset diff.submodule &&
 	test_cmp expected actual
 "

>   2. You can still indent expected output when using <<-.

I know;  however, I wanted to be consistent with the surrounding code.

Ram
