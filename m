From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 4/6] t/t5528-push-default: generalize test_push_*
Date: Mon, 24 Jun 2013 11:45:59 +0200
Message-ID: <CALKQrgdEszpXO3noA3xAp=Q3b6bL=XUd00wRoR4K1H9dJ3beKg@mail.gmail.com>
References: <1372048388-16742-1-git-send-email-gitster@pobox.com>
	<1372048388-16742-5-git-send-email-gitster@pobox.com>
	<CALKQrgeSbY3spjTp_m7kgt4TkFi8B5pNpLQ8wvDD+qkCYa+Mww@mail.gmail.com>
	<7v7ghkdl2p.fsf@alter.siamese.dyndns.org>
	<CALKQrge4Nac4nk1RSnOFwE4-BNtHRNDSZHh9ihPY7ERd5jQ2Ng@mail.gmail.com>
	<CAPig+cRgN7yMGWc6zM8RiLrFxOcsMcia_BKiYT6fgQX_toA_QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jun 24 11:46:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ur3Lk-0001G4-28
	for gcvg-git-2@plane.gmane.org; Mon, 24 Jun 2013 11:46:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752080Ab3FXJqH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Jun 2013 05:46:07 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:51883 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751109Ab3FXJqE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Jun 2013 05:46:04 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur3LW-000NPs-Us
	for git@vger.kernel.org; Mon, 24 Jun 2013 11:46:02 +0200
Received: from mail-ob0-f179.google.com ([209.85.214.179])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Ur2Et-000EOk-WE
	for git@vger.kernel.org; Mon, 24 Jun 2013 10:35:08 +0200
Received: by mail-ob0-f179.google.com with SMTP id xk17so10553612obc.38
        for <git@vger.kernel.org>; Mon, 24 Jun 2013 02:45:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=spyZaK2XLUmOedy3ljUN8gmgImRwsGmwjse2yvXRowQ=;
        b=AH4bFcJZhC1hZtcDHgHIewPJFwMQZq2ctwzHTp6Mvat9V3kpkc1JDodsZe9cG/uw2d
         vS8rtVJKjJMGHelvy/adP701m9qUYiN/hpbHiraNZCeepUbkZ0uw+eHKofUEe5imRg6O
         lkxVCk+zy7W2F9QYA5Kgxd9kk6yv8z/HKPIuyJroLG5WAPQJXtC78MWDqiJMVPRtFPSg
         ObVxDgFeNWaRln2Jl+pc8Oo50KMnZpKskgHDLZPhfQyN6hfIEC9nsmQqYLyDHh1Lrqu1
         OhEzRaRRxY1BaJzU8trzZixfjmxBqLfHu3jFZK7wINjPzELthCnY+DceEcjd0wGZJGIi
         TcNA==
X-Received: by 10.60.93.196 with SMTP id cw4mr10490003oeb.135.1372067159347;
 Mon, 24 Jun 2013 02:45:59 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Mon, 24 Jun 2013 02:45:59 -0700 (PDT)
In-Reply-To: <CAPig+cRgN7yMGWc6zM8RiLrFxOcsMcia_BKiYT6fgQX_toA_QQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228799>

On Mon, Jun 24, 2013 at 10:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Jun 24, 2013 at 4:33 AM, Johan Herland <johan@herland.net> wrote:
>> On Mon, Jun 24, 2013 at 9:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Johan Herland <johan@herland.net> writes:
>>>
>>>>> +       git --git-dir="${3:-repo1}" log -1 --format='%h %s' "$2" >actual &&
>>>>
>>>> Isn't  ${3:-repo1} a bashism?
>>>
>>> I do not think so.  But now I looked at it again, I think I would
>>> use ${3-repo1} form in this case myself.  No caller passes an empty
>>> string to the third place.
>>
>> Ok, I have to admit that I'm not at all sure where the line between sh
>> and bash goes when it comes to ${magic}... Is there any good
>> documentation on what is in sh and what is not?
>
> POSIX: http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02

Thanks! Learn something new every day, I guess. :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
