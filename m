From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 07/26] upload-pack: use skip_prefix() instead of starts_with()
Date: Wed, 25 May 2016 03:02:39 -0400
Message-ID: <CAPig+cTg-oTMiRBbcTpRdH5F8z=o_iQmndnCC-uZu6Sw93X+wA@mail.gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
	<1460552110-5554-8-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 09:02:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5Sq6-0002iA-E8
	for gcvg-git-2@plane.gmane.org; Wed, 25 May 2016 09:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbcEYHCl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2016 03:02:41 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34439 "EHLO
	mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbcEYHCk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2016 03:02:40 -0400
Received: by mail-io0-f175.google.com with SMTP id 190so26783614iow.1
        for <git@vger.kernel.org>; Wed, 25 May 2016 00:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=498COPizgolZFAOI0TL0YppDvzuBWvOptX+xIWjZK8A=;
        b=mDTaGDR3cRYF8lpwPVYBvmcxkcoRurhXiNc5kG4/Hn7CtItX3sYpyshRRGTUELXJZ6
         DGDs8Q1CHCobNiKI0ZUDP+iQyQ37SAYSTftBqAiRFpYLwuGB2y1UKmg0MdhiB6FznF4Y
         nX8RGgiVBofO3UYpdeXKBR5v4lfiXmrR3/f3u6RbcTIAOQ2YbBhU1K0thwmAvqghcljk
         UlLqdnCknd3J8hs8Z66cpeWj/CmpRMbIZXbi/rNpngtz4VWdSGpUfRf87AA1LzFwGWh+
         ie0XGEuH9Ehg9mh2pegVk8y0AiEMoSAKnDli7pon6DSCHyL6RE4biZ5zC6HyE6MKFJRi
         sNaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=498COPizgolZFAOI0TL0YppDvzuBWvOptX+xIWjZK8A=;
        b=dp14APkgnE6uyzfIk0V0O5NNv0sY3gI8s72YJw/5SSaaACTEvlha/nYYgAsCBp5Z0V
         bR4ANr0UoLX5MgWJ4JGbW9bRfDo9RzpCa6N5GWKcw/dWdtZ2hqlyF+brInqpjUkYNEah
         xv9xsR8Qbf4qcHz5sPeQl8W9p+tNUIOGKeWKimYLaDs+V6CcS3jjrGmCcBGOY57h7p6f
         94pDyE62ynTLZUBfZMNct7XcctK1kp257cZ+q/kN8fTJSsas72evHbGLOSwVvtDtXSpn
         UlQpzF9tO0y3QxvkOiWZmRv18DGysc5qRBsNyTGigaNePEXWEFc1FCK1xhHUW5IPx6FI
         8tzw==
X-Gm-Message-State: ALyK8tJRTpLWilDN/FfB+CQz51hKQ72Rek5Bz2Sp+IyQSc9EcEEzlou7Umkb01A1J4lbdUnPUGh1b5ce8BBpYQ==
X-Received: by 10.107.47.37 with SMTP id j37mr2301132ioo.168.1464159759768;
 Wed, 25 May 2016 00:02:39 -0700 (PDT)
Received: by 10.79.110.21 with HTTP; Wed, 25 May 2016 00:02:39 -0700 (PDT)
In-Reply-To: <1460552110-5554-8-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: F7IknzNXTPFzTr2_v901ucwSQM0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295565>

On Wed, Apr 13, 2016 at 8:54 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> upload-pack: use skip_prefix() instead of starts_with()
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/upload-pack.c b/upload-pack.c
> @@ -403,8 +405,8 @@ static int get_common_commits(void)
> -               if (starts_with(line, "have ")) {
> -                       switch (got_sha1(line+5, sha1)) {
> +               if (skip_prefix(line, "have ", &arg)) {
> +                       switch (got_sha1(arg, sha1)) {

There's one more instance of starts_with() in upload-pack.c:main()
which could be given the same treatment:

    if (starts_with(arg, "--timeout=3D")) {
        timeout =3D atoi(arg+10);
        daemon_mode =3D 1;
        continue;
    }

Was its omission an oversight or intentional since it's not related to
the others?
