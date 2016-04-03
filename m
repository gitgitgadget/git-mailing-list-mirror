From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH v3 3/4] builtin/verify-tag: move verification code to
 tag.c
Date: Sun, 3 Apr 2016 17:53:11 -0400
Message-ID: <20160403215310.GC28933@LykOS>
References: <1459638975-17705-1-git-send-email-santiago@nyu.edu>
 <1459638975-17705-4-git-send-email-santiago@nyu.edu>
 <CAPig+cS47LSmwtLWPJZG8eFByEJ+t_hegM93nqsfTZEoH-+f4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 03 23:55:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ampzH-00087I-S8
	for gcvg-git-2@plane.gmane.org; Sun, 03 Apr 2016 23:55:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751984AbcDCVxO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Apr 2016 17:53:14 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34636 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcDCVxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2016 17:53:13 -0400
Received: by mail-qg0-f52.google.com with SMTP id c6so6632547qga.1
        for <git@vger.kernel.org>; Sun, 03 Apr 2016 14:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kfsnBUGTQIagKLr3398OVnfc/YX0th62XGhpB6gbstg=;
        b=jKxCswlS8zKXIF3zbX1RFV90vw/GBaXnbgb7gn3JbmGOYxDI03GXI7Gt7L6RLLqcI3
         1qXeFwtB/NPpP3vIO3jAHGR6ww18Bhdmeued8WHh/gYLuRDtpcMxi2wk9I0GPP5ksgUW
         disaX3vKDEqnN6mVaapSEYsX4uoCP6BZljfuLs1NAeX+i5xAFE87ZuqbJaPQigPxPcEn
         rFi5J5Lftyy6GjHxzqtvfLvj1kpXvtFzseql/eX7Y+qMpXm7meHXueC0R/GTkSj5MIvG
         X3SX0m0YbeHI1H3TOpgrcVWmG7kTAdhvwY65yt2Y+988xdcUVMhh6MdVPrmlT+/WHAKb
         85QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kfsnBUGTQIagKLr3398OVnfc/YX0th62XGhpB6gbstg=;
        b=E+stqcrSGySB8xhouylkQjL7qFzuxhX85u3uUX0QsrEn6yn3Om/IgErU2dtNO8LJKp
         ciEu2aKb02IKeMD7cHWlBLMCeGYYZMpmeIeTR4uVg6Scpw6Cg3IvX434zUX+aUKhAO6S
         xVU9QONfLq7UDq2bDMhyqD2zsdM+b1OFSDY2QnB5Vjx8ax1c1+jKHVTWFNuDXU8504bd
         jJIEEd6sFTNfdS9SY3hDJV09kdYwLuu1NgPUDwblFkG7G8BigMwBD+6xMW9VBewVm2do
         5soljnRfOVBaPh562ZEtAvCOozxcMtcvLZgRDJmMiT6aG6OOrGQCq2uTZuErqWPrDqcT
         97Xw==
X-Gm-Message-State: AD7BkJIig19maXcEe9xxyUUvJw2xYRsswXAb/hNvZKzLkSJCTFZqyAEMjxPyA87sXYhyvEAG
X-Received: by 10.140.81.51 with SMTP id e48mr7579536qgd.27.1459720392294;
        Sun, 03 Apr 2016 14:53:12 -0700 (PDT)
Received: from LykOS (cpe-74-65-203-27.nyc.res.rr.com. [74.65.203.27])
        by smtp.gmail.com with ESMTPSA id o77sm11048169qgd.37.2016.04.03.14.53.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 03 Apr 2016 14:53:11 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAPig+cS47LSmwtLWPJZG8eFByEJ+t_hegM93nqsfTZEoH-+f4Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290658>

On Sun, Apr 03, 2016 at 04:19:26AM -0400, Eric Sunshine wrote:
> On Sat, Apr 2, 2016 at 7:16 PM,  <santiago@nyu.edu> wrote:
> > The PGP verification routine for tags could be accessed by other
> > commands that require it. We do this by moving it to the common tag.c
> > code. We rename the verify_tag() function to pgp_verify_tag() to avoid
> > conflicts with the mktag.c function.
> >
> > Signed-off-by: Santiago Torres <santiago@nyu.edu>
> > ---
> > -       len = parse_signature(buf, size);
> > -
> > -       if (size == len) {
> > -               if (flags & GPG_VERIFY_VERBOSE)
> > -                       write_in_full(1, buf, len);
> > -               return error("no signature found");
> > -       }
> > [...]
> > +       payload_size = parse_signature(buf, size);
> > +
> > +       if (size == payload_size) {
> > +               write_in_full(1, buf, payload_size);
> > +               return error("No PGP signature found in this tag!");
> > +       }
> 
> Also, [1] asked why the moved code no longer respects
> GPG_VERIFY_VERBOSE, and that question doesn't seem to be answered
> either in the previous review thread or by this patch's commit
> message. It's not clear at a casual glance why this change is
> desirable.
> 

I must've missed this when moving code around. I don't think that this
if should change in any way. I'll put it back as it is (other than the
variable naming that is)
