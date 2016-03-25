From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] t7012: Implement test for git-checkout
Date: Fri, 25 Mar 2016 19:29:06 -0400
Message-ID: <CAPig+cR16EOA-EC=6GXXAkoJRC7dP-79xJUjVhyg+62sukK6qg@mail.gmail.com>
References: <56F57714.4050708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Chhatoi Pritam Baral <chhatoipritam@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:29:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajbAQ-0003nf-3C
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751763AbcCYX3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:29:09 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:32912 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127AbcCYX3I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:29:08 -0400
Received: by mail-vk0-f52.google.com with SMTP id k1so104312605vkb.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=J+SDafsZP4J4R/mF4gCb18UFhIOIFFlxcFl3pQEuqYY=;
        b=MFR6CsqldaPRngQByoUOZz0fPJzCjJeu0eeQCi8FDOoYSXJhN8bW4NoHkFUwKTUYLY
         szlvk4OmDenGpg6GCGnPx8Np/sdfN2QgqDkNmtIgOipQJ8+uzuIBgnHacm7mM1DEKKwo
         DIZwlh1FI3XDaFA4r2AXIB5SyKNJXCm2H3uLFcdmqT8FdMM6hp+cXoKBAmV9HN8PNTt6
         sTUrToFnp1cPWbSZ8pWeD+su207H9BYwpSIg1Fzu2B9Tmobu2orgnjGux81/+2yXBbUc
         UPt3cdlVXHsyL8AM/EckQ8G0xiSqK0RMffw+rwaDkD7+Vi/D3+weDTcArVv01BVMFGYx
         rnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=J+SDafsZP4J4R/mF4gCb18UFhIOIFFlxcFl3pQEuqYY=;
        b=BRaQRFJt2AWxsWj4wMQUfAdQeb3UKXostKMn9gmCeRNHnK8qG4gfLg+1fNBJe/RjMl
         Rm+sJHN2pHAmbrEiDy03DAJQjVSoIUEPSzFaF7uLAXim54R4v7yxFyV7vpI32qN2TDtW
         w6QTiZbInLvC16g7bGiNv3jmGJ2d0PVp8b4Fo7DvWYESD3HJZ/Uhs3fmzdcCljoUJwyD
         UO3b2/xqrtvHVlxfDp13BqLqe60JQRzjyrZ0rHgb5YdzuHmPF1muJFOVV/+cvyUNOBYU
         kOQpCgA5nrU5iTXwzGbJNwS+xn5wh6j5hQ8jTQSKUxmVyu3Eu/SlNRTWMqHXCYLknTMw
         Qt2Q==
X-Gm-Message-State: AD7BkJJl+iEOo77Fl/ap4OoaEtK1qo03aHjeMK4b3qDe4W6WJ73RkgwVgANiMbdS7iJ7FixYDB4n/V1hjECjFQ==
X-Received: by 10.159.36.248 with SMTP id 111mr7618034uar.99.1458948546823;
 Fri, 25 Mar 2016 16:29:06 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Fri, 25 Mar 2016 16:29:06 -0700 (PDT)
In-Reply-To: <56F57714.4050708@gmail.com>
X-Google-Sender-Auth: BoOPR5fGhjjF1DamOJZv1NlHDKA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289970>

On Fri, Mar 25, 2016 at 1:36 PM, Chhatoi Pritam Baral
<chhatoipritam@gmail.com> wrote:
> Previously a TODO, this patch adds a test for git-checkout skipping a
> file with the skip-worktree bit set.

In addition to Torsten's comments...

> diff --git a/t/t7012-skip-worktree-writing.sh
> b/t/t7012-skip-worktree-writing.sh
> @@ -141,6 +141,16 @@ test_expect_success 'git-clean, dirty case' '
>  #TODO test_expect_failure 'git-apply removes file' false
>  #TODO test_expect_failure 'git-mv to skip-worktree' false
>  #TODO test_expect_failure 'git-mv from skip-worktree' false
> -#TODO test_expect_failure 'git-checkout' false
> +
> +test_expect_success 'git-checkout ignores skip-worktree file' '
> +       echo > 1 &&
> +       git commit -m "Add files" &&
> +       echo dirty > 1 &&
> +       echo dirty > 2 &&
> +       git update-index --skip-worktree 1 &&
> +       git checkout -- . &&
> +       grep -q dirty 1 &&
> +       test_must_fail grep -q dirty 2

test_must_fail is for git commands; for system commands, just use '!'
(t/README explains the rationale).

    ! grep -q dirty 2

> +'
>   test_done
