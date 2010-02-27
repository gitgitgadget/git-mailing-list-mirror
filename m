From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFD] Deepen the git directory structure a bit.
Date: Fri, 26 Feb 2010 17:28:51 -0800
Message-ID: <7vzl2va2lo.fsf@alter.siamese.dyndns.org>
References: <alpine.LFD.2.00.1002181010590.4141@localhost.localdomain>
 <alpine.LFD.2.00.1002220830550.4141@localhost.localdomain>
 <7v7hq46gwe.fsf@alter.siamese.dyndns.org> <4B8657EC.8060302@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Fabian =?utf-8?Q?K=C3=B6ssel?= <mok4sin@googlemail.com>
X-From: git-owner@vger.kernel.org Sat Feb 27 02:29:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlBUZ-0003Gh-2V
	for gcvg-git-2@lo.gmane.org; Sat, 27 Feb 2010 02:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966847Ab0B0B3B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2010 20:29:01 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:56027 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966844Ab0B0B27 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2010 20:28:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4F34E9DAD9;
	Fri, 26 Feb 2010 20:28:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=Y/2ReRqo8aVHARMCEUUuRiwXY
	+0=; b=qzR/zrgNmDFMD2C7Z+iWRC5lC4I9fccwyRHW3tapjuAhD+RMkcpqFYXu+
	YRa3/2+HjzwFuw0+a3rEkyQziXLK90Rw1qmaJvTRH0dZOJa0y4Rf/f76Qyb5rouC
	qV3Vq+rTL0bWXmI09TvTy1178M4Qxnl2KOzC4sTd90mjm3OsVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=fMhu1QDsP2HhMVufOZ0
	bsCV7ETw+0UJDeG63syQRbxp4H5o0eZ2ZEmQ6bNtnUBG2m22l5A18KM66Xlz4PyS
	C/O1PkGak0ZMcnOG9DNvxDToZ7IWAbM76lFq0mCeATbpjwW/gBWbJpaPjFsh1TJt
	VTx+1kMP0kWWt9buNCVOmQpA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E9099DAD8;
	Fri, 26 Feb 2010 20:28:55 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F19E9DAD7; Fri, 26 Feb
 2010 20:28:52 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 783D9E40-233F-11DF-AB04-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141164>

=46abian K=C3=B6ssel <mok4sin@googlemail.com> writes:

> On 22.02.2010 23:32, Junio C Hamano wrote:
>> I'll queue with a trivial addition of "rm builtin/*.o" to the "make
> clean"
>> target.  I am not looking forward to merging the result of this with
> other
>> topics, though... X-<.
>
> Just out of curiosity, how do you actually merge such a relatively bi=
g
> rename with other branches?

=46or git.git, existing files are not so troublesome.  merge-recursive =
knows
how to handle renames, so does "am -3", but the latter is tricky when t=
he
contributor based a patch on some unknown vintage of the source.

A topic with a new builtin command is a bit problematic and no mechanic=
al
merge would help. I suspect that no other SCM would be able to either.

 - A topic that adds builtin-frotz.c has an entry that describes how to
   build builtin-frotz.o in Makefile, somewhere near Linus's topic chan=
ges
   an existing builtin-nitfol.o to builtin/nitfol.o.  The topic would h=
ave
   added the new target already, and then we are merging Linus's topic.
   The merge will conflict.  Every time I rebuild 'pu', this conflict w=
ill
   reappear over and over.

   But once the conflict is resolved, rerere will remember it for me, s=
o
   this is not a big problem.

 - A new builtin-frotz.c file in such a topic is more problematic.
   Linus's patch does not know anything about it, so it will merge
   cleanly, but the merge will not move it to builtin/frotz.c; this nee=
ds
   to be fixed manually as an evil merge.

   I have automated such an evil merge so that I can rebuild 'pu' witho=
ut
   manual intervention.
