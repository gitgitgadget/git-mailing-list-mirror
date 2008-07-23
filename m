From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did not change
Date: Wed, 23 Jul 2008 11:53:53 -0400
Message-ID: <32541b130807230853y136f41bdmf221637e35d601c3@mail.gmail.com>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
	 <32541b130807221522r2a43c49cl6400f00dbe7451a0@mail.gmail.com>
	 <20080723120104.GQ2925@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com
To: "Dmitry Potapov" <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 17:55:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLgg3-0005kb-Mb
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 17:54:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753032AbYGWPx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 11:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbYGWPx4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 11:53:56 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:20731 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750799AbYGWPxz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 11:53:55 -0400
Received: by yx-out-2324.google.com with SMTP id 8so428324yxm.1
        for <git@vger.kernel.org>; Wed, 23 Jul 2008 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xMy2RGurXi8HNCM2xHL6cEMkr1OvmUuvokPCUScXs9c=;
        b=UmguYZYYU6Pa1SMAO9Uj80BRgZW/4YQ9lMoVPOz2+lPQQcTkhiScqQxWrDkNdxVWRQ
         g3Vioe7Jd0I0tdoENXYJshosxhprXZNW3xdBoj8dDxU2hlYAAINW0lB6P+dLDo8dHpyn
         5AkaUPmN6AWHHeRv3MUyrlDUP24RWVR0A0Ua0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IstGYssj3gP1HTUquCC/HpNNx3EuePCcqXX7xppRrlIVc+lBE8GjXpAkMF1mh8QQgo
         /W5/9DYCGM9PQw1htw+AstMX5tEbQQ3cj4tsFccrdbE51egaILUlykBgGYKhGuPzAn3T
         esWBihR/z75JVHLx3qCJqM7MyNPy0YvSiMfNU=
Received: by 10.151.158.2 with SMTP id k2mr357329ybo.70.1216828433958;
        Wed, 23 Jul 2008 08:53:53 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Wed, 23 Jul 2008 08:53:53 -0700 (PDT)
In-Reply-To: <20080723120104.GQ2925@dpotapov.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89690>

On 7/23/08, Dmitry Potapov <dpotapov@gmail.com> wrote:
> On Tue, Jul 22, 2008 at 06:22:34PM -0400, Avery Pennarun wrote:
>  > This patch is perhaps a symptom of something I've been meaning to ask
>  > about for a while.
>  >
>  > Why doesn't "edit" just stage the commit and not auto-commit it at
>  > all?  That way an amend would *never* be necessary, and rebase
>  > --continue would always do a commit -a (if there was anything left to
>  > commit).
>
> Actually, it would be better to refuse to continue if there are unstaged
>  changes in the work tree, and if all changes are staged then just do git
> commit.

I'm not sure about that.  The auto-committing on --continue has never
annoyed me, and in fact I greatly appreciate that I can just "git
rebase --continue" after making changes and the expected thing will
happen.  After all, if I screw it up and commit too much at once, I
can always just rebase one more time.

However, taking out the auto-commit wouldn't pain me too much if
others want it that way.  It would be somewhat more typing, but at
least makes easy to understand exactly what's going on.

> It would not only save typing, but also help to avoid costly mistakes
>  where users, being taught to use "git commit --amend" after editing
>  during git-rebase, fire this command automatically after a conflict
>  resolution and get two commits accidently squashed.

Yes!  Good point.  I forgot about this, but I've been bitten by it a
couple of times.

Have fun,

Avery
