From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] pre-commit hook updates
Date: Tue, 25 Nov 2014 20:32:27 -0500
Message-ID: <CAPig+cS76GWES3hXF4Bdjg5G7QFcTKhzLyjM55LPMSD0zEinPQ@mail.gmail.com>
References: <cover.1416953772.git.oystwa@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?Q?=C3=98ystein_Walle?= <oystwa@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:32:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtRT6-0000zZ-Sg
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751146AbaKZBc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Nov 2014 20:32:29 -0500
Received: from mail-yh0-f52.google.com ([209.85.213.52]:42465 "EHLO
	mail-yh0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750864AbaKZBc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Nov 2014 20:32:28 -0500
Received: by mail-yh0-f52.google.com with SMTP id z6so857910yhz.39
        for <git@vger.kernel.org>; Tue, 25 Nov 2014 17:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=b/NtbtkzpphOpdD+sbvhO1vGC/Y9Dd3sq9LX7hKiZMM=;
        b=hM79idcDjTX2HeA6i08RVetAwSlhik8KENLjMH6OlMc+6TOclFAuBG8TpHmvc+3Yr8
         GEvGxXE4dj0fThSeWckAgrDYsvPUuPtA05EnPA/LYwqNHB2b6+vtrBwWMpPCYLTNvmlj
         Borx9kyZvppEbvS8II9xklOHozHO6GPPfvXgVrvnO/NjqfShr5k/BrrnGHYTwoHVTYJu
         pmd4hptehBbNZL2EHinoWcSU76UjoE5pZqnw5VY1GV0ZStFFmBUJ+yutbvCB/8ohbVm6
         xGhyfR6dBRU3P9kbPY1bSGDGemmZL6TZbcoWOHOq7AF0d2+3wK40ChYJdVS6KteLRC3x
         BETg==
X-Received: by 10.170.128.207 with SMTP id u198mr30726407ykb.51.1416965548049;
 Tue, 25 Nov 2014 17:32:28 -0800 (PST)
Received: by 10.170.68.68 with HTTP; Tue, 25 Nov 2014 17:32:27 -0800 (PST)
In-Reply-To: <cover.1416953772.git.oystwa@gmail.com>
X-Google-Sender-Auth: 1wMzaYVkzvI2dOYJgVDk6WyQhno
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260262>

On Tue, Nov 25, 2014 at 5:51 PM, =C3=98ystein Walle <oystwa@gmail.com> =
wrote:
> The first patch changes t/t7503-pre-commit-hook.sh to use write_scrip=
t
> everywhere, as was suggested by Jeff King in the discussion of the
> previous patch.
>
> The second patch is v2 of the patch I sent earlier. I've incorporated
> Eric Sunshine's suggestions. I didn't do enough digging; I found
> test_expect_failure and assumed this was test_expect_success's twin
> brother, but it marked stuff as known breakages so I went with the '!=
'.
> I also found it a bit strange that test_must_fail has a different
> signature (to the extent a shell function has one at all). Is my use =
of
> test_must_fail correct?

Your use is not correct (as I'll explain when responding to the patch).

> I agree with Junio Hamano that it's better to provide no argument at =
all
> rather than an empty one. I also agree with Jeff King that "noamend" =
is
> better than an empty argument. I went with the second one since Jeff
> seemed to get the last word :)

=46or what it's worth (probably not much), I agree with Junio.

> I'm not sure I like the ternary inside the function call like that, b=
ut
> I went with it because it gave the smallest footprint (which is proba=
bly
> not a good argument). I suppose I could have done:
>
> if (amend)
>         hook_arg1 =3D "amend"
> else
>         hook_arg1 =3D "noamend"
> ...
> ... run_commit_hook(use_editor, index_file, "pre-commit", hook_arg1, =
NULL);
>
> or create a hook_amend variable.
>
> I'm happy to send a v3.
