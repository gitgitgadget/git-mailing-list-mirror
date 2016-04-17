From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] test-lib: add a function to compare an expection
 with stdout from a command
Date: Sun, 17 Apr 2016 02:41:40 -0400
Message-ID: <20160417064140.GA31993@sigill.intra.peff.net>
References: <1460823230-45692-1-git-send-email-rappazzo@gmail.com>
 <1460823230-45692-2-git-send-email-rappazzo@gmail.com>
 <CAPig+cSOuFygsScGn_Nu0_d8mvRik1hQJuanrb-Nvw3ozyt7JQ@mail.gmail.com>
 <20160417035414.GA30002@sigill.intra.peff.net>
 <CAPig+cTOa2yaMikOJHQXpSjY_EtyUXaqVz4KobQwO2xn=Q6h_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Rappazzo <rappazzo@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 08:41:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1argOy-00059K-LW
	for gcvg-git-2@plane.gmane.org; Sun, 17 Apr 2016 08:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbcDQGlo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Apr 2016 02:41:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:50901 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752044AbcDQGln (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2016 02:41:43 -0400
Received: (qmail 25041 invoked by uid 102); 17 Apr 2016 06:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Apr 2016 02:41:43 -0400
Received: (qmail 27154 invoked by uid 107); 17 Apr 2016 06:41:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Apr 2016 02:41:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Apr 2016 02:41:40 -0400
Content-Disposition: inline
In-Reply-To: <CAPig+cTOa2yaMikOJHQXpSjY_EtyUXaqVz4KobQwO2xn=Q6h_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291748>

On Sun, Apr 17, 2016 at 02:36:24AM -0400, Eric Sunshine wrote:

> Agreed. I wouldn't mind the version where test_stdout grabs "expected"
> from <<EOF, but, as you say, it doesn't buy much over the manually
> prepared test_cmp version.
> 
> I suppose that the one-liner form of test_stdout could have its uses,
> however, it bothers me for a couple reasons: (1) it's not generally
> useful like the version which grabs "expected" from <<EOF, (2) it
> squats on a nice concise name which would better suit the <<EOF
> version.

I think you could get around your second objection by making "-" a magic
token, like:

  test_stdout - = git rev-parse ... <<-\EOF
  false
  EOF

Though I admit the combination of "-" and "=" is pretty ugly to read.

I'm OK with abandoning this line of inquiry, too. This may be a case
where a little repetition makes things a lot less magical to a reader,
and it's not worth trying to devise the perfect helper.

> Anyhow, this may all be moot (for now) since I think this patch series
> is going in the wrong direction entirely by abandoning the systematic
> approach taken by the original t1500 code, as explained in my
> review[1]. If modernization of t1500 retains a systematic approach,
> then the repetitive code which prompted the suggestion of test_stdout
> won't exist in the first place.

Fair enough. I haven't really followed the other part of the series very
closely.

-Peff
