From: Yves Goergen <nospam.list@unclassified.de>
Subject: Re: Bug? Git checkout fails with a wrong error message
Date: Tue, 17 Jan 2012 18:56:42 +0100
Message-ID: <4F15B65A.8070009@unclassified.de>
References: <loom.20120112T193624-86@post.gmane.org>	<4F1028AD.9080701@ira.uka.de> <4F106DDF.4040408@unclassified.de>	<4F1085EC.9010708@ira.uka.de> <4F128AD0.5020101@unclassified.de>	<4F1404E7.9040805@ira.uka.de> <4F14718B.80209@unclassified.de>	<87r4yzzcci.fsf@thomas.inf.ethz.ch> <4F152767.9010104@unclassified.de> <87ipkaogyj.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Holger Hellmuth <hellmuth@ira.uka.de>, Jeff King <peff@peff.net>,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>,
	git@vger.kernel.org, Erik Faye-Lund <kusmabite@gmail.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Jan 17 18:57:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RnDHR-0004NV-2l
	for gcvg-git-2@lo.gmane.org; Tue, 17 Jan 2012 18:57:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753322Ab2AQR46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jan 2012 12:56:58 -0500
Received: from dotforward.de ([178.63.102.138]:34898 "EHLO dotforward.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753175Ab2AQR44 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2012 12:56:56 -0500
Received: from dsl01.83.171.184.42.ip-pool.nefkom.net ([83.171.184.42] helo=[192.168.1.13])
	by dotforward.de with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <nospam.list@unclassified.de>)
	id 1RnDH1-0005Ls-QP; Tue, 17 Jan 2012 18:56:44 +0100
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
In-Reply-To: <87ipkaogyj.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188709>

On 17.01.2012 09:45 CE(S)T, Thomas Rast wrote:
> It would also be interesting to know for how long this problem has
> existed.  You can search for the offending commit with something like
> 
>   git log --name-status --diff-filter=A -- "PosterWantsItCensored.*"
> 
> which should normally give you just one or two commits, namely the
> one(s) that introduced the two files.

I have found two commits adding that file. The second one has the file
with the then-already-present name modified and the new spelling added.
I could have noticed that at commit time, but that's the very commit
where I also renamed the original files and recreated them in the Forms
designer. 1) This may have led me to overlook that additional add and 2)
this may be the source of the spelling difference because the file was
newly created.

> As for the fix, there are two-and-two-thirds cases. (...)

That all sounds quite complicated. The "offending" commit is quite a
while back so replacing the last commit is not a solution.

This is just my personal repository that should help me out with finding
changes when I find something broken that wasn't before. Deleting and
recreating the "hub" (bare) and the other working repository would be
okay for me in this case. I have decided that it is also okay to fix the
error by new commits. To avoid all further issues with this, I have
renamed the file, committed the deletion, renamed it back and then
committed the add. The revsion in between won't compile, but it's got a
message with it and the compiler error would be obvious.

> You should really read up on this, e.g.
> 
>   http://tomayko.com/writings/the-thing-about-git
> 
> AFAIK everyone who groks the feature uses it daily.

It's on my to-read list. Looks like an interesting article from reading
the beginning of it.

I have done a test, too: I have set the core.ignorecase setting to false
(or deleted its entry) and then renamed one of the files in my working
directory only in case. TortoiseGit has offered me adding the new
spelling for a commit. After setting the core.ignorecase setting to
true, it has not offered any change to commit anymore. So it looks like
this is just the setting that every repository for Windows use should -
no - must have, and it was missing here.

Just like that stupid autocrlf that causes more issues than it solves. I
regularly see files with all lines changed and the diff says that both
files only differ in line endings. But I have no sure observation on
whether that value was set or unset in those cases. I'll have to look
after that, too.

These two config settings are not cloned with the repository, are they?

Also, TortoiseGit already sets ignorecase = true. So maybe the Visual
Studio provider does the init on its own and is missing that. Or I have
at some time cloned the repository and the setting wasn't copied over.

-- 
Yves Goergen "LonelyPixel" <nospam.list@unclassified.de>
Visit my web laboratory at http://beta.unclassified.de
