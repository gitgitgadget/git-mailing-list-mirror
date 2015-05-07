From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH v2 11/12] t5524: test --log=1 limits shortlog length
Date: Fri, 8 May 2015 01:06:18 +0800
Message-ID: <CACRoPnRfqQMRJ5N=oL84SMw=FC=Eg-Co-De_9E9cpWCaaSZAxw@mail.gmail.com>
References: <1430988248-18285-1-git-send-email-pyokagan@gmail.com>
	<1430988248-18285-12-git-send-email-pyokagan@gmail.com>
	<05adfac12cb9a7ad183281974d991e00@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 19:06:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqPFh-0004zc-TX
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 19:06:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbbEGRGU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 13:06:20 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33141 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbbEGRGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 May 2015 13:06:19 -0400
Received: by lbbzk7 with SMTP id zk7so35855623lbb.0
        for <git@vger.kernel.org>; Thu, 07 May 2015 10:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=ETWJv6Sq1XY5h01sWM00jnxRuUPUkmDDFjlsXYKljTg=;
        b=YA0SIbblKsRqBOqKU0UCCyvYwMq2235thg74fj/nmhqaMwRRRWjaUm71H+eX1XCjhQ
         ltPShljgb99J4FsUoTmMFP6ZsFGqX3OIzaIVY6swdq6WMzl73yZFsAJKsk10EW6rVAE9
         ZdxdcYvv41jqzWSGlX8osgzL7DVOHXlsLlRQVHo9Cp6aiKeiPN0xua07i8dYJBITlmjk
         EdVaw39uKobw6P+Kguz30+8IXvRTpBSDbRM3ujRH0k2KxcmMNhJn/34wFfdCTrKcw0de
         OJLnjoH4rOaxV3WyKG90ECTHM4mMbB2iTpKuJgpvqndUtjJKla18IyKCkpfBcKQySbTT
         Xr8w==
X-Received: by 10.112.205.69 with SMTP id le5mr356868lbc.65.1431018378614;
 Thu, 07 May 2015 10:06:18 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Thu, 7 May 2015 10:06:18 -0700 (PDT)
In-Reply-To: <05adfac12cb9a7ad183281974d991e00@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268553>

Hi Dscho,

On Fri, May 8, 2015 at 12:28 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> Hi Paul,
>
> On 2015-05-07 10:44, Paul Tan wrote:
>> @@ -32,4 +35,18 @@ test_expect_success pull '
>>  )
>>  '
>>
>> +test_expect_failure '--log=1 limits shortlog length' '
>> +(
>> +     cd cloned &&
>> +     git reset --hard HEAD^ &&
>> +     test `cat afile` = original &&
>> +     test `cat bfile` = added &&
>> +     git pull --log &&
>> +     git log -3 &&
>> +     git cat-file commit HEAD >result &&
>> +     grep Dollar result &&
>> +     ! grep "second commit" result
>> +)
>
> I think it might be better to use `test_must_fail` here, just for consistency (the `!` operator would also pass if `grep` itself could not be executed correctly, quite academic, I know, given that `grep` is exercised plenty of times by the test suite, but still...)
>
> What do you think?

Yep, it's definitely better. Sometimes I forget about the existence of
some test utility functions :-/.

Thanks,
Paul
