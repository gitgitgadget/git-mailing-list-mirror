From: Tor Arvid Lund <torarvid@gmail.com>
Subject: Re: bug in git-p4?
Date: Fri, 8 May 2009 13:43:32 +0200
Message-ID: <1a6be5fa0905080443h5c696f8es55ea5acf3b3025cb@mail.gmail.com>
References: <F98DA2FE6F6C464C860149518BD861CC3B3C13440A@SSDEXCH2.websense.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Mercier, Carl" <cmercier@websense.com>
X-From: git-owner@vger.kernel.org Fri May 08 13:43:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2OUQ-0007CZ-1B
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 13:43:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753286AbZEHLnd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 May 2009 07:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753171AbZEHLnd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 07:43:33 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:34336 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbZEHLnc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 07:43:32 -0400
Received: by fxm2 with SMTP id 2so1344546fxm.37
        for <git@vger.kernel.org>; Fri, 08 May 2009 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6rAzxmOcTFoKsBKW8/0lp3+PjiN/58w6unv2dzSgW9U=;
        b=gsgI5SFNv2VRnK95TKZFl8AuRUmBTuuMi/Z0XdCqu6qTGbieNFdkv5W0efYjQaMF1G
         Qzfg4vj9k4pVIQbl0dPuanPjDJYC9keGtWncGyU91DhxO5RW1Vmxj4k3xp8z1ovjfvM1
         VOviLQT8EBkIGlTrWetVlNXqt3NZFSoim4Sh8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=m1IB3r2J8H/VOWvP5t5HFPT/6h9R0ZbDl5OpQqBgMXepN/8EH8k/4IXBP4av8vfF/x
         w1yu6ZVYmZHTpctsgKBYp87BJJ6OtULkBsFBKsLwt8jHmKwGGu82ujO9ogIRqRqDXBgN
         gHLgw3xqL9bypETlZygluywppqx/9p0L9ORFQ=
Received: by 10.86.79.6 with SMTP id c6mr3470193fgb.52.1241783012340; Fri, 08 
	May 2009 04:43:32 -0700 (PDT)
In-Reply-To: <F98DA2FE6F6C464C860149518BD861CC3B3C13440A@SSDEXCH2.websense.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118600>

On Mon, May 4, 2009 at 9:20 PM, Mercier, Carl <cmercier@websense.com> w=
rote:
> Hello all,
>
> I've been trying to use git-p4 without much success. =C2=A0My setup i=
s very simple:
>
> - 1 existing Git repo (with data)
> - 1 existing P4 depot (with an empty subdirectory)
> - We commit and push to Git and our company requires all the code to =
be stored in P4 (in the p4 empty subdir).
>
> Here's what I did:
>
> cd /root/p4-repo/SecTech
> git clone /home/git/repositories/web website
> cd website
> git-p4 sync //SecTech/website
> git branch --track p4-master p4/master
> git checkout p4-master
> git merge master
> git-p4 submit

Hi. What I try to do at my job, is to consider the P4 depot to be the
"master" depot, since I consider it the "weaker" of the two VCSs. I
have not had much success doing git merges and then trying to sync
with P4. I instead use rebasing a lot. So what I would do in your
situation is something like:

=2E..
git-p4 sync //SecTech/website
git rebase p4/master
git-p4 submit

So.. my normal flow of work is:

code
commit
code
commit
git p4 sync
git rebase p4/master
git p4 commit

Don't know if this is something that might work for you, though...

-Tor Arvid-
