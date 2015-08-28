From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 7/9] fetch: fetch submodules in parallel
Date: Fri, 28 Aug 2015 12:02:25 -0700
Message-ID: <CAGZ79kYkJno-VCLbt_L6neMpJqdYRiXtMF7VUjh5OJxTi4Jiqg@mail.gmail.com>
References: <1440724495-708-8-git-send-email-sbeller@google.com>
	<CAGZ79kbTAVDVmw+MrXvky6tJWZcG97tT_KAxV7S-pKCiNqRp3g@mail.gmail.com>
	<20150828170141.GB8165@google.com>
	<xmqqfv332v84.fsf@gitster.mtv.corp.google.com>
	<20150828182008.GC8165@google.com>
	<xmqqpp271d6v.fsf@gitster.mtv.corp.google.com>
	<20150828183501.GA17222@sigill.intra.peff.net>
	<CAGZ79kZALSJ9oY+6ZwyQ9CPFiV-AAq7c-r9mxw3N+gvsDw8m4A@mail.gmail.com>
	<20150828184405.GA17721@sigill.intra.peff.net>
	<20150828185050.GF8165@google.com>
	<20150828185330.GA18041@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:02:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZVOv1-0002QX-L5
	for gcvg-git-2@plane.gmane.org; Fri, 28 Aug 2015 21:02:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752516AbbH1TC1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2015 15:02:27 -0400
Received: from mail-yk0-f176.google.com ([209.85.160.176]:36660 "EHLO
	mail-yk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341AbbH1TC0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2015 15:02:26 -0400
Received: by ykek5 with SMTP id k5so10945253yke.3
        for <git@vger.kernel.org>; Fri, 28 Aug 2015 12:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=YzzPPq9N2pTbnDW1algb4BaOvr0TrlhTgL9KQtYqMdM=;
        b=CWa2BCYOme0x0N44cmjGgn0cprDlJFEdA+qJDsk37W7SpthToD2r/pHo7e0KIT8tq0
         LjtiSq4t35mL9Prjd8S+nVP5zZtLuTMUn1dU2cNFU4H+NddQhzmnSUASziLSuye4F99m
         OzccXKsVS2PtCzpvi1I54E+PdWvbBmBcflBMB4G4xVYw6dHXG7JN4klqtEoRnGYd55eJ
         NQEmG80wSUEfNodlsSx2cLMgz8piJMw8RpCBAp6JsoYbyrJZGQEAGm7xJENGKjNtmO1Z
         FRQeXhHV2/m9WHbmqLXCjlfYE1nQk8nNYrpPPPpl5Ng/BfZGY6VpG/m9rAZbg8F+xV/i
         uV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=YzzPPq9N2pTbnDW1algb4BaOvr0TrlhTgL9KQtYqMdM=;
        b=AoS+nNbTUkENiXhdMzHwW25vZN7WiiJ6lwdrdMqE8lbj/mvzE0wQ2xuHWFZNuHnh2F
         InygUa2OmL70hCCAXOuKT7cnMO27MPdaeDuk1TsBGitpX8ItkL671XVPotr/aTInEGYI
         TvtnPQ3h5zxmSyvGQ3EdZO0UIhdwfBTC/IgDz8Y/qO4GsmGwkESJX6v7o9vbpkmTT0mP
         YG66BJe7Yv4iHoC5/ch6Cr4bbRyx0atpxbhtf61MMSTMXXsKTVlE03ynJZ7U5qZFpv/v
         wtL0LKW/dpLYEuORE2QpUeufltGM+A09UY4U746ukArWIF3SGEKIgyEtRAaSoX7rqzyY
         nFGA==
X-Gm-Message-State: ALoCoQn9gxqoUA8OnicW0DQ2onQ4C8AMKBx4lDrNNwgaPYPWzLvPfwaPszzYbCeSsbugV1pyc15n
X-Received: by 10.170.205.151 with SMTP id w145mr10301978yke.56.1440788545701;
 Fri, 28 Aug 2015 12:02:25 -0700 (PDT)
Received: by 10.37.21.132 with HTTP; Fri, 28 Aug 2015 12:02:25 -0700 (PDT)
In-Reply-To: <20150828185330.GA18041@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276757>

On Fri, Aug 28, 2015 at 11:53 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 28, 2015 at 11:50:50AM -0700, Jonathan Nieder wrote:
>
>> > But what I meant was: the child will only show progress if stderr is a
>> > tty, but here it is not.
>>
>> For clone / fetch, we can pass --progress explicitly.
>>
>> For some reason 'git checkout' doesn't support a --progress option.  I
>> suppose it should. ;-)
>
> Yeah, that will work for those tools, but I thought you could pass
> arbitrary shell commands.  It would be nice if git sub-commands run
> through those just magically worked, even though we don't have an
> opportunity to change their command-line parameters.

Technically speaking this discusses the patch for fetch only and we'd
want to have that discussion at the previous patch. ;)
But as both of them use the same code, the sync feature of run-command,
which is in patch 5/9, we want to have git commands just work anyway.

>
> -Peff
