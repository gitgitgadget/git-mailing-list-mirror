From: Robert Dailey <rcdailey.lists@gmail.com>
Subject: Re: Git submodule first time update with proxy
Date: Fri, 23 Jan 2015 22:45:40 -0600
Message-ID: <CAHd499B+ZAAYAtDdsX=v4H60dq3wuVgR0Hk7x6NRubMJ_Umjjg@mail.gmail.com>
References: <CAHd499BEmV2zeosE9th59QTWPA0CPsU8eyHnONhsZqEb=bH+rA@mail.gmail.com>
	<CAFOYHZAiZkXqSkso+=Eh_THEkh+qi9k8xWsP0yt1dbw5ymwDDQ@mail.gmail.com>
	<CAHd499A+K=uh=wt4P_qy+8XOEttTziJEPvhE+=03oD_MRxna2Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 24 05:45:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEsbW-0000RF-UF
	for gcvg-git-2@plane.gmane.org; Sat, 24 Jan 2015 05:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbbAXEpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 23:45:42 -0500
Received: from mail-ig0-f169.google.com ([209.85.213.169]:50928 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbbAXEpl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 23:45:41 -0500
Received: by mail-ig0-f169.google.com with SMTP id hl2so274125igb.0
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 20:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=er5Ao8PLuqMnQUufdZUFr54dEmhhc4noZVfXlmCjiu4=;
        b=XQHZnchMvWH+1S4zYFfHRX3LDM7VqL65JZqEo3pmN0UFeK62rHbpUSX/UKABJqLqOk
         eGRBli9msb7uW19GBtVf1KhTvKsZWDwj+PVZtisCGTyHbMwhkpi2jriG+lA9cFQbuwET
         UNJqIoxX5T1JiWFSAnny1f9iUQ91y5OnL6o/IHCcU7m8aek/44sUFRkeJ3jNIXBwKGnX
         MiFu9McP2s8s1pd3Ca+PWVHZ8SjwJFROgvneOYZ0q9CuoQ90yQUN4iSZMHtwBy3GIMqb
         Wak9jv8serRI9IkLw++1TmGyxCcLyXICT+CEyaaEcNuPEj2qFgKGIg6RKMYlfdVcSE2P
         U8BQ==
X-Received: by 10.51.17.1 with SMTP id ga1mr2502675igd.33.1422074740368; Fri,
 23 Jan 2015 20:45:40 -0800 (PST)
X-Google-Sender-Delegation: rcdailey@gmail.com
Received: by 10.36.56.70 with HTTP; Fri, 23 Jan 2015 20:45:40 -0800 (PST)
In-Reply-To: <CAHd499A+K=uh=wt4P_qy+8XOEttTziJEPvhE+=03oD_MRxna2Q@mail.gmail.com>
X-Google-Sender-Auth: nllQrYYNzdKPr7ugeQeQEVcpWnc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262988>

On Fri, Jan 23, 2015 at 10:23 PM, Robert Dailey
<rcdailey.lists@gmail.com> wrote:
> On Fri, Jan 23, 2015 at 4:13 PM, Chris Packham <judge.packham@gmail.com> wrote:
>> Hi,
>>
>> On Fri, Jan 23, 2015 at 3:50 PM, Robert Dailey <rcdailey.lists@gmail.com> wrote:
>>> I have a submodule using HTTP URL. I do this:
>>>
>>> $ git submodule init MySubmodule
>>> $ git submodule update MySubmodule
>>>
>>> The 2nd command fails because the HTTP URL cannot be resolved, this is
>>> because it requires a proxy. I have "http.proxy" setup properly in the
>>> .git/config of my parent git repository, so I was hoping the submodule
>>> update function would have a way to specify it to inherit the proxy
>>> value from the parent config.
>>
>> Your not the first to suggest it and you probably won't be the last.
>> It is hard to decide _which_ config variables, if any, should
>> propagate from the parent. What works for one use-case may not
>> necessarily work for another.
>>
>>> How can I set up my submodule?
>>
>> Probably the easiest thing would be to make your http.proxy
>> configuration global i.e.
>>
>>   $ git config --global http.proxy ....
>>
>> If you don't want to make it a global setting you can setup the
>> submodule configuration after running init but before running update
>> i.e.
>>
>>   $ git submodule init MySubmodule
>>   $ (cd MySubmodule && git config http.proxy ...)
>>   $ git submodule update MySubmodule
>
>  For some reason, the init call does not create the submodule
> directory as you indicate. I also checked in .git/modules and it's not
> there either.

Correction:

I have to deinit the submodule then init again, then the submodule dir
is created (but empty). When I run the git config command inside the
submodule directory, it silently returns and does not indicate
failure, however the final git submodule update command shows failure
to access the remote and then subsequently the submodule empty
directory is removed by Git.
