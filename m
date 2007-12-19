From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: log/show: relative pathnames do not work in rev:path
Date: Wed, 19 Dec 2007 12:23:41 +0100
Message-ID: <200712191223.42446.jnareb@gmail.com>
References: <20071218173321.GB2875@steel.home> <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org> <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Alex Riesen" <raa.lkml@gmail.com>, git@vger.kernel.org
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 19 12:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4x24-0004lE-Ur
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 12:24:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbXLSLXt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 06:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752430AbXLSLXt
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 06:23:49 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:58522 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244AbXLSLXs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 06:23:48 -0500
Received: by ug-out-1314.google.com with SMTP id z38so268660ugc.16
        for <git@vger.kernel.org>; Wed, 19 Dec 2007 03:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=fWz/L5rpb/+8lv84rI4sBG8aezN844vf/Mnu/2baNLY=;
        b=x9qEzqP9G66Fg305TacgxaEEg2XUkGY0CJIlgnelyHejSPmefc6Vx5qOYn24/ih9rG1gXc8We8d6TUI+dASPzjl0nV66aH0GGF+m7ioLJoE1TiwXoFnRczYu+evrLGBrtQs8vB5cVSQmVDbx9LFrNvMXoTt4d+QFm8nY+k8UnNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=SvEbNa6drLD+IdX9yIibnX1Xdu8vVAgR+ntW8Goe+1nntg1/2xKBQDRsDN8Kune+1GyR+SEYxRdtIARweT+bCM71FXr+nUzV4mNva0PLEoIQkgRsLdqPXWv3Dw3URBNzYBML5LA8EILt+9RbscF2YQdUogxXb/gxJMpmlNzzVIY=
Received: by 10.67.30.13 with SMTP id h13mr2041612ugj.45.1198063426946;
        Wed, 19 Dec 2007 03:23:46 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.252.93])
        by mx.google.com with ESMTPS id s7sm4580886uge.86.2007.12.19.03.23.44
        (version=SSLv3 cipher=OTHER);
        Wed, 19 Dec 2007 03:23:45 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68884>

On Wed, 19 Dec 2007, Dana How wrote:
> On Dec 18, 2007 5:16 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>> On Tue, 18 Dec 2007, Dana How wrote:
>>
>>> The cases we are talking about are all subtrees of the working tree.
>>> There is a useful cwd suffix.
>>
>> No.
>>
>> The cases we're talking of are *not* subtrees of the working tree.
>>
>> The SHA1 of a commit may well be a totally disjoint tree. Try it in the
>> git repository with something like
> 
> Agreed,  but note you wrote *may*.
> 
> I'd like to move some stuff currently in a p4 repository into git.
> The directory structure within the repo is 13 levels deep;
> I didn't design it nor can I change it.
> 
> For the majority of the cases of interest to me git already accepts
> relative paths.  However,  one thing people do often in p4 (or any SCM)
> is look at (or compare, etc) specific revisions.  Unfortunately,  these are
> not part of branches or commits,  they are just file-specific revisions
> (don't get me started on p4 "branches").  The equivalent in git is
> to use a commit name (or a tag) and then name the file.  The
> basic commit:file syntax doesn't accept relative paths.  I am not
> specifically hung up on the commit:./path syntax;  I just want some
> notation that will get those 13 directories from $cwd instead of
> making me type them again.  Yes,  sometimes that might not make
> sense to request.
[...]

I think new feature like this should be postponed after 1.5.4 is out;
we are now in feature freeze (only bugfixes are accepted).

That said, does git-showrel solution proposed by  Johannes Schindelin
in
  Message-ID: <Pine.LNX.4.64.0712182250040.23902@racer.site>
  http://permalink.gmane.org/gmane.comp.version-control.git/68840
work for you?

Below version of git-showrel script which uses proposed 'commit:./relpath'
syntax (it could be improved, of course):

cat > git-showrel <<\EOF
#!/bin/sh

rel=$(git rev-parse --show-prefix 2>/dev/null)
git show $(echo "$@" | sed -e "s!:./!:${rel}!")

EOF
-- 
Jakub Narebski
Poland
