From: "Jacob Helwig" <jacob.helwig@gmail.com>
Subject: Re: How to supply "raw" bytes to git grep?
Date: Thu, 18 Sep 2008 08:46:49 -0700
Message-ID: <8c9a060809180846j25e4eb44h291b017aa01bbe36@mail.gmail.com>
References: <200809181728.18597.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johan Herland" <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:48:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLjc-0007wk-Rz
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753646AbYIRPqw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:46:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753534AbYIRPqw
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:46:52 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:33823 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753523AbYIRPqv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:46:51 -0400
Received: by wa-out-1112.google.com with SMTP id j37so2451832waf.23
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 08:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=2vx+rXjOgbM9ivIJQHedxybjrupT0YmcdTXtvxdzbOE=;
        b=cEv12l7aqFC8ZVn3ZdWCY/OcosuQm30DrCbg6Y9TytTFsM6OoS5huYkw3+rCIGitxj
         qp7UHcukZo9e8evocfv1KKgmu5zb9pC4WdrjmuMY8NcCKTe6He1gWYDKG1Bhc8NEKEbc
         WTyE+fFtHfrYCrJpIhsS17zOC8Y3n9FM1zzK8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=OxclpWODcLkEJNnF2+WfxAA/aj5W2qVXpBigWG6zaqTc0jto0WNShtjlIg2U0HpYg/
         jdUagxFSDKh2J+JgxCv4aAnEwSm03YGHEtprAJl8K0eRt7rFMJSgbMDvQFaeHZq6J6l5
         7T2Nsf8JIyHj8OpdXCUeJoXhaGyr8eUWqdXVM=
Received: by 10.115.77.3 with SMTP id e3mr3977143wal.43.1221752809644;
        Thu, 18 Sep 2008 08:46:49 -0700 (PDT)
Received: by 10.114.57.20 with HTTP; Thu, 18 Sep 2008 08:46:49 -0700 (PDT)
In-Reply-To: <200809181728.18597.johan@herland.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96204>

On Thu, Sep 18, 2008 at 08:28, Johan Herland <johan@herland.net> wrote:
> Hi,
>
> I wanted to list all text files in my repo which contain carriage
> returns, so I tried the following command-line:
>
>        git grep --cached -I -l -e <CR>
>
> where <CR> is some magic incantation that I've yet to figure out. I've
> tried all the obvious cases (\r, 0x0d, \015, etc.), but none of them
> seem to DWIM...
>
> The only working solution I've found so far is to create a file
> (named "cr") in a hex editor that contains exactly one CR byte, and
> then use the -f option to 'git grep':
>
>        git grep --cached -I -l -f cr
>
> Is there an easier way? And if not, should I try to create one (e.g.
> teaching 'git grep' to grok backslash escapes)?
>
>
> Have fun!
>
> ...Johan
>
> --
> Johan Herland, <johan@herland.net>
> www.herland.net
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Inserting a literal carriage return seems to do the trick for me, in bash.

git grep --cached -I -l -e <Ctrl-V><Ctrl-M>
