From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: [PATCH 10/22] run-command: optionally clear git environment
Date: Thu, 24 May 2007 09:19:47 +0200
Message-ID: <81b0412b0705240019u30a21c1dpd2528dfe58a479cb@mail.gmail.com>
References: <11799589913153-git-send-email-skimo@liacs.nl>
	 <11799589923790-git-send-email-skimo@liacs.nl>
	 <81b0412b0705232357i535be2adl6570847942ecb9c0@mail.gmail.com>
	 <20070524071527.GM28023@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "skimo@liacs.nl" <skimo@liacs.nl>, git@vger.kernel.org,
	"Junio C Hamano" <junkio@cox.net>,
	"Martin Waitz" <tali@admingilde.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 09:19:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7bz-0002Qr-Ia
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbXEXHTu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756132AbXEXHTu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:19:50 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:12913 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbXEXHTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:19:49 -0400
Received: by ug-out-1314.google.com with SMTP id 70so829944ugb
        for <git@vger.kernel.org>; Thu, 24 May 2007 00:19:47 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nmovp1dOj9yMQc5ajF4AoOCHc1M6hnKa/ffniDS7loxfCWvyTgpimOGJ17R5T3lSxz1sT/JwCO/PDOLVVM5NB94TmXIbTM8mZt5fyyQdc8OcW4M+UNcyyWHaqVAEfFjyRrBe55dgSpYqRisaahmbRS10Ay00ok5tdV2HFhImac4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fN6/7W6F3aWtxFMJabSSJ++nMJ6+9292fCqqH1s+QPSoQZ8dDEvi3u54QCpRTSo9CCaFMDmf+7oZc3pW5KwFXexgCuLpM/DIG4LRfqLA8npIHM6Ykw16KgQRpVdcUb0VWVfK5JV5Nmy8tzQDlPkDg+hTH257v5zRplK+UScQdu4=
Received: by 10.78.183.8 with SMTP id g8mr382598huf.1179991187662;
        Thu, 24 May 2007 00:19:47 -0700 (PDT)
Received: by 10.78.97.16 with HTTP; Thu, 24 May 2007 00:19:47 -0700 (PDT)
In-Reply-To: <20070524071527.GM28023@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48230>

On 5/24/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Alex Riesen <raa.lkml@gmail.com> wrote:
> > On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:
> > >+               if (cmd->clear_git_env) {
> > >+                       unsetenv(ALTERNATE_DB_ENVIRONMENT);
> > >+                       unsetenv(DB_ENVIRONMENT);
> > >+                       unsetenv(CONFIG_ENVIRONMENT);
> > >+                       unsetenv(GIT_DIR_ENVIRONMENT);
> > >+                       unsetenv(GRAFT_ENVIRONMENT);
> > >+                       unsetenv(INDEX_ENVIRONMENT);
> > >+               }
> >
> > You might want to try the alternative approach from the recently
> > proposed patches to do the same, but more generic. Would
> > be less code, too.
>
> Unfortunately Alex's approach means the caller must know the list of
> "special Git envvars" that should be cleared when entering into a
> subproject Git repository to execute a command.  That's horrible code
> duplication in the callers of run_command, and is just asking for
> trouble later when/if another magic environment variable is added.

#define GIT_ENV_LIST ALTERNATE_DB_ENVIRONMENT, \
            ...
