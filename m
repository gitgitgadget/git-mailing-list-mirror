From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Thu, 19 Feb 2015 12:20:02 +0100
Message-ID: <54E5C6E2.9040101@drmicha.warpmail.net>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>	<20150218170007.784be6aa@pc09.procura.nl>	<54E4CFDC.40401@drmicha.warpmail.net>	<20150218182547.GA6346@peff.net>	<xmqqpp972h1n.fsf@gitster.dls.corp.google.com>	<20150218185734.GB7257@peff.net>	<54E5BBDD.7040100@drmicha.warpmail.net> <20150219121438.59050ce8@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: "H.Merijn Brand" <h.m.brand@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:20:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOP9h-0005pX-SQ
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 12:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752767AbbBSLUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 06:20:06 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:58371 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752358AbbBSLUE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 06:20:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 1655420BFB
	for <git@vger.kernel.org>; Thu, 19 Feb 2015 06:20:04 -0500 (EST)
Received: from frontend2 ([10.202.2.161])
  by compute2.internal (MEProxy); Thu, 19 Feb 2015 06:20:04 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=nvAiGlMsgiaudspvwyusg+
	JhGik=; b=c7llsUy8bl+3iPyukXPQBnBcSetBEa0dRloE3DWX+o72oTSJ1rvgWA
	/JZgjz1xI7pgoM7EuwzqTt/Pax7RO1dd9Ib36pf9QqPITNzd8jsv6sq9vTayb6ul
	sEdsPlGh8Pjes7i+LdPxTjGUU83ayDm1rjZAZJ32zuji5D7o4kIQ4=
X-Sasl-enc: GZCj8mDIjCKh/smHmd7D8mWdq8b96TDwaSCp455VKdnU 1424344803
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 5E6C66801BC;
	Thu, 19 Feb 2015 06:20:03 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150219121438.59050ce8@pc09.procura.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264093>

H.Merijn Brand venit, vidit, dixit 19.02.2015 12:14:
> On Thu, 19 Feb 2015 11:33:01 +0100, Michael J Gruber
> <git@drmicha.warpmail.net> wrote:
> 
>> Jeff King venit, vidit, dixit 18.02.2015 19:57:
>>> On Wed, Feb 18, 2015 at 10:47:16AM -0800, Junio C Hamano wrote:
>>>
>>>>> It seems like we could use
>>>>>
>>>>>   (cd src && tar cf - .) | (cd dst && tar xf -)
>>>>>
>>>>> here as a more portable alternative. I don't think we can rely on rsync
>>>>> being everywhere.
>>>>
>>>> Thanks; I wasn't even aware that we used rsync in our tests.  We
>>>> certainly do not want to rely on it.
>>>
>>> I don't think we do.
>>>
>>> Grepping for rsync in t/, it is mentioned in three places:
>>>
>>>   1. In t1509, we use it, but that test script does not run unless you
>>>      set a bunch of environment variables to enable it.
>>>
>>>   2. In a sample patch for t4100. Obviously this one doesn't execute. :)
>>>
>>>   3. In t5500, to test "rsync:" protocol supported. This is behind a
>>>      check that we can run rsync at all (though it does not properly use
>>>      prereqs or use the normal "skip" procedure).
>>>
>>>> Why not "cp -r src dst", though?
>>>
>>> I was assuming that the "-P" in the original had some purpose. My "cp
>>> -r" does not seem to dereference symlinks, but maybe there is something
>>> I am missing.
>>>
>>> -Peff
>>
>> There's a symlink in sub that needs to be preserved.
>>
>> I'm cooking up a mini-series covering tar/cp -P so far and hopefully the
>> JP encodings later. Do I understand correctly that for Merijin's use
> 
> Merijn, no second j. You can also call me Tux, as that is what the perl
> people do just because of that :)
> 
>> case on HP-UX, we want
>>
>> - as few extra tools (GNU...) as possible for the run time git
>> - may get a few more tools installed to run the test
> 
> You can require as many GNU tools for testing as you like: I'll install
> them. I just need to be sure they are not required runtime. (tar, cp)
> 
>> I still don't have a clear picture of the iconv situation: Does your
>> iconv library require OLD_ICONV to compile?
> 
> No
> 
>> Is there a reason you want to disable it?
> 
> Yes, if I build a package/depot, and the package depends on iconv, it
> is highly likely to fail on the client side after installation, as I do
> not control the version of iconv/libiconv installed.
> 
> As HP does not have libiconv installed by default, I have experienced
> many tools to be unusable after installation because of that dependency.
> 
> Another reason is that I built 64bitall, as my CURl and SSL environment
> is 64bitall for every other project on these systems (including Oracle
> related, which *only* ships 64bit objects on HP-UX) and the OpenSource
> repos for HP-UX only ship 32bit software (sad, but true). That implies
> that I cannot require libiconv.so to be present on the client side.
> 
> I'd like my git to be as standalone as possible

OK, so we should use NO_ICONV on HP_UX then.

>> Failing so many tests with NO_ICONV is certainly not ideal, but I'm not
>> sure we should care to protect so many tests with a prerequisite.
> 
> How feasible is it to isolate those tests into separate test files that
> people that know to not use e.g. Asian can safely ignore them?
> 
>> Michael

We have the prerequisite mechanism for that, and most probably, the
tests are "isolated" already, in the sense that with NO_ICONV, only
trivial setup tests succeed for those test files but all "proper" tests
fail. But I'll check. Need a good test to set the prerequisite, though.

Michael
