From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v4 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Tue, 22 Apr 2014 00:08:17 +0200
Message-ID: <535596D1.6070709@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de> <5349BC2C.9030509@gmail.com> <5349C314.50500@gmail.com> <53511617.80506@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 00:08:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcMNt-0000PA-DM
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754711AbaDUWIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:08:13 -0400
Received: from mail-ee0-f52.google.com ([74.125.83.52]:47925 "EHLO
	mail-ee0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896AbaDUWIL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:08:11 -0400
Received: by mail-ee0-f52.google.com with SMTP id e49so3972871eek.11
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 15:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=e/OPQ7yyKa0v+BsDBuru3Z+u18nhFIeAdMfLLgl8Nsc=;
        b=oj+GxUNh963gVJvkuVDq5YrKRWf2hQxr660vSVioEr7LQ8wFVOy0odDTUrbjt832xN
         8hK3gY8Vs7Du2/IArx3nJjjrRPjFf9Thh8dZv4c03RufRPVfkcTjbjSm/bdhMJKHGeJZ
         6fQnfTLFk5n8t9LFBbQNt7pGa3GYB7LRaAfFI8fOCiE4DqO9gzIw0iiZXfam9hEd/Qow
         rjFtr4JVWBuPYknRE+/Il+guXpMBdeSkA3R80yx+CjXqa64GBphToqXaMDje698tQtsY
         QrGWtSHUSSxKerx533oVxwgNpDHtIM4tZ1m2JhfxlkJKh2NajrLkYqRl0p/JPtom4eS5
         CgfQ==
X-Received: by 10.14.180.2 with SMTP id i2mr50893958eem.53.1398118090356;
        Mon, 21 Apr 2014 15:08:10 -0700 (PDT)
Received: from [10.0.1.226] ([212.144.56.68])
        by mx.google.com with ESMTPSA id t44sm107169032eeo.6.2014.04.21.15.08.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 21 Apr 2014 15:08:09 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53511617.80506@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246655>

On 18. 4. 2014 14:09, Jens Lehmann wrote:
> Am 13.04.2014 00:49, schrieb Ronald Weiss:
>> Allow ignoring submodules (or not) by command line switch, like diff
>> and status do.
>>
>> Git commit honors the 'ignore' setting from .gitmodules or .git/config,
>> but didn't allow to override it from command line.
>>
>> This patch depends on Jens Lehmann's patch "commit -m: commit staged
>> submodules regardless of ignore config". Without it,
>> "commit -m --ignore-submodules" would not work and tests introduced
>> here would fail.
> 
> Apart from the flags of the test (see below) I get three failures when
> running t7513. And I'm wondering why you are using "test_might_fail"
> there, shouldn't we know exactly if a commit should succeed or not
> and test exactly for that?

I used "test_might_fail" instead of "test_must_fail" to denote that this
test doesn't care whether "git commit" fails or not due to empty commit
message. I found it more appropriate. However, if you disagree, I can
change it to "test_must_fail", no problem for me.

Unfortunately I don't know why the test fails for you, they pass for me.
Did you apply it on top of your own patch for "commit -m", which is
a prerequisite?

I tried it again, on top of current master (cc29195 [tag: v2.0.0-rc0]).
First, I have applied your patch from here:

http://article.gmane.org/gmane.comp.version-control.git/245783

On top of that, I applied my two patches, and the tests pass fine here.
Until now I was testing on Windows, but now I tested on a Linux box,
and that makes no difference.
