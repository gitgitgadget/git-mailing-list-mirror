From: "Anders Melchiorsen" <mail@cup.kalibalik.dk>
Subject: Re: [BUG] git ls-files -m --with-tree does double output
Date: Sun, 16 Nov 2008 10:00:15 +0100 (CET)
Message-ID: <58634.N1gUGH5fRhE=.1226826015.squirrel@webmail.hotelhot.dk>
References: <37512.N1gUGH5fRhE=.1226613228.squirrel@webmail.hotelhot.dk>
    <7vod0jfe51.fsf@gitster.siamese.dyndns.org>
    <57320.N1gUGH5fRhE=.1226617873.squirrel@webmail.hotelhot.dk>
    <7vr65c3xn5.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 16 10:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L1dVf-0007p5-K4
	for gcvg-git-2@gmane.org; Sun, 16 Nov 2008 10:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751661AbYKPJAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Nov 2008 04:00:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYKPJAS
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Nov 2008 04:00:18 -0500
Received: from mail.hotelhot.dk ([77.75.163.100]:47106 "EHLO mail.hotelhot.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751457AbYKPJAR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Nov 2008 04:00:17 -0500
Received: from mail.hotelhot.dk (localhost [127.0.0.1])
	by mail.hotelhot.dk (Postfix) with ESMTP id 4A58414068;
	Sun, 16 Nov 2008 10:00:15 +0100 (CET)
Received: from webmail.hotelhot.dk (mail.hotelhot.dk [192.168.0.190])
	by mail.hotelhot.dk (Postfix) with ESMTP id 118EB14062;
	Sun, 16 Nov 2008 10:00:15 +0100 (CET)
X-Squirrel-UserHash: NQYRRTwcNktTVUlTWFZaWRRVWg==
X-Squirrel-FromHash: N1gUGH5fRhE=
In-Reply-To: <7vr65c3xn5.fsf@gitster.siamese.dyndns.org>
User-Agent: SquirrelMail/1.4.13
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101119>

Junio C Hamano wrote:
> "Anders Melchiorsen" <mail@cup.kalibalik.dk> writes:
>
>> Junio C Hamano wrote:
>>
>>> What's the use case of using -m together with --with-tree to begin
>>> with?
>>
>> The script runs
>>
>>    git ls-files -d -m -o -t --with-tree=HEAD
>>
>> to get a parseable "git status"-like output. If I leave out
>> --with-tree=HEAD, I do not get information about staged changes.
>

> [...]

> I lack the context to interpret what you mean by "The script", but in any
> case, the only use case --with-tree was designed for was to use it in
> conjunction with --error-unmatch inside the scripted version of "git
> commit", to see if the paths given by the users make sense as a request to
> create a partial commit.  It is not entirely surprising if any other funny
> options do not work with it at all.

"The script" is just a random script I was writing when I found this issue.

If --with-tree is only meant for --error-unmatch, maybe update the help to
show it like this,

    [--error-unmatch [--with-tree=<tree-ish>]]

I never read the description of --with-tree, I just found the parameter in
the top of the man page and tried it out. It did what I wanted, but gave
double output. And so I reported that in this thread, as I believed it to
be an error.

Now I understand that I am using ls-files in unintended ways, but I cannot
really fix that when no "git status" like plumbing tool is available.

> Having said all that, I think this would fix it.

That sure seems to fix my test case.


Anders.
