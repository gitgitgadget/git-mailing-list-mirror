From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v6 28/32] config: read ref storage config on startup
Date: Mon, 29 Feb 2016 17:59:14 -0500
Organization: Twitter
Message-ID: <1456786754.18017.69.camel@twopensource.com>
References: <1456354744-8022-1-git-send-email-dturner@twopensource.com>
	 <1456354744-8022-29-git-send-email-dturner@twopensource.com>
	 <20160227035634.GA10829@sigill.intra.peff.net>
	 <1456783062.18017.65.camel@twopensource.com>
	 <20160229221024.GE25342@sigill.intra.peff.net>
	 <20160229222107.GA18931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, pclouds@gmail.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 23:59:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaWmf-0005kX-D1
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 23:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbcB2W7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 17:59:17 -0500
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36348 "EHLO
	mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbcB2W7R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 17:59:17 -0500
Received: by mail-qk0-f172.google.com with SMTP id s68so62711004qkh.3
        for <git@vger.kernel.org>; Mon, 29 Feb 2016 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=YFrdzZgVcpzUpnrlvYJk5htz6Tv9gUwHXJmR+EWqNn4=;
        b=YURk2QyjAUyeKq9O0oUOKURz4KnpQQjpmaYLTzhv9qZyBs9es9vyuH0ENuWwnu0u6q
         DTPEA2q/bP0U1lHnLDu+A6Lbsir1P/Qksl/+JYE/m8fac04dRAUNeP23u9iUadhTYl6g
         k+sJmuJ8/XS0ClmGgyKuIzYlurpOgtnwanw9z3L2hhQ0L9Ly8ykTlRlz1XR+vcIkPREb
         HizyPCmvOcsNTXKLga696oLmLljJourTURRTu1xe/4qMOqJEFRcvI3RFnN34IoeHyloR
         inacUJU0k63VvIqHZb25Cn9BZVQ1wTjkuEB6Br2/t5Z1SsCK67LuqtQrAEa4yrWlIaVU
         91mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=YFrdzZgVcpzUpnrlvYJk5htz6Tv9gUwHXJmR+EWqNn4=;
        b=l0jtUcDDqB6OIvXnZV/NU4xsBV8Bp3Dh3b1Ns2SsH0OWVNhE7je8toMZjEFQYj0YbZ
         EVYZohsnxzPkZKNVrQU2fL9jPE4Xnvesjmv913WAfED1NC9Q8iv8kH22uOVsAZL7D2dy
         s1G6KaGfPf1Na2UYeRYuBA1uXikOX+8D+6fnEaYy0bxcypy81i2K8qgWuVixEb2Ej6YD
         bp2mF1CYiJiO67nhbE2Zu5b92x/iggZrzHmY5N1xvVmsxn5vZh7m7LVej8e0Efjah9P3
         aiJuZTQ5X8kajkTXZeRvlGU+5IezKlZN8UJUqfV4T9iB0wMdV/5bvmRZWXIhEOgFoVCx
         dTMA==
X-Gm-Message-State: AD7BkJLxc4J+ncUq2A5DzESzLF6V5aMeTVuAy1eq4n0jRz1hLLY6O2Kb0NAyz3JbVJA7Ew==
X-Received: by 10.55.78.201 with SMTP id c192mr23320557qkb.9.1456786756134;
        Mon, 29 Feb 2016 14:59:16 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n48sm11869916qgd.38.2016.02.29.14.59.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 14:59:15 -0800 (PST)
In-Reply-To: <20160229222107.GA18931@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287933>

On Mon, 2016-02-29 at 17:21 -0500, Jeff King wrote:
> On Mon, Feb 29, 2016 at 05:10:24PM -0500, Jeff King wrote:
> 
> > > We apparently don't always call check_repo_format before calling
> > > git_config_early -- or, more to the point, before doing ref
> > > operations.
> > > So I think we need this in git_config_early.
> > 
> > That seems horribly broken, though. If a program is accessing refs
> > without calling check_repository_format, isn't it bypassing all of
> > our
> > regular version and extension checks?
> > 
> > I think we should be smoking out such cases (e.g., by setting
> > a null refs-backend, as I mentioned earlier) and fixing them,
> > rather
> > than working around them by putting the backend setup in the wrong
> > place.
> 
> So even without your series, this isn't too bad to instrument, like
> the
> patch below.
> 
> It does reveal a handful of failures in the test suite. I haven't dug
> yet, but I strongly suspect those are all bugs that should be fixed.

I'll try to add a patch for these cases.
