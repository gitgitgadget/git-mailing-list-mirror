From: Jaime Soriano Pastor <jsorianopastor@gmail.com>
Subject: Re: [PATCH] read-cache.c: Ensure unmerged entries are removed
Date: Thu, 14 Aug 2014 00:10:03 +0200
Message-ID: <CAPuZ2NGB710TUW4VJB5kGWjoXV+eiebv_ZYvooG=E-J-MLXywQ@mail.gmail.com>
References: <1407857491-16633-1-git-send-email-jsorianopastor@gmail.com>
	<xmqqd2c55zl6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 00:10:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHgkF-0007DA-S0
	for gcvg-git-2@plane.gmane.org; Thu, 14 Aug 2014 00:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaHMWKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 18:10:05 -0400
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59980 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751704AbaHMWKE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 18:10:04 -0400
Received: by mail-pd0-f173.google.com with SMTP id w10so412740pde.18
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 15:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=7Grfwtun4BFHBlJRMsgCI0R9B16D6k59qrxbbfxb680=;
        b=ThVFeoELdR69Syr3Hj11TCrjYRc7dSc4EjoCktUzYi3pLtgfV+r5S/1Qn9EuiAHDbv
         h4jCpn+/vG9CuRzXzsAgZZrV7bAMavDt9n2DAqdvxCcELSxU18PcBPatyBPfzs7v/LDH
         UNzqz0e/5jf1wDK3ASvXY0wGs9wQp6/e6ZdK5AY65uXJ4EbSvfyjVpzJmj4Ft2Q1Vo+w
         F1JTlUFEAo1B8OW9femZ3oShqDUTy6NUppGWMjq8nBLDa87hJhDMjfe2giisPAY7pdv4
         /I/AAYXL97BrFnT13geBmeoiKV+tqtykFcQLm16dC/FV6wrsr3gTVqCGi04IMN+Enpp3
         uH+A==
X-Received: by 10.70.98.232 with SMTP id el8mr6273202pdb.119.1407967803482;
 Wed, 13 Aug 2014 15:10:03 -0700 (PDT)
Received: by 10.70.43.170 with HTTP; Wed, 13 Aug 2014 15:10:03 -0700 (PDT)
In-Reply-To: <xmqqd2c55zl6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255255>

On Tue, Aug 12, 2014 at 8:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Jaime Soriano Pastor <jsorianopastor@gmail.com> writes:
>
> > A file in the index can be left as merged and unmerged at the same time
> > by some tools as libgit2, this causes some undesiderable behaviours in git.
>
> Well, doesn't it mean that libgit2 is broken?  Have you filed a bug
> over there yet?
>

Yes, exactly, I think libgit2 is broken but I wanted to double-check
that it was still happening in their master branch, and it is. I have
reported the bug after checking it.
https://github.com/libgit2/libgit2/issues/2515

>
> Having said that, protecting ourselves from insanity left by other
> people is always a good idea, provided that it can be done without
> bending overly backwards.


Yes, I think the most important thing in this case is to protect git
against this kind of inconsistencies.
