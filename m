From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: I've been pushing to one branch from both git-svn and git
Date: Tue, 4 May 2010 12:34:31 -0400
Message-ID: <w2s32541b131005040934o339e3e79vf386427ed282ce64@mail.gmail.com>
References: <z2h7eeb06461005040443ib2fb7405i39e7d5b4220bfb08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ricky Clarkson <ricky.clarkson@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 18:35:07 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9L5N-0003e9-SI
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 18:35:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758806Ab0EDQe6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 May 2010 12:34:58 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:45004 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758148Ab0EDQe5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 May 2010 12:34:57 -0400
Received: by gwj19 with SMTP id 19so1705139gwj.19
        for <git@vger.kernel.org>; Tue, 04 May 2010 09:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RpMerZOXXa05CRmWLMFfMNWzmP3t3fdBQTLCaiAJ0t0=;
        b=WKIl++FdwInDd3NWrpzvQxAOTv1WrFrWIFiQPdx+JWYbxxA3g9wycGzY6ziiESDoil
         WxnBwiiSNRmhzpQPsHY11uwy6JhXknqxfSql2U2zZpog4YuCpjeknO+o8OD+LtW9c5X4
         37xr6GOxrXhNbf2yYbzI+Un5fv3GGoRO6uxT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Tl2jRr+lomydJxCAODGHdfDxct/Z8TB3C91g2O67XQEGn4YZjf06Yjy2CqFbD3t5+f
         bR3Jju1MQYDM6+81phQajZw9k4TpFeUm4wizECQJWscpBnzYtWG3ri34Vd91IArl9KU9
         mHXMlyck4+JWcFDnVXxXhgSPcYMqYRRgyNarc=
Received: by 10.150.213.14 with SMTP id l14mr12357603ybg.241.1272990891471; 
	Tue, 04 May 2010 09:34:51 -0700 (PDT)
Received: by 10.151.109.5 with HTTP; Tue, 4 May 2010 09:34:31 -0700 (PDT)
In-Reply-To: <z2h7eeb06461005040443ib2fb7405i39e7d5b4220bfb08@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146324>

On Tue, May 4, 2010 at 7:43 AM, Ricky Clarkson <ricky.clarkson@gmail.co=
m> wrote:
> I have a git repository we'll call the git svn repo, in which I only
> perform git svn fetch and git push bare.
>
> bare is a bare git repository, which I push to from a local
> repository. =A0The mistake I've been making is to push to the branch
> 'trunk' in bare, from my local repository. =A0The reason this is a
> mistake is because git push bare from the git svn repo also pushes to
> there.
>
> Today I've been forced to learn of my mistake, as I cannot push from
> the git svn repo without possibly losing commits. =A0It turns out (wh=
ich
> is probably obvious to you all) that I should have been pushing to,
> say, bare's 'master' branch instead of its trunk one.
>
> I don't intend to push back to svn from any of these repos, but I
> would like to be able to continue pulling changes from svn at least
> for the time being. =A0What should I do?

If you don't intend to push back to svn, then life is relatively simple=
=2E

=46irst, on your PC where you've been making other commits, rename the
trunk branch to master and push that:

   git branch -m trunk master
   git push bare master

Then delete the 'trunk' branch on bare, and re-push it from the git svn=
 repo:

   git push bare :trunk
   git push bare trunk

And probably you'll go back to your PC and merge the latest trunk into
your master:

   git pull bare trunk
     # resolve any conflicts
   git push bare master

Have fun,

Avery
