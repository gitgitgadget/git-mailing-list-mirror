From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH] Implement https public key pinning
Date: Fri, 12 Feb 2016 11:02:26 +0100
Message-ID: <20160212100226.GB13775@hank>
References: <20160211225437.GA33955@mitoraj.siccegge.de>
 <alpine.DEB.2.20.1602120030120.5268@tvnag.unkk.fr>
 <87oabmg24u.fsf@mitoraj.siccegge.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Stenberg <daniel@haxx.se>, git@vger.kernel.org
To: Christoph Egger <christoph@christoph-egger.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 11:02:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aUAYF-0001Nl-9I
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 11:02:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbcBLKCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 05:02:07 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35509 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751885AbcBLKCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 05:02:02 -0500
Received: by mail-wm0-f41.google.com with SMTP id c200so12929171wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 02:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=MGAs0fFYBzXrQU8mIpQMIqb45buSZvy2vwAHzewyIyw=;
        b=ajQ0x+d+0IR04F1TMFaYdIHav+NNZPEkT3QfJzgWk2suxsF7av2rk7Cj3RdWSN/1+l
         Gs35SeMGrz/JBHGbxuITo4AUBt5naUUCF7/tvQQABNu6f4V97Y45CkCMBblmZHsJ2fiD
         BdsNIAIegOeJ16fm0fevj7EusXoi27VeBRLc6rVkLc/b+TY2J2SIez2kTomL6JmZhToh
         gXACQ2ylUvSPKgvU8gcKiF72+5HccYwkfQz93EudWhgSv62g0VP5iPWUr4T5ad+QrG9n
         dqp7in6RBVmxCeFiy5+yfKZ029Wvj86eUuqa8JU/jUbGhUPpGSagam+SiRuKyJFx+Aje
         V8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=MGAs0fFYBzXrQU8mIpQMIqb45buSZvy2vwAHzewyIyw=;
        b=iGPz+HRf2cFkdrH/kghPTlAMv3YJ4MvhYgnL8lxNw9kw3RI1wrAL7XLSW6hGedU+yq
         1YFFwQFYHLkrg8UfSXNGQlq6EeoCclQbJjliW9ILYYLyTxP3Vmg4XVVD3/4y1RoZIgj3
         cyRc6T8IFTLHcDkyQFfj6IGblOUI9hVEgGa+QGsSGu1aSj/gRTavhek3yWStQUAh3Muj
         VBjc+oPhWsibDMzx/g18oI4Dd3+Ph2pTh8st9vPQyHXRoqwDaDA+o9Fsx8SYph8liqEI
         pKkVF2JAIJu5Ff/EQM0rXW8uP0lJgimghCM6oy+cp7bRUlty8K3S+7PpnQuiXErORscJ
         3g9g==
X-Gm-Message-State: AG10YOTTgEqH6IpY6Txvsk+Oo2vpg20lWOE4UCdX/qi0giaZsPl9BokE9FURlJfzqtWCYA==
X-Received: by 10.194.184.112 with SMTP id et16mr717204wjc.75.1455271321289;
        Fri, 12 Feb 2016 02:02:01 -0800 (PST)
Received: from localhost (host214-157-dynamic.24-79-r.retail.telecomitalia.it. [79.24.157.214])
        by smtp.gmail.com with ESMTPSA id di1sm11296032wjc.3.2016.02.12.02.01.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2016 02:01:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <87oabmg24u.fsf@mitoraj.siccegge.de>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286044>

On 02/12, Christoph Egger wrote:
> Daniel Stenberg <daniel@haxx.se> writes:
> > On Thu, 11 Feb 2016, Christoph Egger wrote:
> >> +#if LIBCURL_VERSION_NUM >= 0x074400
> >
> > That should probably be 0x072c00 ...
>
> This is, of course, right.
>
> I used 7.44 / 0x072c00 as base because it has robust support for this
> feature (including the sha256// variant). One could lower that depending
> on the compromises one is willing to take FWIW
>
>   Added in 7.39.0 for OpenSSL, GnuTLS and GSKit. Added in 7.43.0 for NSS
>   and wolfSSL/CyaSSL. Added for mbedtls in 7.47.0, sha256 support added
>   in 7.44.0 for OpenSSL, GnuTLS, NSS and wolfSSL/CyaSSL. Other SSL
>   backends not supported.
>
> Also some people suggested that git should fail if this option is
> requested in the config but not supported by the libcurl version instead
> of falling back to just not pin the key. I'm undecided about that.

This seems to have been suggested off list (or at least I can't find
the message).  FWIW I do agree with failing or as a bare minimum
warning the user if the config option is set, but not supported by the
libcurl version.  Otherwise we risk giving the user a false sense of
security when the option is set, which is arguably worse than not
having the security option at all.

>   Christoph
