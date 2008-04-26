From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH resend] make "git push" update origin and mirrors, "git
 push --mirror" update mirrors
Date: Sat, 26 Apr 2008 10:46:16 -0700
Message-ID: <7vzlrgmrvb.fsf@gitster.siamese.dyndns.org>
References: <4812DA50.3000702@gnu.org> <20080426170126.GC29771@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Apr 26 19:47:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JpoUb-0005pb-6a
	for gcvg-git-2@gmane.org; Sat, 26 Apr 2008 19:47:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbYDZRqe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Apr 2008 13:46:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751501AbYDZRqe
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Apr 2008 13:46:34 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33424 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbYDZRqd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Apr 2008 13:46:33 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 826074D58;
	Sat, 26 Apr 2008 13:46:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id D52484D56; Sat, 26 Apr 2008 13:46:25 -0400 (EDT)
In-Reply-To: <20080426170126.GC29771@spearce.org> (Shawn O. Pearce's message
 of "Sat, 26 Apr 2008 13:01:26 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80383>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Why not just have a remote named "my-mirror" and do `git push my-mirror`?
> Yes, its on keystroke longer to type.  Call it foo.  `git push foo` would
> be shorter, and not require code changes in Git.

Configuring to push to multiple can already be done as you described, not
having to have a special case code like this patch is certainly very
attractive, and also it is one less "magic" applied to the configuration
(meaning, when you have to figure out what an unadorned "git push" does
for somebody else who is having trouble, you have one less thing to
consider).

I've been torn between

 (1) but then you have to have an extra 'foo' remote and with this patch
     it becomes unnecessary, and

 (2) no, by separating individual remotes (which are not 'foo') and a
     magic "pushing to everywhere" (which is 'foo'), that extra 'foo'
     simplifies things, to explain, understand, and diagnose (when
     something goes south).

I am leaning towards the latter argument now, especially after you
commented on this issue.
