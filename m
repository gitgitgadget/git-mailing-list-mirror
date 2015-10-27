From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Tue, 27 Oct 2015 16:39:37 -0700
Message-ID: <CAGZ79karRbOTSEfFHRU6MG21T1L5GyuZW2ATqfdP4NE7wHMmHQ@mail.gmail.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
	<082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
	<20151026191724.GE7881@google.com>
	<alpine.DEB.1.00.1510271036100.31610@s15462909.onlinehome-server.info>
	<xmqqr3kge0d3.fsf@gitster.mtv.corp.google.com>
	<20151027232848.GA4172@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:39:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrDqA-0002gh-SE
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:39:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752101AbbJ0Xji (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:39:38 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:33505 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbJ0Xji (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:39:38 -0400
Received: by ykft191 with SMTP id t191so53639622ykf.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 16:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Ce/ogu+Uy7ZPcZVLqc4ZUBqqsvwpH6FsP0wYvseCWsA=;
        b=kC5yQcGmabX/C2dZ29IVLkn+GJtKGqNrylqQfqjsMrvbcLqUnB4C8u8cpiFXJyPyRM
         7pEJ0AApmuhNmIAW6kPXlmA6ar34AUl3zAW7fr+W7QQSmvqJpH7V0FojgEDsAWXH3kXi
         hXQtIls3gCs3+Hz6oPXgZyiNFXWBcBO1/Y8r+4Pt/GLlr2VDU1pKVZGQCtZllbYOPKlG
         0MlQz0POkkofEy2RNX+U4/I4Jcwc1JYtRGeyBMQEZB8yBVOToN0Ip6fQkWkYDtNahKnP
         SMtVfBrXZLco0ziUoeSHuxJmOj4Vp9rsKXHj72aEHRDm5Fb47FQL9dbF6GV7rzGlqVtY
         L0nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=Ce/ogu+Uy7ZPcZVLqc4ZUBqqsvwpH6FsP0wYvseCWsA=;
        b=KlFq3HscQTeizJnLq/IMUVXHCBUM3mA9n5xVXWcJyBTD6NUxAuehxc3FoV+NXYr5i7
         eb4XLW0aolbZ0V2ZS2J+9WPATeFiPjPARwjNJXiRFl2SI3PoohH1ToIz6fJdJjXg54Wp
         3onM/1DVuRThMWqWAN4buZzFkD3RzPlz2H0laYIGlYT+sBj65nNB2ERwEIK+LpDkf1Oc
         tY1m9FDuPHnGK+QLMXfAx1shqZa0vHC5Dvh5TXFzcY0HNhkAbUKocTpjVKl5r1FxL1g/
         oWzGWyQhqbLxBA6XjsGFQLeZBDT937bjHDMpoarmgyh3B/eAc4rJuf1oLcHppuYrLjkC
         JP6Q==
X-Gm-Message-State: ALoCoQmCkicozhzIVxxCLJMJUX79Qrp00sjlmXc8hUaTv0GS9Hwh491TEhhL+E1/Wc1V+2yYG0dF
X-Received: by 10.129.40.18 with SMTP id o18mr31880424ywo.199.1445989177441;
 Tue, 27 Oct 2015 16:39:37 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Tue, 27 Oct 2015 16:39:37 -0700 (PDT)
In-Reply-To: <20151027232848.GA4172@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280317>

On Tue, Oct 27, 2015 at 4:28 PM, Jeff King <peff@peff.net> wrote:
> I agree doing so would be crazy. But would:
>
>   ./t1234-frotz.sh --gdb=17
>
> be sane to run gdb only inside test 17?

OT:
We have two ways of addressing tests, by number and by name.
Usually when a test fails ("Foo gobbles the bar correctly" failed),
I want to run tests 1,17 (1 is the correct setup and 17 is the failing test)
But coming up with that tuple is hard.
  * How do I know we need to run 1 as the setup ? (usually we do,
    sometimes we don't and other times we also need 2,3 to completely
setup the tests)
  * How do I know it's test 17 which is failing? My workflow up to now
    I just searched the test title in the file, such that I'd be there anyway
    to inspect it further. But still I found it inconvenient to
mentally map between
    17 and the test title.

Stefan
