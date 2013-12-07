From: Muzaffer Tolga Ozses <tolga@ozses.net>
Subject: Re: Git reports
Date: Sat, 7 Dec 2013 21:46:16 +0200
Message-ID: <CAMAQ3nK3CMvhh2=wYqCedd_9fS9k9yGWdmN8NzRfQft585zigQ@mail.gmail.com>
References: <CAMAQ3n+OtBdYALh4pg6kywtbgPtQjHr6Xc-2ff63df-h=TLwbA@mail.gmail.com>
	<20131206210035.17413ee7bcdf3ca0c9655d81@domain007.com>
	<20131206210958.59f553060e3802d56f4a53b8@domain007.com>
	<CAMAQ3nKVjF-5oW2pZZaD9MSz9wqoXJBQDoGcdy5mb=gxCguuSA@mail.gmail.com>
	<20131206215334.1a9031a1450d9c436943ce3d@domain007.com>
	<CAMAQ3nLgnpDo1jWFL1rqtEvmQm8LeEpZ41Uxo0GTQOk8ttpSZA@mail.gmail.com>
	<20131206192651.GK29959@google.com>
	<20131206222201.GF25620@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Konstantin Khomoutov <flatworm@users.sourceforge.net>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Dec 07 20:46:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpNpY-0002K9-Ij
	for gcvg-git-2@plane.gmane.org; Sat, 07 Dec 2013 20:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755749Ab3LGTqU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Dec 2013 14:46:20 -0500
Received: from mail-wi0-f171.google.com ([209.85.212.171]:62556 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754307Ab3LGTqT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Dec 2013 14:46:19 -0500
Received: by mail-wi0-f171.google.com with SMTP id bz8so2120755wib.16
        for <git@vger.kernel.org>; Sat, 07 Dec 2013 11:46:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=THBMp+3RwERp7TzsuUV3Eo4VttGverIUkgteqLX0m+w=;
        b=O5cg8ICNPxtElrzIJ9kMAGSay7r4pLNR3+BP7scKeD95CEiASMIFsq1tb7pEtkRT8Z
         rnB+PumzfpIqMF6ca8Umj3nt3+Jl0xXFBkDcuj34x7+7LJ7Bu9gui1vL5sDYdn+SFmnE
         MskkY1cjkTRDy7i1ueJh/dBwvBDNr2HFVVjxF2yjUzNZpifZ+IMgLeHO2iJFgKb56Z2Q
         zhJ37d/QSwSurHCF3K3ECfin1rHmXtexNVz0qtDH/oMnKvBgSJR3ZCrbRcWEWnwFz4Hd
         2iorKDGIw9suDKZ24hPRUEo32ZswUWX4b7TNfqzTlyVrLinpUH7uUpFa9KgrN2pcuXqq
         9d6g==
X-Gm-Message-State: ALoCoQmnn6RTaZIpEVEf8thLFU6YqzcBcuugZKJhwncf3kw0Lf7eW2cY4DxT2/rHOK+OHGUtGwJQ
X-Received: by 10.180.97.228 with SMTP id ed4mr3769126wib.15.1386445576502;
 Sat, 07 Dec 2013 11:46:16 -0800 (PST)
Received: by 10.216.174.70 with HTTP; Sat, 7 Dec 2013 11:46:16 -0800 (PST)
X-Originating-IP: [46.196.57.29]
In-Reply-To: <20131206222201.GF25620@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239016>

I looked at man git-http-backend, and I didn't understand a thing.
I'll look at it tomorrow again with a clear head.

On 7 December 2013 00:22, Jeff King <peff@peff.net> wrote:
> On Fri, Dec 06, 2013 at 11:26:51AM -0800, Jonathan Nieder wrote:
>
>> > I am cloning over http
>>
>> I am guessing you are using the "dumb" (plain static file transfer)
>> HTTP protocol.  With that protocol the server doesn't do anything
>> other than shuttle out files, so it doesn't need to do its own
>> progress reporting.
>
> Yeah, that would also explain why GIT_TRACE_PACKET produced no output.
>
>> Perhaps the client should do some progress reporting based on file
>> sizes and amount downloaded so far, but it's hard to get excited
>> about given the existence of "smart" (transfer only what is needed)
>> HTTP protocol.  See git-http-backend(1) for details.
>
> You get some very verbose and nasty progress with "-vv". It would be
> nice to have a regular throughput meter for dumb-http, though. I haven't
> bothered adding one so far because I don't expect many people are using
> http. However, if we start supporting fetching via bundles over http,
> then it will be very nice to have some kind of progress display there
> (since the main use is to get gigantic full clones).
>
> -Peff
