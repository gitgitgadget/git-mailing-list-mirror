From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Git repository mesh?
Date: Wed, 25 Nov 2009 11:08:46 +0100
Message-ID: <81b0412b0911250208v67a16637s72551a892af4b0d8@mail.gmail.com>
References: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 11:08:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDEnt-0008Qw-Jg
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 11:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758547AbZKYKIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2009 05:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758529AbZKYKIm
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 05:08:42 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:54830 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758369AbZKYKIl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2009 05:08:41 -0500
Received: by bwz27 with SMTP id 27so6747415bwz.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 02:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=Jp5ZSJs6+9tAEvnQDuw+OpZzGa8ujudSVCUB0pIc6vw=;
        b=noM4WXxOtkIof2/9xAwy8nuhGT7nl9ymFFTVQg+dDH0yyh42Ei3IProip+UDgCTJjf
         27n9p86nQKc1QOne6zRnoUBmEyK4YXmskqPMXqhpvMpaLfXA6ykKlSz2GHv2keP7RX1A
         otU7DRnPrS9VlJmhIQIeGmcyuqUyZozraU0rE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=MHf39Q73W2kFRBSPIDjWZzFOK7nXxDsuI2F6Pqx1U+wFZFwAoxNZbhF0Pq+7kpm7qi
         NtShYiZajK8lmdsDVFasMmNwTW/Ici2SxwyoaUcdpKfb0kzg8kYH42UdFHmMZmEWrSyg
         m2PeZm9Jtl4kx82XnUmJotnKhLRK7TFS8gFIc=
Received: by 10.204.156.203 with SMTP id y11mr6989520bkw.200.1259143726826; 
	Wed, 25 Nov 2009 02:08:46 -0800 (PST)
In-Reply-To: <fcaeb9bf0911242007t1294bddej87b48691ea283e21@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133622>

On Wed, Nov 25, 2009 at 05:07, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> I work on a few machines so I have repositories on all of them. One
> repository can pull from or push to any other repositories (in case of
> push, it pushes on remote branches). I avoid a central repository
> because it's quite inconvenient when you just need to push some
> changes to a machine, you have to push it to the central repository
> then pull from that (and if the central repository is on WAN, double
> inconvenient). Maybe this model is just plain wrong, but it'd be fun
> to see if Git can work with this model.

You can always use fetch (and pull) without specifying a remote:

  $ git fetch host:/path/repo some-branch
  $ git log ..FETCH_HEAD # git merge FETCH_HEAD

Maybe fetch should be extended to record this operation in .git/config?

  $ git fetch ---save=host-some host:/path/repo some-branch some-branch
  $ git remote -v
  ...
  host-some	host:/path/repo (fetch)
  $
