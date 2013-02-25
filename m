From: Mike Gorchak <mike.gorchak.qnx@gmail.com>
Subject: Re: [PATCH 1/1] Fix date checking in case if time was not initialized.
Date: Mon, 25 Feb 2013 23:47:47 +0200
Message-ID: <CAHXAxrO4c=s0pjNpXK171HUbQT06jm-VAxNNK1DAqZEZfz6OtA@mail.gmail.com>
References: <CAHXAxrOOqn6ZSVT1AFyO3a3paD1tokBtcnaX68a+ddhodOvZ6Q@mail.gmail.com>
	<7vzjysxnb1.fsf@alter.siamese.dyndns.org>
	<CAHXAxrMaQRdBxSvNO+no_9d==v0tVnkpXtguTKyfvnm-VfR_xA@mail.gmail.com>
	<7vr4k4xlie.fsf@alter.siamese.dyndns.org>
	<CAHXAxrOjSS5jGLcCw4KTxP_F_uRQhi0cPSvzbx58jx9dP25XPA@mail.gmail.com>
	<7va9qsxjzk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 25 22:48:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UA5uB-0006dd-73
	for gcvg-git-2@plane.gmane.org; Mon, 25 Feb 2013 22:48:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759346Ab3BYVrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Feb 2013 16:47:49 -0500
Received: from mail-qe0-f50.google.com ([209.85.128.50]:52449 "EHLO
	mail-qe0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756921Ab3BYVrs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Feb 2013 16:47:48 -0500
X-Greylist: delayed 99773 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Feb 2013 16:47:48 EST
Received: by mail-qe0-f50.google.com with SMTP id w7so1985821qeb.9
        for <git@vger.kernel.org>; Mon, 25 Feb 2013 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=yPTEmJ16zaJi+o+gxPyWxe05xJbzquIxHB5/p7lCOH4=;
        b=GPBLcfDV09Ylrbh2tC2zoRAXJYbgwE2VwMQmZK2ph+j6G/1685ir9XC+hryzVGJHXe
         wq5jddkrhU3CvzHFCEl+ZEKbTkQQJUzLn8pbOUOQNjN3VlwPDrYI9X/5u0u1sNRe4XRs
         uk56KZEFl9u0PATGgdGDjXS+N1P/A6Df5R/0g5DpqGuHfYYdTuVr5FITnhCjUJ9KnZHJ
         b0ajhZSRo9tij+pM0vXJ/cqk87mMjJAoupdirC1xnBj2EWzZG6z6dcWK2+cve55h4HJ/
         rwjHGYQAqfBtd38sDs7gOdnTBsFHO7DiX8lSnHmk2IsZw8qucca3cHJZ/Wn9axZOOZIg
         9r2w==
X-Received: by 10.49.127.199 with SMTP id ni7mr15672040qeb.17.1361828867630;
 Mon, 25 Feb 2013 13:47:47 -0800 (PST)
Received: by 10.49.71.68 with HTTP; Mon, 25 Feb 2013 13:47:47 -0800 (PST)
In-Reply-To: <7va9qsxjzk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217108>

>> So is_date() always return negative result for the text string where
>> date is placed before time like '2008-02-14 20:30:45'.
> Yes, it returns this -1 on other platforms, but...
>> It must fail on
>> other platforms as well.

It also fails under Linux, but real problem is not here, it is just an
unoptimal date parser.

> ... the input '2008-02-14 20:30:45' still parses fine for others
> (including me).  That is what is puzzling.
> A shot in the dark: perhaps your time_t is unsigned?

Yeah, it was a headshot :) It really due to unsigned time_t. I will
send two patches right now with fixes regarding unsigned time_t
comparison.
