From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Requirements for integrating a new git subcommand
Date: Fri, 23 Nov 2012 10:13:26 +0100
Message-ID: <50AF3E36.4080800@drmicha.warpmail.net>
References: <20121122053012.GA17265@thyrsus.com> <CAJo=hJsQjXEhmfRUEgBc=RkF3Lk8QVqUqmeAJiOZ0dtvcMYVFw@mail.gmail.com> <20121122221107.GA16069@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Fri Nov 23 10:13:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbpKe-0006dz-Q1
	for gcvg-git-2@plane.gmane.org; Fri, 23 Nov 2012 10:13:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759012Ab2KWJNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 04:13:36 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:49397 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758723Ab2KWJN3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Nov 2012 04:13:29 -0500
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5DE46202D9;
	Fri, 23 Nov 2012 04:13:28 -0500 (EST)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute4.internal (MEProxy); Fri, 23 Nov 2012 04:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=message-id:date:from:mime-version:to:cc
	:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=I7cFU+JEyzTuFh67UeP5Zw
	ucLP4=; b=EJ6DlxEwZwYkTvurviZn+DDRMgv88wr64ho3hGLAlX5p1qtvXnsJ5T
	u5T2PMcw6JHeK+LGNxkv6CtOzJSZ4COjqqCGdDnEnPqV3lrYcqQ0MLqVWZCepT9c
	igNd5c5lseZTiq4RY2WMd0R730Gm+C8hmrGm6gV8O3UeQMWtw1U54=
X-Sasl-enc: 77FHEKQnFGZEKKeNTANcQlg+gKvQRw9o9d73N016k3eI 1353662008
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id C38B24824F5;
	Fri, 23 Nov 2012 04:13:27 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121122221107.GA16069@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210247>

Eric S. Raymond venit, vidit, dixit 22.11.2012 23:11:
> Shawn Pearce <spearce@spearce.org>:
>> [Lots of helpful stuff ended by]
>>> 4. How does "git help" work?  That is, how is a subcommand expected
>>> to know when it is being called to export its help text?
>>
>> IIRC "git help foo" runs "man git-foo".
> 
> OK, that makes sense.
> 
>>> 5. I don't see any extensions written in Python.  Are there any special
>>> requirements or exclusions for Python scripts?
>>
>> Nope, it just has to be executable. We don't have any current Python
>> code. IIRC the last Python code was the implementation of
>> git-merge-recursive, which was ported to C many years ago. We avoid
>> Python because it is not on every platform where Git is installed. Yes
>> Python is very portable and can be installed in many places, but we
>> prefer not to make it a requirement.
> 
> I find that odd.  You avoid Python but use shellscripts?  *blink*
> 
> One would think shellscripts were a much more serious portability problem.

Different versions of python can be a mess to deal with, also, at least
with respect to standard modules being "standard" or not for a specific
version.

In any case, the point is that we try to avoid *additional*
dependencies. Shell and perl are given with the status quo.

That being said, we also have remote helpers in python. The testsuite
can run tests depending on the availability of python.

Regarding git-weave, I'm wondering (without having looked at the code)
how this relates to git-archiv and git-fast-import/export, i.e. how much
this leverages existing infrastructure rather than reinventing the
wheel. Do your "trees" correspond to a "git tree"?

Again, without having looked at the code, it seems to me that exploding
blob and tree objects might give you a structure not much unlike
weave's, and your instruction sheet resembles that of fast-import quite
a bit (plus date fill-in etc.).

One could even dream about implementing this as a remote helper instead...

Michael
