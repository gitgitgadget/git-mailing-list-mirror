From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: git name-rev not accepting abbreviated SHA with --stdin
Date: Sat, 04 Jul 2015 06:56:54 +0530
Message-ID: <5597365E.7070508@gmail.com>
References: <558A2405.2090709@gmail.com>	<xmqqsi9g8x51.fsf@gitster.dls.corp.google.com>	<558B60E4.9020604@gmail.com> <xmqqbnft5eja.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 04 03:27:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZBCEW-0002Dy-2N
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jul 2015 03:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755031AbbGDB1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 21:27:03 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35468 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754688AbbGDB1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 21:27:00 -0400
Received: by pactm7 with SMTP id tm7so63906718pac.2
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=U5PdEu5h5l3sq0bQY15rlPS5s5s8Ep3QOVgOFX5HMiM=;
        b=cEBU3I8ftpOY1w+zYhq0YgwAmT02rQYiib2/HzQr/cUxXJrltUIyRYgvucss73p0Qe
         fpst6Sg997UhcBL4IrbQtSJlmX+L8qV8zWtIeRmfTSOrvuo9A6I3AVutjjNoF4Mc0Yjl
         QBgoUknutqRW9gGesDXSWh4zykcj99gml8CZRcwqm2nDxIOpwm1MwkslCNRHAyZ2fDk4
         463OXrmazQhyAGVoeA6tGpcjRNT5I0aPNUPOseAZ8lo7jq+YvKTLM5rmJypjDp+XlGko
         YT1Cd5FxRAY1KzDgDNs+DE789Uq9jplVUBKcEG2ZxJz0kmgsF3HNq2LKa0hVP8hgtczx
         OILQ==
X-Received: by 10.68.136.42 with SMTP id px10mr83124150pbb.19.1435973220173;
        Fri, 03 Jul 2015 18:27:00 -0700 (PDT)
Received: from sita-lt.atc.tcs.com ([117.216.213.68])
        by mx.google.com with ESMTPSA id nz2sm10338589pbb.40.2015.07.03.18.26.57
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jul 2015 18:26:58 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqbnft5eja.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273341>

On 07/03/2015 11:06 PM, Junio C Hamano wrote:
> Sitaram Chamarty <sitaramc@gmail.com> writes:
> 
>> On 06/25/2015 05:41 AM, Junio C Hamano wrote:
>>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>>
>>>> This *is* documented, but I'm curious why this distinction is made.
>>>
>>> I think it is from mere laziness, and also in a smaller degree
>>> coming from an expectation that --stdin would be fed by another
>>> script like rev-list where feeding full 40-hex is less work than
>>> feeding unique abbreviated prefix.
>>
>> Makes sense; thanks.  Maybe if I feel really adventurous I will,
>> one day, look at the code :-)
> 
> Sorry, but I suspect this is not 100% laziness; it is meant to read
> text that has object names sprinkled in and output text with object
> names substituted.  I suspect that this was done to prevent a short
> string that may look like an object name like deadbabe from getting
> converted into an unrelated commit object name.

As a perl programmer, laziness is much more palatable to me as a reason
;-)

Jokes apart, I'm not sure the chances of *both* those things happening
-- an accidental hash-like string in the text *and* it matching an
existing hash -- are high enough to bother.  If it can be done without
too much code, it probably should.
