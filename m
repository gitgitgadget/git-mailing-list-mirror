From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 80/83] run-command: make dup_devnull() non static
Date: Sun, 8 May 2016 17:15:53 +0700
Message-ID: <CACsJy8DUcLWQ6AwyLE+CF+TxZtqDLS=82peizSf4TrZ3q=qjJg@mail.gmail.com>
References: <1461505189-16234-1-git-send-email-chriscool@tuxfamily.org>
 <alpine.DEB.2.20.1604251704300.2896@virtualbox> <CAP8UFD2f1L3YKNBA4zP1bmGe8BQitxZp-aDsGP5UTDv06LbLBg@mail.gmail.com>
 <572BA80E.3000309@kdbg.org> <CAP8UFD35L8P2YJbbvg_-n9Nc61xMs+_2qBJwBxFzXeF-jA4WwQ@mail.gmail.com>
 <alpine.DEB.2.20.1605061733170.2963@virtualbox> <CAP8UFD0ht+ozCMguGwBc19dd9ViXG4tTE0mdaOQ+JVXhSOk02Q@mail.gmail.com>
 <alpine.DEB.2.20.1605071409490.2963@virtualbox> <CAP8UFD2wFZgOzmadm7X2988RyDGve92TsoMHPf2S5Ydyhc=Nyg@mail.gmail.com>
 <alpine.DEB.2.20.1605080811380.4092@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun May 08 12:17:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azLlb-0001kg-4V
	for gcvg-git-2@plane.gmane.org; Sun, 08 May 2016 12:16:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbcEHKQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 May 2016 06:16:26 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34700 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750698AbcEHKQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 May 2016 06:16:25 -0400
Received: by mail-lf0-f65.google.com with SMTP id m101so18013831lfi.1
        for <git@vger.kernel.org>; Sun, 08 May 2016 03:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=lu2WuGLWD/X2SqKzF9s4ulOpA6vIZqmT8n5sPEH13b8=;
        b=c45M1hnb+ieHqLgY10n0qMOAvZsOZeZopCPXPKSynd/3jPwGU0b4kfCW3NQqLKh+GZ
         P+QutnmoHQHnVp7GLZD91baAM5TU9Ox52W+oOZp6pGFWYBiDsBJ6oZZm3XLoUWNXMijA
         /vCuGYGD9p1JXtqK2tnZgE01Nh5vWYB8k/KzBMwVno/C9rkjLdt/2LyeSg2ZBpVSdHb9
         cm/bhb2xtiZ1zGKircOnUFT0EkqlkPUrX7pSrjvBPEF+6wjuTy43n/hSddx8lkCXB36e
         6gyMAhJCkuVcoQgNqaewHp8noMsPqainVTVm5XcE8xeZcmdaeN1IzlATukzs1cCNNzTI
         HPDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=lu2WuGLWD/X2SqKzF9s4ulOpA6vIZqmT8n5sPEH13b8=;
        b=LXIHrl7TDJ9jPohIJrHIngv4dpZl2fTp3Ll+pZ0aZB7ZU5nlvB05s3IB+ZOgKCuB9b
         FfJRYIJk0LAJoueiWzpHPnEzOqsMiScP/KaKNgX491fhiENTL5ZRA4MPAySgCHWuqi/V
         9oMUXHm0vRK0i6MNiAmJjxKRurbbpxjlEvMCPdv62NW3J8HAfP40uNoDhM+22klRtRnn
         qTLCGrSA0xbDZHXOWcRltbzTFLH3mHso05rFvYKLe/gDPehCkwT7e7uKKqHrYSNL4bib
         ZuBSMCKV1zjC6QY7U39/od2I6/HKIfEugSKjblH+KvtxVsjt/DV2zMKdVxTkMd/WQeNx
         Fafw==
X-Gm-Message-State: AOPr4FViFzoe9v5givvEdv45gEMo+TJmpB+aBenZuE4ubfgqvQM1V88zgYjdxUlDP6+eekWhy9AgtoE/Eit4yA==
X-Received: by 10.112.170.106 with SMTP id al10mr2133465lbc.12.1462702583191;
 Sun, 08 May 2016 03:16:23 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Sun, 8 May 2016 03:15:53 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1605080811380.4092@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293959>

On Sun, May 8, 2016 at 1:33 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> The claim is that this libifies the procedure. But it makes the code
> really nasty for use as a library: if this is run in a thread (and you
> know that we are going to have to do this in the near future, for
> performance reasons), it will completely mess up all the other threads
> because it messes with the global file descriptors.

I vote one step at a time, leave multi-thread support for future.
There's a lot more shared state than file descriptors anyway, at least
there are object db and index access and probably a couple of hidden
static variables somewhere. And I'm not sure if multi-thread really
helps here. Are we really CPU-bound? If object inflation causes that
(wild guess), can we just inflate ahead in some separate process and
pass the result back?
-- 
Duy
