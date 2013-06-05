From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH v5 1/7] add simple tests of consistency across rebase types
Date: Tue, 4 Jun 2013 21:31:01 -0700
Message-ID: <CANiSa6jSFVykguWgF_n=N+TqTC6VLf-gyzYgetKAKO9kLnbGzQ@mail.gmail.com>
References: <1369982987-18954-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-1-git-send-email-martinvonz@gmail.com>
	<1370292135-1236-2-git-send-email-martinvonz@gmail.com>
	<7v1u8ide2b.fsf@alter.siamese.dyndns.org>
	<CANiSa6hGLKATn3uUJKoi4917R4qoiyRHHJWo-p8vFrCZsg5joQ@mail.gmail.com>
	<51AD860B.1070507@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
	Chris Webb <chris@arachsys.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Jun 05 06:31:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk5Nb-0001wz-Tc
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 06:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919Ab3FEEbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 00:31:04 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:59260 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750971Ab3FEEbC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 00:31:02 -0400
Received: by mail-wg0-f46.google.com with SMTP id l18so893553wgh.25
        for <git@vger.kernel.org>; Tue, 04 Jun 2013 21:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=PE4rNejyl7hIQ8GijS1h6mAmgN3tU40IdLUCJPnxlPo=;
        b=GYl/Qjy9C3BvziBlnwhRfVjtbTyLJXI43AiLaBCzZ48nDUtD4ArIhLYPBhpvE2iZ2K
         rhaL1xqy5wApBat7NcNhWphf3jkGX7QjF1Qa666KGfH7m9VruqSO+biwrMYDu4edbHlC
         oQRlUsc+jWKotJm2XySAAsQQmz49bKb9wEp3rqB1cHTMLVC+SgzqUO/DFINVCBDqMIgf
         avwkxzmedCtkqOyOQ9XEQY9tFyb01X/YDV2FwkgKYhWlJXcczwWRENDB+xT34VvofbQ0
         Bt5BhJGWhboLqj3Z5KU9RoI+BjuMQDNv/+vPwQ4SEQo33fuv6iTybqQOj3yaaKTpznNh
         Nb2w==
X-Received: by 10.180.184.101 with SMTP id et5mr4506170wic.45.1370406661389;
 Tue, 04 Jun 2013 21:31:01 -0700 (PDT)
Received: by 10.180.7.99 with HTTP; Tue, 4 Jun 2013 21:31:01 -0700 (PDT)
In-Reply-To: <51AD860B.1070507@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226429>

On Mon, Jun 3, 2013 at 11:15 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> Am 6/4/2013 7:14, schrieb Martin von Zweigbergk:
>> On Mon, Jun 3, 2013 at 3:28 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> +
>>>> +# checks that the revisions in "$2" represent a linear range with the
>>>> +# subjects in "$1"
>>>> +test_linear_range () {
>>>> +     ! { git log --format=%p "$2" | sane_grep " " ;} &&
>>>
>>> An interesting way to spell:
>>>
>>>     test $(git rev-list --merges "$2" | wc -l) = 0
>>
>> Heh, true. I'll change that.
>
> Then I think it would be even better written as
>
>         revlist_merges=$(git rev-list --merges "$2") &&
>         test -z "$revlist_merges"
>
> so as not to ignore errors in the git invocation (and at least one less
> fork()).

Done. I'll send it out in a day or two.
