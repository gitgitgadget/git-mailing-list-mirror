From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Add new @ shortcut for HEAD
Date: Mon, 29 Apr 2013 18:10:13 -0500
Message-ID: <CAMP44s3fkrfZw-mcYKEfYy1SkGa1vvkMp14VRbwUUKcP8J-rKA@mail.gmail.com>
References: <1367264106-2351-1-git-send-email-felipe.contreras@gmail.com>
	<7vwqrlezcs.fsf@alter.siamese.dyndns.org>
	<CAMP44s2iTBW3P25RCDQCoM02K1JTs9v6-8SG91MJeUxh4b1qEQ@mail.gmail.com>
	<7vobcxey3g.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jon Seymour <jon.seymour@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:10:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxDC-0000df-DS
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:10:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758925Ab3D2XKQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:10:16 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:43779 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758823Ab3D2XKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:10:15 -0400
Received: by mail-lb0-f180.google.com with SMTP id v1so5908lbd.39
        for <git@vger.kernel.org>; Mon, 29 Apr 2013 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=RZGP2l1w/tPiDqQTwScrYdskHObR51Re9lrod+RNmik=;
        b=YdMqQIcDaGjxuHu+n963PSwnB8sZQ/oXnItnDd/pqsEnTUfpn+ny3uat+CXuLhtY3R
         CbwuZqZWNZqgN127KZtJWEZyKi12JPr9z0uMjHgc5YU4/PhPj1kHTZjYBxODrmxsSYuX
         DGtBVxFUnsT44D/KhHM2zAtnUevYARqFOA50XJiLYP6EpJypFQDXDNV0Wkq6RsciKXJo
         2ZLdJoru2tCHGvymXL2rtrpEP3KfF24Gkc/QPqFaFZS+iidpcs4ubgHK1nWKfUWtgugx
         jDV064591rRJUVA0N/3/oBBaa4C5T5GNDgGERLtJEOKoUMBIqu/U1Ofm9xiHs+4Ng5pe
         m32A==
X-Received: by 10.152.19.10 with SMTP id a10mr28595407lae.8.1367277013697;
 Mon, 29 Apr 2013 16:10:13 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Mon, 29 Apr 2013 16:10:13 -0700 (PDT)
In-Reply-To: <7vobcxey3g.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222877>

On Mon, Apr 29, 2013 at 6:06 PM, Junio C Hamano <gitster@pobox.com> wrote:

> --- a/t/t1503-rev-parse-verify.sh
> +++ b/t/t1503-rev-parse-verify.sh
> @@ -115,13 +115,18 @@ test_expect_success 'master@{n} for various n' '
>         test_must_fail git rev-parse --verify master@{$Np1}
>  '
>
> -test_expect_success 'empty @' '
> +test_expect_success 'empty @ and ref@ without trailing {stuff}' '
> +       test_when_finished "git branch -d twoago" &&
> +       git branch twoago HEAD~2 &&
>         rev_hash=$(git rev-parse --verify @) &&
>         test "$rev_hash" = "$HASH4" &&
>         rev_hash=$(git rev-parse --verify HEAD@) &&
>         test "$rev_hash" = "$HASH4" &&
>         rev_hash=$(git rev-parse --verify master@) &&
> -       test "$rev_hash" = "$HASH4"
> +       test "$rev_hash" = "$HASH4" &&
> +       rev_hash=$(git rev-parse --verify twoago@) &&
> +       test "$rev_hash" = "$HASH2" &&
> +       test_must_fail git rev-parse --verify nosuch@
>  '

Sure, but none of the tests above do that. Up to you.

-- 
Felipe Contreras
