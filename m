From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] t6131 - skip tests if on case-insensitive file system
Date: Wed, 17 Jul 2013 20:42:48 +0700
Message-ID: <CACsJy8Ayyb7kTydXFxoeqNQgGemdUXXzAc3ZwEbT5dCuk_tkQA@mail.gmail.com>
References: <1374067336-6545-1-git-send-email-mlevedahl@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 17 15:43:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UzS0o-0006OS-Vl
	for gcvg-git-2@plane.gmane.org; Wed, 17 Jul 2013 15:43:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755426Ab3GQNnT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Jul 2013 09:43:19 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:35323 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755339Ab3GQNnS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jul 2013 09:43:18 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so2527360oag.19
        for <git@vger.kernel.org>; Wed, 17 Jul 2013 06:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=yURyqiM6C2IVOePwSF5r4sq/FLGoTwK3+SYshRqXiJM=;
        b=EKqn5Xwf+j/1ErfutXyiGtRDcpas+ZIa+jsr0D8WOHJluw8Fk1RIY0ep79FL2AesfY
         fbMp3RnqS5GdX2Hbpz6Ig1IWAgbbpdYwHlERgYr5j9CrUyCccbDOMNLRuKOhxuumawOB
         OSXKuio0SDCbItPzPepaHTT530ltax1BAm7vkzuPtP+skOSbxQ8UmSSCV632SdLWFTl8
         1jcYBD05QwCLmSbXdToupaJyRKiMXvOk8vg0L4QivoG5uV0WgGQSN/0W3TvcL45qELev
         CDMiyocgTBdlwIN5knF95XCej6tIM5hywJ1s82xqESZ7debuHgl3XhX0DCjPMJaCkFQM
         3log==
X-Received: by 10.182.153.72 with SMTP id ve8mr2573205obb.39.1374068598300;
 Wed, 17 Jul 2013 06:43:18 -0700 (PDT)
Received: by 10.76.88.230 with HTTP; Wed, 17 Jul 2013 06:42:48 -0700 (PDT)
In-Reply-To: <1374067336-6545-1-git-send-email-mlevedahl@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230625>

On Wed, Jul 17, 2013 at 8:22 PM, Mark Levedahl <mlevedahl@gmail.com> wrote:
> This test fails on Cygwin where the default system configuration does not
> support case sensitivity (only case retention), so don't run the test on
> such systems.

Yeah. I knew this when I wrote this test but forgot to put the check
in. Thanks. We can re-enable the test later, as it does not really
need case-insensitive filesystems.

>
> Signed-off-by: Mark Levedahl <mlevedahl@gmail.com>
> ---
>  t/t6131-pathspec-icase.sh | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/t/t6131-pathspec-icase.sh b/t/t6131-pathspec-icase.sh
> index 3215eef..8d4a7fc 100755
> --- a/t/t6131-pathspec-icase.sh
> +++ b/t/t6131-pathspec-icase.sh
> @@ -3,6 +3,12 @@
>  test_description='test case insensitive pathspec limiting'
>  . ./test-lib.sh
>
> +if test_have_prereq CASE_INSENSITIVE_FS
> +then
> +       skip_all='skipping case sensitive tests - case insensitive file system'
> +       test_done
> +fi
> +
>  test_expect_success 'create commits with glob characters' '
>         test_commit bar bar &&
>         test_commit bAr bAr &&
> --
> 1.8.3.2.0.63
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
Duy
