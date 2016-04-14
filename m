From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 15/16] branch: use ref-filter printing APIs
Date: Fri, 15 Apr 2016 00:47:15 +0530
Message-ID: <CAOLa=ZR7rKETM2b34B2Whw7Au-t7iFEkcNAB4ZygeQM=9Lp9zQ@mail.gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-16-git-send-email-Karthik.188@gmail.com>
 <xmqqtwj6pnma.fsf@gitster.mtv.corp.google.com> <xmqqinzmpmg2.fsf@gitster.mtv.corp.google.com>
 <CAOLa=ZQ5gwW1vwREsK=h0tDuyk18axHU491brKJM_DR53=9zcQ@mail.gmail.com>
 <CAPc5daUZvP03o+eb2ngvRtV=aoXWGnZH9FKj9bRCEj3MrCT8WQ@mail.gmail.com>
 <CAOLa=ZQnM95mApOmYYZa3SeFq2af5FMmiqh0ZFZDn3EO8U9-Dg@mail.gmail.com> <20160413220559.GC8712@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 14 21:17:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqmm0-0000uN-QF
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 21:17:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbcDNTRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 15:17:48 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:36597 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbcDNTRr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 15:17:47 -0400
Received: by mail-qg0-f48.google.com with SMTP id f52so68974407qga.3
        for <git@vger.kernel.org>; Thu, 14 Apr 2016 12:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4klrwrT7GR287WDtNZKKpZI0R5/TAbX5MC9OMXhNOW8=;
        b=IN6Qaz6FZuyISDUzcrRKze+9RBitIWvW5sr1EBA5siK3W3Sj1FDXR8ks/R6O7JSZVX
         vRVCacqyFPMxUI2eDmnM9SXJ8TsNsnCqSd7qlYSd8mB7f5b503+wzVgSuTW/X4KSt7Xf
         3Ecn9UvvBuZ0UjUwOAN8QKNKKSHylRkDPOBfCGNRKL0IaAjftyFuORSWJwQrrDKV+xku
         RLhgT4thy32qRhrLeubcB10OEAF2Lq78JccFHQ8sdaN3UkH/e7CZP80hreNplQM4kZj9
         p4WYCTpaKa/Ih/7UmoQrtZsP8GW0bLA/FhgtqTTDkoOFK8KTyjw6ZjexZKuKOJmj8Xwy
         EqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4klrwrT7GR287WDtNZKKpZI0R5/TAbX5MC9OMXhNOW8=;
        b=NZ4e9UfCMmmYHIfTsQcjdbsmd6SrPcF+pyOACXqNTcIrU2fK5Ul09kGZF6FL7UCGHx
         RaXQa8NRuV4Ypw/wVOMnas1hIAHB2200fLkNtR1vLzMkbBW50PD1+lbFxScmkFtYrKLc
         XC6wbjlCFYhfrMDeY9Z+LtnOP/60V2/Wk5EVEJiH7jvOUMPnmzd0RNNhRV97KctEztcy
         PSqF1MU5Ve4N4HCLpntik0kvqccUqGWTrjDNsApkSc8BJs9rMg3IXxieBGMrvo9dFUGp
         d39pqtBEeJ5uZXZns7O7N215DZBY5b29b7Zs2UVADEJ7x0Ca8QAN88/b3BijZw9In8Wj
         LN4Q==
X-Gm-Message-State: AOPr4FXfG0SAkQkO9weroNDbFk2Q7m85UYGdaWtvGAN0jDZFUQRC+NZ0wlH7dYmjHtx31BgFIixeuiI6KHnpBg==
X-Received: by 10.140.218.82 with SMTP id o79mr9741323qhb.33.1460661465416;
 Thu, 14 Apr 2016 12:17:45 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Thu, 14 Apr 2016 12:17:15 -0700 (PDT)
In-Reply-To: <20160413220559.GC8712@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291558>

On Thu, Apr 14, 2016 at 3:35 AM, Jeff King <peff@peff.net> wrote:
>
> The cross-prefix behavior I put into the test is not something I feel
> strongly about; it was mostly just restoring the earlier behavior. I do
> think shortening everything is fine, too, as long as there's some way to
> get the fully qualified ref. E.g., if `git branch` shows %(symref:short)
> or %(symref:strip=2), by default, but you can ask for just %(symref) if
> you want (which I think is how you have it implemented now, though I
> notice that symrefs don't get nearly as many formatting options as
> things like %(upstream)).
>

That does make sense, I guess then I'll stick to shortening all symref's
by default and allowing the user to change this if needed via the '--format'
option.

About %(symref) not getting enough formatting options, I don't see anything
else in %(upstream) which would be required in %(symref), maybe the 'strip=X'
option could be added. But for now I see 'short' to be the only needed option.
If anyone feels that something else would be useful, I'd be glad to
add it along.

> If anyone is machine-parsing git-branch output in the first place, they
> are Doing It Wrong. And doubly so if they are relying on some obscure
> shortening rules that I don't think were ever carefully designed. So I
> think we should be free to change it here to what serves users best.
>
> -Peff

This is a good reason, since 'git branch' is a porcelain command a change like
this shouldn't be a problem.

Junio, I'll re-roll with a small fix to the test written by Jeff soon.

-- 
Regards,
Karthik Nayak
