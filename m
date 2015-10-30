From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 2/8] submodule config: keep update strategy around
Date: Fri, 30 Oct 2015 11:25:25 -0700
Message-ID: <CAGZ79kYCmqv6vqRERWmihs5Ym-ug_xiqebMjQMDzjAmHgwKPGw@mail.gmail.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
	<1446074504-6014-3-git-send-email-sbeller@google.com>
	<CAPig+cRTa35B5aHcopaWOtCLxN6BhGJKTcVeDUf0hrZE_nfCKQ@mail.gmail.com>
	<CAGZ79kZ1usWVutWwyFQKeujyyTPVRtSQM6dvkU9gWUDSTNpB6w@mail.gmail.com>
	<CAPig+cRh9J0izFvLzRjjU4FEBKJsiJaYFv=9WdxFVfJ3xs0JiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jacob Keller <jacob.keller@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:25:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEMk-0003nC-TK
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:25:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbbJ3SZ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:25:26 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172]:32939 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751395AbbJ3SZ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:25:26 -0400
Received: by ykft191 with SMTP id t191so84301500ykf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2015 11:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ivBAYk9BtfzlpuKBbeHYqQ6HCKDQXqfRU2xMwLYRctI=;
        b=MsT5GkSBxOL6DSMMEl4yiA/mPQi5ylaoL3fS1OucuyfSWodTceKYBamRvttdrS1xRp
         hS2K1HYLS6xNptZXX4+xVKqFmTeYuD96KnMWkies9As+7G7CGduccnnKibH++h7q865T
         q/y+jV4CwHR29voax0HQuovLdYdje7K5A2F7wdIO+YF18IIyRqyjuj/9BivQPAF3hrFM
         QTjT6auBwmRJy+qTw19bmbfaXcJar3KSs6QWTcl48IKvtncQX/fIosaGp+l1Q6s8CNWN
         SdT5CE+VgD2rYugAxPaQdVoBbplR4FmBozJuM9VZ8J1UCByHVOG+V69m92fNoTmZHis8
         xw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=ivBAYk9BtfzlpuKBbeHYqQ6HCKDQXqfRU2xMwLYRctI=;
        b=eBoby2q75KOvwcXnRvVEJ0VfSH7TXsN9qKlpwpLwdZU8+peo98qE+x5/9HGrKaGk4z
         m6h6y503xJWJB3MxywEkxoaZlGxfb16oyMAmdyntS9ChK1LcaPOh7SwDXI+sYvRzu7wA
         vcQn5kW8wUmAwsFw36UZ3tOIn0liNHYoohGFQ/67F0anQ0OMd+hsRsGmlVHtOnxBaHWu
         kKH/EEK5J5YbIqROx+bLFZ5qSX8cItRAnKl080mY6gusoyqFwpUuYo1W4RQVylWNYynH
         FXQ1OllSY048nc/x5/SCDIXYXUD77xLoRbqZe4ZoMOBEJhVaz4PbvKnR6EzjCWXW/eYU
         rbrQ==
X-Gm-Message-State: ALoCoQlERM3Z/MQcIDFSpcDdAAS2C+CmcTAz3kr6DQv/8XomwqNAs50x62GYXJEnAGtwyuc0Y0Qn
X-Received: by 10.13.251.2 with SMTP id l2mr7415793ywf.44.1446229525440; Fri,
 30 Oct 2015 11:25:25 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Fri, 30 Oct 2015 11:25:25 -0700 (PDT)
In-Reply-To: <CAPig+cRh9J0izFvLzRjjU4FEBKJsiJaYFv=9WdxFVfJ3xs0JiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280509>

On Fri, Oct 30, 2015 at 11:16 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Fri, Oct 30, 2015 at 1:38 PM, Stefan Beller <sbeller@google.com> wrote:
>> On Thu, Oct 29, 2015 at 6:14 PM, Eric Sunshine <ericsunshine@gmail.com> wrote:
>>>> +               else if (!me->overwrite && submodule->update != NULL)
>>>
>>> Although "foo != NULL" is unusual in this code-base, it is used
>>> elsewhere in this file, including just outside the context seen above.
>>> Okay.
>>
>> ok, I'll clean that up as we go.
>
> Oh, I wasn't suggesting that you clean this up (though you may if you
> want). I was merely commenting (for the sake of others reviewing this
> patch) that, while not the norm for the project, this instance is
> consistent with surrounding code.

I only did a separate patch on top cleaning up 4 occurrences in that file.
We use != NULL quite often throughout the code base, specially in
conditions with side effects like:

    while ((char *c = string++) != NULL) {
        ...

where I think that makes even sense. But there are a minor number of
cases where we have no side effects

    $ grep -rI "!= NULL" |grep -v "((" |grep -v "))" |wc -l
    135



>
>>>> +                       free((void *)submodule->update);
>>>
>>> Minor: Every other 'free((void *) foo)' in this file has a space after
>>> "(void *)", one of which can be seen in the context just above.
>>
>> done
