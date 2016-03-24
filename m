From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 09/33] refs: reduce the visibility of
 do_for_each_ref()
Date: Thu, 24 Mar 2016 14:56:15 -0400
Organization: Twitter
Message-ID: <1458845775.2976.1.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-10-git-send-email-dturner@twopensource.com>
	 <56F3924C.3040408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	peff@peff.net, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 24 19:56:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajAQi-000805-0E
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:56:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbcCXS4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:56:20 -0400
Received: from mail-qk0-f178.google.com ([209.85.220.178]:35285 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750884AbcCXS4S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:56:18 -0400
Received: by mail-qk0-f178.google.com with SMTP id o6so23692966qkc.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rds08s0HuRgTkEm4qCheAUj9YMp1D+YmYtX5PY/EQFc=;
        b=uhbDGmzzQecpOAOC3YYGdejQIh3hLOPSLwamWLKhoYl6GFS6vBEhz9XqXtPPFgt+JD
         9/SK9SpfDzsq+3nMn7K5EIC2M/41xM/6EDNKaspRngXKyE3InGaK8KHfC9mXB29U7x2t
         2KrgN4YmgwJRnRiluM93kxO8Q7Zx/mtygEJI3Vx/yOrHhq+oJP+toSQe2ZXD/+A9OEV5
         c1hvXdf2y0tRofuFWwLG+jzNYrlwapgm/hGWPWGi/4sZCylLIoXrvL1EqC/fmUh7qXLx
         aulf3DsQTBM7cyrOeOnFiwXwZYJbLAQyC/7L+RiOSVdtyjRWqC4mJiZQUfC9heEUpR3t
         RxJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rds08s0HuRgTkEm4qCheAUj9YMp1D+YmYtX5PY/EQFc=;
        b=LueGSvyOZTtThoXebEqP13DI0Tm27s+W77I6foeraSt8DnvDic+tAG69esnaI2oSHl
         ejXzxStOMXnT99Yr+09igJIr+81ebq4/SZrS1BKotBMzkf5zFhIlUMWFQNzdOWQ85KcT
         lh6IlPXwnZ7dCxAB5HKAhxFmcCkpbvfZf0dtSqhgSHjF7uoLqHTEsZyPgZx/eZ/gc2fc
         RCHlhOIVJgRPVYKsNF+T1Ynui/9PBZc0vPx0fC+9RxuHJfwlGWAxnlfXcD1tZFYks9Rb
         9ywCk+KCHW2xtLNfjZP+9/z+AaORAvcDEdFR/QHNUg/20MzfRpUHCKhf1NtYfHrFJOfO
         QUiQ==
X-Gm-Message-State: AD7BkJL1ETFksJh2BIRISeVfezoJfEqVJBhWX/LEZWVW1Cq/GWUq7S6k+5E54xwROW2vuQ==
X-Received: by 10.55.27.234 with SMTP id m103mr12758485qkh.109.1458845777417;
        Thu, 24 Mar 2016 11:56:17 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id x64sm3768575qhx.47.2016.03.24.11.56.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Mar 2016 11:56:16 -0700 (PDT)
In-Reply-To: <56F3924C.3040408@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289784>

On Thu, 2016-03-24 at 08:07 +0100, Michael Haggerty wrote:
> > +/*
> > + * The common backend for the for_each_*ref* functions
> > + */
> > +static int do_for_each_ref(const char *submodule, const char
> > *base,
> > +		    each_ref_fn fn, int trim, int flags,
> > +		    void *cb_data)
> 
> The two lines above are indented incorrectly.

Fixed, thanks.

> > -
> > -int do_for_each_ref(const char *submodule, const char *base,
> > -		    each_ref_fn fn, int trim, int flags,
> > -		    void *cb_data)
> > -{
> > -	return the_refs_backend->do_for_each_ref(submodule, base,
> > fn, trim,
> > -						 flags, cb_data);
> > -}
> 
> Nit: in the previous patch, please put the function where you want it
> so
> that you don't have to move it in this patch.
> 
> > [...]
> 
> Michael

Ok.
