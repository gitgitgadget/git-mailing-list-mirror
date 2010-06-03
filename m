From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: About [PATCH 2/2] gitweb: Create a perl module to handle gitweb  cgi params and vars
Date: Thu, 3 Jun 2010 12:17:06 +0200
Message-ID: <201006031217.07525.jnareb@gmail.com>
References: <201006022229.31593.jnareb@gmail.com> <201006031055.28966.jnareb@gmail.com> <AANLkTilYSAj_byhZ1WDEBrYOAj6OZVsyDmp59vuK0tQz@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 03 12:17:25 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK7UL-000647-Co
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 12:17:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933357Ab0FCKRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 06:17:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:43934 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932663Ab0FCKRS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 06:17:18 -0400
Received: by fg-out-1718.google.com with SMTP id l26so2065003fgb.1
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 03:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bIxfKtiNlpS+ffhYqP63+c24/vJQCRKzFAyLqSSi4kw=;
        b=Ts/pJMm414ipxG/sfMxS0dXx08lt++BvLd5r5ZkUsc3fL+fZCxAavYgDpNEXVNLqUr
         vIFW3Z1Z3+gQvwOm7Cv3QppyiDlY0RkHZ9L0ZIqSqN//AH/5Ac093xj3HpR6OJ6Y3Auc
         mGPXxuljdAUUmR0OhnJMPzL+n2p0PuHKe+Ldo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=qkxptVpZc6gl3dESkc5G5UC9lL2e49XWGQuDd1D9jaPu+9CWmTPNZDwNZPKknErEVL
         H2LVPfpJUhw/0SBq296u7/Dm/6yRvZTwZr0EGBdYyMTKhf8w2SJTXa/SQrxCrXXvVifo
         SKgCwrnOYwR4Me0TtCvz2X3al7TcVeIdOeAT4=
Received: by 10.103.86.21 with SMTP id o21mr3308015mul.113.1275560236419;
        Thu, 03 Jun 2010 03:17:16 -0700 (PDT)
Received: from [192.168.1.15] (abvx149.neoplus.adsl.tpnet.pl [83.8.221.149])
        by mx.google.com with ESMTPS id j2sm13548422mue.23.2010.06.03.03.17.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 03:17:15 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTilYSAj_byhZ1WDEBrYOAj6OZVsyDmp59vuK0tQz@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148304>

On Tue, 3 Jun 2010, Pavan Kumar Sunkara wrote:
> Jakub Narebski wrote:

>> Shouldn't evaluate_query_params(), evaluate_path_info(), and the
>> subroutine that ties them together evaluate_and_validate_params() be
>> in Gitweb::Request too?
>>
>> Ditto with evaluate_git_dir()?
> 
> Well, evaluate_and_validate_params() and evaluate_path_info() contains
> calls to subroutines which are not yet moved into any package. So,
> what do you want to in such a case ?

O.K., in this case you should mention in the commit message that
the subroutines evaluate_query_params(), evaluate_path_info(),
evaluate_and_validate_params() and evaluate_git_dir() didn't get
moved to Gitweb::Request because evaluate_and_validate_params()
and evaluate_path_info() contain calls to check_head_link(),
die_error() and validate_*() subroutines which are not yet moved
into any package.  And it doesn't make sense to put only some
of them in Gitweb::Request.

We can always move them later.


P.S. The validate_*() subroutines could also be moved to
Gitweb::Request.  The check_head_link() subroutine looks like
candidate for Gitweb::Util / Gitweb::Utils; I am not sure where
one should put die_error() and friends: git_header_html(),
git_footer_html(), get_page_title(), and other subroutines
they use.

-- 
Jakub Narebski
Poland
