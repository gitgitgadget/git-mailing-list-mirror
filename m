From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 11/11] t6050-replace: use some long option names
Date: Sun, 1 Sep 2013 04:07:46 -0400
Message-ID: <CAPig+cSwQdhybTzRwqGLbdxGRcAZfBeU6jjWYy43G0oT0hxkNw@mail.gmail.com>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
	<20130831191215.26699.76207.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Sep 01 10:08:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VG2hg-0001GG-GL
	for gcvg-git-2@plane.gmane.org; Sun, 01 Sep 2013 10:08:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255Ab3IAIHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Sep 2013 04:07:51 -0400
Received: from mail-lb0-f182.google.com ([209.85.217.182]:47755 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211Ab3IAIHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Sep 2013 04:07:47 -0400
Received: by mail-lb0-f182.google.com with SMTP id c11so2386138lbj.41
        for <git@vger.kernel.org>; Sun, 01 Sep 2013 01:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=lQrOIREaEAMs8z2wGL1AlmZbnvHX/zxMRRMhhl0e9mU=;
        b=vCVMXJmCEjBPYdRgzMnbs1LeCG8xBaI1l+hutpnNTQV3gOjslwo6De9QflLRHDdARG
         TN61GekQBsi5A0RC/ewbPLB4t//ySfWlokCS5J5vwfdOjxckjiW/RLdt+9qbOJTieo09
         QPP04fNsKB8614j7fE61eOso04A3VYx6/OgzvYX0dm5eTzaS4j1Prllp6BgCiq/4Libk
         6/rthTF19M5TwHJdCEAhL12HOtztUw6pecQWLOeXuKOqgeE25XSZBnT/qBU3BpyN06ZE
         wGMJbss7JRqhmL8e5CtoQ+bsEgbMOryVCPVf6hYXhCAitIVfAgt/jXQoohqNRxRZyC0g
         eM2A==
X-Received: by 10.112.130.134 with SMTP id oe6mr457004lbb.30.1378022866118;
 Sun, 01 Sep 2013 01:07:46 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Sun, 1 Sep 2013 01:07:46 -0700 (PDT)
In-Reply-To: <20130831191215.26699.76207.chriscool@tuxfamily.org>
X-Google-Sender-Auth: w9h4zK0CL8BhOyQgD2Xubr3AruE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233571>

On Sat, Aug 31, 2013 at 3:12 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> So that they are tested a litlle bit too.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t6050-replace.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> index 0b07a0b..5dc26e8 100755
> --- a/t/t6050-replace.sh
> +++ b/t/t6050-replace.sh
> @@ -122,9 +122,9 @@ test_expect_success '"git replace" listing and deleting' '
>       test "$HASH2" = "$(git replace -l)" &&
>       test "$HASH2" = "$(git replace)" &&
>       aa=${HASH2%??????????????????????????????????????} &&
> -     test "$HASH2" = "$(git replace -l "$aa*")" &&
> +     test "$HASH2" = "$(git replace --list "$aa*")" &&
>       test_must_fail git replace -d $R &&
> -     test_must_fail git replace -d &&
> +     test_must_fail git replace --delete &&
>       test_must_fail git replace -l -d $HASH2 &&

Is this sort of change a good idea? A person reading the code, but not
familiar with this particular patch, might not understand the
seemingly random choice of short versus long option usage. Such a
person might be led to wonder if there is some subtle difference
between the short and long forms, and then unnecessarily spend time
digging into the code and documentation in an attempt to figure it
out. Alternately, someone reading the code might be led to assume that
the person who added the tests was being sloppy.

Hopefully, t0040-parse-options should already be proof enough that
long options are correctly handled, but if you really want to test
them here too, it seems like a separate test would be more appropriate
than randomly changing short form options to long in various tests.

>       git replace -d $HASH2 &&
>       git show $HASH2 | grep "A U Thor" &&
> @@ -147,7 +147,7 @@ test_expect_success '"git replace" resolves sha1' '
>       git show $HASH2 | grep "O Thor" &&
>       test_must_fail git replace $HASH2 $R &&
>       git replace -f $HASH2 $R &&
> -     test_must_fail git replace -f &&
> +     test_must_fail git replace --force &&
>       test "$HASH2" = "$(git replace)"
>  '
>
> @@ -278,7 +278,7 @@ test_expect_success 'replaced and replacement objects must be of the same type'
>
>  test_expect_success '-f option bypasses the type check' '
>         git replace -f mytag $HASH1 2>err &&
> -       git replace -f HEAD^{tree} HEAD~1 2>err &&
> +       git replace --force HEAD^{tree} HEAD~1 2>err &&
>         git replace -f HEAD^ $BLOB 2>err
>  '
>
> --
> 1.8.4.rc1.31.g530f5ce.dirty
