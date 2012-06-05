From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to pull force just one folder in dev tree?
Date: Tue, 05 Jun 2012 11:35:23 -0700
Message-ID: <7vlik1obdg.fsf@alter.siamese.dyndns.org>
References: <4FCE44D4.6050805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "J.V." <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 05 20:35:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbybK-00036j-SB
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 20:35:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755659Ab2FESf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 14:35:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52618 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754936Ab2FESf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 14:35:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D936C8F30;
	Tue,  5 Jun 2012 14:35:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=B8J2CyaQlDIcDUlSUqs0NqU3Avs=; b=iDloDN
	/YSX2dc946tMlZzhIh6LHApf4cq32Q3/5LihEm4x17Q7CmHRFEi06vz40y3UcT1i
	YHed4jEAVRPJ5KKu/lMo8cEENfcnmSPB3zsO46f3GxWjeTVchm5wAszdfEpmlVqA
	bh8jxNaEfo0yCnEOkqgjUIRm3SAdfwobgkuY8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sB1L2utLKXpBTwRnGTPSF73zW7EgJ27/
	pWXjp+C9x579F9LqA2sIQfrrGsErhzeojTKJ7vBJcCjTzCmUkWQXMLtOXTQfFaE/
	ITHCQVikg3rFtRwQTJfvgh+GYskE1RFtlkseU+GdGqgKmaC9YN2Z8f91jlTdzYbe
	AWHVUFbRoss=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CFC598F2E;
	Tue,  5 Jun 2012 14:35:25 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 356408F2D; Tue,  5 Jun 2012
 14:35:25 -0400 (EDT)
In-Reply-To: <4FCE44D4.6050805@gmail.com> (J. V.'s message of "Tue, 05 Jun
 2012 11:41:40 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 373AC116-AF3D-11E1-BA2F-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199277>

"J.V." <jvsrvcs@gmail.com> writes:

> If I am in my source code tree down deep in a directory at the command
> line, how do I pull from a repo and force overwrite all files locally
> (and also get files that I deleted locally, just in the folder I am
> in?)
>
> I do not want to do this for the entire repo, just the directory that
> I am in and also on the branch I am in.  I am not in the 'master'
> branch, but another branch.
>
> so
>
>  $git reset --hard HEAD
>
>  Would probably do my entire local repo and from 'master' (even if I
> am not on master)?

No. It asks "Please reset the index and the working tree files to
match what I have in the commit I checked out".  If you are on the
'slave' branch, the index and the working tree files are updated to
match the commit at the tip of the 'slave' branch.

It is unclear what you are trying to do, but if you made random
changes in files in your current directory (somewhere deep), all
changes are crap and you regret making them, and you are wishing to
go back to the state you started from, then the way to ask "I want
everything in this directory checked out from my current branch" is
to say:

	$ git checkout HEAD -- .
