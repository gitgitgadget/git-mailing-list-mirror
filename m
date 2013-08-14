From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 18:49:58 +0200
Message-ID: <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
References: <520BAF9F.70105@googlemail.com>
	<1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, iveqy@iveqy.com,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 18:50:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9eGs-0006Xs-5x
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 18:50:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932877Ab3HNQt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 12:49:59 -0400
Received: from mail-qa0-f47.google.com ([209.85.216.47]:58710 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932789Ab3HNQt7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 12:49:59 -0400
Received: by mail-qa0-f47.google.com with SMTP id o19so1136213qap.6
        for <git@vger.kernel.org>; Wed, 14 Aug 2013 09:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1xudSw09olHPaiEp5rgj9wMaGtGU7g8AEAdSRwCnfv0=;
        b=XsyLo++CF749PWbjU3UKn9Np5kmkYVp7jh1liXnjGlC7KBU4cd7FC9I6XS+ijcbeSL
         I9V3l/JSMHSgL37pUSuUtgk5UjzPrkDXS9Evbb/LWeAMG/oBq/fVqULEgxKfbbGZtlpY
         nGB6+trz3s8RisL86VBI/vgpbyupKT0Vj9JYzlUQGtr+8v3sG4zK1hXtEs2NGjXhzuX5
         kM2JvmSu8g7XyYKnlDOVmUrAbWpq12EJcvASLwfEyEG/eWHPx5BXMXziDrhRprcknsAy
         nkb5bprh/+0UqiE7Bg5jXW8SCtThXcGvpENI/CugrwLh890xDyZmXN7rUGAFr/ynQAZ9
         3nBA==
X-Received: by 10.49.35.241 with SMTP id l17mr10154189qej.56.1376498998091;
 Wed, 14 Aug 2013 09:49:58 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Wed, 14 Aug 2013 09:49:58 -0700 (PDT)
In-Reply-To: <1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232295>

On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
<stefanbeller@googlemail.com> wrote:
>  builtin/repack.c               | 410 +++++++++++++++++++++++++++++++++++++++++
>  contrib/examples/git-repack.sh | 194 +++++++++++++++++++
>  git-repack.sh                  | 194 -------------------

I'm still not sure I understand the trade-off here.

Most of what git-repack does is compute some file paths, (re)move
those files and call git-pack-objects, and potentially
git-prune-packed and git-update-server-info.
Maybe I'm wrong, but I have the feeling that the correct tool for that
is Shell, rather than C (and I think the code looks less intuitive in
C for that matter).
I'm not sure anyone would run that command a thousand times a second,
so I'm not sure it would make a real-life performance difference.

Last and very less important: I think it's OK to format-patch with -M,
especially when you move a file.

Cheers,
Antoine
