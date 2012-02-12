From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] column: Fix an incorrect parse of the 'nodense' option token
Date: Sun, 12 Feb 2012 10:37:50 +0700
Message-ID: <CACsJy8B7=6OYBV-HVK3Cq4_cTdPvm_1MvVv=U2R=4yQw9t5X9Q@mail.gmail.com>
References: <4F36B64D.4030000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Feb 12 04:38:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwQH7-0007DY-8J
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 04:38:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751567Ab2BLDiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Feb 2012 22:38:23 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:50470 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938Ab2BLDiW (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Feb 2012 22:38:22 -0500
Received: by lagu2 with SMTP id u2so3238978lag.19
        for <git@vger.kernel.org>; Sat, 11 Feb 2012 19:38:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=bnYEC5yHa7ZTRWQwLtztfbmkkNp72v0CrJqGYSaYGxQ=;
        b=uoEpftNfUZzuk2RsPlCiTs6/g6rIGGm3H4jxqAMjc0GlN6i7kqNeFNsVBw9AwlfE9C
         ZNJkNodfuPMznc2hY307Ehs0FavoL253LIXYuuCS0xvuldG4G/MdsmYbar+luWmXnuNf
         S7rgYxXzkpmg6PBpBo3GH7MXlbcE+Rme8XWZ8=
Received: by 10.152.147.1 with SMTP id tg1mr8018180lab.22.1329017901191; Sat,
 11 Feb 2012 19:38:21 -0800 (PST)
Received: by 10.152.111.34 with HTTP; Sat, 11 Feb 2012 19:37:50 -0800 (PST)
In-Reply-To: <4F36B64D.4030000@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190559>

On Sun, Feb 12, 2012 at 1:41 AM, Ramsay Jones
<ramsay@ramsay1.demon.co.uk> wrote:
>
> The parse_option() function always saw the 'nodense' token as
> 'dense', since it stripped the 'no' off the input argument string
> earlier when checking for the presence of the 'color' token.
>
> In order to fix the parse, we use local variables (within the loop)
> initialised to the function input arguments instead, which allows
> each token check to be independent.
>
> Also, add some 'nodense' tests to t/t9002-column.sh.
>
> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>

Acked-by: Nguyen Thai Ngoc Duy <pclouds@gmail.com>


> Note that the code supports the 'nocolor' token, but it is not documented
> in config.txt.
>
> If I understand correctly (and it's quite possible that I don't!), the
> 'nodense' token has the same meaning as the absence of the 'dense' token
> (and I assume a similar comment applies to the '[no]color' tokens). If that
> is the case, then maybe a better solution would be to simply remove the
> 'nodense' and 'nocolor' tokens. I will leave it to you to decide which
> solution is more appropriate.

It's about overriding config. If you set "dense" by default in
column.ui but do not want it in this particular run, you can say
--column=nodense.

The [no]color is for plumbing only. If a command produces colored
output, "color" is required to calculate text length correctly.
Overriding it with "nocolor" would break the layout badly so it's no
use there. It does not make sense (to me) for users to put "color" in
column.ui. Which is why it's not mentioned in document.
-- 
Duy
