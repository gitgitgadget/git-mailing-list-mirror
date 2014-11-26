From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 1/2] t7503: use write_script to generate hook scripts
Date: Tue, 25 Nov 2014 20:25:18 -0500
Message-ID: <CAPig+cRjwt1NhT1=cqndNihhHzwh7Cc1DWQik=g8MxJV6wWfXw@mail.gmail.com>
References: <cover.1416955873.git.oystwa@gmail.com>
	<cover.1416953772.git.oystwa@gmail.com>
	<78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:25:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtRMB-0004Eh-I6
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:25:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbaKZBZU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 20:25:20 -0500
Received: from mail-yk0-f177.google.com ([209.85.160.177]:45461 "EHLO
	mail-yk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234AbaKZBZT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 20:25:19 -0500
Received: by mail-yk0-f177.google.com with SMTP id 9so833721ykp.22
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 17:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=AsyZlMxXdFjTi7Vuo6sYl+dsSuRRSEs9VLfjgaYiwGU=;
        b=tehHC90+9tAhI9JpSmT5hrRrTXcMiNwmdfV0qm57eB9CcpPug8S9L/R+Zx05Zhko5R
         WjC8zQED8Bi1GpaTPuUPUJyeigq//3aKbAcH8/bWWVBtjmc+SIQi9/30hMyQTFZaIlZB
         pky9k4U2ZGe6SZrPGh0tcpTNhRbvcr8Wc9wLq8G/Wzn6Ib9xmWWV1f4rRIl5thGzvu2f
         mVoKwo5iSr0EGq04bvmM+os574oIXv0hjLFXzAMlsnkfPgxVA6sgGxXDn8ZwbwW2uDah
         ra6de/B5AJ04yPXECmgVNa8RTUzXarX2AX/i1ZG5M6swBstoimu7x4RQUj1q3aJqYG+D
         VpkA==
X-Received: by 10.236.53.69 with SMTP id f45mr28652248yhc.65.1416965118795;
 Tue, 25 Nov 2014 17:25:18 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 25 Nov 2014 17:25:18 -0800 (PST)
In-Reply-To: <78f25aaa60554f7e3b917c565df0f89fb9c08921.1416955873.git.oystwa@gmail.com>
X-Google-Sender-Auth: CSXivEcvtgHxGRBIjbzune-RzyE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260261>

On Tue, Nov 25, 2014 at 5:51 PM, =C3=98ystein Walle <oystwa@gmail.com> =
wrote:
> Signed-off-by: =C3=98ystein Walle <oystwa@gmail.com>
> ---
>  t/t7503-pre-commit-hook.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/t/t7503-pre-commit-hook.sh b/t/t7503-pre-commit-hook.sh
> index 984889b..99ed967 100755
> --- a/t/t7503-pre-commit-hook.sh
> +++ b/t/t7503-pre-commit-hook.sh
> @@ -24,8 +24,7 @@ test_expect_success '--no-verify with no hook' '
>  HOOKDIR=3D"$(git rev-parse --git-dir)/hooks"
>  HOOK=3D"$HOOKDIR/pre-commit"
>  mkdir -p "$HOOKDIR"
> -cat > "$HOOK" <<EOF
> -#!/bin/sh
> +write_script "$HOOK" <<EOF
>  exit 0
>  EOF
>  chmod +x "$HOOK"

You can drop the 'chmod' too since write_script does that for you.

> @@ -47,8 +46,7 @@ test_expect_success '--no-verify with succeeding ho=
ok' '
>  '
>
>  # now a hook that fails
> -cat > "$HOOK" <<EOF
> -#!/bin/sh
> +write_script "$HOOK" <<EOF
>  exit 1
>  EOF
>
> @@ -88,8 +86,7 @@ chmod +x "$HOOK"
>
>  # a hook that checks $GIT_PREFIX and succeeds inside the
>  # success/ subdirectory only
> -cat > "$HOOK" <<EOF
> -#!/bin/sh
> +write_script "$HOOK" <<EOF
>  test \$GIT_PREFIX =3D success/
>  EOF
>
> --
> 2.2.0.rc3
