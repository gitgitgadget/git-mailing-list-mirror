From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Tue, 4 Oct 2011 23:48:22 -0400
Message-ID: <CAG+J_Dx=65RE+QZT_r=tSPhWtGdNMhrZ-bk4A0-TtKk8WgRJZw@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 05:48:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBIT6-0003x6-Ff
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 05:48:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933162Ab1JEDsY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 23:48:24 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:33660 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755942Ab1JEDsX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 23:48:23 -0400
Received: by ywb5 with SMTP id 5so1186156ywb.19
        for <git@vger.kernel.org>; Tue, 04 Oct 2011 20:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zg/8x/rICsh/V8NjEsB/XVD8Voc4CbNGjYWj9nikHaU=;
        b=GF6Y53h633I79ZOk1gpYPc+kFrgTLxi3x01GfZxgcg3R/LGfqfu48h0UAKaItxpKbd
         tWRsp6hoAlAIdwk0o1hwqqDOsrfyC2Zze495ZR8PoDXksFQkwcmjcNv85UrBo+hpDBAy
         TcqLfWsT8vjW+xS31B5on86KzPFukpz/WqP78=
Received: by 10.236.76.102 with SMTP id a66mr10990316yhe.25.1317786502999;
 Tue, 04 Oct 2011 20:48:22 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Tue, 4 Oct 2011 20:48:22 -0700 (PDT)
In-Reply-To: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182822>

On Tue, Oct 4, 2011 at 11:43 PM, Jay Soffian <jaysoffian@gmail.com> wrote:
> When using 'git new-workdir', there is no safety mechanism to prevent the
> same branch from being checked out twice, nor to prevent a checked out
> branch from being deleted.
>
> By teaching 'checkout' to record the workdir path using
> 'branch.<name>.checkout' when switching branches, we can easily check if a
> branch is already checked out in another workdir before switching to that
> branch. Similarly, we can now add a check before deleting a branch.
>
> Allow 'checkout -f' to force the checkout and issue a warning
> instead of an error.
>
> Guard this behavior behind 'core.recordCheckouts', which we will
> teach 'git new-workdir' to set in a followup commit.

Well, depending upon what folks think of this RFC, anyway.

> Note: when switching away from a branch, we set 'branch.<name>.checkout'
> to the empty string, instead of deleting it entirely, since git_config()
> otherwise leaves behind an empty section which it does not re-use.

Maybe this is a bug in git_config()? It seems like if it's removed the
last item from a section, it should remove the whole section OR it
should re-use an empty section.

j.
