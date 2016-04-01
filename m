From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3] builtin/apply: handle parse_binary() failure
Date: Fri, 1 Apr 2016 15:31:55 -0400
Message-ID: <CAP8UFD0RCECwy4DXM0PHe+K-XTiCbtur0dEhk6Z37wCKLDwfKQ@mail.gmail.com>
References: <1458304241-537-1-git-send-email-chriscool@tuxfamily.org>
	<CAP8UFD2vx17KDf5HgSYYZudbXiq7CYDg0=hXbJuJrLp9QDfJUg@mail.gmail.com>
	<xmqqvb41i705.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 21:32:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am4nZ-0001XQ-Pm
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 21:32:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752735AbcDATb5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 15:31:57 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34878 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbcDATb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 15:31:57 -0400
Received: by mail-wm0-f48.google.com with SMTP id 191so2633432wmq.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=LV1PUlG6c11ZC1zwV8sn+4oVsfoPuS354DbQbix0Ik4=;
        b=FxpSILNVtajO70EqYRdCojlbeA0cW+URcoDrtUtgOt+D3O/EYWnYWjlu1NMQEELpmy
         tA5t/4Q7GHOdGOxmdKY1uRgnTIUN6sJtqgj1uqZXocGngIr2NNSig70KPoRoTO3WmZFR
         UZPCfmvFRVVFCjQThRyCrJd4A/CG/1iQsZY8PIc5qx7ai219er3CwqfcF9m8GuKdVfIH
         1tWu8rQawFxydbrW+zehEWRAWykfFUi4g140CXWz716dd2NcJV3XtZeFulm0crkO4K+Y
         5NeBI4DR9ZMo/pCaflyrTsho8ht7NzB89Rskz2d596OlQ9W0oh+Hh6MQonIkdYUPfE1Y
         G6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=LV1PUlG6c11ZC1zwV8sn+4oVsfoPuS354DbQbix0Ik4=;
        b=PlBWuaveRDo9e+QiEVY9iB6yonTGpUNhtL0FRZvCe1xfqyEKuqfVytBGN2eMsreiXS
         N9o7fKEnYzoI7dU75/nQAz7ZMznEBu/tV322rMX75d9aZYEY1cMtczGXRN4fgt+F5hFZ
         q7WJej5rCPrC/DqXU2iT8Den0Kfl9/51KFjP8VWCu+0JsYkupsGg8hIoNz1+MSPSdHQB
         mpnlBNW+7Lk3RW8co238w1pwm6jYgqip09A+68ZPF/8ngF+ST20S71z4CtYmb3cOXwop
         v4e9Zu8I/KTZCoEjbg/UBWXd+eI9NH4bpuXZyT0H9dZRy+T60VZ0k1HwUTsZnqOfkfEA
         42cA==
X-Gm-Message-State: AD7BkJImAWtaej4b4GIuwha61FCcXaLFfdxpYXiGLWpAEAC1z8wrDEhNiGT8hhoRCjs/OBSf8BefzSdm1cpO6w==
X-Received: by 10.28.107.13 with SMTP id g13mr429718wmc.62.1459539115588; Fri,
 01 Apr 2016 12:31:55 -0700 (PDT)
Received: by 10.194.151.131 with HTTP; Fri, 1 Apr 2016 12:31:55 -0700 (PDT)
In-Reply-To: <xmqqvb41i705.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290577>

On Fri, Apr 1, 2016 at 1:16 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>>
>> It looks like this patch is not in pu. Maybe it has fallen through the cracks?
>
> Yup, it indeed was ignored (giving priority to work towards 2.8
> during the freeze) and then was forgotten.
>
> My comment on the first one that exited mentions "your follow-up
> patch", but I cannot quite tell which one, as there was no threading
> in your original patches.  Does this change need to come before
> something else that I already have?

No, I think by "your follow-up patch" you meant the other one that had
also been forgotten and that I also replied to, that is:

[PATCH] builtin/apply: free patch when parse_chunk() fails

I had first sent both of them at around the same time.

Thanks,
Christian.
