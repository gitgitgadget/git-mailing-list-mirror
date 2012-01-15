From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Sending patches with KMail
Date: Sat, 14 Jan 2012 18:14:16 -0800
Message-ID: <7vwr8tww3r.fsf@alter.siamese.dyndns.org>
References: <2608010.fNV39qBMLu@descartes> <20120112162617.GA2479@burratino>
 <2304907.sEfEeC6Eon@descartes> <20120113233158.GD7343@burratino>
 <7vlipbxfne.fsf@alter.siamese.dyndns.org> <20120114183111.GC27850@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?R=C3=BCdiger?= Sonderfeld <ruediger@c-plusplus.de>,
	git@vger.kernel.org, davidk@lysator.liu.se,
	Sergei Organov <osv@javad.com>, Kevin Ryde <user42@zip.com.au>,
	Michele Ballabio <barra_cuda@katamail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 03:14:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmFcK-0003Nm-Rl
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 03:14:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752259Ab2AOCOV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 21:14:21 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54667 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751936Ab2AOCOU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 21:14:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C11F60D4;
	Sat, 14 Jan 2012 21:14:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MBNoS15bOMQK8L65+UZeL+P+z7E=; b=AZL5ac
	7cna5JawiJvQe7zp6KP+T10HqrTZL8pnqIU9G/KOOa+l2oVt4cVNc9LWl0dqCB3m
	8/aMcAB0OKBBTgGeCjw0Ca1pC7tvQPIeH3SYaBUESB48Lm8wG/QhJRmclZxVNvMX
	VOmrSfniOHrt9XMpyeqi0xIwVj4pMc2VWuEa4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UsGeQGJkmpUYxCvQbp8QNeJJgzZlgNE4
	EZUWftrankYzKRudZJX/q4okob5k5QHY8l4bmv5k6Y60rPWQLJ0luW+qMrExSWJu
	pvVPMpBA9tSer0tBt9ND8CI73UMZcNjsMXJAS9QmUXVr/Tv/Buv3s5+9Gx3Mqbtr
	Ahtx27cBw84=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62EE960D3;
	Sat, 14 Jan 2012 21:14:20 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E497960CF; Sat, 14 Jan 2012
 21:14:19 -0500 (EST)
In-Reply-To: <20120114183111.GC27850@burratino> (Jonathan Nieder's message of
 "Sat, 14 Jan 2012 12:31:11 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A221B7EE-3F1E-11E1-969E-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188584>

Jonathan Nieder <jrnieder@gmail.com> writes:

> My favorite approach would be to introduce a new option
> --format=plain|mbox, with the default being mbox, allowing format-patch
> --format=plain to produce a nice patch that does _not_ include a "From "
> line or q-encode its header lines, ready for use without much tweaking
> in an email body as an attachment.

I actually like the removal of q-encoding part. But I am not sure what
headers it should produce.  What should the beginning of the output file
look like? Does it just have "Subject: ", or does it still have the "From:
", "Date: " and "Subject: ", the first two of which the user would almost
always want to remove?

If we can decide a sane behaviour wrt the pseudo header, and if the option
is made _incompatible_ with --stdout when (and only when) emitting more
than one message, then I think it would be a good addition.
