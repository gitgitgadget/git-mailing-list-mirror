From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 11/15] remote-testgit: make clear the 'done' feature
Date: Mon, 12 Nov 2012 07:45:15 -0800
Message-ID: <20121112154515.GB3546@elie.Belkin>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-12-git-send-email-felipe.contreras@gmail.com>
 <29291552-880A-4FEB-88E0-A73A1C7742F7@quendi.de>
 <CAMP44s0o1eP+aeT0AHu4uP1NPLqJq56qUDb-+F_x5NjoJCnf+A@mail.gmail.com>
 <EA56F0CC-7C93-491F-A076-4A1AA9593ED0@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Nov 12 16:45:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXwCh-0006Ly-3P
	for gcvg-git-2@plane.gmane.org; Mon, 12 Nov 2012 16:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab2KLPpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2012 10:45:25 -0500
Received: from mail-pb0-f46.google.com ([209.85.160.46]:42169 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2KLPpY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2012 10:45:24 -0500
Received: by mail-pb0-f46.google.com with SMTP id rr4so4443530pbb.19
        for <git@vger.kernel.org>; Mon, 12 Nov 2012 07:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=wcYSYhog1WXys63KD8NZGEFnz6f9Iao0Sl0KgHSIhos=;
        b=FSa+Cujcsdgz4X9n76HCZaD0NwbfIjN1enU3kN5oBgBaRboEpVG013HJq0mllYc1Qi
         3M+sUACUMuGGlXFEqwZHvcArvc5Cb1mQwTE+uwC23Tb/bTZnD9mNmgtU+Oa5GASDaC+P
         IC/+bH/tg2MQ+wu2QLB+QlE0uKlYQttlb9lpvy0Ae1zEiF9CyU/XafpfWtXDCrM+Lpc9
         EVVXepGIR9zjacmn0KaXqhr7wEMITBliYzGVyO7R/x8K7UYaIkFuHQLZPlvpjs7qkjUB
         tRo2vKAfWPfesOlkgDnexkLrmCXrG6OZ6ZPZbqNt7/e34ba0YCpxvk97haKoDlrenw+5
         eicw==
Received: by 10.66.72.134 with SMTP id d6mr56176466pav.13.1352735124243;
        Mon, 12 Nov 2012 07:45:24 -0800 (PST)
Received: from elie.Belkin (c-67-180-61-129.hsd1.ca.comcast.net. [67.180.61.129])
        by mx.google.com with ESMTPS id ot5sm4361315pbb.29.2012.11.12.07.45.22
        (version=SSLv3 cipher=OTHER);
        Mon, 12 Nov 2012 07:45:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <EA56F0CC-7C93-491F-A076-4A1AA9593ED0@quendi.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209481>

Max Horn wrote:

> Aha, now I understand what this patch is about. So I would suggest
> this alternate commit message:
>
>   remote-testgit: make it explicit clear that we use the 'done' feature
>
>   Previously we relied on passing '--use-done-feature ' to git
>   fast-export, which is easy to miss when looking at this script.

I'm not immediately sure I agree this is even a problem.  Is the point
that other fast-import frontends do not have a --use-done-feature
switch, so a typical remote helper has to do that work itself, and the
sample "testgit" remote helper would be a more helpful example by
doing that work itself?

The idea behind --use-done-feature is that if fast-export exits early
for some reason and its output is going to a pipe then at least the
stream will be malformed, making it easier to catch errors.  So there
is something to be weighed here: is it more important to illustrate
how to make your fast-export tool's output prefix-free, or is it more
important to illustrate how to work around a fast-export tool that
doesn't support that feature?  The answer is not immediately obvious
to me.  A good description could provide context to make it obvious.

Hoping that clarifies,
Jonathan
