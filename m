From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Tue, 3 Jun 2014 08:23:02 +0200
Message-ID: <20140603062301.GA22149@spirit>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
 <20140529161628.GB3763@sigill.intra.peff.net>
 <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
 <20140529194932.GA16665@sigill.intra.peff.net>
 <CACJZPBs2_htD=zS1K3fOW+DZ323+2+iwupWuyNDArg2XF6Qx5g@mail.gmail.com>
 <CACJZPBtJZ+gDvtHnRwi8JOO7rFAg=pPBvEQ=-FwKnp9Gr+FStw@mail.gmail.com>
 <20140603034619.GA18176@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rodrigo Fernandes <rtfrodrigo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 03 08:23:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wri7u-0006Kk-NT
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 08:23:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753439AbaFCGXK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 02:23:10 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:46654 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaFCGXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 02:23:09 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so5816555wiv.7
        for <git@vger.kernel.org>; Mon, 02 Jun 2014 23:23:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=fEQvtWU9aMAoOuRtMcraj9SRxHwJf32LqcMuLNVo21k=;
        b=D6dIsohFpruKEPc6/T1JPbmfqA7EkaQry3fbufklLTBhI6p3fBUD0lmsREuJQ+TXRR
         lshghwXwgvpDxqTZTdyIXT7Fp/tPQwaZP2/fiWkZk1aCmTt9DIYFKoS0dGTSgYN2WHDd
         oX90qaE5xdx7M+u/eRKV21YVyN/H9tz/StYW8OkGHAn7o1neGRjfl7xI79ZvosOTPpHZ
         +mZKQjJ7ywqEjK0ZGue+nHnsaLUxYYkV11YH4lvKefNfIqZ3c2B4NLK5yWyByv1324zb
         lX//gl3Ypvx0E4X8faJBEBWlWQGxgTSgOZu9ebcyehB5atVqRPDwwLAPl1QPopJM4oCB
         l76g==
X-Gm-Message-State: ALoCoQlCuZIW8mAsEVAYYScvAYT6Ots5+5RyGOMZQlYrLts+pmZfAj9bH4b8fSJFYPm4ed7M1iD/
X-Received: by 10.180.99.166 with SMTP id er6mr29601996wib.48.1401776586927;
        Mon, 02 Jun 2014 23:23:06 -0700 (PDT)
Received: from spirit (195-240-45-142.ip.telfort.nl. [195.240.45.142])
        by mx.google.com with ESMTPSA id gu2sm17446076wib.14.2014.06.02.23.23.05
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 02 Jun 2014 23:23:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140603034619.GA18176@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250613>

On Mon, Jun 02, 2014 at 11:46:19PM -0400, Jeff King wrote:
> On Fri, May 30, 2014 at 09:08:57AM +0100, Rodrigo Fernandes wrote:
> 
> > Do you have any idea how does github understand that is a bug and
> > fixes it automatically?
> > (I'm saying this because on Github the date is correct).
> 
> I looked into this. The dates you see on GitHub's web UI are actually
> parsed by Rugged/libgit2. The libgit2 parser is slightly more forgiving
> in this instance; if it sees a broken timezone, it will leave the
> timestamp intact, and only omit the timezone. Whereas git says "no, it's
> broken, and the timestamp cannot be trusted".
> 
> I think both are equally valid strategies, and I do not even think it is
> a problem that they diverge between the two implementations. I'd be OK
> with a patch to make git handle errors in each independently, assuming
> it is not too invasive.

I think what libgit2 does is more wrong than what git does. It displays
the timestamp subtly wrong (off by 7 hours) instead of making it
completely clear that the timestamp is bogus.

-- 
Dennis Kaarsemaker <dennis@kaarsemaker.net>
http://twitter.com/seveas
