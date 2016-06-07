From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 1/4] diff.h: extend "flags" field to 64 bits because we're
 out of bits
Date: Tue, 7 Jun 2016 07:40:18 +0700
Message-ID: <CACsJy8AVzWBsDhzj+UJo9AbSi0f=jrAyrLZ9sU=VBP3woFXr0A@mail.gmail.com>
References: <20160606111643.7122-1-pclouds@gmail.com> <20160606111643.7122-2-pclouds@gmail.com>
 <xmqqfusqw17r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Thomas Braun <thomas.braun@virtuell-zuhause.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 02:40:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA54f-0001Xm-RX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 02:40:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753555AbcFGAkt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jun 2016 20:40:49 -0400
Received: from mail-it0-f44.google.com ([209.85.214.44]:36945 "EHLO
	mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752347AbcFGAkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2016 20:40:49 -0400
Received: by mail-it0-f44.google.com with SMTP id z123so59945501itg.0
        for <git@vger.kernel.org>; Mon, 06 Jun 2016 17:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=SunpvLSq/njFGKw8AI8UwfMQ5cvHPUjrGv8tUtpmtOI=;
        b=SqDFEAImt57zrJl271pz8vggAza+nPZrUyDYACuPAWSZQKXowjvGvULLFcTkQL858f
         Ji+AaCuA2dIgFuDnl8dB39oGJQ0wM+EYdbiQfrTofPxbm/5DJTgCfq6HTDrkv8UNctjR
         h/KvN3/lJ/MIcH7TrcJQF0bV63w7moaPKiprg5Tz8CdsLKi0JqJhp3WNwJCltBt1YNVQ
         kWAf+Ekeg8hh30wmaja0YrL8+rkymDq89BS7Q1veY2KPDHQxNyeViP6H7OZ1GxYt8MGK
         vqvO09PKG9Bl16br6Yh7lFb2tLOe4nV3rNYpDOWVoSeVd3hqLm/hVtEu5tjgu6gWzCmE
         C5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SunpvLSq/njFGKw8AI8UwfMQ5cvHPUjrGv8tUtpmtOI=;
        b=fDchROKWLkuXlCKDrbr2d8k5bc9C0PBsDzqrzA/0PUBz212VyvSmkQ1tvySojASx8E
         lqplJYGBcLk8krBUqF5kH6m4Bwy/BsnUyFwhxT55ecooLL+7SgXQKh/Yuq+vGaqtvjJQ
         w7vFy7z52jZ00Kma3khT9l/bsISErX6oPRC5qSKvooJXatL8geIfTwRe14Lw3mFgFTcW
         nKniAvXxPa2N4pIdS1Oy4h3ZEA9KUeSR+HMiecg+qBWolzU9LRLvNeOsYcgkP3AfRefa
         qPXpMIXyIh0hCGDF7llHvqlA2xVHbO2eWw4gSUNKX/xMdStZOYSnGapy9WGbKJE4hSLv
         rjPg==
X-Gm-Message-State: ALyK8tKZT7Drsax90vfOSrxGbz1MGRxWEw9ooGvi7NVskKP+sEuLV1e6z36XNnM3GGqtlOtnvdyBHf2KkwvqXg==
X-Received: by 10.107.159.84 with SMTP id i81mr24515569ioe.29.1465260047757;
 Mon, 06 Jun 2016 17:40:47 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Mon, 6 Jun 2016 17:40:18 -0700 (PDT)
In-Reply-To: <xmqqfusqw17r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296581>

On Tue, Jun 7, 2016 at 2:45 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> Current flags field is 32-bits, all used except one bit and we need =
one
>> more bit is needed for to toggle i-t-a behavior. The 9th bit could b=
e
>> reused for this, but we could just extend it to 64 bits now to give =
room
>> for more future flags.
>
> Isn't it a better option to add new things as separate words (or a
> separate bit:1 field)?  Is this 32nd thing envisioned to be added
> going to be used everywhere like the existing flag bits, or can it
> be handled like "use_color", "break_opt", "show_rename_progress"?

It could probably live as a separate bitfield, or an int. What scares
me is "flags" sometimes is backed up then restored, but it's probably
ok. But we need to extend this "flags" eventually, don't we? I don't
think people will stop adding new  DIFF_OPT_ flags.
--=20
Duy
