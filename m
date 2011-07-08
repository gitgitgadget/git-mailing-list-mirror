From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Redoing a merge for a particular file
Date: Thu, 07 Jul 2011 17:36:45 -0700
Message-ID: <7vaacphale.fsf@alter.siamese.dyndns.org>
References: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 02:36:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qez3t-0005su-EQ
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 02:36:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657Ab1GHAgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 20:36:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58772 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751680Ab1GHAgr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 20:36:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 64F8166C7;
	Thu,  7 Jul 2011 20:36:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4ZWWUww6tP55HcLNoqmnJYnofOs=; b=ykMLeJ
	Bn4ONeRSE2JsmSPfzLpcJ9vd/Jid5juUF8ezWoqxOI8ZlptgTW/yhpnk19hK6Xme
	VoETYv5lVEnOGqZqjYbbdR1Tx/6bjcdRoP7Wp4HIGy9YWQwj+6FQeMSgCyywIckQ
	rrU3g160DQhlNqKptdNABZV1Trd/RmVAkSzEw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ePHbhi3wrZkMEcaqC7J3QvowuxMzdjOS
	ohHJH9jIgSACrl+74FK7lmhkXF6b/eEWF/kIoVKxAJQGYKhEjcBEeodu+XsV0Ycu
	Wcxb60l3KrOt+n4RSH090P5KOqQDVmaf06BMOKG92prdDUu58UNXmT6XYUlqsvl8
	9U+h+AXVUtM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5D11366C6;
	Thu,  7 Jul 2011 20:36:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C145E66C5; Thu,  7 Jul 2011
 20:36:46 -0400 (EDT)
In-Reply-To: <CAFOYHZCFetkokgtn4z0O3nPTEy6GCTEcN0Pzc8ce-joqMzZM1Q@mail.gmail.com> (Chris
 Packham's message of "Fri, 8 Jul 2011 10:24:10 +1200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5C7B72D0-A8FA-11E0-A019-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176793>

Chris Packham <judge.packham@gmail.com> writes:

>   $ git merge topic
>   Auto-merging foo.c
>   CONFLICT (content): Merge conflict in foo.c
>   Auto-merging bar.c
>   CONFLICT (content): bar.c
>   Auto-merging otherfile1.c
>   Auto-merging otherfile2.c
>   Auto-merging otherfile3.c
>   Resolved 'foo.c' using previous resolution.
>   Resolved 'bar.c' using previous resolution.
>   Automatic merge failed; fix conflicts and then commit the result.
>   $ git mergetool
>   No files need merging
>
> So rerere has remembered the bad resolution of foo.c.

I would do this:

 $ git rerere forget foo.c
 $ git checkout -m foo.c

then fix it up and

 $ git add foo.c
 $ git commit
