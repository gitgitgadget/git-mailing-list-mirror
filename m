From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/4] Make t1300-repo-config resilient to being run via
 'sh -x'
Date: Tue, 22 Mar 2016 10:59:48 -0700
Message-ID: <20160322175948.GG28749@google.com>
References: <cover.1458668543.git.johannes.schindelin@gmx.de>
 <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>,
	Kazutoshi SATODA <k_satoda@f2.dion.ne.jp>,
	Eric Wong <normalperson@yhbt.net>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:00:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQbJ-0007p7-F3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932704AbcCVR7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 13:59:55 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36101 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932508AbcCVR7x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 13:59:53 -0400
Received: by mail-pf0-f196.google.com with SMTP id q129so37929930pfb.3
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 10:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Eqkh/IlmxSi1qhY4Of6+mNRshn0VvIkVwUjmJ5JjXA4=;
        b=PY2bq1UvsemOjAQ3GccNKrgalgedncF5KwbN+yaBWZr44e2+npeY5BMbfEoI/Ew36c
         ur6Ix+WpoTN1TCocWTZqzhadNa3BZIKLQ/vdvjgF+e9N6z/5bdkiWj1uS0642Tgu2NjX
         bbTpjBRJ/GrQCf0XaleTfPBZMSwWejTKharqUq4+l+L5vxh0gBmh99/2Ounj2lnjBwcA
         DQSvxTXWB8IZmYbeUJWMl/u7jpNImYPGlKDwNwCsjkip4OI4R3Wq+dIptVckEJ/uf+86
         WKFbcVjDLymEiTzUFwnMsoyFC5szi5AXCjmCOkeGsE6OKPYQvNkr5+TDK/HTEgP7TEoc
         vDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Eqkh/IlmxSi1qhY4Of6+mNRshn0VvIkVwUjmJ5JjXA4=;
        b=HVJkWkR7xPf1TgjtcLmj/F1EDq8UhPQbQQEEvaACphrvawy0Z2KSnqzPiftWeMCwTh
         6ZBw4VupTFOySERGwDToSHltAicjTxzg7txpbloyHzBEF+4xWb8BRTNvHV7Dk5yYlaMv
         tUq7dKS5rB9qXF8eiAOrG8/7VSPxeCspkIKW4IiIOjDWt2mPrkg1QZnjN07+1YjXZ8zV
         JTYFRAWi4QZLOW7EiW5Wzbzr8NhtB6oRYP68Tm0VoBODNSQwUy+FEw0bhEns0zohKxzD
         klii1HeF204oVJPaqymUXII7r0GeHpeSslYuGmD/KuSZzOf/osLq04CY5/LPafJb5Ewi
         XrfA==
X-Gm-Message-State: AD7BkJIVAayFNzpjKElHfNFblmgbK83G2pcv1Q7NEiEZfGzu+58zjAPItf4mTA+FX4enMg==
X-Received: by 10.66.243.35 with SMTP id wv3mr56003553pac.93.1458669591451;
        Tue, 22 Mar 2016 10:59:51 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:694a:ddce:573a:2ea8])
        by smtp.gmail.com with ESMTPSA id ah10sm49865244pad.23.2016.03.22.10.59.50
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Mar 2016 10:59:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <b4df45088aa68d8410895f66a814dd6780e2e451.1458668543.git.johannes.schindelin@gmx.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289536>

Johannes Schindelin wrote:

> --- a/t/t1300-repo-config.sh
> +++ b/t/t1300-repo-config.sh
> @@ -699,17 +699,13 @@ test_expect_success 'invalid unit' '
>  	echo 1auto >expect &&
>  	git config aninvalid.unit >actual &&
>  	test_cmp expect actual &&
> -	cat >expect <<-\EOF &&
> -	fatal: bad numeric config value '\''1auto'\'' for '\''aninvalid.unit'\'' in file .git/config: invalid unit
> -	EOF
>  	test_must_fail git config --int --get aninvalid.unit 2>actual &&
> -	test_i18ncmp expect actual
> +	grep "^fatal: bad numeric config value .1auto. for .aninvalid.unit. in file .git/config: invalid unit$" actual

Would test_i18ngrep work?

>  '
>  
>  test_expect_success 'invalid stdin config' '
> -	echo "fatal: bad config line 1 in standard input " >expect &&
>  	echo "[broken" | test_must_fail git config --list --file - >output 2>&1 &&
> -	test_cmp expect output
> +	grep "^fatal: bad config line 1 in standard input $" output

This test is very strange.  Why do we care that it starts with
"fatal:" as opposed to error?  Why are we testing for an extra space at
the end of the line?

I would expect something like

	test_i18ngrep 'line 1 in standard input' output

to be more useful for testing the useful part of the error message while
remaining resilient against error message changes.

Thanks,
Jonathan
