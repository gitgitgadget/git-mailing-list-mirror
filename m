From: "Nigel Magnay" <nigel.magnay@gmail.com>
Subject: Re: [PATCH] Teach git submodule update to use distributed repositories
Date: Thu, 17 Jul 2008 16:07:11 +0100
Message-ID: <320075ff0807170807l1537e34ev510deda537e4d11e@mail.gmail.com>
References: <320075ff0807170508j3d3c1ef8j49df576fc47debe2@mail.gmail.com>
	 <alpine.DEB.1.00.0807171311010.8986@racer>
	 <320075ff0807170520r200e546ejbad2ed103bd65f82@mail.gmail.com>
	 <320075ff0807170521s26693381m60648468cce1c41c@mail.gmail.com>
	 <alpine.DEB.1.00.0807171351380.8986@racer>
	 <320075ff0807170703l57fe26d2h1e9c4db1c38dd6f1@mail.gmail.com>
	 <alpine.DEB.1.00.0807171513560.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 17 17:08:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJV5b-00012h-6d
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 17:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758243AbYGQPHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 11:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758177AbYGQPHO
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 11:07:14 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:49409 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757762AbYGQPHN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 11:07:13 -0400
Received: by yx-out-2324.google.com with SMTP id 8so1960292yxm.1
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 08:07:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=jn+P4sRBaMhpoXiWeCrvzfmikXhkowbaQW/uzd2m2jQ=;
        b=u/byc8DLo5T3l7yOO9u4p3ygXjGF68qADXX1w5GZmjV8aJuDRKbFa/DUBfycYEOsy+
         NP/bhCeqS40DJHua2X3NPmyybV/ACAuqg+mTohrn5FYqUqpP4OPa0iC/qBwQBAk7WWVB
         BgH2A0g++TD+pYvN4kalLYMXScUcXod6dYTeE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=v7ysxREB/EKsY7ZWlOKTGAXsn+o+UxmMTKGu7yhqtaNUUSQVVDB5xWCbtkrk6VfuzO
         V3QOYcjUIm96DZWV3/aagtLmmQb/hLzeQJTGhi2BKjh1biltMp7GC0STKrYpYet/cKPp
         pdUKc753Auqiha5/DaSG7ioF+yU8DaeTUGsjw=
Received: by 10.103.20.7 with SMTP id x7mr2013568mui.96.1216307231162;
        Thu, 17 Jul 2008 08:07:11 -0700 (PDT)
Received: by 10.103.246.15 with HTTP; Thu, 17 Jul 2008 08:07:11 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807171513560.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88864>

On Thu, Jul 17, 2008 at 3:16 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 17 Jul 2008, Nigel Magnay wrote:
>
>> Your attitude seems to be that the status-quo is in some way desirable;
>> "It's no wonder that this tool is awkward to use in your workflow.".
>> This workflow is really common, and there's actual, real people on this
>> list complaining about it. Don't we think it could be improved to be
>> non-awkward ?
>
> I do not think that the status quo is the best possible.
>
> But I think that the way you go makes things so confusing that those who
> use it apart from you will have problems.
>
Ok

> For example, in your setup everybody would have to install _different_
> remotes in every submodule.
>
> And then some would ask themselves why the original origin was not good
> enough.
>
> And others would specify "-o origin" all the time, thinking it was
> required.
>
> There must be a better way to promote submodules to a usable state,

My attempt was to try and do some small simple things, but you could
well be right, that might make some commands bloat out with
unneccessary options just to get something done, and that would be
bad.

Stepping back - lets try to come up with a better way (please comment
and and critique)

What we'd like (to start with) is for
$ git pull fred

perhaps with --submodules (as Petr mentions), perhaps with config
settings and caveats, to produce a result that means you don't need to
be aware that there were submodules, they're automatically fetched and
updated based on commits that may only exist in fred's repository.

So currently, you can do
$ git pull origin && git submodule init && git submodule update

And it works, but

$ git pull fred
$ git submodule update

Can leave you with problems, because if a submodule wasn't pushed to
origin, you won't have it available. This is because the commands are
equivalent to

$ git pull fred
for each submodule()
  cd submodule
  git fetch origin
  git checkout <sha1>

So somehow, you need to replace 'git fetch origin' with the "correct"
repository (on fred's computer). My patch was really just about being
able to pass parameters to 'git fetch'. The problems are that if you
did

$ git submodule update fred

Unless each submodule had a [remote] specified for "fred", you'd be
stuffed. But what you could do is either by passing the right URL, or
looking at the superproject [remote] for "fred" - i.e: If in the
superproject you have

[remote "fred"]
        url = ssh://git@fred.local/pub/scm/git/workspace/thing/.git
[submodule "module"]
        url = ssh://git@repo/pub/scm/git/module.git

Then the submodule "module" on fred, if it's a working-copy, can be calculated
       ssh://git@fred.local/pub/scm/git/workspace/thing/module/.git

If it isn't a WC then you'd have to have a [remote "fred"] in that
submodule, but I'm thinking that'd be a rare case.

I'd assumed (possibly wrongly?) that there was resistance to putting
any of the submodule logic in things other than git-submodules.

As a starter for 10, how about
- a '--submodules' option to git fetch / pull
- using the remote name if known, calculate it if not based on the above

WDYT?
