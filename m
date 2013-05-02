From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 5/9] t1508 (at-combinations): document @{N} versus HEAD@{N}
Date: Thu, 2 May 2013 12:27:57 -0500
Message-ID: <CAMP44s1Hkff1QU7undZvLfFOCeeiBrB4RRtVEOoNCsfoGZu7yg@mail.gmail.com>
References: <1367501974-6879-1-git-send-email-artagnon@gmail.com>
	<1367501974-6879-6-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 02 19:28:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXxIj-0006nv-Kl
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 19:28:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761125Ab3EBR2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 May 2013 13:28:05 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:39383 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760941Ab3EBR2B (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 May 2013 13:28:01 -0400
Received: by mail-la0-f51.google.com with SMTP id ep20so775803lab.38
        for <git@vger.kernel.org>; Thu, 02 May 2013 10:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=SrUtAsq8t64MYGCEyfVec4FBRlNorL9Gx5QBFrva5YI=;
        b=hZQAVaFhVE1FacxK8eXzh/PxBMcY6Lp/Tli9Ik+AXOLPdxi7SiVUePRNIcjPERutyT
         u8IwH7NarJoIrZqoed0o+7AHeYv1TbnvYNQG3p7buctqV1rZ4r3Mq/xLvhlhtQ1cXSY7
         FDEyhf7bgzl6CoznHl+LmojGrScF5JbrH3gDYZFbuymc6LtlyYj4TyifWIGWsknYebtc
         y339qyyvPWPgqo0ZXqQH9DnCazWDGoRUp4dhp5THiNZFqVYA1c9vsGR16isz3osqvK0y
         bko57BHntYnSdQ6z7NRMYcCK9mC0sEbI1nzU46INEYNJ5Jla3m3+efwE8Th9+BQztBSF
         Z52g==
X-Received: by 10.112.146.133 with SMTP id tc5mr3014297lbb.88.1367515677798;
 Thu, 02 May 2013 10:27:57 -0700 (PDT)
Received: by 10.114.83.167 with HTTP; Thu, 2 May 2013 10:27:57 -0700 (PDT)
In-Reply-To: <1367501974-6879-6-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223232>

On Thu, May 2, 2013 at 8:39 AM, Ramkumar Ramachandra <artagnon@gmail.com> wrote:
> All the tests so far check that @{N} is the same as HEAD@{N} (for
> positive N).  However, this is not always the case: write a couple of
> tests for this.
>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  t/t1508-at-combinations.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> index eaa5337..29ffd73 100755
> --- a/t/t1508-at-combinations.sh
> +++ b/t/t1508-at-combinations.sh
> @@ -59,4 +59,18 @@ nonsense "@{1}@{u}"
>  nonsense "HEAD@{-1}"
>  nonsense "@{-1}@{-1}"
>
> +# Document differences between @{N} and HEAD@{N}.

That's enough explanation, except that we not documenting them, we are
testing them.

> The former resolves
> +# HEAD to a branch and looks up the logs for that branch, while the
> +# latter looks for the logs of HEAD.
> +check "HEAD@{3}" commit old-two
> +nonsense "@{3}"

> +test_expect_success 'switch to old-branch' '
> +       git checkout old-branch
> +'
> +
> +check HEAD refs/heads/old-branch
> +check "HEAD@{1}" commit new-two
> +check "@{1}" commit old-one

And here we are testing something completely different.

-- 
Felipe Contreras
