From: Stefan Zager <szager@chromium.org>
Subject: Re: [PATCH] Enable index-pack threading in msysgit.
Date: Thu, 20 Mar 2014 14:56:03 -0700
Message-ID: <CAHOQ7J-sUt3HGYNE7n=X3ZmV3Q-n+n9hMDAtzLbH3YU8iAqoqA@mail.gmail.com>
References: <5328e903.joAd1dfenJmScBNr%szager@chromium.org>
	<532AF304.7040301@gmail.com>
	<CAHOQ7J9drXwcTt4b0Tcyw97KTGcifwsO5rtFNQYf7CVr3WD7zQ@mail.gmail.com>
	<532B5F0D.2070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Stefan Zager <szager@chromium.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 22:56:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQkwf-0000ZS-F4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 22:56:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759397AbaCTV4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 17:56:06 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:41025 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757263AbaCTV4F convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Mar 2014 17:56:05 -0400
Received: by mail-oa0-f52.google.com with SMTP id l6so1639040oag.25
        for <git@vger.kernel.org>; Thu, 20 Mar 2014 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZIWdujYwJrSam67OsYbhDRfIk+pVDPDpOekv0Mxs/8A=;
        b=Bfse3TXnIi1oavxxn1vMw9PxP0HF9lCO6BvhBW5Tqnw62vblode03CWMcInMCpnTEN
         3V0XItQvvl7q8cleaxII045VHtBLY2bzoowx8FBc7qdfn4Zg+NkeYtcXAggN6M4WfKQl
         YwHaRwv72fvmMZitF8iwHTolpx9CLKscQI+IPNik2Gt61ddW6nSNl4GcctlCwzvIo07V
         3BgSK2huEL3szzD62E/XCIrlcWyNXmKRdinA2+cMYULmfprEHMpSP3BCwUlNWrK238H7
         y0pgr9UMbQrP7YYTk5l3nvRGSGI6OJ/Wd1rckPE3llWzhGBlos/BCionYoKNNmVncPVw
         wdtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZIWdujYwJrSam67OsYbhDRfIk+pVDPDpOekv0Mxs/8A=;
        b=HEhk7PdR3jRX8Zqta8+totGQYf2MSiRwKx727rUD1jHQoOui732orsz3uWaj1cr5N+
         LoGk4FZCTbRnlvhpgDc3rmI5PzeeakN/mdJ2t07IKjHAWOtOHDqk22JosLUKQNsIpC62
         fsKKNMcam1kbroG/SY9kuwlitpNDJzjk9jf0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZIWdujYwJrSam67OsYbhDRfIk+pVDPDpOekv0Mxs/8A=;
        b=aQSV45241+dbmWbOj1CHCxbYbbyO+JXbpjPmzDQQr9XBctXJ8zUqyO4TvkBH/Q75rF
         1hcThipGlii2Tw+KrIUF9CZQ2GYKd4XMDSa+cYVgETF2b8RkXWwafNqXUM0kwpZvPV/6
         JQnM7WG+qTSWd1ZjodheMqDpuQWsDczcoMpkcPx8tHKOvv/7RgaE4V1W3WKJLcRWDzai
         WFlULIbcHiYeLOjDSGraw7HYRO3V1GXGrVmbH8/sXLqqLj/MAwyYOv6/56hqbD6dQd2j
         n7FlqyWmEFbiXdqXEaR72IRGvTmHNa//l78lBpy0adE/59deN1Ph5SJjKOtGYqrBFJMP
         Pwbg==
X-Gm-Message-State: ALoCoQlhfmGhqIS7UGgH6hgAB2VUHB0qRMQsVeRMu1mbb5iV8CH1TdoqqpZhkIK1aenz8pecb9YJlf3FOREtGB0Qtft/KUYZ3hAeRF6pQcLLspqDfj4WuqxLByhOtTzuvZ5JVFVafkXN7qkAumsr+VtVM845nrgnRjsHScIMq69z+OEccq6FFNhASsa4xahxRulvUOfK5e/7
X-Received: by 10.60.15.131 with SMTP id x3mr40206887oec.15.1395352563882;
 Thu, 20 Mar 2014 14:56:03 -0700 (PDT)
Received: by 10.182.233.201 with HTTP; Thu, 20 Mar 2014 14:56:03 -0700 (PDT)
In-Reply-To: <532B5F0D.2070300@gmail.com>
X-Google-Sender-Auth: VaoUdZpGr15O1Dud7pQ6dXRt9hs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244589>

On Thu, Mar 20, 2014 at 2:35 PM, Karsten Blees <karsten.blees@gmail.com> wrote:
> Am 20.03.2014 17:08, schrieb Stefan Zager:
>
>> Going forward, there is still a lot of performance that gets left on
>> the table when you rule out threaded file access.  There are not so
>> many calls to read, mmap, and pread in the code; it should be possible
>> to rationalize them and make them thread-safe -- at least, thread-safe
>> for posix-compliant systems and msysgit, which covers the great
>> majority of git users, I would hope.
>>
>
> IMO a "mostly" XSI compliant pread (or even the git_pread() emulation) is still better than forbidding the use of read() entirely. Switching from read to pread everywhere requires that all callers have to keep track of the file position, which means a _lot_ of code changes (read/xread/strbuf_read is used in ~70 places throughout git). And how do you plan to deal with platforms that don't have a thread-safe pread (HP, Cygwin)?
>
> Considering all that, Duy's solution of opening separate file descriptors per thread seems to be the best pattern for future multi-threaded work.

Does that mean you would endorse the (N threads) * (M pack files)
approach to threading checkout and status?  That seems kind of
crazy-town to me.  Not to mention that pack windows are not shared, so
this approach to multi-threading can have the side-effect of blowing
out memory consumption.  We have already had to dial back settings for
pack.threads and core.deltaBaseCacheLimit, because threaded index-pack
was causing OOM errors on 32-bit platforms.

Cygwin (and MSVC) should be able to share a "mostly" compliant pread
implementation.  I don't have any insight into NonstopKernel; does is
really not have a thread-safe pread implementation?  If so, then I
suppose we have to #ifdef NO_PREAD, just as we do now.

I realize that these are deep changes.  However, the performance of
msysgit on the chromium repositories is pretty awful, enough so to
motivate this work.

Stefan
