From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH/RFC/GSoC 01/17] perf: introduce performance tests for git-rebase
Date: Wed, 16 Mar 2016 19:51:53 +0800
Message-ID: <CACRoPnS=qg=a3xYKHyk-7E2HN5HhTimGirZcwL8hMa0xLY6KdA@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<1457779597-6918-2-git-send-email-pyokagan@gmail.com>
	<alpine.DEB.2.20.1603160855390.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Sam Halliday <sam.halliday@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 16 12:52:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ag9zg-0002i3-FV
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 12:52:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbcCPLv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 07:51:56 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:33368 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751101AbcCPLvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 07:51:55 -0400
Received: by mail-lb0-f177.google.com with SMTP id oe12so46313758lbc.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 04:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ZNo4FtJ79xnusr4M49jP3xuAaAmAOGvI+MRstI4zLxk=;
        b=SUcrmQK7LZqX2yrcpJNfKrUFNLpktEoqFujUio8ody4kyVopdKCWUu5/XQIGKJ4wKc
         p56oiKyDu9s7Bid1O2nXwGPIGxi+dFjxdQEDJ6s4VMeP85dzVMBVWnxXfD3EcG4p4MQu
         4JOOxYCAySb8nfFqRFHLyWK/+WcMEA9YEL2Gz6lRs+eiK6f71Rns8+kWL3f0/U9u4+Y0
         1n7aSGoBPfI7mItgbCp8xJSXvSbALE+Rmc3OBa6kyiuDsd5lAurNkh3xVIaSwVuo4csC
         9TR0CFg488Dvb0lhemkslwY68r160dDt5ndEUqZAyusde6xyzGXLBkPxnVm6wUubdc/a
         APLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ZNo4FtJ79xnusr4M49jP3xuAaAmAOGvI+MRstI4zLxk=;
        b=GIP8qwPpIuMANbyQv/LmftHIBeOQfo+H3YznfM/HiHFyGL27tCuZQlLBjVzi2Ku+Wf
         au0CX8sH3KdEm+xa03EOJvj6TT8m1JqJkF6EWAVQX8X24euYGdPmFbcSvOv6AE5Z6xwD
         t6KvyOM6MER4CNbQiA6n1wXHiVqkWr2ho/fLDs+SmPKHL8CHsd6uY6rL7qiqZAr9ZmEo
         mCywYow3kjYMs23uMpx67pG+vzJgW4obbUjVzMDCzhGNKFXE7ddMqecJ+HD0s2eOyYrw
         kBy0+9XgA7Rhkveb5LICEKdiL7/SBig2vayLj/yD9z6Eo4/b9OJlT8Tbfd+9zuzk7wCa
         WgCA==
X-Gm-Message-State: AD7BkJJ/X1pSFRJzWIqRVW8Ja9EkL7AYopiZvVztCF249Ps8gcohfAaNxpPgB+T/Ivuou73UKVmqr17nXkrbYw==
X-Received: by 10.112.128.225 with SMTP id nr1mr1214042lbb.101.1458129113724;
 Wed, 16 Mar 2016 04:51:53 -0700 (PDT)
Received: by 10.112.207.74 with HTTP; Wed, 16 Mar 2016 04:51:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603160855390.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288961>

Hi Dscho,

On Wed, Mar 16, 2016 at 3:58 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi Paul,
>
> On Sat, 12 Mar 2016, Paul Tan wrote:
>
>> diff --git a/t/perf/p3404-rebase-interactive.sh b/t/perf/p3404-rebase-interactive.sh
>> new file mode 100755
>> index 0000000..aaca105
>> --- /dev/null
>> +++ b/t/perf/p3404-rebase-interactive.sh
>> @@ -0,0 +1,26 @@
>>
>> [...]
>>
>> +test_perf 'rebase -i --onto master^' '
>> +     git checkout perf-topic-branch &&
>> +     git reset --hard perf-topic-branch-initial &&
>> +     GIT_SEQUENCE_EDITOR=: git rebase -i --onto master^ master
>> +'
>
> This measures the performance of checkout && reset && rebase -i. Maybe we
> should only test rebase -i?

test_perf runs the same script multiple times, so we need to reset
--hard at least to undo the changes of the rebase.

I think we can remove the reset if we use rebase -f and rebase onto
the same base, but -f was not implemented in this patch series.

> Also, I would strongly recommend an extra test_commit after reset;
> Otherwise you would only test the logic that verifies that it can simply
> fast-forward instead of cherry-picking.

Or, we could use the -f flag, I think.

Thanks,
Paul
