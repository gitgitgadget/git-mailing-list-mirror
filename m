From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 1/3] pretty: expand tabs in indented logs to make
 things line up properly
Date: Tue, 29 Mar 2016 20:17:24 -0400
Message-ID: <CAPig+cTd_VRnikMzN7b2qfeG87M0v-4_qM42MkhOcRT54Wmv=Q@mail.gmail.com>
References: <1458775426-2215-1-git-send-email-gitster@pobox.com>
	<1459293309-25195-1-git-send-email-gitster@pobox.com>
	<1459293309-25195-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 30 02:17:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1al3pC-0004ak-Iy
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 02:17:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbcC3AR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 20:17:26 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33852 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbcC3ARZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 20:17:25 -0400
Received: by mail-vk0-f66.google.com with SMTP id e6so4441441vkh.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 17:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=S5XZUVCun7spHNnqOh3ktJ+EJckW7cUAoS19bwRvb84=;
        b=uxyNbgTpxCs7E6RsIV4LiBieAK0Rn+9keCa/yg8Xh8j4QmWIbKSxqIyI95rhZ1Br7s
         nkseF8SrueMuyTaZKE84VhIOqidC9OpNWSHbcY73kYcnd5ro2P2SHSvZj5nxhSlUA4Nv
         xkr66tPiGNiWx0pcgKov0t2FvpcS9qI9X1Qpuoo71d/zKygCc/lZsn+xqwkOM/zVBGJL
         3VaeOIOGNROzyexVrGMmcNLaSVickYEvU/9aYbf8SxWftsUZwqQVbMWAkFRKsUHtSMFF
         GGLXhLYQZq2qyHn4sFu7acb2r6q/zmjRF1r+kj64MCPoYPqba+lH3XbimWLOWf2PqFYv
         aj+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=S5XZUVCun7spHNnqOh3ktJ+EJckW7cUAoS19bwRvb84=;
        b=ZlJJy1KQ0IpHQgIYPafSwnGhJEpAYFXwQakEVokTr1De/ShV9OTQKP8hHaevRKT3Pp
         JPoCu7AGCxHueVEKv96RB9NZEl8fhd13/jWRG4TgiN/43sfzWLoRtqRaxQlJ0NssWWZr
         fv1T8OuQNbKgCdVAFbPU7oOnLZIfAylRcQCwlh4ULuU/+TMP+uJsYjGYXw1LUEvrwmvb
         tl7vjjpN9VqjX1+hrIPQojKFvJmE/iz8wOU0gDeGC9XOOu2HaqZANX+ZA3BNpobPEWrK
         MCfdUm5kkyzhjZo6TalkCuYRIqHIyVNnjQMUppGOTCDjSwVlfyk8T/Uj8VdgR8+7V+kv
         Ah6Q==
X-Gm-Message-State: AD7BkJJa6TVpBD8iydZULnevBgciEL1arqXVPB2HNKQ1c8GqYAdKQymF8dKfgnuhe5NV70EZjpq5s9WhYZbT5w==
X-Received: by 10.159.37.234 with SMTP id 97mr3020314uaf.99.1459297044458;
 Tue, 29 Mar 2016 17:17:24 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Tue, 29 Mar 2016 17:17:24 -0700 (PDT)
In-Reply-To: <1459293309-25195-2-git-send-email-gitster@pobox.com>
X-Google-Sender-Auth: pOKOIjY8sS5_4Pgj9vTRKs34bpY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290231>

On Tue, Mar 29, 2016 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> A commit log message sometimes tries to line things up using tabs,
> assuming fixed-width font with the standard 8-place tab settings.
> Viewing such a commit however does not work well in "git log", as
> we indent the lines by prefixing 4 spaces in front of them.
> [...]
> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/pretty-options.txt b/Documentation/pretty-options.txt
> @@ -42,6 +42,12 @@ people using 80-column terminals.
> +--expand-tabs::
> +       Perform a tab expansion (replace each tab with enough number
> +       of spaces to fill to the next display column that is

Nit: "enough spaces" or "a sufficient number of spaces".

> +       multiple of 8) in the log message before using the message
> +       to show in the output.
