From: "Carlos Rica" <jasampler@gmail.com>
Subject: Re: [PATCH] Make builtin-reset.c use parse_options.
Date: Mon, 3 Mar 2008 15:39:05 +0100
Message-ID: <1b46aba20803030639i73557fb3v44de6387b8fd57a7@mail.gmail.com>
References: <47C98472.8000002@gmail.com> <20080302094031.GA2973@steel.home>
	 <1b46aba20803020454v322f061bi4f34a737e9e2b7f3@mail.gmail.com>
	 <20080302155541.GH2973@steel.home>
	 <1b46aba20803021040ofec56b9q120a654a192eec09@mail.gmail.com>
	 <20080302213843.GA13954@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 15:40:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWBpQ-0000Yx-MJ
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 15:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753360AbYCCOjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 09:39:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbYCCOjH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 09:39:07 -0500
Received: from wf-out-1314.google.com ([209.85.200.170]:6248 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753294AbYCCOjG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 09:39:06 -0500
Received: by wf-out-1314.google.com with SMTP id 28so72427wff.4
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 06:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=70dayjMJrD2SMtuYe2FurrkkIRxgXr3dLFwPYJt/s5A=;
        b=d5KhEjkqWlQxd59jCAO5xn3P/v+LXazk9Ez6Prc34Hbu4pSQiYzO0yvafaxnexu7caT9yvK1brQnxckB3ZlJniB1YzTyHHTjUtqAialASAK56eD+jrmsNCeqq5AEP14K2R1BOH0P9L0E4tGdefH+J3QApiHYhtjj9gJevn28Cq8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=wF8RZKkpIgwTnuBf7IjsLD44G+sfrvTV7gx93BH4Q7ky04OSKRX4VbC0ikF1nZcV+ixFoFULeqWJiyBxLTmDrpsy0bxOZeJ2w0fikVrL6IbR1vbIW3YRkjh9cOB6PQqP2ZuiSj56JF59+MoquLnmHxGy9bmRahGOqSxFxjGzFbs=
Received: by 10.142.178.13 with SMTP id a13mr8224674wff.146.1204555145600;
        Mon, 03 Mar 2008 06:39:05 -0800 (PST)
Received: by 10.142.99.13 with HTTP; Mon, 3 Mar 2008 06:39:05 -0800 (PST)
In-Reply-To: <20080302213843.GA13954@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75930>

On Sun, Mar 2, 2008 at 10:38 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Carlos Rica, Sun, Mar 02, 2008 19:40:09 +0100:
>
> > On Sun, Mar 2, 2008 at 4:55 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
>  > >
>  > >  "static const struct option options[] = {"
>  >
>  > The other files using parse_options have only "static", or nothing.
>
>  Well, they all miss something. Besides all nice things about static
>  syntax checking, the compiler (GCC) can optimize string constants to
>  use the same data (not that it is interesting in this particular
>  case).
>
>
>  > To make "options" static, then reset_type and quiet should be
>  > static too, otherwise it cannot compile (in my system).
>
>  Of course. Is it a problem for user-interface level code?

The only problem could come from reusing this code to calling
many times to a cmd_reset function in the future. Then, I would
prefer not to worry about previous values in the variables by
using only automatic variables in the function.

Anyway, "const" is nice, since the options struct doesn't change.
