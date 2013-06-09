From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] build: get rid of the notion of a git library
Date: Sun, 9 Jun 2013 20:26:32 +0530
Message-ID: <CALkWK0=7PRndNc7XQ-PCPbVCp9vck909bA561JhQG6uXXj1n4g@mail.gmail.com>
References: <1370712574-27688-1-git-send-email-felipe.contreras@gmail.com>
 <CALkWK0mA7MXQv1k5bFpZLARDOHxU5kzKFXzcyUfb6NLZZY-=FA@mail.gmail.com> <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 16:57:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ulh3V-0006oi-Iw
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 16:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279Ab3FIO5N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 10:57:13 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:63356 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739Ab3FIO5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 10:57:13 -0400
Received: by mail-ie0-f177.google.com with SMTP id u16so14523282iet.36
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=CRGtMBkADVCt0cPeLY2joMUrVzXhtUjwXnAfmXP9t6o=;
        b=A8QvwqWdsk4pvUv5x9DGZLLaZbBAxWGuR8wvAVlT44QHVEihEOdkNoW+bQTq77T9+6
         P5TaqLmvQdgkKcpOhQQRDN4GY5m6y+2aKglQ773PCQkA5+z5zXXkE9fDgbHalNNWoTG/
         eNx0xI/XScOGPq4ri0ZLaX7Cy/cDASl9xh32oy06G7fL/B04zhY7VmEWJILLiXBcUGQR
         LHkFbU2RjShzVT5STQFzMFCjcpK7PVPmTlb2rrv1IF/T5q+xz1HESXCS3Y8QUnDVhSs7
         FQdLeVUjCwj9hhI4KJPuVzmZ/tVlPtuLLIvJG3YY6ru4vn/XgvarRTkm2L/FONMpMR4T
         7hig==
X-Received: by 10.50.56.20 with SMTP id w20mr2390763igp.40.1370789832667; Sun,
 09 Jun 2013 07:57:12 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 07:56:32 -0700 (PDT)
In-Reply-To: <CAMP44s0cozMsTo7KQAjnqkqmvMwMw9D3SZrVxg48MOXkH9UQJQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226963>

Felipe Contreras wrote:
> The plan is simple; make libgit.a a proper library, starting by
> clarifying what goes into libgit.a, and what doesn't. If there's any
> hopes of ever having a public library, it's clear what code doesn't
> belong in libgit.a; code that is meant for builtins, that code belongs
> in builtins/lib.a, or similar.
>
> Give this a try:
>
> --- a/sequencer.c
> +++ b/sequencer.c
>
> libgit.a(sequencer.o): In function `copy_notes':
> /home/felipec/dev/git/sequencer.c:110: undefined reference to
> `init_copy_notes_for_rewrite'
> /home/felipec/dev/git/sequencer.c:114: undefined reference to
> `finish_copy_notes_for_rewrite'

This is a good example: yes, I'm convinced that the code does need to
be reorganized.  Please resend your {sequencer.c ->
builtin/sequencer.c} patch with this example as the rationale, and
let's work towards improving libgit.a.
