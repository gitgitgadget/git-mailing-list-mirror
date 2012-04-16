From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] completion: add new git_complete helper
Date: Mon, 16 Apr 2012 13:51:23 -0700
Message-ID: <7v7gxftn78.fsf@alter.siamese.dyndns.org>
References: <1334524814-13581-1-git-send-email-felipe.contreras@gmail.com>
 <20120415213718.GB5813@burratino>
 <CAMP44s0PWAV=nD1xnAFMx8OPby88W2jKwDGtiUFY4LA93D-gAw@mail.gmail.com>
 <7vaa2by8nj.fsf@alter.siamese.dyndns.org> <20120416160729.GM5813@burratino>
 <CAMP44s2_VYNFeBi9GPa9CeqT=oRmSq1J1XaSP+aKgC6bJ55Lfg@mail.gmail.com>
 <20120416200941.GD12613@burratino>
 <CAMP44s0CVsmHw4jQqHvZMi342V8-Yh2zYYcAE_5EHu5OAiktcw@mail.gmail.com>
 <20120416203320.GF12613@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 22:51:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJstY-0001H8-PI
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 22:51:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab2DPUv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 16:51:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63108 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751023Ab2DPUv0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 16:51:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B33C6326;
	Mon, 16 Apr 2012 16:51:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FcqjptfSRH9ZmSz8/1y+hVXJq2U=; b=DXITAm
	F2ZBlR/oqEAQ94J6PBE8VY5NlnK9ewu8bGFeP9W5e7rOh0hJxpo2GAPzEk5DQV4y
	i39aWt8iU2Z5EF7CEe3Mjgo5nX/BNcnjUC6QEAdbBq5UPQJ+2/YsZmnG71hSabIA
	7tjdXMsjxKTQcWHuI4F+bdZxAZxtJhklvn3uE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JCsZoRxkUlwA/NqnJI0omIrUuvy70mEv
	DybahnGo+skLgFyrK+ayuSboF2rwaDavucpO9KVFp8kggqi6bFveay79p6Vf7Yhm
	3Ih+aQ3o+Cmr01qNckOB3E4AazbXShDCuLgjhZbnEEydYB67lrRTtxz7KengrGks
	kS8bRLwPnKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 426AE6325;
	Mon, 16 Apr 2012 16:51:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4CE66324; Mon, 16 Apr 2012
 16:51:24 -0400 (EDT)
In-Reply-To: <20120416203320.GF12613@burratino> (Jonathan Nieder's message of
 "Mon, 16 Apr 2012 15:33:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EE15DCEA-8805-11E1-BC25-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195692>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Felipe Contreras wrote:
>> On Mon, Apr 16, 2012 at 11:09 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> Felipe Contreras wrote:
>
>>>> I would like to see a completion script that actually has a function
>>>> supposed to be exported and that still uses the _ prefix anyway.
>>>
>>> The /etc/bash_completion library itself exports lots and lots of
>>> functions with a _ prefix.
>>
>> We are not making a bash_completion library; I mean a bash completion
>> script (other than the library).
>
> Ok.  If you refuse to put two and two together, then I will (as usual
> when this happens) just be a little passive aggressive and annoyed and
> let you talk to other people.

I have been assuming that bash_completion library is a sort of metaproject
whose sole purpose is to supply a framework for completion scripts for
other packages like Git to be plugged easily and give niceties like lazy
loading to avoid inflicting undue latencies to the end users.

Earlier I said "Ok" to you based on that assumption; somebody may have his
own git_complete that rebuilds a test integration branch (i.e. completes
it) and having the name git_complete exported by us will indirectly affect
her fingers if she installs bash_completion and Git package on her system.

But that assumption may not be correct, or even if it is correct, Felipe
may be missing that part, so it may not be "refusing to add two and two",
but could be "learned two, but do not know the number of the other side of
addition".
