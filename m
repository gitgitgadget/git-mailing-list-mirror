From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2 4/4] remote: use remote_is_configured() for add and
 rename
Date: Tue, 16 Feb 2016 01:16:09 +0100
Message-ID: <20160216001609.GB1831@hank>
References: <1455575984-24348-1-git-send-email-t.gummerer@gmail.com>
 <1455575984-24348-5-git-send-email-t.gummerer@gmail.com>
 <CAPig+cTH+S67_T=O58E_x--ZhawQEZKjCmK8G+unzm_8f2w8eA@mail.gmail.com>
 <20160215230920.GC30631@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 16 01:15:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVTJ0-0004U4-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 01:15:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753127AbcBPAPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 19:15:47 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32995 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbcBPAPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 19:15:46 -0500
Received: by mail-wm0-f67.google.com with SMTP id c200so18209832wme.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 16:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=tpP18qTxIbuNB5GkkBNh5RpwieNMKMi6FISoME7M3UA=;
        b=dsogDWRsr5UxwEiMNlrkX0o0olbnCABTNkQI44GauYvnmhxZioRLughmd4toH6LOvr
         XDWEN0K1h88EPCkcowE/WiDr4tiDSi/IW2wPTMDfIyJ5lfGvhngBPD5NgHAfeu8WMbjs
         r1w44+hPweZCKkr2oQqy+GHwlaJdGoMhObw2kU7bHXplSx25cofR+BGdsYafuhaJQ83X
         UZKydl55yjRBnP0Cu3X5rgnQtgSD4kAzX8mjLuvA9cEIbGMMgwKq6hmbmmP8hsekAASc
         MNRCGRSco2NOPNiMmM6YoZVjgSOWBqJELzJatuD01FIZ3QzxlmASQakrNDULEerDZa38
         zjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=tpP18qTxIbuNB5GkkBNh5RpwieNMKMi6FISoME7M3UA=;
        b=foDsxWLsciDpYNoBNq/OKr9Dovbw+KC8aSfPBMJNcnucLmTWcqdBEPOqZ47xmRPDZV
         5VmFMqAdQr521Y9nTwX09ZRnsOg/ViypsqNlrbyl2wun69V3nBPOrltnKhww3aQzT5IU
         xILi8OfTbmNpMmq6YJ1m7Dc/eyJOF5N4kxVPvedcPCYY6e9CNS1b87vbOga8JKtATUFz
         AT2GffofTN7UHSolEn3CbIZSPLi5UpeeIwCGDWLLVVMTIRuX3BLLUas8GwhTJroVch9j
         9o3eU4n2YdV8Yfb9VO0AjGK/eb0oFY/RGs42FQzApq6E2Lp4Www/DePUNcM5xnDTZXYW
         3VFQ==
X-Gm-Message-State: AG10YOR4kjwMxGllH8P2BzGpert5T7Pe8La6kno4cweZz4Q88Aj4hgqwEQ7ZCxuXpNH1rQ==
X-Received: by 10.28.60.11 with SMTP id j11mr10311075wma.99.1455581745191;
        Mon, 15 Feb 2016 16:15:45 -0800 (PST)
Received: from localhost (host186-106-dynamic.41-79-r.retail.telecomitalia.it. [79.41.106.186])
        by smtp.gmail.com with ESMTPSA id i5sm7472874wjx.15.2016.02.15.16.15.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 16:15:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160215230920.GC30631@sigill.intra.peff.net>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286295>

On 02/15, Jeff King wrote:
> On Mon, Feb 15, 2016 at 05:52:14PM -0500, Eric Sunshine wrote:
>
> > > diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
> > > @@ -157,6 +157,24 @@ test_expect_success 'rename errors out early when deleting non-existent branch'
> > > +test_expect_success 'add existing foreign_vcs remote' '
> > > +       git config --add remote.foo.vcs "bar" &&
> > > +       git config --add remote.bar.vcs "bar" &&
> > > +       test_when_finished git remote rm foo &&
> > > +       test_when_finished git remote rm bar &&
> >
> > Nit: If the second git-config fails, then none of the cleanup will
> > happen. You'd either want to re-order them like this:
> >
> >     git config --add remote.foo.vcs "bar" &&
> >     test_when_finished git remote rm foo &&
> >     git config --add remote.bar.vcs "bar" &&
> >     test_when_finished git remote rm bar &&
>
> Good catch. Do we actually care about "--add" here at all? We do not
> expect these remotes to have any existing config, I think. So would:
>
>   test_config remote.foo.vcs bar &&
>   test_config remote.bar.vcs bar
>
> do? I guess technically the failing "git remote rename" could introduce
> extra config that is not cleaned up by those invocations, and we need to
> "git remote rm" to get a clean slate, but I don't think that is the case
> now (and it does not seem likely to become so in the future).

Good point, I think the test_config is indeed enough.  Thanks, both,
will fix in the re-roll.

> -Peff

--
Thomas
