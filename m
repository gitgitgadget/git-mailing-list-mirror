From: "Denis Bueno" <dbueno@gmail.com>
Subject: Re: git cherry-pick before archive
Date: Fri, 11 Jul 2008 14:28:43 -0400
Message-ID: <6dbd4d000807111128l4721113dh3713bc7abd3d837e@mail.gmail.com>
References: <6dbd4d000807110846m2921ddb9r88eb3986762b8f81@mail.gmail.com>
	 <alpine.DEB.1.00.0807111649290.8950@racer>
	 <6dbd4d000807110909n1ced22eeraef45af441c20cca@mail.gmail.com>
	 <20080711161158.GD10347@genesis.frugalware.org>
	 <alpine.DEB.1.00.0807111924180.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 11 20:29:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHNNH-0006GV-EC
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 20:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753593AbYGKS2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 14:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbYGKS2p
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 14:28:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:26281 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbYGKS2o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 14:28:44 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1579732fgg.17
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=EwyFHPOrdE896N4g8pu2U/MGZykg0VyxIRbU0flqkp8=;
        b=JwIQ15goeDcAfrEQpskhQ/mK9+CbB8VATY8euhd0nNkQN/Zl3MV9LJzYGjF5ZaYGKc
         YgVk04FtJnR0gHWZ/2xc36Ch6NG9aNaCNNRHFyNHZ2G74IGqJ+IW+J6cztRFxzarOoM7
         EVRLZ3qvsba5dTjxvju1YZ15CHUVHI+s9D88w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=s42hrB3dfxcjLTqIFfsmyzAm7XcjCUR604DmJ/CHGb9kPo8HR9HzaueLFB7G+cveoT
         sGfSvPYwo3WeTY+wcagG8HBdd0MgIadNm0EoHCyg0aRFItKZ9mz6dGosgdKZT2Q+Kerf
         2IySeO82OBicRenLjei6KKDfWGzg5zS/fYFOw=
Received: by 10.86.33.19 with SMTP id g19mr10313735fgg.30.1215800923203;
        Fri, 11 Jul 2008 11:28:43 -0700 (PDT)
Received: by 10.86.59.7 with HTTP; Fri, 11 Jul 2008 11:28:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807111924180.8950@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88150>

On Fri, Jul 11, 2008 at 14:25, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Anyway, back to Denis' question: I could imagine (haven't tested,
> thought), that "git revert -n <the-same-commit>" would undo the "git
> cherry-pick -n".

So I need to be able to maintain the patch that is applied to the tree
before archiving, so instead of a commit ID, I'm now using a patch
file, and the sequence of actions is like so:

    $ <assume index is clean>
    $ git apply --cached patchfile || exit 1
    $ git archive --format=tar --prefix=pfx/ $(git write-tree) \
          | gzip > prj.tgz
    $ git reset

This way I don't even need to reverse-apply the patch, because I never
touch the working copy.  Of course, this can't be done in this way in
any other revision control system, because they don't have an index.

-- 
 Denis
