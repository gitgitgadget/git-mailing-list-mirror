From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 54/68] drop strcpy in favor of raw sha1_to_hex
Date: Thu, 24 Sep 2015 19:42:05 -0400
Message-ID: <CAPig+cQSOoYwG7EKDWPWoB+vHvYWv6ZHg9Zhd8bvH6XKfmG_1w@mail.gmail.com>
References: <20150924210225.GA23624@sigill.intra.peff.net>
	<20150924210805.GY30946@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Sep 25 01:42:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZfG9W-0003wt-Jr
	for gcvg-git-2@plane.gmane.org; Fri, 25 Sep 2015 01:42:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbbIXXmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Sep 2015 19:42:09 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:32974 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752364AbbIXXmG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Sep 2015 19:42:06 -0400
Received: by vkgd64 with SMTP id d64so46872579vkg.0
        for <git@vger.kernel.org>; Thu, 24 Sep 2015 16:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=CTqDK5PhqKuMDuevU54z69Pw5wMJ506t/C/9Hh6AXPs=;
        b=Jxccvod6Myg/TfAQRdbqP6Lw8Pe39lY95HEm+ofIC/s8tFvGbOtxvaosED5tDQFcFX
         qhqzmzlDQOLtTi99jRf6XMIKdLrcixD7h42B2ibdeL5REX6YCNJJer5isuB+rKPwTWR+
         q+8wsbXsJEqCe5XhlIY8WH4bS8FKU6VyZaei6GbNC6kX6cQv9dX0UODmB3wJABloljsT
         a8woi1sC6wQq4kGDKxIHFFV84U64JK4wt2QutIOFCRha5galOPWZC0ikRqu4rxmJqTIf
         K5XxK2gnGK61o5NllZ794yd8i7NdU4ANfN3uB6+NK0xMc3tfOfxg66VdhOjiF4bDqfjK
         O+0A==
X-Received: by 10.31.151.84 with SMTP id z81mr1424436vkd.14.1443138125464;
 Thu, 24 Sep 2015 16:42:05 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Thu, 24 Sep 2015 16:42:05 -0700 (PDT)
In-Reply-To: <20150924210805.GY30946@sigill.intra.peff.net>
X-Google-Sender-Auth: uzb6K3QepS1kT8SzIoDAVVFJ_a0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278636>

On Thu, Sep 24, 2015 at 5:08 PM, Jeff King <peff@peff.net> wrote:
> In some cases where we strcpy() the result of sha1_to_hex(),
> there's no need; the result goes directly into a printf
> statement, and we can simply pass the return value from
> sha1_to_hex() directly.
>
> When this code was originally written, sha1_to_hex used a
> single buffer, and it was not safe to use it twice within a
> single expression. That changed as of dcb3450 (sha1_to_hex()
> usage cleanup, 2006-05-03), but this code ewas never

s/ewas/was/

> updated.
>
> History-dug-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
