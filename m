From: Vasily Titskiy <qehgt0@gmail.com>
Subject: Re: [PATCH] Ignore dirty submodule states during stash
Date: Tue, 17 May 2016 03:17:05 +0000
Message-ID: <20160517031705.GA2617@gmail.com>
References: <20160516020735.GA7884@gmail.com>
 <CAGZ79kaTss6ctZDCiRP2wjuxH+rJ79RKFLM79_FJN+37Bed+HQ@mail.gmail.com>
 <20160516154606.GA8797@gmail.com>
 <CAGZ79kZESuKiEt2RJJdWJPBySgbDA6abGkZMiTFgzaNCUP1_mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 05:17:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2VVX-0008IG-N3
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 05:17:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233AbcEQDRK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 23:17:10 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:35754 "EHLO
	mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751729AbcEQDRI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 23:17:08 -0400
Received: by mail-yw0-f194.google.com with SMTP id v81so504524ywa.2
        for <git@vger.kernel.org>; Mon, 16 May 2016 20:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ewgxRv8EuxQvc5U1O1ryAqw5jMr4QEEdZvTEJW1ryGA=;
        b=L0Mrakv6APq9qcTBisPwL5PxzYb5pCjx+5vBdj1o9kgcWQ+PX5WtTHnpxkXTGtnOVp
         9DlTzcqFegmx902uBVny9KzH8FUUIZZ1u2UqHNSpUX8mAuABgnc9F8PaWgKEyerbZGX2
         j1VHzpoAe375ZQvmQrtnNzLxcAfHcaswomZE3F01l45f7Pfp36zdoYgv7dH1Xv5vi/MM
         qPwgwnfMLBQhZfrUf7DBkaka2dCcajGSWaYpC56Xxb/KSqLci0dWqo+DWcDV5Wtw7AtZ
         2v/a2T4pjye/OnrpRh7BJna2hPXEzwm3aE9qUf4c5y+2c16V+DE8QiHmD2qsiaYU6FrR
         bI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ewgxRv8EuxQvc5U1O1ryAqw5jMr4QEEdZvTEJW1ryGA=;
        b=mEWo678yuVoO6cKjA9h/s0gC/LGNkeuAKp8NXpx/2Ik7+pfLH3j46tAzMLP6cXiNEX
         M0cHc05oVdcIFVdsewffI897dw+qTpiIruEYCWC5+TSmV1TE0Yp2++7IC/kCHpqtWfZo
         f+bt3Q/ZCKyvznuPS8YbRQlLUeGUuD/BmA1gaoI2d90k/1G5NSX6Qj29CrqO9nfJWbGw
         sjHUkQxCCFxwIhdtdcgu+7HOHPDfMaiJNkQGEqKprWBlsgxeBUMKGQQeuGUuJCIdCScZ
         eWOaWwiu6CuBWDOgvc9Ry82hnEbl2oLZjLitBtUZUmd8IMNp/DJRunJq6DgHcCdLCOZ+
         w9EQ==
X-Gm-Message-State: AOPr4FUeweiJPYWelApHlFn2tnmvWDA5yem6fr/X5EOGFKc0NOPAZPHYNb6nE+NTkcnm2w==
X-Received: by 10.129.76.147 with SMTP id z141mr15872233ywa.136.1463455027326;
        Mon, 16 May 2016 20:17:07 -0700 (PDT)
Received: from gmail.com ([2600:3c02::f03c:91ff:fe96:da77])
        by smtp.gmail.com with ESMTPSA id n126sm429219ywd.50.2016.05.16.20.17.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 May 2016 20:17:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZESuKiEt2RJJdWJPBySgbDA6abGkZMiTFgzaNCUP1_mA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294839>

Hi Stefan,

> > So, this is the issue. Instead of getting my local changes, I got a conflict (and stash is not
> > poped out). The root cause is the 'stash' command does not know how to deal with submodules,
> > but currently it tries to save the state of submodules, and even tries to re-apply the state
> > (and it fails of course). The proposed solution fixes this behaviour.
> >
> > All internal tests work fine with the change.
> 
> I think you could take the example as above and make it into a test?
> Showing that this change actually fixes a bug.
> 
> Looking for a good place, I would have expected t/t3906-stash-submodule.sh
> would be a good place to put your code, but I am not sure how to
> properly integrate that test there.
> 
> Maybe we can put the test in t3903 instead?
t3903 is better, as t3906 creates its submodule with forced 'ignore' option.
It's not a default parameter and it actually hides the issue. I'll send the
patches soon.


> >> Do we need a test/documentation updates for this?
> > I don't think so, 'stash' have never claimed submodule support.
> 
> But it also never explicitly claimed it doesn't support it.
> 
> Maybe we want to squash in something like
> (with better wording):
> 
> diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
> index 92df596..b2649eb 100644
> --- a/Documentation/git-stash.txt
> +++ b/Documentation/git-stash.txt
> @@ -41,6 +41,8 @@ the usual reflog syntax (e.g. `stash@{0}` is the most recently
>  created stash, `stash@{1}` is the one before it, `stash@{2.hours.ago}`
>  is also possible).
> 
> +Stashing ignores submodule operations completely.
> +
>  OPTIONS
>  -------
Looks perfect to me.

--
  Vasily
