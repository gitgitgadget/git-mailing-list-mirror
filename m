From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 01:38:50 -0700 (PDT)
Message-ID: <m3fxq3ws16.fsf@localhost.localdomain>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com>
	<alpine.DEB.1.00.0807210310330.3305@eeepc-johanness>
	<1216604693.3673.20.camel@pc7.dolda2000.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Fredrik Tolf <fredrik@dolda2000.com>
X-From: git-owner@vger.kernel.org Mon Jul 21 10:39:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKqvx-0003gt-Ta
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 10:39:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754962AbYGUIiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 04:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754690AbYGUIiy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 04:38:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:32470 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbYGUIix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 04:38:53 -0400
Received: by nf-out-0910.google.com with SMTP id d3so419634nfc.21
        for <git@vger.kernel.org>; Mon, 21 Jul 2008 01:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=LC278dkr1F6/KL8G0kND79SrkC6ksj1Y9NcMB3+IoA4=;
        b=QT4aL7aHatFalAY1PslJI/8QCJc/sXkDpLbyUGH3vil2vStuZApORZr8npmkl5eK9/
         PLB38Rg3WSTYc3hlB83ZDGykcVAu3YAjY1RL0Vry7elYHwMWxruKbQ9WKU2Ilv75hhqD
         oOB0a3i/0J+h3RESW/NMEuNt3OrIx6nrQ0ASw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ahxm3NJacO8qvg1l3/M1XNe0SRyAqdA8bCIUaRvMrzt2NLbITZCFiUsg2iMPJyzEQm
         0fWmix7HiI1mAv/f9nT4IwGzhnkYPlF3JJxkMsQ1JbhosyFNTYm7QPZLbtFdJvlT7EDR
         TXUMKQ9qaQ8PvRni++DyD7nNaONf7gtxM0O9o=
Received: by 10.210.21.13 with SMTP id 13mr3027957ebu.75.1216629531703;
        Mon, 21 Jul 2008 01:38:51 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.212.51])
        by mx.google.com with ESMTPS id z33sm7123754ikz.0.2008.07.21.01.38.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 21 Jul 2008 01:38:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6L8ckB1012352;
	Mon, 21 Jul 2008 10:38:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6L8cjVW012349;
	Mon, 21 Jul 2008 10:38:45 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1216604693.3673.20.camel@pc7.dolda2000.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89323>

Fredrik Tolf <fredrik@dolda2000.com> writes:

> [...] Here's some makeshift documentation:
> 
> The string specified in core.sshcommand is first checked if it matches
> any of the built-in templates, in which case it is expanded (I've added
> the templates "openssh" and "plink" by default). When used, the string
> is split into words, each of which is processed as follows:
> 
> * If a word is %p, it is replaced by the port number, if specified.
>   If the port number is not specified, the word is deleted.
> * If a word is %h, it is replaced by the remote host name.
> * If a word begins with %P, it is deleted if no port number is
>   specified. This is to allow for specifying different port number
>   flags for different SSH implementations. The syntax is a bit ugly,
>   but I cannot really think of anything that would look better.
>   If a port number has been specified, the leading %P is simply deleted.

There is a syntax which would look better, but perhaps it is a bit
overkill in this situation.  Namely use either shell conditional
expansion:

  ${p:+-P $p}

or syntax used in RPM spec macros

  %{?p:-P %p}

(and there is complementing %{!?<var>:<expansion>} in RPM spec macro
language).
-- 
Jakub Narebski
Poland
ShadeHawk on #git
