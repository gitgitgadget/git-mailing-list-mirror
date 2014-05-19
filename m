From: Philippe Vaucher <philippe.vaucher@gmail.com>
Subject: Re: bug: autostash is lost after aborted rebase
Date: Mon, 19 May 2014 09:40:23 +0200
Message-ID: <CAGK7Mr6nMD5Q9ptvuWk9BRKwhEhtRdANSC5G=m3=2V2HgJYG4g@mail.gmail.com>
References: <20140519005719.GB38299@tequila> <CAGK7Mr532G+OSXLf4HAbWoJxV2fOvxnVQXC4nV9ciPsU4JR5bA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Karen Etheridge <ether@cpan.org>
X-From: git-owner@vger.kernel.org Mon May 19 09:40:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmIBu-0005GO-GF
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 09:40:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbaESHkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 03:40:55 -0400
Received: from mail-ob0-f178.google.com ([209.85.214.178]:42595 "EHLO
	mail-ob0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750852AbaESHky (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 03:40:54 -0400
Received: by mail-ob0-f178.google.com with SMTP id va2so5695767obc.37
        for <git@vger.kernel.org>; Mon, 19 May 2014 00:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wMC4zy0RkBTxsi46fFDEFqrFJhSyypvA8+ioBNirqTk=;
        b=f64GTFHZlQDSRvdKC4+ZBkpYNaZJtKlqh43dejmA3fFYn9pu5InDToK1xk1S72c1SA
         UTXjN0/swPgAP4TvjkXies+yWQpzMNaxdNeT/RFW1BoJJ3gqX22HzCSj/LgjARnNxH/v
         hfIYLqrNeotdrBclSpR38883J3NzEdY5ooWQIVwaNLcorWAwvWmBopgF2skIVIeKhQgz
         78YFdGMXAXne9pObzcXMFhhcPhnlWBEIwEePucytXBKCgfKhUwUiEc3zay6rP6RhyIYs
         NNx7hD9S2qVtXYcEXwxeVRMxHKod85nML8Ih29+VLGmBvOpMaMFLdLk4vF/tC0+VOaGl
         VytQ==
X-Received: by 10.182.246.40 with SMTP id xt8mr1125797obc.76.1400485254064;
 Mon, 19 May 2014 00:40:54 -0700 (PDT)
Received: by 10.76.76.228 with HTTP; Mon, 19 May 2014 00:40:23 -0700 (PDT)
In-Reply-To: <CAGK7Mr532G+OSXLf4HAbWoJxV2fOvxnVQXC4nV9ciPsU4JR5bA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249563>

> scenario:
> - edit some tracked files; do not add them to the index
> - "git config rebase.autostash true"
> - "git rebase -i HEAD~3" (an autostash will be created)
> - delete the entire buffer and save/exit the editor - this will abort the
>   rebase
>
> poof, the autostash is gone (it is not reapplied) -- it must be explicitly
> applied again via the SHA that was printed earlier.

Yes, I hit this often and it's annoying in "sausage making" workflows.
Thanks for reporting this issue, I don't know why I didn't think of
reporting it myself :) It likely affects a large portion of the users
who like to set `rebase.autostash` and rebase.autosquash` in their
config, but for some reason they didn't think of reporting it either.

Philippe
