From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Performance optimization for detection of modified
 submodules
Date: Tue, 19 Jan 2010 10:09:57 -0800
Message-ID: <7vpr569dai.fsf@alter.siamese.dyndns.org>
References: <4B54C3EA.9090200@web.de>
 <7v1vhmg975.fsf@alter.siamese.dyndns.org> <4B556ED2.7020904@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 19:10:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXIXB-0003GZ-Ev
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 19:10:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab0ASSKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 13:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754581Ab0ASSKJ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 13:10:09 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:48886 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752492Ab0ASSKG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 13:10:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 87E0792DAD;
	Tue, 19 Jan 2010 13:10:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5vQ0uDqXDXwOBS1SSNe4XfjAMOs=; b=o+llz5Tu3QtEaqtTmxJ3F3l
	QJkrAabtSfKBIledVSXYzU8bevab1RxeDIlX384k19FK5AYC6AQQMCo8xFheEFzh
	O0r1lqt5PXn2Sm6xUG7kyAyilulm4O0ycIhEiT9Euueq0bh/dpwFEAXDedlh5pFD
	1dW95rLvAbkq8YZfcMag=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=sy1COvcP3EOiRcqn94/yOWOMebRu03VkDSOfZDN/kFd/xT6Nf
	zLtT6M8DCZtfC4QwLnnhjrrHwLJmbHgbAE34OgcxTsd/A032kZYvEAamqxLV12yD
	6pZrRavTvIo3aO4ETYWMpBhEtpbMxP8rA1TbLf+wMeuPa6nQM69O3VG1Fs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 624B692DA6;
	Tue, 19 Jan 2010 13:10:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B576192DA5; Tue, 19 Jan
 2010 13:09:59 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DCF9C9EA-0525-11DF-AA97-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137479>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> I am working on a subsequent patch where dirty_submodule is used as a
> bitfield to store more detailed information about the dirtiness. That is
> then used by "git diff --submodule" to tell the user if the submodule
> contains untracked and/or modified files.
>
> But i can revert that part if you want.

"Will be used as bitfield in later patches" is a justification that was
missing; with that I think the patch is Ok as-is.

>> Mental note to myself.  prefix[0] is either '-' (removed from the work
>> tree) or '+' (added to the work tree).  Added submodule could be
>> immediately dirty.
>
> Should i add a comment there?

Meh, that was just me thinking aloud.

Thanks.
