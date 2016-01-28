From: Andrew Wheeler <awheeler@motorola.com>
Subject: Re: [PATCH v2] push --force-with-lease: Fix ref status reporting
Date: Thu, 28 Jan 2016 14:30:58 -0600
Message-ID: <CAE=k0msr-5euhiKep9YgE_gvPXsQfLujoXGoq3=A3LnaRRBqgA@mail.gmail.com>
References: <1454012410-10049-1-git-send-email-agwheeler@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 28 21:31:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOtDu-0002j0-Qm
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 21:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934374AbcA1UbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 15:31:19 -0500
Received: from mail-vk0-f47.google.com ([209.85.213.47]:32794 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056AbcA1UbS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 15:31:18 -0500
Received: by mail-vk0-f47.google.com with SMTP id e64so30968534vkg.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 12:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=motorola-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        bh=2UYpg9fJ2cQ5IXR3ltOsHwN2ZZ2BbC3L7mZ1AxXi7DI=;
        b=0X/FvmGdtjEwrh82bFqY/DXEOMlKlHfXNIZDhePgCYYTcrAEXIONA366AQpdlktL7o
         08YytxUB69TO2Sj1tlOulTkAbuhDrNT6f7kaauoFxUmFmWvu1EVVFvzewXwgYa3618Gy
         +VfFSN8a6gXL7uYGUfKIRlowS2m5+WUKe3FC/V52ACf13p7F9ZAiojlNS28WRo1P+yQu
         wyw5Y15SJYfTq/yY7eCrxNS3i9d3Yj3gbWhTqMwuN6g7YXsCpfo09C7pMS+BrAt3k++i
         eV5MmRadd6Ps3THy4PaHTRqKrmH3Dyvu2SjyRnDd74Q4v4FHPIan+eKj8jTVYuBK+CwN
         8PnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:content-type;
        bh=2UYpg9fJ2cQ5IXR3ltOsHwN2ZZ2BbC3L7mZ1AxXi7DI=;
        b=l4Rf/imCgfHMdq+cRN5p/Bnu0PCz6loimVuO365Kh5CQ1zG2dE3xjcKBx2gNWbPUIZ
         6SLOConSxkc4sflrRbkAmQACSaeRsgEn6eXJtHPM1xZN25jgbQRSj3PCdrMENFHg1cZU
         XRW1tbIgM2nzIoeFqMYjnJQDdK79TIm6HXoMSPccCahvGGkCGFTLNofoX/yupfekSzHg
         tWm0eYy28PKz22gbL699HAoB0/qiA4mrX8Gb06UJYpEyBxmqtVglY3iE1z70KI1lcj5v
         9eMvcW5ckGy+xHKyzTFPD8cu+gcu+jci8jsAIvezDF+l6C+g41OUylkWZy07pzkTLdr0
         TJKg==
X-Gm-Message-State: AG10YOQ5X+qSuU4k8jw0qrFx9kNW3dcSAszhuKGzv6K+XTkb9oj5ZhOkV2DTos+SatMfGe2WNrPWlnXDVJ+oa8dU
X-Received: by 10.31.58.83 with SMTP id h80mr3444875vka.149.1454013077546;
 Thu, 28 Jan 2016 12:31:17 -0800 (PST)
Received: by 10.103.85.21 with HTTP; Thu, 28 Jan 2016 12:30:58 -0800 (PST)
In-Reply-To: <1454012410-10049-1-git-send-email-agwheeler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285026>

Ignore -- I left an extra blank line. v3 is sent.

On Thu, Jan 28, 2016 at 2:20 PM, Andrew Wheeler <agwheeler@gmail.com> wrote:
> From: Andrew Wheeler <awheeler@motorola.com>
>
> The --force--with-lease push option leads to less
> detailed status information than --force. In particular,
> the output indicates that a reference was fast-forwarded,
> even when it was force-updated.
>
> Modify the --force-with-lease ref status logic to leverage
> the --force ref status logic when the "lease" conditions
> are met.
>
> Also, enhance tests to validate output status reporting.
>
> Signed-off-by: Andrew Wheeler <awheeler@motorola.com>
> ---
>  remote.c            | 16 +++++++++-------
>  t/t5533-push-cas.sh |  9 ++++++---
>  2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/remote.c b/remote.c
> index 9d34b5a..bad6213 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1545,11 +1545,8 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>                 }
>
>                 /*
> -                * Bypass the usual "must fast-forward" check but
> -                * replace it with a weaker "the old value must be
> -                * this value we observed".  If the remote ref has
> -                * moved and is now different from what we expect,
> -                * reject any push.
> +                * If the remote ref has moved and is now different
> +                * from what we expect, reject any push.
>                  *
>                  * It also is an error if the user told us to check
>                  * with the remote-tracking branch to find the value
> @@ -1560,10 +1557,14 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>                         if (ref->expect_old_no_trackback ||
>                             oidcmp(&ref->old_oid, &ref->old_oid_expect))
>                                 reject_reason = REF_STATUS_REJECT_STALE;
> +                       else
> +                               /* If the ref isn't stale then force the update. */
> +                               force_ref_update = 1;
>                 }
>
>                 /*
> -                * The usual "must fast-forward" rules.
> +                * If the update isn't already rejected then check
> +                * the usual "must fast-forward" rules.
>                  *
>                  * Decide whether an individual refspec A:B can be
>                  * pushed.  The push will succeed if any of the
> @@ -1580,9 +1581,10 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
>                  *
>                  * (4) it is forced using the +A:B notation, or by
>                  *     passing the --force argument
> +                *
>                  */
>
> -               else if (!ref->deletion && !is_null_oid(&ref->old_oid)) {
> +               if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
>                         if (starts_with(ref->name, "refs/tags/"))
>                                 reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
>                         else if (!has_object_file(&ref->old_oid))
> diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
> index c402d8d..c65033f 100755
> --- a/t/t5533-push-cas.sh
> +++ b/t/t5533-push-cas.sh
> @@ -101,7 +101,8 @@ test_expect_success 'push to update (allowed, tracking)' '
>         (
>                 cd dst &&
>                 test_commit D &&
> -               git push --force-with-lease=master origin master
> +               git push --force-with-lease=master origin master 2>err &&
> +               ! grep "forced update" err
>         ) &&
>         git ls-remote dst refs/heads/master >expect &&
>         git ls-remote src refs/heads/master >actual &&
> @@ -114,7 +115,8 @@ test_expect_success 'push to update (allowed even though no-ff)' '
>                 cd dst &&
>                 git reset --hard HEAD^ &&
>                 test_commit D &&
> -               git push --force-with-lease=master origin master
> +               git push --force-with-lease=master origin master 2>err &&
> +               grep "forced update" err
>         ) &&
>         git ls-remote dst refs/heads/master >expect &&
>         git ls-remote src refs/heads/master >actual &&
> @@ -147,7 +149,8 @@ test_expect_success 'push to delete (allowed)' '
>         setup_srcdst_basic &&
>         (
>                 cd dst &&
> -               git push --force-with-lease=master origin :master
> +               git push --force-with-lease=master origin :master 2>err &&
> +               grep deleted err
>         ) &&
>         >expect &&
>         git ls-remote src refs/heads/master >actual &&
> --
> 1.7.11.2
>
