From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 06/14] remote.h: add get_remote_capabilities,
 request_capabilities
Date: Tue, 03 May 2016 17:21:26 -0400
Organization: Twitter
Message-ID: <1462310486.4123.81.camel@twopensource.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	 <1461972887-22100-7-git-send-email-sbeller@google.com>
	 <1462215463.4123.70.camel@twopensource.com>
	 <20160503053337.GA17986@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 03 23:21:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axhl7-0001E9-OX
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 23:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756389AbcECVVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 17:21:30 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:36629 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756136AbcECVV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 17:21:29 -0400
Received: by mail-qk0-f181.google.com with SMTP id x7so15358984qkd.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 14:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=qYHk2LRfifhScfiNq0aEMPC2z2x1BlRIhQLw1X1I3aI=;
        b=fsSd0h+EEiJzO3HZq0e5ruZSyV6RtyyzsFIvIzRZ0tj1uLKOutSAIYI2OShXiIUjtM
         VtKpKC1brwh2myygg85UN9f3ecxn3x54FYDdsmhphxfPsnudwsnnTe8Yn3xlzEG2QpwZ
         CPFw7zaYPEi3Az6prqTO8OkPCotEuuxyuyfm2LwmS7FUm9LLrTlGwlsIbS5I3xMG8AUk
         s62WP2P9hoAbhmyFHqZWxJ/ldSO40S3u/UqrC3Av+sD6phAU19h4OEuNTFVTufw+l/Pi
         FRJ8c0WjVOf1bm0FAYk9wOV3IbNA4mGDOJJJy4/03CIhVOLb8BWIeTRhBHoeTKRqsJjR
         Ktxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=qYHk2LRfifhScfiNq0aEMPC2z2x1BlRIhQLw1X1I3aI=;
        b=IRl3QwiiVhBVCN+4YfMpkQtOsbluHQUakKzUjSLjqwlfwtRX/FEyQxtqdKKdsWXyPV
         8/6kJbK5THQuCDtmRIT6xkA64lEx3qnPLM7zlmSjq2kocKfcxIeyNT8iSIVO+NqTD69K
         nqSgwrZS1CMgsvtpnUUsm1OSagse2dPsZb18V6dhrYoaGUNCxtkyQZDoRaJ9vnK3laQL
         g+PtUi9AeeszrGK8GBMqkf5YKf5giSTuuJVB8kUokguNkm9CNPBfT3bjvzsV0yDb/qaf
         diI/hjIsAbK3TPbIFu3G3CJaGk/mCgyHDsko9TmD3MyseyXD/DCsW2UVw9UDoNd8yIGD
         yt9w==
X-Gm-Message-State: AOPr4FWChnrMgkJv82yA+qWEvhS6CxTnbXyB/fryGZwprzaC/o9hd+nEMtDiO5uaWVEvrA==
X-Received: by 10.55.74.14 with SMTP id x14mr5444216qka.70.1462310488468;
        Tue, 03 May 2016 14:21:28 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 23sm134405qkd.8.2016.05.03.14.21.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 03 May 2016 14:21:27 -0700 (PDT)
In-Reply-To: <20160503053337.GA17986@sigill.intra.peff.net>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293458>

On Tue, 2016-05-03 at 01:33 -0400, Jeff King wrote:
> On Mon, May 02, 2016 at 02:57:43PM -0400, David Turner wrote:
> 
> > On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
> >  
> > > +const char *known_capabilities[] = {
> > > +	"multi_ack",
> > > +	"thin-pack",
> > > +	"side-band",
> > > +	"side-band-64k",
> > > +	"ofs-delta",
> > > +	"shallow",
> > > +	"no-progress",
> > > +	"include-tag",
> > > +	"multi_ack_detailed",
> > > +	"allow-tip-sha1-in-want",
> > > +	"allow-reachable-sha1-in-want",
> > > +	"no-done",
> > > +};
> > 
> > I wonder if it is possible to not repeat the list from upload
> > -pack.c?
> > It seems unfortunate to have to add the same string in two places
> > whenever you add a capability.
> 
> I think that in general, we'd stop adding capabilities to v1. If you
> have a client which speaks the new capability, then it should also be
> speaking the new protocol. That's not strictly true if other non
> -git.git
> implementations want to learn capability X but not protocol v2, but I
> think in practice it's not an unreasonable world view.
> 
> I guess there may be a grey area for a while, though, where even
> v2-capable clients don't end up speaking it, because they don't yet
> know
> that a particular server can handle it. So any capabilities added in
> that grey area may want to go to both v1 and v2.

OK, but then there should be one list per protocol version rather than
two copies of the same list.  
