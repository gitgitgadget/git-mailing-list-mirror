From: Paolo Bonzini <bonzini@gnu.org>
Subject: Re: What's cooking in git.git (Jul 2009, #02; Sun, 26)
Date: Tue, 28 Jul 2009 09:27:38 +0200
Message-ID: <4A6EA86A.5010705@gnu.org>
References: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 09:28:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVh6i-0004Sq-TG
	for gcvg-git-2@gmane.org; Tue, 28 Jul 2009 09:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751574AbZG1H1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2009 03:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbZG1H1o
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Jul 2009 03:27:44 -0400
Received: from mail-bw0-f221.google.com ([209.85.218.221]:65083 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848AbZG1H1n (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2009 03:27:43 -0400
Received: by bwz21 with SMTP id 21so706148bwz.37
        for <git@vger.kernel.org>; Tue, 28 Jul 2009 00:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=1bQsOxk19pJQEeFxpbATQwQ9yFYOgO2Dd9CwSF6ys1Q=;
        b=GSrNxjsmO8qYjZRYK97BOOOaRJINmE3x1GTmFkum/maG/lXwL+u9Okmfv+D59FgFNf
         mCpu9Fx3qzCSVqD3K/eRaIMmzBZWBcnXI5J5JjmFz6w9ssXraY5sGlV49DJaUra/JP0i
         D1WWtvhKkfyzhTnpvMqi64GNkj67nj6YVRqFo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:newsgroups:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=iLMtNuZAPCkOmUSpdnjHQ60j3dEaMPt9H9PAEbGKJiEWMdPzmaq5ugTOYjbtRPyhtE
         /oYR8VJUoMfDmR7mI+Jz/4sS4z6mDXJ9MUK58cC9h9pDQXa+daw3k69/7oNZ2ZDCRj1T
         B2nbjXsL22ZXVJk7FG1g7yl5ZPlnuOBm9Qajo=
Received: by 10.204.119.71 with SMTP id y7mr4081086bkq.16.1248766062433;
        Tue, 28 Jul 2009 00:27:42 -0700 (PDT)
Received: from yakj.usersys.redhat.com ([85.93.118.17])
        by mx.google.com with ESMTPS id 9sm13173988fks.58.2009.07.28.00.27.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Jul 2009 00:27:41 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <7viqhfrfu5.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124216>


> * pb/tracking (Thu Jul 16 16:26:15 2009 -0500) 7 commits
>   + branch.c: if remote is not config'd for branch, don't try delete
>     push config
>   + branch, checkout: introduce autosetuppush
>   + move deletion of merge configuration to branch.c
>   + remote: add per-remote autosetupmerge and autosetuprebase
>     configuration
>   + introduce a struct tracking_config
>   + branch: install_branch_config and struct tracking refactoring
>   + config: allow false and true values for branch.autosetuprebase
>
> After some discussion, I suspect we may want to rewind this out of 'next'
> and start over with a fresh design.

Is your workflow to merge next to master after the release, or do you 
cherry-pick the merges?  If the latter, I propose that instead you 
graduate to master only the first five patches (e.g. as 
pb/per-remote-tracking).

I'd rather not see the series reverted until there is some code for the 
fresh design.  While I like it overall, I tried implementing it and I 
could not really do it in a nice way (I could not even find a way to 
nicely separate changes).

Do you plan to merge at least the first two patches of "git push 
--current" (i.e. without the config option)?  Do you want me to resend 
them separately?

I will also separate from the --push series in two parts the patch that 
reuse "git remote" code in "git clone", so that you can get the first 
one as a cleanup and I can resubmit the rest later if the fresh design 
does not work out.  I'll submit it after 1.6.4.

Paolo
