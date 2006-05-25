From: "Geoff Russell" <geoffrey.russell@gmail.com>
Subject: importing cvs logical modules
Date: Thu, 25 May 2006 14:18:25 +0930
Message-ID: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
Reply-To: geoff@austrics.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Thu May 25 06:48:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj7lu-0007BW-Ju
	for gcvg-git@gmane.org; Thu, 25 May 2006 06:48:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbWEYEs1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 00:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965027AbWEYEs1
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 00:48:27 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:57367 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965026AbWEYEs0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 May 2006 00:48:26 -0400
Received: by py-out-1112.google.com with SMTP id b36so2224055pyb
        for <git@vger.kernel.org>; Wed, 24 May 2006 21:48:26 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=VqGSPlaLogKOdpVAERioT+Fw5PW8nJ+4MQGm8QZI/dCI/cuqeK8f5FpU0owfQZLihQlNMKg6NLvTeEi/bOPA/IDPzwQGf/qgw2aVgwMssPq6IlSKJ0kuYbC2lwMCy2X0NRTDevXp2g3eXmq1AqK2D9gdvpYMDdejkDDU5dVy0rQ=
Received: by 10.35.22.17 with SMTP id z17mr2266477pyi;
        Wed, 24 May 2006 21:48:25 -0700 (PDT)
Received: by 10.70.32.19 with HTTP; Wed, 24 May 2006 21:48:25 -0700 (PDT)
To: git@vger.kernel.org
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20723>

Hi,

Firstly, the code to automagically
repack a git repository on-the-fly during a big load has solved one of
my problems - thanks, it is great. Unfortunately  it has bought me to
showstopper number 2.

- cvs modules.

cvs allows you to define modules which rearrange the physical repository into
a different logical structure.  This sounds great and we use it, but it gives
us other headaches because "cvs update" doesn't always do the right
thing with these modules.

Furthermore cvsps doesn't appear to handle this module feature at all and
is tricked into thinking that rearranged directories come from somewhere
else and issues its "file xxx doesn't match strip_path" message.

I have tried to hack cvsps to go around the problem, but without success.

Another alternative that I thought might be easier would be to unload the cvs
repository in clean pieces - each being a git repository. Then to join the
git repositories together in the desired way. I think this would be
generally useful and not just solve my problem.

e.g. Suppose I have 3 git repositories: Progs, xxxx, yyyy

           Progs/.git
           xxxx/.git
           yyyy/.git

I'd like to make 1 git repository Progs with xxxx and yyyy as child trees.

           Progs/.git
           Progs/xxxx
           Progs/yyyy

Does this sound useful to anyone else, or is it already possible?


Cheers,
Geoff Russell.
