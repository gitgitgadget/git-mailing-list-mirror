From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] git-commit: add a prepare-commit-msg hook
Date: Fri, 18 Jan 2008 22:08:25 +0100
Message-ID: <20080118210825.GB3411@steel.home>
References: <4790BCED.4050207@gnu.org> <20080118190509.GA3411@steel.home> <47910229.90700@gnu.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jan 18 22:08:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFySR-0006sD-Ap
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 22:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762550AbYARVIa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 16:08:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760066AbYARVIa
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 16:08:30 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32081 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759875AbYARVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 16:08:29 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Ccul2hcN05LQ==
Received: from tigra.home (Fa934.f.strato-dslnet.de [195.4.169.52])
	by post.webmailer.de (fruni mo62) (RZmta 15.4)
	with ESMTP id v0406ck0IJ0Iro ; Fri, 18 Jan 2008 22:08:26 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 0C844277AE;
	Fri, 18 Jan 2008 22:08:26 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 9804356D22; Fri, 18 Jan 2008 22:08:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <47910229.90700@gnu.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71065>

Paolo Bonzini, Fri, Jan 18, 2008 20:46:49 +0100:
> Alex Riesen wrote:
>> Paolo Bonzini, Fri, Jan 18, 2008 15:51:25 +0100:
>>> +		if (!edit_message) {
>>> +			run_hook(index_file, "prepare-commit-msg", git_path(commit_editmsg));
>>> +		}
>>>  		launch_editor(git_path(commit_editmsg), NULL, env);
>> "preedit-new-commit-msg", perhaps. A "prepare-" suggests it is called
>> every time, even if no editor is specified, which it is not.
>> And it really does look like a template...
>
> It is, but quite a powerful one. :-)

Except that "template" is already taken. Someone uses it and some may
even got used to "template" having that meaning.

> template-commit-msg?

Not really. It will be run even if the template (the one Git have
already) is not used.

It really looks a bit complicated. If at all, how about running that
"pre-editor" hook with information about where the message comes from?

I.e. if the message comes from a template:

    preedit-commit-msg .git/COMMIT_MSG template

or, for a message coming from commit:

    preedit-commit-msg .git/COMMIT_MSG commit 0123456789abdef

or, for a message coming from a file

    preedit-commit-msg .git/COMMIT_MSG file user/path/to/file

and finally, for a new message:

    preedit-commit-msg .git/COMMIT_MSG

?
