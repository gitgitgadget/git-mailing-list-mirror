From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2 6/6] t5543-atomic-push.sh: add basic tests for atomic pushes
Date: Tue, 16 Dec 2014 12:51:47 -0800
Message-ID: <CAGZ79kb6JqJRJYhx=ypo+3WJAbu1uy_LSCPc+a+3=wW5EKWhZw@mail.gmail.com>
References: <xmqqzjaobl0q.fsf@gitster.dls.corp.google.com>
	<1418755747-22506-1-git-send-email-sbeller@google.com>
	<1418755747-22506-6-git-send-email-sbeller@google.com>
	<xmqqoar39y3l.fsf@gitster.dls.corp.google.com>
	<CAGZ79kZnGKNTpRZndgG_CjAC9gqafGXoq8rFOWuHZkaqY_LK7w@mail.gmail.com>
	<xmqq7fxr9vc7.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	ronnie sahlberg <ronniesahlberg@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 21:51:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0z60-0003kg-Fz
	for gcvg-git-2@plane.gmane.org; Tue, 16 Dec 2014 21:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751155AbaLPUvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2014 15:51:48 -0500
Received: from mail-ig0-f171.google.com ([209.85.213.171]:39652 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751044AbaLPUvs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2014 15:51:48 -0500
Received: by mail-ig0-f171.google.com with SMTP id z20so7583381igj.16
        for <git@vger.kernel.org>; Tue, 16 Dec 2014 12:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=M7rsOR6VbppgwiyfDPtuLjMXeWz1dFs93dhoia3f/EY=;
        b=A0d3t+YciEYAVlBenNhnKUHoJZ8HXrCWDb0OHsjaplEevV2CTihZ3HqxrQ10A1O2R7
         8/vFVZxmeShalQQ4BYbq9QHSIdZKmnPfZxvnXfXzeIcjuSIj4R67rOCBh9CdarhUMncG
         MRQqSnHaXznb80wXAr3AFOHaUXcnLX2+EAO8l3YLvnmlMDa+uclWvjK/SvYcSd6BQhkh
         I54ShFqXafpQbro938UaXpzYvli7QukRkozJGKJh+FdRn3UrC6iPfrQnTaLAQHph+e3n
         BmwaKOHS6k3TIwIsCpeikEhcOvr1ZM+xxoCKyhP/4wywrwnAJliRp1cMZ1BGuVXaDbrk
         pPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=M7rsOR6VbppgwiyfDPtuLjMXeWz1dFs93dhoia3f/EY=;
        b=FsoZLs2YS8NeS4dTvz0Mg69QfP0+qU0Qcep2O0pY19gwaBeYOKw8aPPPBPTU+hJrNV
         cxUMnFCj2efPHRyhq8HMF9U752ONG54ps7YXZgtN9fxangpnyhq/0PUZbkZpW27Ojxqo
         dJYVZwf3MZYQFbNFq1da6vjrgfqO9TT2+5F/jRZ4GpDqoQJr0EbhTt0wfdpib7u9VFSC
         4w918iFx7DCcaOFVF8vTJQ8LzmmyNJxQSyT3WbLXJZkRAghEqUYqxCff2n4LWfPvVj80
         BVCXJCDl6uxqGAXAUExpC1I1Xba5jO5fAigxzXGsU+1+0I6aAG3XemjzGfIBnp2/RO2e
         n0/A==
X-Gm-Message-State: ALoCoQnc3TEMGhNh03y+JeLI7lY9VcFk6pakHaa162YKbk8CQiUdT/BMlQklUar8caI2YAax6eFt
X-Received: by 10.43.154.196 with SMTP id lf4mr3605705icc.95.1418763107499;
 Tue, 16 Dec 2014 12:51:47 -0800 (PST)
Received: by 10.107.31.8 with HTTP; Tue, 16 Dec 2014 12:51:47 -0800 (PST)
In-Reply-To: <xmqq7fxr9vc7.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261471>

On Tue, Dec 16, 2014 at 12:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> On Tue, Dec 16, 2014 at 11:46 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>>
>>> Seeing that all callers of test_ref_upstream computes $2 as
>>>
>>>         git -C workbench rev-parse --verify <something>
>>>
>>
>> Only in the first tests, where this should be the case after push.
>> In the failure tests, we go with HEAD@{N} which needs to be computed
>> inside the workbench repo.
>
> Aren't we saying the same thing?  The suggested alternative is to do
> the "git -C workbench rev-parse" bit inside the helper.

Now I am saying the same. (I finally understood what you were saying)

Will incorporate in a reroll.
