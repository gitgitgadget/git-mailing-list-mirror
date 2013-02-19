From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: inotify to minimize stat() calls
Date: Tue, 19 Feb 2013 15:25:29 +0100
Message-ID: <51238B59.1050106@dcon.de>
References: <CALkWK0=EP0Lv1F_BArub7SpL9rgFhmPtpMOCgwFqfJmVE=oa=A@mail.gmail.com> <7vehgqzc2p.fsf@alter.siamese.dyndns.org> <7va9rezaoy.fsf@alter.siamese.dyndns.org> <7vsj56w5y9.fsf@alter.siamese.dyndns.org> <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com> <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com> <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com> <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com> <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com> <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com> <20130210111732.GA24377@lanh> <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com> <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com> <511AAA92.4030508@gmail.com> <C
 ALkWK0=XFBfZjO3oCJ8Jxya1ud79MQcQFm6pmZpOU8c3MxVtqQ@mail.gmail.com>
Reply-To: blees@dcon.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Duy Nguyen <pclouds@gmail.com>, kusmabite@gmail.com,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 15:25:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7o8s-000069-60
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 15:25:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932915Ab3BSOZd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 09:25:33 -0500
Received: from mail-ea0-f179.google.com ([209.85.215.179]:58650 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932906Ab3BSOZd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 09:25:33 -0500
Received: by mail-ea0-f179.google.com with SMTP id d12so2775317eaa.38
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 06:25:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:reply-to:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=atrnYEIAQRehHhtIhA4CrpXHvqRqN8ixMArfIyuigjI=;
        b=IlSc6CC8NokrVnjY7x2Nhk2kRxCJt5QZY3VMcgPHyk+wYHe7s5eQ7aJcE1IHUlykp1
         Bp31DuOY3uOwN/fiKHAi+80JkR6XGbCfwbzeDK0gg5jOOlo10Rfkksu0N9GonoVDY0uK
         AL69bOuHksDhneSxoO/ZbigLltz91A4iw00zXSjjQFfPxNzlgjGuaOS5F9uncqzphgo7
         astrZQVPx13XAGMUKhWZaFi2XHNsTxaUsPOicbzocbSM/AwTiikG5p0Nu+9fTKZTkJYC
         IkMpTUyqnBB5U3hPIL9sAiLqHpU1Ifuy1cb+BPhw2Df+ZwB3zDYGtnlkStVI0zabtzTW
         n+iQ==
X-Received: by 10.14.209.131 with SMTP id s3mr57226782eeo.26.1361283931812;
        Tue, 19 Feb 2013 06:25:31 -0800 (PST)
Received: from [10.1.100.50] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPS id l8sm70184151een.10.2013.02.19.06.25.30
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 06:25:30 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:17.0) Gecko/20130107 Thunderbird/17.0.2
In-Reply-To: <CALkWK0=XFBfZjO3oCJ8Jxya1ud79MQcQFm6pmZpOU8c3MxVtqQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216620>

Am 19.02.2013 10:49, schrieb Ramkumar Ramachandra:
> Karsten Blees wrote:
>> Am 11.02.2013 04:53, schrieb Duy Nguyen:
>>> On Sun, Feb 10, 2013 at 11:58 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>>> Karsten Blees has done something similar-ish on Windows, and he posted
>>>> the results here:
>>>>
>>>> https://groups.google.com/forum/#!topic/msysgit/fL_jykUmUNE/discussion
>>>>
>>
>> The new hashtable implementation in fscache [1] supports O(1) removal and has no mingw dependencies - might come in handy for anyone trying to implement an inotify daemon.
>>
>> [1] https://github.com/kblees/git/commit/f7eb85c2
> 
> Thanks!  I'm cherry-picking this.  Why didn't you propose replacing
> hash.{c,h} with this in git.git though?
> 

I was planning to, but didn't find the time yet to adapt existing hash.[ch] uses to the new version, and there's not much use adding four more files of dead code. If someone else could jump in here that would be great.

Note that there's another t0007 now, so t/t0007-hashmap.sh needs to be renamed.

>>>> I also seem to remember he doing a ReadDirectoryChangesW version, but
>>>> I don't remember what happened with that.
>>>
>>> Thanks. I came across that but did not remember. For one thing, we
>>> know the inotify alternative for Windows: ReadDirectoryChangesW.
>>>
>>
>> I dropped ReadDirectoryChangesW because maintaining a 'live' file system cache became more and more complicated. For example, according to MSDN docs, ReadDirectoryChangesW *may* report short DOS 8.3 names (i.e. "PROGRA~1" instead of "Program Files"), so a correct and fast cache implementation would have to be indexed by long *and* short names...
>>
>> Another problem was that the 'live' cache had quite negative performance impact on mutating git commands (checkout, reset...). An inotify daemon running as a background process (not in-process as fscache) will probably affect everyone that modifies the working copy, e.g. running 'make' or the test-suite. This should be considered in the design.
> 
> Yes, an external daemon would report creation of *.o files, from the
> compile, for instance.  We need a way for it to be filtered at the
> daemon itself, so git isn't burdened with the filtering.
> 

...and this filtering should affect foreground processes as little as possible. For example, gaining 1 s per git-status is counter-productive if compile time increases by 10 s because the daemon re-reads .gitignore files for every new *.o.
