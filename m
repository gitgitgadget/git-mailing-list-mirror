From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature Request: Passing a number as an option to git tags for displaying latest tags
Date: Thu, 23 Jul 2015 11:21:39 -0700
Message-ID: <xmqq8ua6pwek.fsf@gitster.dls.corp.google.com>
References: <CALpYpjE1WE=fO0q=rGPHedZwP8JovJ0CxELBd_EhAmncRS6ZYA@mail.gmail.com>
	<xmqqbnf4rohs.fsf@gitster.dls.corp.google.com>
	<xmqq7fpsroc1.fsf@gitster.dls.corp.google.com>
	<55B0B667.6000103@drmicha.warpmail.net>
	<CA+P7+xpasr7gOYiSsdAyCgh6+D8nYQf9vuEhRna8k7HWMu1Rcg@mail.gmail.com>
	<xmqqd1zipxc3.fsf@gitster.dls.corp.google.com>
	<CA+P7+xpy86GMmdtcag4kaxDrB4TrdeQYraabNS0pASdBG+P+OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Halil =?utf-8?B?w5Z6dMO8?= =?utf-8?B?cms=?= 
	<halilozturk55@gmail.com>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 20:21:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIL7r-0004lJ-Jp
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 20:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753393AbbGWSVo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 14:21:44 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34936 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbbGWSVm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 14:21:42 -0400
Received: by pabkd10 with SMTP id kd10so93693pab.2
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 11:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=6jn68ihCzCVO7AdsJsKGVOYR6jlsufccrQMK1yEhLp0=;
        b=szYGDp6QIXGZ+VeHsL3WlhUhZPdBf/v0YhiJ6SzGKBBzB2DyAqV2b4n7EjtdbxYEJi
         brsD62Uefl0I96PsuYOZcUM+uSAqg7zNe5agCQevahSjD1h5wtHD5IlqUKGxt0xS1GST
         3qvcVghsbz04aedROL7g/iJ0li/inh/RE4NFSy7k28nJin8sr/nJIZQ75g6UR+iYSEaX
         x03W7AMAPv/ZRYTV/KjSBqHOe4v4MAif78/HhtJIzrosd3a2Fd9HBnDWVhdenNfx6sPz
         TXDljcCd4oAOzE2683AOO9kvT4DxtiLFxeHalcm2mKEGeP+BWBvmQyvLhBdxOQSdraVq
         F7Cg==
X-Received: by 10.70.91.206 with SMTP id cg14mr20987031pdb.83.1437675702112;
        Thu, 23 Jul 2015 11:21:42 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:156f:a37c:e915:d6df])
        by smtp.gmail.com with ESMTPSA id j4sm10210063pdg.64.2015.07.23.11.21.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 23 Jul 2015 11:21:41 -0700 (PDT)
In-Reply-To: <CA+P7+xpy86GMmdtcag4kaxDrB4TrdeQYraabNS0pASdBG+P+OQ@mail.gmail.com>
	(Jacob Keller's message of "Thu, 23 Jul 2015 11:12:54 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274519>

Jacob Keller <jacob.keller@gmail.com> writes:

> On Thu, Jul 23, 2015 at 11:01 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jacob Keller <jacob.keller@gmail.com> writes:
>>
>>> Yep, that's pretty much how a build system I've had to use does it.
>>> Sadly, this is quite slow, and I'm not sure if doing it built into the
>>> tag via for-each-ref would be faster?
>>
>> Is the description in "git for-each-ref --help" somehow unreadable?
>> ...
>> If you only need the name of the ref, you can use a lot simpler
>> format string, e.g.
>>
>>     git for-each-ref --count=3 --sort='-*authordate' \
>>       --format='%(refname:short)' refs/tags
>>
>>     git for-each-ref --count=3 --sort='-taggerdate' \
>>       --format='%(refname:short)' refs/tags
>>
>
> That's significantly better than what this system does, but sadly the
> team that owns it doesn't exactly understand git. Pretty sure they
> tend to just use whatever scriptlet they got working, which happens to
> be based on log...  I've tried to help them, but generally hasn't been
> a successful relationship there.

If your build people refuse to switch from an unreliable way of
parsing "log" output that is not meant for machine consumption, then
it wouldn't make any difference what the answer to your "I'm not
sure if doing it built into ... be faster?" X-<.

By the way, I was referring to that question, pointing out that you
do not have be wondering.  It is already there, and as I said a few
messages ago already in this thread, the cross-pollination among
"for-each-ref", "branch -l" and "tag -l" is happening as part of
this year's GSoC program.
