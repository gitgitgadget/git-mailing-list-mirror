From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [PATCH] Preserve cwd in setup_git_directory()
Date: Thu, 24 Jul 2008 19:40:18 +0700
Message-ID: <fcaeb9bf0807240540i400fe0d1s7ea8efe72203471d@mail.gmail.com>
References: <20080724031441.GA26072@laptop>
	 <alpine.DEB.1.00.0807241324040.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Geoff Russell" <geoffrey.russell@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 24 14:41:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KM08L-0000FK-Eu
	for gcvg-git-2@gmane.org; Thu, 24 Jul 2008 14:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304AbYGXMkW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 08:40:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754132AbYGXMkV
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 08:40:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:59355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbYGXMkU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 08:40:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1388142fgg.17
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 05:40:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=nm8NTKocYVlr7PKiERExJj36o9Ym2jcHFc51nBfSZ30=;
        b=luJYxH7O3tGO+Ut7QqHPT9BCfBFu9MhOJA5VLKIPGMgmFRTh2RjARbURxVaCduA+/K
         PJGETymZwZEAOoHtmK11/jI5ZTgWxKvIs5LDZAEn59oUdueksE+NaT6kx+e/XksW+Qu3
         WApB9iSZ5SPyCtDZMko8KdQcTnEbSO3LUdmOA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Z6J5+f76F4ZXlk2IJzYdm4QmhNHEWk58CbNFQrXvJMCGtY0nqcmCpsjPXrzGVUvXM6
         ejmSmwaAYOIRlrFzbAgdTLDEcj7G8xUCp0d6c/Erh1LWrLP4Ow+gZqI4FrvIsqWl14iG
         j952AND1FrBw4MQQR7FW8GULibENo28Ylyji8=
Received: by 10.86.77.5 with SMTP id z5mr845981fga.10.1216903218556;
        Thu, 24 Jul 2008 05:40:18 -0700 (PDT)
Received: by 10.86.91.2 with HTTP; Thu, 24 Jul 2008 05:40:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807241324040.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89874>

On 7/24/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
>
>  On Thu, 24 Jul 2008, Nguyen Thai Ngoc Duy wrote:
>
>  > When GIT_DIR is not set, cwd is used to determine where .git is. If
>  > core.worktree is set, setup_git_directory() needs to jump back to the
>  > original cwd in order to calculate worktree, this leads to incorrect
>  > .git location later in setup_work_tree().
>
>
> I do not understand.  core.worktree is either absolute, in which case
>  there is no problem.  Or it is relative to where the config lives, no?

The problem is GIT_DIR is not absolute in this case. So cwd must stay
where git dir is until it is absolute-ized by setup_work_tree().

-- 
Duy
