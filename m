From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] utf8: NO_ICONV: silence uninitialized variable warning
Date: Fri, 05 Jun 2015 15:19:04 -0700
Message-ID: <xmqqeglpre7b.fsf@gitster.dls.corp.google.com>
References: <1433486536-23447-1-git-send-email-sunshine@sunshineco.com>
	<20150605092309.GA11855@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 06 00:19:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0zxJ-0007WV-Ch
	for gcvg-git-2@plane.gmane.org; Sat, 06 Jun 2015 00:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751028AbbFEWTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2015 18:19:08 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33276 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbbFEWTH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2015 18:19:07 -0400
Received: by iebgx4 with SMTP id gx4so66862584ieb.0
        for <git@vger.kernel.org>; Fri, 05 Jun 2015 15:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=ORqBfXtiiKTBsYU9b8ugQm3wyednVdZfxRoEpXlNUQo=;
        b=XZW24+pFFzZWIfRmNjp3+Lvg+fuoW7Fo+G8qqCDWxgZpRkHBUfRL4nsnAawHAOjCCs
         M0OGoZcmmlXEcqQSEUF7UPcWYQRqW4mMKMOAgbWompHnX+Jybid/1RL9Z9NE4YRU/6bV
         MYUlKsg+IaLZTRPqheubvUpZO8f2GbEhH3AG54AsfuRXAErPoBMVZ2QlmsW+baXjsHSo
         G7MqhFYJc0ahb2hmDWcwbm6hJ82QzGfpJ7SRus99xguStM/ZzhgWU9ioyCRgpPZHzQua
         2uA/slQEQjjXcsJlm58whWbfoziZ1xT3ijpZ1buUJIpR1Ik1hjMh77wmlpiMvMrz3+dm
         T8qg==
X-Received: by 10.107.135.68 with SMTP id j65mr7226846iod.91.1433542746608;
        Fri, 05 Jun 2015 15:19:06 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:1d0d:eed3:5800:fefa])
        by mx.google.com with ESMTPSA id j4sm2248925igo.0.2015.06.05.15.19.05
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 05 Jun 2015 15:19:05 -0700 (PDT)
In-Reply-To: <20150605092309.GA11855@peff.net> (Jeff King's message of "Fri, 5
	Jun 2015 05:23:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270894>

Jeff King <peff@peff.net> writes:

> So I think your patch is the best option, but it might be good to give
> one more look at the callers to be sure we are not missing something.

The two callers both leave the outsz uninitialized and to a human it
is obvious that uninitialized outsz is never used when the function
or macro returns NULL.  It is somewhat sad that we need a useless
assignment to *e to help less than intelligent compilers, but it is
possible that a clever compiler may be able to optimize the useless
assignment away so it might even out in the end ;-)

Will queue.

Thanks.
