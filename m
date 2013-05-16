From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH 1/6] test-lib: enable MALLOC_* for the actual tests
Date: Thu, 16 May 2013 23:28:30 +0200
Message-ID: <CA+EOSBm1rBXiXoe8ux3DsN_YxcPDZ1JhUJ6F1wmkVGd-dbocpg@mail.gmail.com>
References: <cover.1368736093.git.trast@inf.ethz.ch>
	<043f7ee12630ae267bcde88e92a7dfacbf41e730.1368736093.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu May 16 23:28:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ud5j2-0002TK-3X
	for gcvg-git-2@plane.gmane.org; Thu, 16 May 2013 23:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753376Ab3EPV2c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 May 2013 17:28:32 -0400
Received: from mail-ve0-f169.google.com ([209.85.128.169]:47650 "EHLO
	mail-ve0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751540Ab3EPV2b (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 May 2013 17:28:31 -0400
Received: by mail-ve0-f169.google.com with SMTP id jw11so3202376veb.0
        for <git@vger.kernel.org>; Thu, 16 May 2013 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=ddxYa2Ohv6T2+Pcg5Ff4U3Lza+4iYJIn8nQgSXrGvrU=;
        b=DeodX2Gih6tOwcm6gSZinKmzovrwyw5ZgxlA9NID86FKV9aw3EaK7VoYN9CQwXJ7N7
         0tnhNCmlEGLm1jaMDI3T3RwxZO8is7s9/4kiz/9m1jTksljiQuwTDQ/E9wjB2qPyVXmn
         FZ4/pO5hboeMPVDbUcpm2IGkaZfvyeg+Ls8eaV/M2OrqtvRLfOJNKXRuKypzsntUZ+i/
         EiIwldR86fxrVYpDbeRVRRvL2ZCa4RuF7qifEm7zt4jI7xJ4FxlVf4R21v5Nm5zN0Fau
         xegW7DslQJbHPdTc3Eb5Qc4dloirKU+FxZCuwhPQBNJbAXQh5CfsTRWds99FMEjZMpTG
         4MZQ==
X-Received: by 10.52.248.242 with SMTP id yp18mr24379567vdc.40.1368739710875;
 Thu, 16 May 2013 14:28:30 -0700 (PDT)
Received: by 10.52.66.8 with HTTP; Thu, 16 May 2013 14:28:30 -0700 (PDT)
In-Reply-To: <043f7ee12630ae267bcde88e92a7dfacbf41e730.1368736093.git.trast@inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224622>

2013/5/16 Thomas Rast <trast@inf.ethz.ch>:
> 1b3185f (MALLOC_CHECK: various clean-ups, 2012-09-14) moved around the
> MALLOC_CHECK_ and MALLOC_PERTURB_ assignments, intending to limit
> their effect to only the test runs.  However, they were actually
> enabled only during test cleanup.  Call setup/teardown_malloc_check
> also around the evaluation of the actual test snippet.
>
> Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
> ---
>  t/test-lib.sh | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index ca6bdef..229f5f7 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -337,8 +337,10 @@ test_eval_ () {
>  test_run_ () {
>         test_cleanup=:
>         expecting_failure=$2
> +       setup_malloc_check
>         test_eval_ "$1"
>         eval_ret=$?
> +       teardown_malloc_check
>
>         if test -z "$immediate" || test $eval_ret = 0 || test -n "$expecting_failure"
>         then
> --
> 1.8.3.rc2.393.g8636c0b
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Good.
