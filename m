From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patchdiff
Date: Tue, 26 Jan 2010 17:30:57 -0800
Message-ID: <7vzl40wcz2.fsf@alter.siamese.dyndns.org>
References: <fabb9a1e1001261606i4f706387vaf5647436e454fb4@mail.gmail.com>
 <alpine.LFD.2.00.1001262014250.1681@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Wed Jan 27 02:31:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZwkV-0006hM-Mr
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 02:31:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752656Ab0A0BbL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2010 20:31:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752002Ab0A0BbK
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 20:31:10 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45785 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752044Ab0A0BbH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2010 20:31:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FBC994FF0;
	Tue, 26 Jan 2010 20:31:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nPAdaVwj+YTxLPuK8gUrky49fuM=; b=gfQ9Ip
	YGhVdLtj/H7b54lxwnT3KBKNR4Hnc5YpYJ94u3K7r4XL5DrkoCigFrVQv32cZM7j
	appa4CDK9SKwYuFA+brcugD4qur5rKLul2gt7uwvTMww+6PhnC8lfBE2gvnLk017
	EyixF2HGYcCvSeWrXZWiXSPzNKtrSfAA99/rU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QGOvfgYAIA+isNVaoDcAsJL6frIhBRdk
	2sDUsmHSpQx2T7BmaxA0P94XgTih31bS+jcZHJfaLSxT3eU0oqnbbGZPvZaSlVhT
	ThMKKl0F42ZNGJxbnFA7zvzQsVbhsJqXImgIS/8e3imkOHQ0cZnlWkeTwYRFjLoq
	ZOPJCV6WjZA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D717B94FEF;
	Tue, 26 Jan 2010 20:31:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 09E0D94FEE; Tue, 26 Jan
 2010 20:30:58 -0500 (EST)
In-Reply-To: <alpine.LFD.2.00.1001262014250.1681@xanadu.home> (Nicolas
 Pitre's message of "Tue\, 26 Jan 2010 20\:19\:13 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A18A5578-0AE3-11DF-88AA-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138099>

Nicolas Pitre <nico@fluxnic.net> writes:

>> Do we have anything that allows me to compare two versions of a patch?
>> In theory it'd do something like "apply both patches to the their
>> merge base, then show the diff between the results". I don't think we
>> have something like that, since there's probably some major caveats
>> about conflicts when applying the patches to their merge-base. Or
>> perhaps my theory is silly, and there's an easier way to compare two
>> patches (other than looking at a diff's diff, which I've never been
>> good at).
>
> What about Git's diff -c/--cc ?  You'd have to reverse the parenthood 
> logic though.

When I did "diff --cc" originally, I thought about its interaction with
reverse (-R), and gave up.

The thing is, "--cc" output needs to show "here is _the_ end result",
together with "and each sides did things in these different ways (shown
with +/- annotations)".

When showing a merge, there is one end result (the merged version), so it
fits the model that is a natural extension of two-way diff.  In the "two
patches walked in a bar, modified the same version and produced two
different results" case, the common thing is the preimage, not postimage.
I couldn't come up with a combined output format that visually makes sense
for that mode of operation.
