From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 2/3] trace: omit repository discovery report
Date: Tue, 25 Jan 2011 19:46:38 -0600
Message-ID: <20110126014638.GA29929@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-2-git-send-email-pclouds@gmail.com>
 <20110126004915.GA11230@burratino>
 <20110126005916.GC11230@burratino>
 <AANLkTinyVKQOVHgdVhB3PhQOp9FbdNNHLqYny6i=_qKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 26 02:46:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PhuTK-0004KL-5w
	for gcvg-git-2@lo.gmane.org; Wed, 26 Jan 2011 02:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977Ab1AZBqs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Jan 2011 20:46:48 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55547 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769Ab1AZBqr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Jan 2011 20:46:47 -0500
Received: by vws16 with SMTP id 16so236160vws.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 17:46:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=GuorWq3UNtNeVPqKm4fMF+q+w8zQGKHgYFryrEur5vY=;
        b=yFOXKSgnPWhySF4Y8XZBZNlw5LYmdc7HcHMJt6UcLHjz38JmJAON1GE5YbqUql4anp
         HoTTA5h++t+2zeqNYYvC1Q540mV+ShFN7hbGeItE1QWYPG9VE7wujnUucw/ytaJPoDuq
         jfI628sNM3JWRuOwO4k0EMXaeHtld7LxF4R8M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=PMfzs3J+Y+zK03+Vf46rDPErtZMY8vdwUv1LDkp+2xRS1T9zUnZ+hr0Q31jM5e2D7g
         o/B7t2bVc2pEqEd7jTkTHu+5Pp54MqhX1EDZJRcHlFNuC/Pf6XMC9tYT0qSTLu+FwE1t
         8Z9JewmdRZeB+8iHG+eNIT4Ne24phasxZGU4s=
Received: by 10.220.176.11 with SMTP id bc11mr1678985vcb.149.1296006406835;
        Tue, 25 Jan 2011 17:46:46 -0800 (PST)
Received: from burratino (adsl-69-209-75-28.dsl.chcgil.ameritech.net [69.209.75.28])
        by mx.google.com with ESMTPS id o6sm4903130vcr.27.2011.01.25.17.46.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 17:46:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTinyVKQOVHgdVhB3PhQOp9FbdNNHLqYny6i=_qKw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165497>

Sverre Rabbelier wrote:
> 2011/1/26 Jonathan Nieder <jrnieder@gmail.com>:

>> In practice, four extra lines of trace output per git process is too
>> much noise. =C2=A0So stop printing repository discovery info except =
when
>> running tests.
>
> Doesn't this disable _all_ discovery debugging aids? So doesn't this
> make it more difficult to figure out what's going on in the
> not-many-child case?

Let's take the 0-child case.  With v1.7.4-rc3:

 $ GIT_TRACE=3D1; export GIT_TRACE
 $ git symbolic-ref confused
 setup: git_dir: .git
 setup: worktree: /home/jrn/src/git
 setup: cwd: /home/jrn/src/git
 setup: prefix: (null)
 trace: built-in: git 'symbolic-ref' 'confused'
 fatal: ref confused is not a symbolic ref

 $ git rev-parse confused >/dev/null
 trace: built-in: git 'rev-parse' 'confused'
 fatal: ambiguous argument 'confused': unknown revision or path not in =
the working tree.
 Use '--' to separate paths from revisions

Observations:

- Orthogonal to the useful quantity of information is that it would be
  nice if the setup info dump were consistent.  Currently non-builtins
  and commands like rev-parse without RUN_SETUP|RUN_SETUP_GENTLY skip
  it.

- Except for "cwd", the setup lines write information that is easy to
  retrieve with git rev-parse.  In my limited experience, it is not
  the information I need when debugging.

- The cwd, on the other hand, could be very useful.  Maybe git should
  make sense to always follow "trace: run_command", "trace: exec", and
  "trace: built-in" lines with "trace: cwd".
