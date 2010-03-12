From: Junio C Hamano <gitster@pobox.com>
Subject: Re: re-running merge on a single file
Date: Fri, 12 Mar 2010 15:07:39 -0800
Message-ID: <7v3a05p29w.fsf@alter.siamese.dyndns.org>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
 <201003112129.52596.markus.heidelberg@web.de>
 <a038bef51003111408g38698837ldcf1d0f5995f4f30@mail.gmail.com>
 <m3hbomla3u.fsf@localhost.localdomain>
 <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com>
 <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
 <4B99E309.2070603@viscovery.net> <7viq92rpsr.fsf@alter.siamese.dyndns.org>
 <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jakub Narebski <jnareb@gmail.com>, GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 13 00:08:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqDxY-0008HV-GQ
	for gcvg-git-2@lo.gmane.org; Sat, 13 Mar 2010 00:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933397Ab0CLXHz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Mar 2010 18:07:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48346 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933282Ab0CLXHy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 18:07:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01544A1BCA;
	Fri, 12 Mar 2010 18:07:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7ae/oYLmMgc1ldF+RybhElEfCng=; b=EqQQrq
	A2uMvn4TFCsmwuzgfbohKVNU8h5P3wKl2Eic4Xx8E7foykpCGKvIq+URb6NdPQix
	Kw6uG+mcfK2o4nA4iPOWhCrUJtKt6+z9X+yxJNxGjjVsLwxRZ1OzAPNonprIWpXC
	JGNJwtnrS0jU/LhoIbmHIUF2J1l1w0Izau3Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJVJN3hnQmviXfdWOUQVDlDqt/fjauq/
	SUSiyzyNm6hHp03NsK7hnR+i3DZgZLCr0vq5K39K7H37YexNuvRTUKW4sL+KwGcs
	uANpWV2hnJtRFMzcwuiTHsG3wvzMO+8uCbaRI/oCjH4j+HhgVrqotVjBoIGK40OO
	vi6XlijTi/w=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 31D83A1BC5;
	Fri, 12 Mar 2010 18:07:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC4BDA1BBE; Fri, 12 Mar
 2010 18:07:41 -0500 (EST)
In-Reply-To: <a038bef51003121216l5c0a4942qabc3d12741c9030e@mail.gmail.com>
 (Chris Packham's message of "Fri\, 12 Mar 2010 12\:16\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 12B4E838-2E2C-11DF-A373-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142068>

Chris Packham <judge.packham@gmail.com> writes:

> ... I'm lazy and my
> projects rules allow broken commits so ...

We cannot fix, nor it is our job to fix, lazy people or undisciplined
projects ;-)

Having said that you can still retry your merge, which was _mostly_ Ok.

 (1) First, check out the original commit before the merge.  You may have
     built a few more commits on top of it, so "git log --first-parent"
     may help to find that commit.  Suppose you found that merge commit
     and we call that $merge; then:

     $ git checkout $merge^1
   
 (2) Then you retry that merge:

     $ git merge $merge^2

     which would conflict the same way you saw.

 (3) If you have rerere enabled, then the conflicts would be already
     resolved in your working tree at this point, but not in the index, so
     you can reproduce the conflicted state with "checkout -m".

 (4) If you didn't have rerere enabled, then you would have a lot of
     conflicted files in the working tree.  Inspect them by comparing with
     $merge:

     $ git diff $merge

     Since we are assuming that most of the resolution was good, and you
     know what paths you want to fix your earlier resolution for, you
     would want to take what is in $merge for most of the paths.  You can
     run checkout on paths that you know were good in $merge, like so:

     $ git checkout $merge -- include/ drivers/

     and repeat this step to narrow it down to the paths you are
     interested in.

 (5) After you fix the resolution and make a commit,

     $ git diff $merge

     will show that your earlier incorrect resolution is replaced by a new
     correct resolution.

After that, you can rebase your branch on top of HEAD to conclude.

Note that recent git can use "checkout -m path" to reproduce conflicts
even after you ran "git add path".
