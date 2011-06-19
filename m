From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Undo last commit?
Date: Sun, 19 Jun 2011 12:37:54 +0200
Message-ID: <201106191237.55825.jnareb@gmail.com>
References: <BANLkTinWujKYvx_fh2iBDOdMbywqzfgwUA@mail.gmail.com> <m31uyrutx7.fsf@localhost.localdomain> <20110619003718.GA5628@elie>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Mike <xandrani@gmail.com>, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	=?utf-8?q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 19 12:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYFOa-0000fl-JS
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 12:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab1FSKiJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 06:38:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:46004 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753400Ab1FSKiG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 06:38:06 -0400
Received: by fxm17 with SMTP id 17so438967fxm.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 03:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=FZ1LmJySLgm+BkAFoZEJVWc+V+Qse84JGPIpeecEx6I=;
        b=mUKZsJ+vpmxUcCstPdZKlm4/N2ubkDzCECZKdE4U5dVbY5URqZyGJo1LoGQEeB+Ws1
         6Ax0gHurbyiuPTNmgj6qBN2gpKf2F1VKP0psy13ArDhLdkFq6DXOQ9OiYIT+NTwLRwHy
         X7/YGlGvcc4EWJXQckTseZrWdo1MB752E/DD4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=tIa9yGmJQ3LvXlIRbgeSTAnx6FxmPFNyesUVruvN6ZHuuGx2UAoNCKNOjJQXDhFprv
         O11vKjEgJx8qzx+M4AY/09d2QH1lQkYPt3dRgA5SUJlo/MSy5ODZNUvq7ddkv0k+a1gr
         g413bPY5lG8y1GJPM7CdUCdPwwta0zp1HLYOE=
Received: by 10.223.32.142 with SMTP id c14mr2151868fad.59.1308479885430;
        Sun, 19 Jun 2011 03:38:05 -0700 (PDT)
Received: from [192.168.1.15] (absh236.neoplus.adsl.tpnet.pl [83.8.127.236])
        by mx.google.com with ESMTPS id e16sm2204828fak.41.2011.06.19.03.38.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 03:38:03 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110619003718.GA5628@elie>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175999>

On Sun, 19 Jun 2011, Jonathan Nieder wrote:
> Jakub Narebski wrote:
> > Mike <xandrani@gmail.com> writes:
> 
> > > % git reset --hard HEAD~1
> >
> > Errr... here you screwed up.  This reset state of you working area to
> > the state at last commit, removing all your changes to tracked files.
> 
> Or rather, here we screwed up.  Jakub and others gave some useful
> advice about how to recover, so let's consider how the UI or
> documentation could be improved to prevent it from happening again.
> 
> * In this example if I understand correctly then the index contained
>   some useful information, perhaps about a larger commit intended for
>   later.  To preserve that, you could have used
> 
> 	git reset --soft HEAD~1
> 
>   which would _just_ undo the effect of "git commit", leaving the index
>   and worktree alone.

Another issue is that Mike haven't realized that `--amend' option can be
used *in combination* with other "git commit" options, which means that
the solution to his problem was using "git commit" as it should have
been done, but with '--amend' added.
 
I'm not sure if git documentation talks about 'git reset --soft HEAD^',
and when to use it; from what I remember it encourages use of 
'git commit --amend' instead (which was I guess most often used reason
of using soft reset before there was '--amend').

> * Another situation that comes up from time to time is making a change
>   that just turned out to be a bad idea.  After commiting it, you might
>   want to discard the erroneous change, like so:
> 
> 	git reset --keep HEAD~1
> 
>   The "--keep" option uses some safeguards to make sure that only the
>   committed change gets discarded, instead of clobbering local changes
>   at the same time.
>
> * In the early days of git, the "--keep" option did not exist.  So a lot
>   of old documentation recommends to do
> 
> 	git reset --hard HEAD~1
> 
>   which is the same if you don't have any local changes.

Yes, it would be good idea to examine git documentation (tutorials,
user's manual, manpages, perhaps "Git Community Book" and "Pro Git"
too) to encourage use of new safer options of hard reset, namely
'--keep' and '--merge' instead of '--hard'.
 
-- 
Jakub Narebski
Poland
