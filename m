From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Please support add -p with a new file, to add only part of the
 file
Date: Tue, 10 Jan 2012 11:33:39 -0800
Message-ID: <7vd3ar9wto.fsf@alter.siamese.dyndns.org>
References: <20120109105134.1239.39047.reportbug@leaf>
 <20120109204721.GC23825@burratino> <87ty43fy7f.fsf@thomas.inf.ethz.ch>
 <7vpqer9znv.fsf@alter.siamese.dyndns.org>
 <20120110183833.GA15787@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:33:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhSC-0004ut-3F
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932989Ab2AJTdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:33:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53284 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175Ab2AJTdm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:33:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA7917A16;
	Tue, 10 Jan 2012 14:33:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=t5cXrGq5J5kteOMeI8igaxHvP7M=; b=jKkMGY
	LMwHJAHRBopyUp+UYM0nhcBM/4+FDszADSt041ZZUmDpshpJVegmE8YYGDoWShoy
	ODd7QLPlVQ2lB8iqSTEChXP+Tx4+LpeDCtEx/NhXe86UmZLG4hGoj2Io5rEhSogT
	UM24GrODOtG3we5Bj6ISgGQMwrfK1KaiTd9uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YW96WD90m2qqddMXNiNhEfmIOxYKZPJi
	1qc9wI2b+UlrzPpIfNBjpVBqgtoHMUHfRklC6gdTCAE6dpgzuubWL2Ifec8aeSKD
	cWzec5HQo2hR7GlHSoy9Yw8jeHmGNfa1Wf9TEJ11MRBDyS3ZHlpFDxc/WsESZ6XH
	eN2BKdb/U4g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFCF27A15;
	Tue, 10 Jan 2012 14:33:41 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 30BF07A14; Tue, 10 Jan 2012
 14:33:41 -0500 (EST)
In-Reply-To: <20120110183833.GA15787@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 10 Jan 2012 13:38:33 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0046227A-3BC2-11E1-9C0B-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188285>

Jeff King <peff@peff.net> writes:

>> Even if you start with "add -N", there won't be individual "hunks" you can
>> pick and choose from diffing emptiness and the whole new file, so you end
>> up using "edit hunk" interface.
>
> I don't think the main impetus for this is that people necessarily want
> to pick and choose hunks from added files.

Well, read the subject of your e-mail and tell me what it says ;-)

And that is why I was contrasting an imaginary workflow to use the
existing "add -p" with requested "allow it to be used with new files" with
what somebody may "emulate" without help from "add -p" machinery, which
is:

	$ cp newfile.c newfile.c-saved
        $ edit newfile.c ;# delete all the things you do not want for now
        $ git add newfile.c
        $ mv newfile.c-saved newfile.c

I just had to point the above out, even though I agree with the use case
you shown below for final verification. They are quite different topic, as
"git diff" won't be very useful for 'inspect changes' step in the "new
file" case to begin with.

>   $ hack hack hack
>   $ git add -p ;# inspect and add changes
>   $ git commit
>
> which is very similar to the traditional git workflow:
>
>   $ hack hack hack
>   $ git diff ;# inspect changes
>   $ git add foo ;# add changes
>   $ git commit
>
> I find myself using "add -p" almost exclusively these days, as it
> combines the two middle steps (and even though I usually am just hitting
> "y" after inspection, when I _do_ want to make a change, I am right
> there in the hunk selection loop already).
