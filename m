From: Erik Bray <erik.m.bray@gmail.com>
Subject: Re: Timestamp of zero in reflog considered invalid
Date: Wed, 6 Apr 2016 15:20:02 +0200
Message-ID: <CAOTD34Z-tJ4-aB7uMy5Hw9D3_N+EOwHsqJ6F+cJ5yHZZzowjug@mail.gmail.com>
References: <CAOTD34YpTXperaC0=Sy=21Q9_+0eGO1y-bP-WzrkxFvrDykRXg@mail.gmail.com>
	<xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 15:20:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1annNX-0003p4-Da
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 15:20:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbcDFNUG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 09:20:06 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:35900 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754309AbcDFNUE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 09:20:04 -0400
Received: by mail-lf0-f47.google.com with SMTP id g184so33629315lfb.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 06:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=d/zGOjIDnat7bJsKPWMFqqkxrPn86+sh2bBSiupuXls=;
        b=U/MyavOw1qtvQ2rhFHjuoAqSnLdrzl8X3249ZGDzsnJAVV2xco+rxYgu6OFSnJRMef
         8r4XePnicYcdvwB7/Qh0H+8G/hbkGlgI5uFdUljRA/PFsRG7PjVq4uzJyNe9gCmyo/DM
         qZ2gGsDJ07IDdgmgJGMCbS/LE8MKrw9uLhIYrm+bflDo/ixh26whQMBXNAFA4uxxanbf
         p8p2udBbikkzLuCeEF+sFVeKsLTi+yQUGvQNMoW4RKwxA6YRcfFl4sgPqJoma29JpmV0
         TwjjjpTByxVKXPUx+2rga0/7fR2xYRBOqYFeiZIpZAcA0ApzTb4I/iaDklRVDagnAd1a
         0mGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=d/zGOjIDnat7bJsKPWMFqqkxrPn86+sh2bBSiupuXls=;
        b=G9iwB4UVckw3i1Jom0bmK8syUW+8LgjVr8cqXE7iK0NCFICpUEn2nvPyT6P5sm8sxb
         BsGK1b00AiMn1hx6ZgI9s6/hYzAq0BRci8A9DP10uCe0kGN5UHJaQXv6IAXcfbBMK1wp
         azrnD2E1RdbAnZ7+LtLfMoJ/iWXxIadOi4IGdvA2a7ToiKZiTj/ANNObf84AnX86T/Y8
         tnlO6mo600vrHvfgjKSVg1iCMdGRZi3l6koLfvbb0htBc6mkGaPv4cDjdu1ffMw8MiL8
         Z00WbmUkkpCOVCfqKiQzGIFidWLGShqk2qVxDXyEM8GsJm6iE/rLQ93FQnpiPg9bewVb
         /ypg==
X-Gm-Message-State: AD7BkJJgJCZQUH4uRdDVF0JUbXLRNxPjzq7uOE58BkuQjFgreWd0HWzXDBfv0ri7ta3uiwoeiRrYzywKI3BNUw==
X-Received: by 10.25.41.140 with SMTP id p134mr11151131lfp.15.1459948802168;
 Wed, 06 Apr 2016 06:20:02 -0700 (PDT)
Received: by 10.25.148.148 with HTTP; Wed, 6 Apr 2016 06:20:02 -0700 (PDT)
In-Reply-To: <xmqqbn5o2gv1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290840>

On Tue, Apr 5, 2016 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks for a report.

Thanks for looking into it!

> I think this dates back to 883d60fa (Sanitize for_each_reflog_ent(),
> 2007-01-08):
>
> commit 883d60fa97c6397450fb129634054e0a6101baac
> Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Date:   Mon Jan 8 01:59:54 2007 +0100

Ah yes, I tracked it to this too--forgot to mention that, sorry.

> I suspect that there was some
> confusion as to how strtoul() signals an error condition when the
> commit was written, or something.

Yep--the next line *did* check for (!message) which would indicate
that strtoul failed, but checking for errno==ERANGE sounds good.  +1
on the patch modulo setting errno = 0 first.

Thanks,
Erik
