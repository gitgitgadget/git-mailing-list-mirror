From: Jan Hudec <bulb@ucw.cz>
Subject: Re: How to bypass the post-commit hook?
Date: Mon, 31 Dec 2007 18:05:32 +0100
Message-ID: <20071231170532.GB9214@efreet.light.src>
References: <46dff0320712300712l78c1cdaeya5fa105be01f6b74@mail.gmail.com> <20071230215008.GB20098@efreet.light.src> <46dff0320712302108i61f3b868obb93f89c1c24062c@mail.gmail.com> <20071231093152.GC20098@efreet.light.src> <46dff0320712310222m64d86e95l1499a7ffb1fff65c@mail.gmail.com> <20071231105514.GA9214@efreet.light.src> <46dff0320712310526l2b801ed7xc52b7aae2d65048e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 31 18:06:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9O5e-0005zV-6V
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 18:06:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXLaRFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 12:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbXLaRFs
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 12:05:48 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:47231 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750942AbXLaRFs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 12:05:48 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id B2C89573F7;
	Mon, 31 Dec 2007 18:05:46 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Qrzvox8-Tx48; Mon, 31 Dec 2007 18:05:44 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id A6F4357472;
	Mon, 31 Dec 2007 18:05:43 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J9O4y-00033K-KW; Mon, 31 Dec 2007 18:05:32 +0100
Content-Disposition: inline
In-Reply-To: <46dff0320712310526l2b801ed7xc52b7aae2d65048e@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69406>

On Mon, Dec 31, 2007 at 21:26:21 +0800, Ping Yin wrote:
> On Dec 31, 2007 6:55 PM, Jan Hudec <bulb@ucw.cz> wrote:
> > Note, that you can -- and should -- add the foo.css to the commit. But the
> > file might contain other changes in tree, that are not about to be commited,
> > so prefered way would be to get the content from the index, modify that and
> > update the index manually (with git update-index).
> 
> If pre-commit has modified files to be commited, it will abort this
> commit and give a message to direct the user to commit again
> with/without the changed content.
> 
> AFAIK, git add -i can add selected chunk to the index. As you said,
> can git-update-index also do this job?

git update-index is the underlying plumbing for git add/git rm.

However, you should change foo.css in index even if the working tree copy
does not match it and is not selected for commit. Only way I see to do that
is to prepare a patch and apply it to both the working tree (git apply) and
to the index (git apply --cached).

It will probably work for you without such finesse, you will just have to be
aware of it's quirks.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
