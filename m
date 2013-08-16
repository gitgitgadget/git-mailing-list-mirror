From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] rebase -i: fix cases ignoring core.commentchar
Date: Fri, 16 Aug 2013 17:55:33 -0400
Message-ID: <CAPig+cTRc1-W7vJX52gb5S0ge4kZgKMBkHJjqWFRDgpuzTfM2g@mail.gmail.com>
References: <1376689447-78807-1-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Ralf Thielow <ralf.thielow@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 17 00:23:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VASQo-0006l0-6W
	for gcvg-git-2@plane.gmane.org; Sat, 17 Aug 2013 00:23:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754107Ab3HPWXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 18:23:38 -0400
Received: from mail-la0-f51.google.com ([209.85.215.51]:52903 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960Ab3HPWXh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 18:23:37 -0400
Received: by mail-la0-f51.google.com with SMTP id es20so1972147lab.10
        for <git@vger.kernel.org>; Fri, 16 Aug 2013 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=GwVX+laJ1IcxaPE013cByeqaQaTtA6Qcu5F0JDDEjV4=;
        b=OQqK94pfidY6p2xrN48hrHNb3jGYKQ4lAX8fi4hehepxMZxCWjAAb8uiz4o1k+7COq
         /CBFTBXZOLhea398t9aR4M59tP3L9XF1Yvb9KMQN5u99UkiTo+29wrq+fLyeQr0E61mf
         6Tb4r2Hy5iP4eYm44MBCeDp6SR9DxC1bz4xDKibkkn/FvdJVlGI1eHh3AOs3OBrtB4u0
         aYjBirGNexkfml68kRPx2Iqa8r5Dz5gzujijaJpGoF+mJV/e6Mch06yi4jhjR5y8wN2z
         NpWuLozQFODW3lcdqp30RMOdHzHM81XvdFF/v4XPJ1Sz+ddiFzlWR3sR35MVJYylcxc7
         Lqkw==
X-Received: by 10.112.72.229 with SMTP id g5mr3972073lbv.10.1376690133795;
 Fri, 16 Aug 2013 14:55:33 -0700 (PDT)
Received: by 10.114.182.236 with HTTP; Fri, 16 Aug 2013 14:55:33 -0700 (PDT)
In-Reply-To: <1376689447-78807-1-git-send-email-sunshine@sunshineco.com>
X-Google-Sender-Auth: EcOTeV1heZkTMzwJVBfBqoXqTxo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232441>

On Fri, Aug 16, 2013 at 5:44 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> eff80a9fd990de36 (Allow custom "comment char", 2013-01-16) added general
> core.commentchar support but forgot to update git-rebase--interactive to
> respect it.  180bad3d10fe3a7f (rebase -i: respect core.commentchar,
> 2013-02-11) addressed this oversight but missed one instance of
> hard-coded '#' comment character in skip_unnecessary_picks(). Fix this.
>
> 9a46c25bdbf79744 (rebase: interactive: fix short SHA-1 collision,
> 2013-08-12) added another instance of hard-coded '#' comment character
> in transform_todo_ids().  Fix this, as well.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>

I forgot to mention that I wanted to add tests to t3404 for these bugs
but couldn't figure out how to do it using the external behavior of
rebase -i. I was able to verify the before and after behavior by
adding temporary echo's to the code in order to observe the "internal"
functioning.
