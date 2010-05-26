From: Troy Telford <ttelford.groups@gmail.com>
Subject: Re: Branch Names and tracking branches
Date: Wed, 26 May 2010 14:54:15 -0600
Message-ID: <201005261454.15277.ttelford.groups@gmail.com>
References: <201005261439.17442.ttelford.groups@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 22:54:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHNcZ-0001BJ-8b
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 22:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758201Ab0EZUya (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 16:54:30 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:35401 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757337Ab0EZUy3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 16:54:29 -0400
Received: by wyb29 with SMTP id 29so3623194wyb.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 13:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=h+LfLYXmbj5oK81Y5Dvtp7r7Fq2Iv5UFcqsnFDsT+Ws=;
        b=OXtkZMvixKEOvd1O1e/DTrcysd5N1iGTyNbqwLe1K6NAqcsyqlHESjjmgCagfOfiDS
         zPPzKia8XO1sl2YkLnJXwS+bIs8kAMr3pVZWiBmRCTGvfYcQkryVy2s8aJOLnJBrwTFQ
         FYjE9oBkDOJiPwioWIsNtmqBVLrr8R3USZEoI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        b=jZ0CnPxaTYZn61LeIbT4zN5qYKzACqrvO2BKVT3/O3kG2ehWpDGyckVutWM5ufC39C
         UC5D0vohI6F4DwYpH/e9OpOyB9vKVZ+1upE/KxaMkoHRNC6ao1k0HHPZ9iHVo/Vsg83F
         XDVf2wG3tSvSE3NmF9cSn8avmTT2H7dmqv+e0=
Received: by 10.216.85.73 with SMTP id t51mr17619wee.3.1274907265527;
        Wed, 26 May 2010 13:54:25 -0700 (PDT)
Received: from rigel.localnet (cfcafwp.sgi.com [192.48.179.6])
        by mx.google.com with ESMTPS id e82sm376181wej.16.2010.05.26.13.54.23
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 26 May 2010 13:54:24 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.32-22-generic; KDE/4.4.3; x86_64; ; )
In-Reply-To: <201005261439.17442.ttelford.groups@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147823>

I just realized it's a config issue.  <sigh>

git config push.default tracking

Sorry for that...

On Wednesday, May 26, 2010 02:39:17 pm Troy Telford wrote:
> I've got a situation where I'm trying to integrate git into another tool,
> so that when you make a commit into a git branch, a post-receive hook will
> then push the code changes into the other tool when the user pushes their
> changes into the repository.
> 
> The problem:  The other tool uses colons in the name.  So, I looked at 'man
> git-check-ref-format', and found that the colon can't be used.
> 
> So, I looked for a substitute character that isn't likely to be used anyway
> -- semicolon seemed to be a good choice.
> 
> As I decided to use a semicolon, a conversion as needed in the post hook. 
> It works fine with the git branch names along the lines of sna;foo;bar.
> 
> But using a branch name of "sna;foo;bar" is not entirely great, as the
> semicolon has to be escaped on the command line when referencing the branch
> name.
> 
> So, I decided to use a tracking branch:
>  git branch --track branch "refs/origin/sna;foo;bar"
> 
> Again, it checks out okay, and it is able to pull in changes fine. 
> However, changes can't be pushed into the remote repository at all; 'git
> push' simply returns "Everything up-to-date," even when changes are made.
> 
> This differs from the behavior I've seen in the past for tracking branches
> - I'm used to (and was expecting) the git push to push the changes into
> the remote's "refs/heads/sna;foo;bar" branch.
> 
> Using another character is, of course, an option; but the semicolon isn't
> explicitly forbidden and it works for everything I've used but 'git push'.
> 
> So am I just doing something wrong, or have I found a bug or documentation
> issue?
