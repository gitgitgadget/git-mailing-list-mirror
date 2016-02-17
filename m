From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 4/4] remote: use remote_is_configured() for add and rename
Date: Wed, 17 Feb 2016 15:24:55 +0100
Message-ID: <20160217142455.GC1831@hank>
References: <1455558150-30267-1-git-send-email-t.gummerer@gmail.com>
 <1455558150-30267-5-git-send-email-t.gummerer@gmail.com>
 <20160215183334.GH26443@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602171451030.6516@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 17 15:24:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW31z-0004Tm-He
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 15:24:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161629AbcBQOYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 09:24:34 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:36972 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030267AbcBQOYc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 09:24:32 -0500
Received: by mail-wm0-f50.google.com with SMTP id g62so30536475wme.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 06:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=TXGiexyjHWzC6y8tdMY0K1Afwa7L/nmyOLwOuS25JZk=;
        b=IYwiLsQrfvzM6PEvyrIO8NKcfcjEpv3x/xnxXPK0bsV/yEw0hl5KTpagJ7Vgq9z/xy
         jbeaRkEum6E2kaoMxGrTJ6FOhlZXFOzTFUXQUusyBVQnMyhNIwKCJNnAM2ylU2aLPFcj
         MQBcTEhb7QNy3K7k8/pf+O9luPQsYoDrFcgfqpg0vBITmnVrG2Gz/QNWWxcGMV5ovS47
         1i0Lf5s+jOdYG7ql+UYreE3zk22+urYJy4sPngQTSZRBM6YD+bySRWdp1cPPzkYveYVK
         od4iw1ln0hLA6i8JOJmJXYx/dLV+Qe0MC46QYXmeEZ4qRbzGYMf+DlpTALnVrAx1QTdE
         tTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=TXGiexyjHWzC6y8tdMY0K1Afwa7L/nmyOLwOuS25JZk=;
        b=eyZbHgdQh3yH3mDE2gSw7wIUbqYnb5aU6FfcDRhjJeXV7LbnDq0b+vSb9MTWvuDv3f
         FidzEjenedmZ3uQBswvWV4xj2bCvJI23kW6X2gkugA6fnkfKTMHtUn4JiRSgZJGNoe/q
         U81KF3nq3R2/RSMVsx0u6XxqwgqDTifL1LXG/yUVNA9tbYJ9YJOIIQTqKXDZ8WTf4Gl3
         IFmA3u5kMz+Zhyf4fX9s+v0TKBvBXj8GYgIlIxsZHL6yktlVfL4gpY9Ronmmh5fVsXRd
         6+I6v40B9E1ouXCYHyJXEPmtlti/KinWzyYaemXoJ6IVH51Pz8oCr9tjjd6qSyTMCObA
         kynQ==
X-Gm-Message-State: AG10YOQTZ2IjNOl7ByqmdUzMom54q2NOC+VicQ5SDXCCUpvues7NXbcLWUtr6Xp4BTy79Q==
X-Received: by 10.28.19.204 with SMTP id 195mr27781013wmt.1.1455719071123;
        Wed, 17 Feb 2016 06:24:31 -0800 (PST)
Received: from localhost (host144-107-dynamic.41-79-r.retail.telecomitalia.it. [79.41.107.144])
        by smtp.gmail.com with ESMTPSA id g1sm31899496wmc.0.2016.02.17.06.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Feb 2016 06:24:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1602171451030.6516@virtualbox>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286506>

On 02/17, Johannes Schindelin wrote:
> Hi Peff & Thomas,
>
> On Mon, 15 Feb 2016, Jeff King wrote:
> > This original is quite confusing. I thought at first that there was
> > perhaps something going on with allowing repeated re-configuration of
> > the same remote, as long as some parameters matched. I.e., I am
> > wondering if there is a case here that does _not_ segfault, that we
> > would be breaking.
> >
> > But reading over fb86e32dcc, I think I have convinced myself that it was
> > merely an ad-hoc check for "is_configured", and using that function is a
> > better replacement.
>
> Yes, yes, yes. Y'all are absolutely correct. I shoulda added a test case
> right away, to make sure not only that what I fixed does not get broken in
> the future, but also to document *what* was fixed, exactly.

Thanks for confirming and the test case so we don't break it again.

> So, belatedly, here goes a patch that verifies what that commit was
> supposed to fix, and yes, it passes with Thomas' changes (Junio, would you
> please apply this on top of tg/git-remote?):
>
> -- snipsnap --
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> Date: Wed, 17 Feb 2016 14:45:59 +0100
> Subject: [PATCH] t5505: 'remote add x y' should work when url.y.insteadOf = x
>
> This is the test missing from fb86e32 (git remote: allow adding
> remotes agreeing with url.<...>.insteadOf, 2014-12-23): we should
> allow adding a remote with the URL when it agrees with the
> url.<...>.insteadOf setting.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t5505-remote.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> index 94079a0..19e8e34 100755
> --- a/t/t5505-remote.sh
> +++ b/t/t5505-remote.sh
> @@ -51,6 +51,11 @@ test_expect_success setup '
>  	git clone one test
>  '
>
> +test_expect_success 'add remote whose URL agrees with url.<...>.insteadOf' '
> +	git config url.git@host.com:team/repo.git.insteadOf myremote &&

Minor nit: I think we should use test_config here.

> +	git remote add myremote git@host.com:team/repo.git
> +'
> +
>  test_expect_success C_LOCALE_OUTPUT 'remote information for the origin' '
>  	(
>  		cd test &&
> --
> 2.7.1.windows.2
--
Thomas
