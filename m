From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 52/67] use sha1_to_hex_to() instead of strcpy
Date: Wed, 16 Sep 2015 14:51:13 -0700
Message-ID: <xmqq1tdyowxa.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915160535.GZ29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 23:51:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcKbn-0007jD-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 23:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbbIPVvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 17:51:15 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:33988 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965AbbIPVvP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 17:51:15 -0400
Received: by padhy16 with SMTP id hy16so220211324pad.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 14:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=VcZaeHOPDMpTYDOZ60Q2+n+/YOf3/ZEUY00RZ4yVCb4=;
        b=Au/UJ02wtt327/EnGFrbYz6VhZ8JIt9ntj3LYB9NogSh4QYOyghr1Xe5m8/fWnVB8a
         zMqNapX1MBFQPvPDvKJ3xt5lmFPBTlvoMza6v/UOpXxNSo/TEMqa+X1YsppUNl0giYKW
         rFL8wFK9rvWo78H0VbVX/4KfsqvRz9uJ1+sgHP9s8bsAC+4wa3rFetUink/FVE+wFQKs
         oQBe2tYtxBsV0iN0XrGUKTh1D17LWQbbaBeRs/eYYsTCJp3PT3DNuK5ZZRpZT0ingOHg
         FP591IOBQs5mCNkpAVUdsMToeUz1rK3vgoszGFThK7XGlD8mvaivbDzAYpinHlNDyAOV
         bXBw==
X-Received: by 10.68.218.65 with SMTP id pe1mr63791892pbc.2.1442440274548;
        Wed, 16 Sep 2015 14:51:14 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id yk5sm31959pab.31.2015.09.16.14.51.13
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 14:51:13 -0700 (PDT)
In-Reply-To: <20150915160535.GZ29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 12:05:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278073>

Jeff King <peff@peff.net> writes:

> diff --git a/builtin/merge-index.c b/builtin/merge-index.c
> index 1d66111..4ed0a83 100644
> --- a/builtin/merge-index.c
> +++ b/builtin/merge-index.c
> @@ -9,7 +9,7 @@ static int merge_entry(int pos, const char *path)
>  {
>  	int found;
>  	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
> -	char hexbuf[4][60];
> +	char hexbuf[4][GIT_SHA1_HEXSZ + 1];
>  	char ownbuf[4][60];

So you saved 19*4 = 76 bytes at runtime?

Looks good ;-).
