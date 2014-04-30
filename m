From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Problem: staging of an alternative repository
Date: Wed, 30 Apr 2014 14:35:45 -0700
Message-ID: <20140430213545.GV9218@google.com>
References: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 23:42:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfcGq-0000TI-OU
	for gcvg-git-2@plane.gmane.org; Wed, 30 Apr 2014 23:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759118AbaD3VmZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Apr 2014 17:42:25 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46598 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbaD3VmY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Apr 2014 17:42:24 -0400
Received: by mail-pa0-f42.google.com with SMTP id bj1so2719352pad.29
        for <git@vger.kernel.org>; Wed, 30 Apr 2014 14:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=/kTUsH7hOIp1EfQgItnIc2adPpZKF+JSbndKCTaSUDk=;
        b=j5cV0G5GLIfptNpfrJXqi+ipIZKXiMe15AG/g5A/C208fTJ8mkFcqsTh/PL780zR8Y
         rn0If4ehwubGcojgEl6ppp5o1XKAuG0Ifxc75WFhLSKocj1z+Nxsg3RZReOR0b4XNxNL
         r2IXXuR4RvFEJ0m95OvDSuOrv4k8TneEnX2OK/eaRiK9JbYnbZ38Py5IcIKsuQVYVVfb
         /vgZx5+B1hbX/1TsaSiuZSVYZnzz+XK/3boFYLIzN8ePLcCctCaWAEnnb0+sFe1AmUaa
         KOe4FsDrkWBGEsmVb+9Dik7lV7ma3cXC58ANC9y2ubxu7HJrj0YGNhUdQdW/n2eWVD39
         yfaQ==
X-Received: by 10.66.149.37 with SMTP id tx5mr12928924pab.81.1398893747727;
        Wed, 30 Apr 2014 14:35:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id vd8sm143558679pac.12.2014.04.30.14.35.46
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 30 Apr 2014 14:35:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAKpPgveXqraM4bXb499mJm5Ls+EinihfEJ6VgOFikC0_Qp8iTA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247783>

Hi Pavel,

Pasha Bolokhov wrote:

>     It turns out Git treats the directory '.git' differently enough
> from everything else. That may be ok,

Yeah, it's intended.

[...]
>     if you supply a different repository base name, say, '.git_new',
> by either setting GIT_DIR or using the '--git-dir' option, Git 'add'
> will not make any exception for it and think of it as a new (weird)
> directory.

Yep, a git repository metadata directory named .git_new is not special
in any way and you can use "git add" to track it if you want (for
example to add a testcase).

[...]
>     Now I know, the '--git-dir' option may usually be meant to use
> when the repository is somewhere outside of the work tree, and such a
> problem would not arise. And even if it is inside, sure enough, you
> can add this '.git_new' to the ignores or excludes. But is this really
> what you expect?

I think it's more that it never came up.  Excluding the current
$GIT_DIR from what "git add" can add (on top of the current rule of
excluding all instances of ".git") seems like a sensible change,
assuming it can be done without hurting the code too much. ;-)

But as you note, you are not using $GIT_DIR the way it was intended to
be used.

Thanks and hope that helps,
Jonathan
