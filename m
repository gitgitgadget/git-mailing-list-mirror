From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Wed, 25 Jan 2012 13:22:22 -0600
Message-ID: <20120125192222.GH1824@burratino>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com>
 <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
 <20120124232239.GG8222@burratino>
 <op.v8motzak0aolir@keputer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 20:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq8QT-0006LA-6V
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 20:22:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797Ab2AYTW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 14:22:28 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:51007 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab2AYTW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 14:22:27 -0500
Received: by yhoo21 with SMTP id o21so2587153yho.19
        for <git@vger.kernel.org>; Wed, 25 Jan 2012 11:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lVUo20wDmCaqUvKBRxQxUx8UsuBB+jb17xqKqBtbYvU=;
        b=kqqerY8yHUccuaaEBS15/VG3MQmBzgXAodBV1kypBkwq2PQpAf+oo9oyeEB6FoYtFn
         /UauacPBMV19deAKYdlKJ7CN3lgsj/iw0vTtmY0G/UYwiRQA3Ee9GrdvmfNPsOKMFSy8
         pdDZArkqYwIuL/KCURxu26GDi6mMLc3Uz31KI=
Received: by 10.236.177.6 with SMTP id c6mr27492121yhm.42.1327519346842;
        Wed, 25 Jan 2012 11:22:26 -0800 (PST)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id y14sm3657070anm.10.2012.01.25.11.22.24
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Jan 2012 11:22:25 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <op.v8motzak0aolir@keputer>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189121>

Frans Klaver wrote:
> Jonathan Nieder wrote:

>> Could you give an example?
>
> The case that triggered me to work on this. I had an incorrect entry
> in my PATH and some aliasing tests failed. The generated command
> output was something like
>
> fatal: script: Access Denied

Sorry for the lack of clarity.  I meant that a (precise) "before and
after" example could make the commit message a lot easier to
understand.

[...]
>> What happens on Windows?
>
> I haven't changed anything on the windows side, so that probably
> sticks to the old behavior.

This was mostly a comment on the change description --- unless I look
at the patch, if I try this out on Windows after reading the changelog
I would end up utterly confused.  For patch 5/5, it also brings up
worries about consistency --- if systems are going to be relying on a
missing #! interpreter being treated differently from a missing script
for the sake of silent_exec_failure, do the same considerations apply
on Windows, too?

Perhaps it's more along the lines of "this is not supposed to happen
in practice, and when it does, humans will find it easier to debug if
we error out hard instead of falling back to the 'if the command does
not exist' behavior (e.g., by trying an alias next)".  In other words,
maybe this is intended as an optional nicety rather than something
scripts would ever rely on.

Jonathan
