From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] ewah/bitmap: silence warning about MASK macro redefinition
Date: Wed, 3 Jun 2015 02:28:10 -0400
Message-ID: <CAPig+cR3Xt5FNSYbDPhW=m5aEOMq8mCLRSe+mjYfVvdS0R382A@mail.gmail.com>
References: <1433281675-24893-1-git-send-email-sunshine@sunshineco.com>
	<xmqqegltzriq.fsf@gitster.dls.corp.google.com>
	<20150603045117.GC15989@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 03 08:28:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z029x-0004t2-J1
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 08:28:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbbFCG2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 02:28:14 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:33915 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751481AbbFCG2L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 02:28:11 -0400
Received: by iecwk5 with SMTP id wk5so5638148iec.1
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 23:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=m7+oUOfPyrI2HKphMJGYEVS4EhTc7hwWZhdKwQbH0Z0=;
        b=e3ZUwnQFicTj1rmxywXsDCgmIhXy4s3r+hgQm0DYCwu+ZEgB55sKrRNEM0GbadafiR
         le5lo2ccyL8shBLy6rspTp1V88WJCV1l3BfIxbU+YTMM3o7+tnj3kcyV6vGKyS38s36+
         Yb0EZ9S7WV3p+/c9Pr2gC0IdwPvu/Ynba2nBUSAvj5NYLPEbqwVO8ZdO19bwIuurnU0h
         AVqHo8h6uL9RbUzV7iQT8ATJq2LGljMPcXGzejRnxIVMp5BfmV6oDET/LOurCukS64ZF
         MEtcmt5VtFc6JbNhpXBX/pslBzUMo5mD+Agu5uWsbZsPLvoXlUH5wL7xgrNTw6h1feyz
         VQiQ==
X-Received: by 10.50.41.65 with SMTP id d1mr3658958igl.7.1433312891049; Tue,
 02 Jun 2015 23:28:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Tue, 2 Jun 2015 23:28:10 -0700 (PDT)
In-Reply-To: <20150603045117.GC15989@peff.net>
X-Google-Sender-Auth: NnRstRttQA5OP3TWmmGz683aNqI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270631>

On Wed, Jun 3, 2015 at 12:51 AM, Jeff King <peff@peff.net> wrote:
> Subject: [PATCH] ewah: use less generic macro names
>
> The ewah/ewok.h header pollutes the global namespace with
> "BITS_IN_WORD", without any specific notion that we are
> talking about the bits in an eword_t. We can give this the
> more specific name "BITS_IN_EWORD".
>
> Likewise, ewah/bitmap.c uses the generic MASK and BLOCK
> macro names. These are local to the .c file, but we have the
> opposite problem: on PowerPC Mac OS X (10.5.8 "Leopard" with
> Xcode 3.1), system header /usr/include/ppc/param.h[1]

The [1] has no meaning anymore, so: s/\[1\]//

> pollutes the preprocessor namespace with a macro generically
> named MASK. We can give these macros more specific names, as
> well, to avoid this conflict.
>
> Reported-and-analyzed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> I'm also happy to split it into two patches, and make Eric the author on
> the MASK part.

I don't mind being an author of a patch, so splitting works for me,
however, I'm also fine with whatever you and Junio prefer. (And, in
retrospect, I agree that renaming the macros here is preferable over
the #undef approach.)
