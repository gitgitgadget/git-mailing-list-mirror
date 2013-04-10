From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] transport-helper: report errors properly
Date: Wed, 10 Apr 2013 17:46:25 -0400
Message-ID: <CAPig+cR_zL5AW+h7ovGjo-Xc=wVcKPbHoRtG0wBG_b9oVXc05Q@mail.gmail.com>
References: <20130410211311.GA24277@sigill.intra.peff.net>
	<20130410211552.GA3256@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 10 23:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ2qf-0002GO-5i
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 23:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932522Ab3DJVq1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 17:46:27 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:59545 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759732Ab3DJVq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 17:46:27 -0400
Received: by mail-lb0-f178.google.com with SMTP id q13so1012752lbi.37
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 14:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=Vt6Tl63fRyMiVRNCzSVSOaG7AO4Sri7r0ttIa894Nyo=;
        b=iD4rGzovLlXFvtRu3Jf9QzCAZjBdROOe4ZWHkCWlFE95OZ5hjOXf+fWcTYQJ1lMoPl
         RtBA6H0gvrLE5k7isF0GfD14oB2WIqF1W3/C5DVhBW8bsYd8q+xW4K3arBRpPY2YMlp0
         R7YmKIB5cygXS5sMhd4x1zQ2LjBjLb8jSzJh0s19O7ticj6uysWknbKRLCNi9dTKgb36
         e7YdmSzlaz5NkBccFWhjPJgllvflIULG9xaIPWIXBQyfhnX9s7UPpApKHuzNRSlDwS7C
         neguHLvfhmMsOzydjIINHCBGqa9Dkz6qrPvipKuxs0a4Drps4JotbUhuK2yZR46tc2XN
         h5yw==
X-Received: by 10.112.75.197 with SMTP id e5mr2090707lbw.6.1365630385655; Wed,
 10 Apr 2013 14:46:25 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Wed, 10 Apr 2013 14:46:25 -0700 (PDT)
In-Reply-To: <20130410211552.GA3256@sigill.intra.peff.net>
X-Google-Sender-Auth: 69240Um0_8SEJZ9s5ZaVOwMDNxk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220780>

On Wed, Apr 10, 2013 at 5:15 PM, Jeff King <peff@peff.net> wrote:
> From: Felipe Contreras <felipe.contreras@gmail.com>
>
> If a push fails because the remote-helper died (with
> fast-export), the user does not see any error message. We do
> correctly die with a failed exit code, as we notice that the
> helper has died while reading back the ref status from the
> helper. However, we don't print any message.  This is OK if
> the helper itself printed a useful error message, but we
> cannot count on that; let's let the user know that the
> helper failed.
>
> In the long run, it may make more sense to propagate the
> error back up to push, so that it can present the usual
> status table and give a nicer message. But this is a much
> simpler fix that can help immediately.
>
> While we're adding tests, let's also confirm that the
> remote-helper dying is also detect when importing refs. We

s/detect/detected/

> currently do so robustly when the helper uses the "done"
> feature (and that is what we test).  We cannot do so
> reliably when the helper does not use the "done" feature,
> but it is not even worth testing; the right solution is for
> the helper to start using "done".
>
> Suggested-by: Jeff King <peff@peff.net>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> Signed-off-by: Jeff King <peff@peff.net>
