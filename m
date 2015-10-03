From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v8 0/7] git-p4: add support for large file systems
Date: Sat, 3 Oct 2015 17:27:33 +0100
Message-ID: <CAE5ih78tsDe-RAUOEjrGMBJU0sage37V1sL9QLPZhRQhb5GUCA@mail.gmail.com>
References: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 03 18:27:44 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZiPex-0000sv-E6
	for gcvg-git-2@plane.gmane.org; Sat, 03 Oct 2015 18:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbbJCQ1e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 12:27:34 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:35345 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752204AbbJCQ1d (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 12:27:33 -0400
Received: by obbzf10 with SMTP id zf10so102434674obb.2
        for <git@vger.kernel.org>; Sat, 03 Oct 2015 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=r8eBiLW1aZYTZcVyLm1jYqlvkWHxI7XDcRunVoui1yU=;
        b=BStv8Mhvj20ZvsM0nS21djGLfAcaTRJKsBAyP2VbLoIihESH0Yp4ukBFMNgS5c4dtr
         0Y3rdZ0uFspaH6F89bDqL8ELIIXiVAzvrJulx4DTWrxY4Eq+QBM4OU6tVUgSyRQ2auiZ
         VTxqz4YUfYOTNOlbZG2gvdmWjJFAnjycwwQ44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=r8eBiLW1aZYTZcVyLm1jYqlvkWHxI7XDcRunVoui1yU=;
        b=N9VFoVDk0ACJ3bT2b2PAWz9tos2cw4ZA5DCOAcI5fI1oR9OiwfhgYCkB8bFE0fSrUU
         rMrMrBp7x1tYFen1HhnQ8TKqrlmOTsyfz4e2hLwrlKw3H4MXy1BEl+b7RxTskN4FLWmB
         SfNsX6p8xHmz2+WFlQD+yYmR7h0t8aSgKU7lmTpjeViSyLxI5Ay4jsygauuJTPvGPv/0
         5T6BQlo3+nyRtgsOia4gfYyxtxzLt4ml4k8vCUH2+K7NRwNnXuuD/isEGt+meu99YoFd
         ZzRHTisFPo2BHlUbMEoiRr+rpbCiXmOAS69vds6M5VBZhJxqV2vTYASXW1bWz3OQCLiL
         Ih/w==
X-Gm-Message-State: ALoCoQnBeVcTpj6h8k6Gzx5LiqYQhT0Tz4aA1Ixq7WE98M/NGUtnfQd6zMhHzEjkcQBIcr47wX8O
X-Received: by 10.182.221.134 with SMTP id qe6mr12235548obc.56.1443889653087;
 Sat, 03 Oct 2015 09:27:33 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Sat, 3 Oct 2015 09:27:33 -0700 (PDT)
In-Reply-To: <1443254104-14966-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278973>

On 26 September 2015 at 08:54,  <larsxschneider@gmail.com> wrote:
> From: Lars Schneider <larsxschneider@gmail.com>
>
> diff to v7:
> * fix commit message line length (thanks Junio)
> * fix sync command for large file system support (thanks Luke!)
> * add test case for sync command
> * rename git-p4.pushLargeFiles to git-p4.largeFilePush for consistency with
>   other git-p4.largeFile* configs
> * fix relative path handling for clone operation which caused a crash in the
>   disk space check and t9819 (thanks Luke!)
> * use test_path_is_missing instead of !test_path_is_file (thanks Luke!)
>
> The patch is again based on maint (ee6ad5f) as patches v1-v6 before.


All looks good to me, Ack.

One tiny thing perhaps Junio could comment on: the git commit message
for 75abe9fa5b39980de27dfc33dd5b4f4b5926f34c, "git-p4: add optional
type specifier to gitConfig reader" uses what looks like UTF-8 encoded
left and right quotes, rather than regular ASCII quotes ("). I don't
know if that matters.

Thanks,
Luke


>
> Cheers,
> Lars
>
> Lars Schneider (7):
>   git-p4: add optional type specifier to gitConfig reader
>   git-p4: add gitConfigInt reader
>   git-p4: return an empty list if a list config has no values
>   git-p4: add file streaming progress in verbose mode
>   git-p4: check free space during streaming
>   git-p4: add support for large file systems
>   git-p4: add Git LFS backend for large file system
>
>  Documentation/git-p4.txt   |  32 +++++
>  git-p4.py                  | 270 +++++++++++++++++++++++++++++++++++++++---
>  t/t9823-git-p4-mock-lfs.sh | 192 ++++++++++++++++++++++++++++++
>  t/t9824-git-p4-git-lfs.sh  | 288 +++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 766 insertions(+), 16 deletions(-)
>  create mode 100755 t/t9823-git-p4-mock-lfs.sh
>  create mode 100755 t/t9824-git-p4-git-lfs.sh
>
> --
> 2.5.1
>
