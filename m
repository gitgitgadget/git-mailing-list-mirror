From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 0/2] do_compare_entry: use already-computed path
Date: Mon, 21 Dec 2015 23:26:02 -0500
Organization: Twitter
Message-ID: <1450758362.3892.7.camel@twopensource.com>
References: <1450737260-15965-1-git-send-email-dturner@twopensource.com>
	 <xmqqzix3e61h.fsf@gitster.mtv.corp.google.com>
	 <1450740784.3892.3.camel@twopensource.com>
	 <CAPc5daW4ru0j4Zd3ynnRcG8df7sZ9ZuVHu8mz2rxVonZpyE4Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 22 05:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBEWZ-0000bc-3P
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 05:26:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbbLVE0H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Dec 2015 23:26:07 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35299 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751304AbbLVE0F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Dec 2015 23:26:05 -0500
Received: by mail-qg0-f54.google.com with SMTP id o11so46906718qge.2
        for <git@vger.kernel.org>; Mon, 21 Dec 2015 20:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=XkB0urYNT2YsqmcXb0HdwM9UgiIL+K4vXiahYqxT5oA=;
        b=ApBCidpht+dyIR2MhnBb/sSn62dg5KkScUz1a2Jwt+qzoJhBuj7zA1GiA2jWWIiTDK
         ueuzDFX51Go2uXITrgTaELegOQSrky3BGb8bG2Us6whNwgzpo6jHEWRj/W0cWuNkmj28
         zitNh5oLZdW1mqnKg8LIpoebiJbwF1Bq+RwmcX+lmuuGkGHtCtOP1Qc+R9CMaxd2qj+c
         MVc/SG9aE6GXp1SVqoyi4lF1I3R+1/+vup6sOxdqm3Ia+KaLOmVk/8Neu7W6fv9bQHeQ
         T+nAOK1SdpkNEWAPjVQtZnB22zChPoNb6ja2b38oGsQZfPfaB0ePdvcsYqpTSldQRGCC
         tnGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=XkB0urYNT2YsqmcXb0HdwM9UgiIL+K4vXiahYqxT5oA=;
        b=NqTjNKm32YUhAT1XNoXpC14txDlrRjwSVkxHuh0OqRI1kVXFLqLlxE/2YA0zMhMP72
         4Px012+3iA5BnGkYhCi454FFhSGCFLgxYX1YLJUwJkBsNPaa5mn0tgkyYY4zje3x8t2E
         ne2l2s6VjF8aX4MXhihFvujodhnsFiT4AE6zhmTT8ku1Z9v53BizwE4aI+2ZYOcBox4g
         W0pCZaXl6tzgtriy2l4tqVqXWirtu9EJS6vSBwW8k61y5muAh+uNfqRMizpnZoGe2cI5
         uSzksLNOKTmfRQDCxnTGx08UaM/rdTCoIq0TrrkqsBIHY680ss8FSmg2GKd1rMHoP+zx
         T/UA==
X-Gm-Message-State: ALoCoQkfJ2rdQYEqBg9QL4RG/GtjdtAFmio1NwEKYX/L13YvBW7fEGh6RrohzgqATbQ7YTMtT0Q138V3zSdf0PaT4KP7e/Ih+A==
X-Received: by 10.140.158.4 with SMTP id e4mr31672834qhe.81.1450758363911;
        Mon, 21 Dec 2015 20:26:03 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id p19sm15377929qgp.9.2015.12.21.20.26.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 21 Dec 2015 20:26:03 -0800 (PST)
In-Reply-To: <CAPc5daW4ru0j4Zd3ynnRcG8df7sZ9ZuVHu8mz2rxVonZpyE4Gw@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282832>

On Mon, 2015-12-21 at 15:34 -0800, Junio C Hamano wrote:
> Great. Thanks, will queue w/o 1/2 (though I do not think it would
> hurt).
> 
> On Mon, Dec 21, 2015 at 3:33 PM, David Turner <
> dturner@twopensource.com> wrote:
> > On Mon, 2015-12-21 at 15:27 -0800, Junio C Hamano wrote:
> > > Thanks.  Does the number still stay at 25% improvement?
> > 
> > Yes.

BTW, that function, via ce_in_traverse_path, gets called about 40
million times when switching (checking out) between master and a branch
that's a few months old (and that contains relatively small changes
from master-as-of-then. Our repo only has approximately a quarter
-million files.  This seems somewhat unreasonable to me, but I haven't
really looked into what's going on. Do you happen to know why this is
and whether it is likely to be a bug?
