From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 4/6] stash: introduce 'git stash store'
Date: Mon, 13 May 2013 23:39:06 +0530
Message-ID: <CALkWK0nmDopEVArofKt42u5JHRBXmGiHP051jhMxtaihWLu95A@mail.gmail.com>
References: <1368449154-21882-1-git-send-email-artagnon@gmail.com>
 <1368449154-21882-5-git-send-email-artagnon@gmail.com> <7vbo8fosd9.fsf@alter.siamese.dyndns.org>
 <CALkWK0kMj6q1rppzfxGWrthub4K_+C+jnvF=K4m2Fhk0pAnt7A@mail.gmail.com>
 <7v61ymop61.fsf@alter.siamese.dyndns.org> <CALkWK0mQhzrndaEp28nOpLs5STq136PY8hntCpX5RUZKrdJVAA@mail.gmail.com>
 <7vppwun5zk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 13 20:09:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbxC3-0000g9-GD
	for gcvg-git-2@plane.gmane.org; Mon, 13 May 2013 20:09:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753316Ab3EMSJr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 May 2013 14:09:47 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33139 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752114Ab3EMSJq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 May 2013 14:09:46 -0400
Received: by mail-ie0-f181.google.com with SMTP id x12so12826417ief.40
        for <git@vger.kernel.org>; Mon, 13 May 2013 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/D52Z2fgUnzB1rpHTILf7qhZzwpTWcQyLAxRkDKjl/k=;
        b=ZvcOLzhpUWqrx84Og4ro2j3Aw7aba1sQyzGTOP9fQjq42Hb9hdvQ0AVFIHZnKq0bCE
         yQZktjzsPWNecNRiQbIOx8XPgUXj0pwYPE3j5yIOkGtQ4x1NGdzyqSwHUh+N1y7NYXUd
         fU3sp1WJVpGnxRLKJGSOHjVhi5o2/oi4h91690N4lfkxmag8QaLzK85gfQ2rv2DrUSev
         +68vSNPFFy0jOc6tZM3YUq8T0mQCS2pVXe50E41QpjZCn+4chSejNwJcdZjL37RbF7ys
         5H0oVins+cswsL0GaKfMyQ8DYhg0qoHwdd9IVUe09r0DmBQLYRXGvjuXI5f3+Y+/PMbS
         azYw==
X-Received: by 10.50.66.140 with SMTP id f12mr10629869igt.63.1368468586428;
 Mon, 13 May 2013 11:09:46 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Mon, 13 May 2013 11:09:06 -0700 (PDT)
In-Reply-To: <7vppwun5zk.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224183>

Junio C Hamano wrote:
> I however suspect that you would regret later when you need more
> customization.  It already happened once for "git merge" when it was
> an internal API for "git pull" and it was painful to support saner
> interface and the traditional one at the same time [*1*].

Oh god.

  git-merge --stat --progress "$merge_name" HEAD 04c5b83c46760573

We made a design mistake at the command-level in merge.  This is at a
subcommand-level.

1. Will git stash store ever be more than a one-liner?  Can you think
of how this function could be larger?

2. Will git stash store ever become an interactive command?  Isn't the
whole point of interactive stash something that operates on a
worktree?  Why will I ever want to operate on a commit with stash,
interactively?

While it is absolutely necessary to avoid calamities like the merge
invocation in git-pull.sh, we shouldn't be over-engineering either.
