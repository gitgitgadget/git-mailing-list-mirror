From: Junio C Hamano <gitster@pobox.com>
Subject: Re: builtin command's prefix question
Date: Thu, 06 Dec 2007 08:04:29 -0800
Message-ID: <7v63zbg67m.fsf@gitster.siamese.dyndns.org>
References: <fcaeb9bf0712050856t5d730779q82783fdb9876f41@mail.gmail.com>
	<7vlk88n648.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0712060726r383c3a36j798a439b9dbb0cae@mail.gmail.com>
	<Pine.LNX.4.64.0712061547070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 06 17:06:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0JDo-00062W-Qc
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 17:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752816AbXLFQEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 11:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXLFQEp
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 11:04:45 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:45631 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752542AbXLFQEo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 11:04:44 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 8E7632EF;
	Thu,  6 Dec 2007 11:05:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 056409D811;
	Thu,  6 Dec 2007 11:04:58 -0500 (EST)
Cc: madduck@madduck.net
In-Reply-To: <Pine.LNX.4.64.0712061547070.27959@racer.site> (Johannes
	Schindelin's message of "Thu, 6 Dec 2007 15:48:02 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67300>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Thu, 6 Dec 2007, Nguyen Thai Ngoc Duy wrote:
>
>> On Dec 6, 2007 6:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > However, if we define setup() to behave this way when GIT_DIR is not 
>> > defined and GIT_WORK_TREE is:
>> >
>> >  (1) internally pretend as if GIT_DIR was specified to be the
>> >      directory where the command was started from (iow, do getcwd()
>> >      once upon startup);
>> >
>> >  (2) chdir to GIT_WORK_TREE (which means "callers of setup() always
>> >      run from the top of the work tree");
>> >
>> >  (3) set prefix to NULL;
>> 
>> (1) is fine by me, even if it goes up to find a gitdir. But (3), no, 
>> prefix should be set as relative path from worktree top directory to 
>> user current directory, not NULL.
>
> If you expect "git <command> <filespec>" to work correctly from GIT_DIR, 
> you will _have_ to set the prefix to NULL.

That depends on the definition of "correctly".

As I said, I think the above "rule-looking things" implement an insane
behaviour where you are in one directory, and use that <filespec> to
name things relative to some other directory whose location is
completely unrelated to the directory you are in.  IOW, not a good set
of rules, and I do not necessarily agree with the statement that says
such a behaviour is working "correctly from GIT_DIR".
