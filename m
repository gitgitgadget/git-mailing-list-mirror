From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: git add -p and unresolved conflicts
Date: Thu, 29 Mar 2012 09:26:55 +0200
Message-ID: <vpqvclnhnpc.fsf@bauges.imag.fr>
References: <CABPQNSYVXMxS3kugu1j=62ArJ_1saYYfMjJdZvqhjgPFGN=Eqw@mail.gmail.com>
	<7vbongyd67.fsf@alter.siamese.dyndns.org>
	<vpqvclozr7e.fsf@bauges.imag.fr> <4F73632E.1060408@ira.uka.de>
	<vpqk424zfb1.fsf@bauges.imag.fr> <4F737027.5020503@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Thu Mar 29 09:27:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SD9ln-0006sQ-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 29 Mar 2012 09:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751703Ab2C2H1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Mar 2012 03:27:08 -0400
Received: from mx1.imag.fr ([129.88.30.5]:36312 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751097Ab2C2H1G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2012 03:27:06 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q2T7LjE9029722
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Thu, 29 Mar 2012 09:21:45 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1SD9l1-0008A5-VB; Thu, 29 Mar 2012 09:26:56 +0200
In-Reply-To: <4F737027.5020503@ira.uka.de> (Holger Hellmuth's message of "Wed,
	28 Mar 2012 22:10:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.93 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Thu, 29 Mar 2012 09:21:45 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q2T7LjE9029722
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1333610506.12652@8xjpdx39UuKQetE1/ImbzQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194241>

Holger Hellmuth <hellmuth@ira.uka.de> writes:

>> And you miss the most usefull (to me at least): "choose the version in
>> the worktree".
>>
>
> But the conflicted chunks are of the form "<<<< our ... ||||||||||
> theirs >>>>>>" in your work tree. So there are two cases:
>
> a) You have removed the markers thereby removing the conflict -> this
> means the chunk will not be offered to you as a conflicting chunk

If you have removed the markers, then the file is still marked as
conflicted in the index, and the user may still want to see the combined
diff.

My use-case is actually quite simple: I see "git add -p" both as a way
to make partial commits, and as a way to manually validate what I'm
about to commit. I review the diff, validate them with "y", and if I see
something wrong, I quit "git add -p", fix the issue, and next "git add
-p" won't show it again. This flow could work also with conflicts:

$ git add -p
# see an unresolved diff for file foo.txt
n
# see a resolved diff for file bar.txt
y        <-- the "missing" possibility for me
$ edit foo.txt
$ git add -p
# see resolution for file foo.txt
y
$ git commit

The "'git reset $path' before 'add -p'" workaround is not really handy
there: it requires typing the path, while my workflow with "git add -p"
does not, and it wouldn't show the combined diff, which is usually the
best tool to see if a merge has been resolved properly.

The current behavior is not that bad for me: I see the combined diff in
the output, I just have one extra "git add $path" to type. Being able to
just say "y" instead would be handy, but not fundamentally different.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
