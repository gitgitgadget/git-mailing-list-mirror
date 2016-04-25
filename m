From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 63/83] builtin/apply: make apply_all_patches() return -1
 on error
Date: Mon, 25 Apr 2016 20:30:55 +0700
Message-ID: <CACsJy8CRiAhHqYDrJifhfarqzarEnuuJm4rw18zxnC9xaBwKNw@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:31:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1augbw-00047s-3T
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 15:31:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932573AbcDYNb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 09:31:27 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:35667 "EHLO
	mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932428AbcDYNb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 09:31:26 -0400
Received: by mail-lf0-f54.google.com with SMTP id c126so116989150lfb.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 06:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2T1rBTg+LBcDC4BFy10zk0H03X8IPltuF1lUP2jpE1I=;
        b=dVJynpA7O0XCODTMXnO/nTU8da75wPiS6saDhM5G6l7BgDj1sRDLzEHEKQ2yesLPY/
         EyHH57SbVrObwUUeIDbDjE7yBzeUbNDx+KKK6yRMduA7cO46sr7AXu8yFgNFiR21qDZZ
         Ye/4YfJzwnwZfPa0/SkQ15/i/BF7kTgZ4SK29U+FsX1LeJoBzvoPG8Fj4TaYvKf5jGvv
         EI/XvLxree9ykRowY5mnnmLO5Yp0/HnBXLvFquHhw89vG//kxoHrWWhDg3IEU2aD6Juo
         uLv1Qd+l5Qk8ybcR6k37XbKM4W671+Jev75hKi6ho/q++ufHpknO7zsj8/A6UWxitQ9E
         Onwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2T1rBTg+LBcDC4BFy10zk0H03X8IPltuF1lUP2jpE1I=;
        b=aHUnpHBlpuBIPxSXTZAz51CIHfHZCatESfeqvzcliXVo9kY73S3nCl/B3F7+ZXMx78
         GOP7NJcehDNZmt5q0aVXkN5HdSlNajzE73nwvZmqF83zGMSNtrESkKUr0WDelgmuArkE
         FmxbIwiYxhG0ptVvVpUZt70DEZtxpKHvfi/5WeioD+hcB/qy9epQydo3u54rZWLhsA3f
         dHmNGV4T5BqYhLRbK6mM7qW1nK3uOTkcyaACO/6yvInfI9FOhELHfuZc35wGbR8cCnWr
         YquQoziw9N/0pD6u3UP5o3FUEQ/jFh6QlAsDP3NmXt2JMMF1bcUQGzFJiXxvVBqO3BtF
         KxtQ==
X-Gm-Message-State: AOPr4FXFpI0WX2a0mgO7mvGk5bNAdNTKkNV02hdbkLrFLecnwLOyPO/gOzBArfXhhsLyM6UJ+ds6QRLfA4vIgg==
X-Received: by 10.25.23.155 with SMTP id 27mr9613333lfx.3.1461591084805; Mon,
 25 Apr 2016 06:31:24 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 06:30:55 -0700 (PDT)
In-Reply-To: <1461504863-15946-64-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292476>

On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
>         if (state->update_index) {
>                 if (write_locked_index(&the_index, state->lock_file, COMMIT_LOCK))
> -                       die(_("Unable to write new index file"));
> +                       return error(_("Unable to write new index file"));
>         }
>
>         return !!errs;
> @@ -4698,5 +4698,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
>         if (check_apply_state(&state, force_apply))
>                 exit(1);
>
> -       return apply_all_patches(&state, argc, argv, options);
> +       if (apply_all_patches(&state, argc, argv, options))
> +               exit(1);

Abusing exit() too much? This is cmd_apply(). A return should be
enough and you can do the !! trick that is used in
apply_all_patches(), shown just a little bit above.

> +
> +       return 0;
>  }
> --
> 2.8.1.300.g5fed0c0
>



-- 
Duy
