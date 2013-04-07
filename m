From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Mon, 8 Apr 2013 02:27:16 +0530
Message-ID: <CALkWK0k_vmXZr-x8=ZctouWbuVgv-1sptC0WX2aJ+yYD-T8cxA@mail.gmail.com>
References: <7v61zz9fu3.fsf@alter.siamese.dyndns.org> <CALkWK0n64BW8zQXweR38T6DjT+iYBbsZDPCLZ-4igqGJHoFwKw@mail.gmail.com>
 <7vr4im7m1y.fsf@alter.siamese.dyndns.org> <CALkWK0=jrO9MQotB+anAn-5YtG1RBTLWEnGL5=K4wy=yi7E-CQ@mail.gmail.com>
 <20130407161209.GG2222@serenity.lan> <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan> <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan> <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan> <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com> <5161D3C5.9060804@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:47:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pR-0000sy-J3
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934343Ab3DGU55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 16:57:57 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:40277 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934304Ab3DGU54 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 16:57:56 -0400
Received: by mail-ie0-f175.google.com with SMTP id c12so6034567ieb.20
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 13:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=UrE3ZmBtORVNbWo/l5g9QNJvCyffv09xW3eaaTcZf34=;
        b=Sp3SpJKmNzPIj5chqaGLpD8M+0C9hyF1LKbOMlKkuEB1biEg0yVNKWYUCY5nB/YgSD
         TUHEC3DBTzxiRyie/eYsBsDhL2cIfXtrFmsul9xt+p4M47wuqLg/pjx3eTEeJNmSWC6v
         us5mz/eX1eVhOH8PFt/+kuAi93Qp11FrpR0mAU2vGsdDvswSQ6Pep8eIT0DR4avTcIf4
         2sTfS/SbEIKL0t0ySYX3ZUdx98pnJWnmMcP64MKRQcBY4bTYyV6YvODSxepjtYAWo42m
         dZ7VNmyfz6Z58EprRTyCJ63C4HqHdkiA1MPzhdHt7eH2mclGN9vaMBSMpyqCQ7qV2lrA
         mlVA==
X-Received: by 10.42.204.79 with SMTP id fl15mr10202572icb.57.1365368276356;
 Sun, 07 Apr 2013 13:57:56 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Sun, 7 Apr 2013 13:57:16 -0700 (PDT)
In-Reply-To: <5161D3C5.9060804@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220382>

Jens Lehmann wrote:
> * Easier coding, as we find all information in a single object.

It's not just the difference between a single location versus multiple
locations.  It's about the core object code of git parsing links, as
opposed to a fringe submodule.c/ submodule.sh parsing .gitmodules.
When you push git-submodule.sh into core, you'll have to constantly
call functions to parse .gitmodules and get the information.  With
links, all that information is free, provided you've parsed the
object.
