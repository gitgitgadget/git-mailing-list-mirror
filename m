From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 02/14] trailer: process trailers from file and arguments
Date: Fri, 14 Feb 2014 15:39:31 -0800
Message-ID: <CAPc5daUsKaKfDD4AN10Az4HGAdLWnDkSYmLEOCMBrEkQtuRtAQ@mail.gmail.com>
References: <xmqqa9dxr09k.fsf@gitster.dls.corp.google.com> <20140214.224133.484636406629780362.chriscool@tuxfamily.org>
 <xmqqfvnlgyel.fsf@gitster.dls.corp.google.com> <20140215.002950.97819205213642217.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: christian.couder@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Johan Herland <johan@herland.net>, josh@joshtriplett.org,
	tr@thomasrast.ch, Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	dan.carpenter@oracle.com, greg@kroah.com, Jeff King <peff@peff.net>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sat Feb 15 00:39:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WESMO-0007Y9-Mf
	for gcvg-git-2@plane.gmane.org; Sat, 15 Feb 2014 00:39:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902AbaBNXjx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 18:39:53 -0500
Received: from mail-lb0-f170.google.com ([209.85.217.170]:38198 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752054AbaBNXjw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Feb 2014 18:39:52 -0500
Received: by mail-lb0-f170.google.com with SMTP id u14so9823728lbd.15
        for <git@vger.kernel.org>; Fri, 14 Feb 2014 15:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=j6O8wILb1JrN3PJAoFKpYRxsqPgl3t1khpndoILaUpo=;
        b=LGJA9FWWTgZvGfJo1A8sKbeygxpUZ5o5+A/yLBCoNfy5n/F3HhP0tf1ojUodyTvCDT
         seIsCP4TqXHQVevvGfc70+aHet2vkd2FqClol5OlWSqaPVvMDe8wC8Sf382gJLPjE7ud
         u11PqbGihMsoy8jN0Vz4TpTIJlsx+myJsaGxNhyysH9rJO7qAky6wv7mHPVqgMXqs3VK
         1Uf7ZwqtMi4AoRKZBK/kWyocu+AboRaMgzWhSF+TCOoAHike7TZFizCphcF4BQzTq6iA
         hvuo6YU9dJt0Lw2sNzpV97ym1dvLurmmXjzDPQ8ZlzNrMoftQFixEseY1vVplgQv/Mfk
         FAHg==
X-Received: by 10.112.128.170 with SMTP id np10mr7141512lbb.22.1392421191201;
 Fri, 14 Feb 2014 15:39:51 -0800 (PST)
Received: by 10.112.180.130 with HTTP; Fri, 14 Feb 2014 15:39:31 -0800 (PST)
In-Reply-To: <20140215.002950.97819205213642217.chriscool@tuxfamily.org>
X-Google-Sender-Auth: 8RkHTJC7gxJomvyak72aqJo_oQA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242163>

>> For example, how would you express something like this only with
>> "if-exists" vs "if-missing"?
>>
>>       if_exists_exactly = ignore
>>         if_exists_with_different_value = append
>>         if_missng = prepend_to_the_beginning
>
> First, previously in the discussion you said that you didn't want us
> to talk about the "where = (after | before)" part, because you could
> see that it was orthogonal to the other stuff, but now it looks like
> you want again to put that on the table.

Oh, then replace both "append" and "prepend" with "append" (it was a mistake).
Can you express that without having two kinds of if-exists?

> But it could be possible with only "if-exists" vs
> "if-missing" like this:
>
>         if_exists = append_if_different
>         if_missing = prepend
> ...
> because we can still easily express things like:
>
>         if_exists = append_if_different_neighbor

The proliferation of these random "if_X" on the action part _is_ exactly
what I find the proposal confusing.
