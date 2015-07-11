From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/10] ref-filter: add support to sort by version
Date: Sat, 11 Jul 2015 11:24:53 +0530
Message-ID: <CAOLa=ZSuftULFSCKK=PoaPejA_FXGkmVrOybk1G6OEjDchfSEg@mail.gmail.com>
References: <CAOLa=ZQyHwza6L9r6iFX1GkVrC+F-XNwegO=bGyxafjY3JoYpw@mail.gmail.com>
 <1436437671-25600-1-git-send-email-karthik.188@gmail.com> <1436437671-25600-4-git-send-email-karthik.188@gmail.com>
 <vpqfv4x792z.fsf@anie.imag.fr> <CAOLa=ZRs560_YBVMTpfKBvB1BF6ts+X_JGFTzhp7A_+YsjwqqQ@mail.gmail.com>
 <CAOLa=ZROk=+mW8uVjpuxMVY9NP0eW4yk2Za8xYW5MAFWSGzXRw@mail.gmail.com> <vpqd2005hq4.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Sat Jul 11 08:19:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDo81-0005Zj-Vp
	for gcvg-git-2@plane.gmane.org; Sat, 11 Jul 2015 08:19:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbbGKGTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jul 2015 02:19:09 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:35096 "EHLO
	mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751431AbbGKGTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jul 2015 02:19:08 -0400
Received: by oihq81 with SMTP id q81so11174226oih.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 23:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=D8HSKiqkr2MKjo2zKMSvL5jA7AtTbNkrULhzvP/w5P0=;
        b=n1sA5d1Q/FhCRG4GvVm8RqMjT1D9LC655xQvonc8kqgp4vxU86Lyaqya22jf4EJ4Vh
         oPvJwjd0cSdIO3MmYbcIt4773PzWn28dvht/sZgLc+E3qe2SmZjgMbo91XI4EbBA3Ncm
         ASps9DJiQDMZwgn5LqWGLkE7OxfVKM1qxlIfuYAuFq1DpgOTEXKJVb66lHZifl5gDWG6
         giieEPV3Kywy+J6ME7XxDNGE81W7BXW0aWAlg+LkCSbDISNX21CQIhnKmcN9izkqlgQa
         uO1NOyWJgs9wNLCKD3afI3Qf9aS4niEIU6Ayxi64QDHD/QHnRj1jGkb5GHQISbVxexSj
         artA==
X-Received: by 10.60.177.195 with SMTP id cs3mr14918565oec.37.1436594122808;
 Fri, 10 Jul 2015 22:55:22 -0700 (PDT)
Received: by 10.182.26.73 with HTTP; Fri, 10 Jul 2015 22:54:53 -0700 (PDT)
In-Reply-To: <vpqd2005hq4.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273842>

On Fri, Jul 10, 2015 at 5:48 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> On Fri, Jul 10, 2015 at 4:22 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>>> On Thu, Jul 9, 2015 at 6:59 PM, Matthieu Moy
>>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>>> Karthik Nayak <karthik.188@gmail.com> writes:
>>>>
>>>>> Add support to sort by version using the "v:refname" and
>>>>> "version:refname" option. This is achieved by using the
>>>>> 'version_cmp()' function as the comparing function for qsort.
>>>>
>>>> You should elaborate on why you need this. Given the context, I can
>>>> guess that you will need this to implement tag, but for example I first
>>>> wondered why you needed both version: and v:, but I guess it comes from
>>>> the fact that 'git tag --sort' can take version:refname or v:refname.
>>>>
>>>> I think this deserves a test and documentation in for-each-ref.txt.
>>>
>>> I'll add it to "for-each-ref.txt" documentation.
>>> About the tests, there are already tests for the same in git-tag.txt and
>>> that's the only reason I did not repeat the tests in for-each-ref.
>>>
>>
>> But since the porting is in a later commit, will add tests to for-each-ref.
>
> Yes: to me "it's tested through 'git tag'" is a good argument to do only
> a superficial test, check that 'for-each-ref --sort v:refname' activate
> the sorting, but no detailed corner-case testing. But not a good
> argument to have no test at all on for-each-ref.
>

Agreed, I've written tests for the same.

-- 
Regards,
Karthik Nayak
