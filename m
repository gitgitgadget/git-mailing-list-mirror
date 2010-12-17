From: Junio C Hamano <gitster@pobox.com>
Subject: Re: conflict resolution of pd/bash-4-completion [Re: What's cooking
 in git.git (Dec 2010, #05; Thu, 16)]
Date: Fri, 17 Dec 2010 11:24:46 -0800
Message-ID: <7v1v5gjj7l.fsf@alter.siamese.dyndns.org>
References: <7vk4j8kfwy.fsf@alter.siamese.dyndns.org>
 <20101217111856.GA9304@neumann>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Dec 17 20:25:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTfva-0005vV-F7
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 20:25:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754830Ab0LQTY7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Dec 2010 14:24:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47515 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754413Ab0LQTY4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Dec 2010 14:24:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62B892C55;
	Fri, 17 Dec 2010 14:25:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=fOXC41zQpMJ9mvRzyK7SiRaOP
	vI=; b=xWumFVepH4WRpCj5ETSYin8buuDMsxE6WEA1LyJ7jL0VpL6VMl9hXwke8
	IgjF2D19hZjd5cD3N/pAfsOWOKGYmV6+quVemyS7Gmz+37yrPk2nbWkrucYGi8JZ
	EniBUoHwiaPjFtKExL1J2/v8MYdgJWf1Tp1bBAtuqVoua/JnvA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=WSOiMx4CRQ8vboP4YKM
	o3vpfWyELM690uH+MTtT5W8jRjS6tW9E7I5jlGwBWwSP3pjkfw8sz39SON2v+O9y
	CkQfdSkaTDbkQUq78BO9vyiGGuA0h5oF8/7wJ+Mc9gRZzBOyvLHADr96RoHEbi3G
	Mmoc8B4DWWbTp/huYBzSA4pU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 407902C54;
	Fri, 17 Dec 2010 14:25:19 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 498352C4E; Fri, 17 Dec 2010
 14:25:16 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6260476A-0A13-11E0-B3B5-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163884>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Thu, Dec 16, 2010 at 11:38:21PM -0800, Junio C Hamano wrote:
>> * pd/bash-4-completion (2010-12-15) 3 commits
>>  - Merge branch 'master' (early part) into pd/bash-4-completion
>>  - bash: simple reimplementation of _get_comp_words_by_ref
>>  - bash: get --pretty=3Dm<tab> completion to work with bash v4
>>=20
>> Updated by Jonathan; this still has some conflicts around "notes"
>> completion I tried to resolve near the tip of 'pu'.
>
> The resolution of that conflict is not quite correct.  I'm not sure
> how I should send a proper conflict resolution...  but I'll try
> anyway.

Thanks, this helped me quite a lot to update my rerere database, so tha=
t
the fix-up can be carried forward in future merges to 'next' and
eventually 'master'.

=46or anybody interested, here is how a merge fix-up patch like yours c=
an be
used:

1. First apply to the commit it is intended to be applied:

    $ git co pu
    $ git am your-patch

2. Re-attempt the merge.  CG stands for "Commit Goal".

    $ CG=3D$(git rev-parse HEAD)
    $ git reset --hard HEAD^^
    $ git merge pd/bash-4-completion

3. Clear the rerere database and redo the merge, letting it conflict.

    $ git rerere forget contrib/completion/git-completion.bash
    $ git reset --hard
    $ git merge pd/bash-4-completion

4. Take the fixup and conclude the merge; this updates the rerere
   database.

    $ git checkout $CG .
    $ git commit
