From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] t0000-*.sh: Fix the GIT_SKIP_TESTS sub-tests
Date: Tue, 20 May 2014 14:40:06 -0700
Message-ID: <20140520214006.GT12314@google.com>
References: <537BC8A2.9060009@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Tue May 20 23:40:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wmrlh-000590-9P
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 23:40:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbaETVkK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2014 17:40:10 -0400
Received: from mail-pd0-f178.google.com ([209.85.192.178]:61593 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbaETVkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2014 17:40:09 -0400
Received: by mail-pd0-f178.google.com with SMTP id v10so700135pde.9
        for <git@vger.kernel.org>; Tue, 20 May 2014 14:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=X7qAanT+Vxg6tYbsT1A99jG5BruMWXrHsL3+2vrMm5A=;
        b=k7D84pYnfxZQyvMt0ndx/Kx6kQfiOJGlZPDBAlDhDT6AfKcJobMKJMdkxa09iid7RI
         SC75X6SVbWJ/RzcdOi8+GubyfVIoi9zc0jCpn6nUdjO5YfxcbsuIbhTGnlKeUJQt2Kg6
         aA9YVrEsn7o3ZRbr17GZGOJlSVeHyNVuCuwiwwrd//CW6ITeQJx1Dm6yymB/Q9PhMT1H
         4vaYwerlunM+cavz0FqiIC1KKmgpf173GkF+9dz1FbcL9TeCpk01ZVDRCepKvuk97CJS
         ZTmBksKVNyA7NFgcnIZsD384FKeRB/qPsxLLZSA8+eysncgv1BRHhFV4IPW3qolLYeVX
         tA1A==
X-Received: by 10.69.1.69 with SMTP id be5mr53811032pbd.126.1400622009065;
        Tue, 20 May 2014 14:40:09 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id tg9sm4724104pbc.29.2014.05.20.14.40.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 20 May 2014 14:40:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <537BC8A2.9060009@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249750>

Ramsay Jones wrote:

> --- a/t/t0000-basic.sh
> +++ b/t/t0000-basic.sh
> @@ -296,8 +296,9 @@ test_expect_success 'test --verbose-only' '
>  '
>  
>  test_expect_success 'GIT_SKIP_TESTS' "
> -	GIT_SKIP_TESTS='git.2' \
> -		run_sub_test_lib_test git-skip-tests-basic \
> +	GIT_SKIP_TESTS='git.2' && export GIT_SKIP_TESTS &&
> +	test_when_finished sane_unset GIT_SKIP_TESTS &&

Oof.  Good catch.

What should happen if I have set GIT_SKIP_TESTS explicitly to run
only some of the tests in t0000-basic?

Thanks,
Jonathan
