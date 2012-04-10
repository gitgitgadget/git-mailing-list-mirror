From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stash refuses to pop
Date: Tue, 10 Apr 2012 11:05:57 -0700
Message-ID: <7vpqbfpim2.fsf@alter.siamese.dyndns.org>
References: <4F847350.3000409@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Phillip Susi <psusi@ubuntu.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:06:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHfSB-0006io-45
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:06:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755331Ab2DJSGA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:06:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41680 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754629Ab2DJSGA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:06:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 904266194;
	Tue, 10 Apr 2012 14:05:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=byLD4IXshrM5Ce4oeeU8QCSSYVY=; b=IrilSI
	O7gwGGcZeeyf6jurI0JSiMXTM7a7gdF6q6fMDgezGUkqYXf7lnQCPwNvalgFFXI3
	FikKuBgw4vcTrbAortiQvZL2M49cTYy77lcuBPz8nib3N9vKrpC85VZo33hbM31n
	SVV2iboawI0Wm9OGHkreU4N8ZaPdIcuDHxu/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XAsBKKKO+Kdp3CKI7iVXmucVE3BVntQM
	fkMK3BI4oscYrNDRF+SBicyk6mBr6W24YZdLAqpQ8SUel8/EOqSqhVLZ7AQ4rjFG
	1ZXXPUftrG3TSfUysNC5i7UjOhcEc/J+hGAQU1KHC+LJEC+K0vFL53O10gDS18+r
	wJfTBhg6mH8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8777C6193;
	Tue, 10 Apr 2012 14:05:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B7526191; Tue, 10 Apr 2012
 14:05:59 -0400 (EDT)
In-Reply-To: <4F847350.3000409@ubuntu.com> (Phillip Susi's message of "Tue,
 10 Apr 2012 13:52:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D36A69C4-8337-11E1-822D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195113>

Phillip Susi <psusi@ubuntu.com> writes:

> git stash refuses to apply a stash if it touches files that are
> modified.  Using stash -p to selectively stash some hunks of a file
> and then immediately trying to pop that stash causes this failure
> every time.

I think that is by design.

I do not use "stash -p" and personally, but I think its broken from the UI
point of view.  The point of "stash" is to clear your workspace to a
pristine state, do random things, and after you are done and cleared your
workspace again, apply it to come back to the original state or a state as
if you started your WIP from the updated clean-slate.

So probably the right way to use "stash -p" (if there were such a thing)
would be to stash away the remainder in a separate stash with another
"stash" without "-p" (which will clear your workspace to a pristine state)
and then pop the one you created with "stash -p", I think.
