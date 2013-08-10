From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] git exproll: steps to tackle gc aggression
Date: Sat, 10 Aug 2013 15:35:50 +0530
Message-ID: <CALkWK0=cZyKO7tjjtgE+tvwkkHGN7xLUy0uKHwXd8zkrM7o2Wg@mail.gmail.com>
References: <CALkWK0mxd35OGDG2fMaRsfycvBPPxDHWrPX8og5y2+4y1dfOpw@mail.gmail.com>
 <7v61vgazp5.fsf@alter.siamese.dyndns.org> <CALkWK0kqE8azzxp_GkzhPNT41nD8NzeLqXSe1xi0jbVo=7Xz3A@mail.gmail.com>
 <7vwqnw7z47.fsf@alter.siamese.dyndns.org> <CALkWK0=nerszb3_YA8P=qXbfAd4Y1rNsHXhfVKzwtj-x80iqkg@mail.gmail.com>
 <20130809110000.GD18878@sigill.intra.peff.net> <CALkWK0nSC-Aty55QO+DrM5Zf2t=DK8iMfbhv_HD44Z_m8d19Pg@mail.gmail.com>
 <20130809221615.GA7160@sigill.intra.peff.net> <CALkWK0kpqyxTyai2Lue7=D4z0kvhxuxKdYSWekT22zUhRis0Og@mail.gmail.com>
 <CACsJy8DtiSupsvDgeBXGGnGE06pDxWvYTNrk3bpta9Bwk5MZwg@mail.gmail.com>
 <20130810094339.GB2518@sigill.intra.peff.net> <CACsJy8CPM2jwWu0g+mamnA89UtWR=3B=8Q+j2mu-CMB=TRm7Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>,
	Git List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 10 12:06:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V864V-0005GT-63
	for gcvg-git-2@plane.gmane.org; Sat, 10 Aug 2013 12:06:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968536Ab3HJKGc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Aug 2013 06:06:32 -0400
Received: from mail-bk0-f48.google.com ([209.85.214.48]:44691 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968531Ab3HJKGb (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Aug 2013 06:06:31 -0400
Received: by mail-bk0-f48.google.com with SMTP id my13so1324178bkb.21
        for <git@vger.kernel.org>; Sat, 10 Aug 2013 03:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=5M0DONl4iJpE3RdNNVfWA11g89HRIjmKRTPncoe75Jk=;
        b=0s9mB6szBXa1OpyktvVwmROS2is/FDhtgP2tOfPFCOB625mrbB8IfinXyrS9S3cZJJ
         GDgZUNND0T7pf/mA1RsaJ8BOBtwfXkytj6HY3/OsbMi/JZ1aF3YtPtEV3luPugZF6xfP
         vt/56qOe+U7+5FUVh5tGojg6MMK0UDyNzwRDN/VX14rZOhuLQm8Ia143Ic3PZjxhGlkQ
         nKgiJdXR7Zjb9mdLyY/7Pic/j23VNvr3n4OjuVeQJjDU7wd4t6ninVX9XGrIPInKqwrN
         rYXZH9SROdzmlsQ1AmV9NeXtwdOyDHd5ykkBUEzq4cRrOb2owr892EvSGbYP3BOiqlCG
         0O2w==
X-Received: by 10.205.9.198 with SMTP id ox6mr2613033bkb.19.1376129190417;
 Sat, 10 Aug 2013 03:06:30 -0700 (PDT)
Received: by 10.204.186.77 with HTTP; Sat, 10 Aug 2013 03:05:50 -0700 (PDT)
In-Reply-To: <CACsJy8CPM2jwWu0g+mamnA89UtWR=3B=8Q+j2mu-CMB=TRm7Og@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232086>

Duy Nguyen wrote:
> Right. transport_get() is also run for push and it sets
> smart_options->thin = 1 unconditionally.

So, it looks like smart http implies the thin capability. I think
sop's patch (6 years ago) was about turning off thin on dumb http: can
we check that before deciding that push --[no-]thin is historical
cruft?

Also, a documentation update is required.
