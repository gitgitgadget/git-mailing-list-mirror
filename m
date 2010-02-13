From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Individual file snapshots
Date: Fri, 12 Feb 2010 16:47:29 -0800
Message-ID: <7v6362c672.fsf@alter.siamese.dyndns.org>
References: <ron1-CD3223.04030512022010@news.gmane.org>
 <4B75BD06.1010802@lsrfire.ath.cx> <ron1-519083.13253112022010@news.gmane.org>
 <12B5BDAB-DD9C-4CED-9489-0773BF577DF3@silverinsanity.com>
 <ron1-62D136.13570812022010@news.gmane.org>
 <C022F034-F60E-4E89-A174-DC0F53ADEC19@silverinsanity.com>
 <ron1-5EFFD7.14390512022010@news.gmane.org>
 <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ron Garret <ron1@flownet.com>, git@vger.kernel.org
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 13 01:48:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng6B6-0000xg-Gg
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 01:48:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757423Ab0BMArz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 19:47:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58276 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757271Ab0BMArm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 19:47:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5560A99889;
	Fri, 12 Feb 2010 19:47:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+UgAnUzq8gn4lK2Qa+U86EDvoUQ=; b=M0Nz3Y
	z7AialItjRxvjp4d2MdIS15tNU7Nx/LqkuypfdT8nIaTW+/XKZOD2DU9LL/FaYe4
	RX9+4mGZSkga3Ztu7oY/BNyFu1UWknYDCEpgW+xIInKpGqSPflgpEHrL6RI4NGUD
	c1vy08T+b1YczAyUBeqR3tsd7LGx3gRm/33/o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e/njMc1LR3h+R1mO5Jm+d5cRCx7Km26G
	Qg5GPNZ/F4ddQPh8xVegVduEN8UrKaeJg5An8pE2MnmGrrRTxanG62sCCSLcDkUk
	LtcOUtq6wsRbC8mNILBsziYJOdoxUThFTUARuus7m7bwdFDkOOBHvLzt5Ti8XHe7
	56LOCI+Av/4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EA0B99883;
	Fri, 12 Feb 2010 19:47:35 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EF7899881; Fri, 12 Feb
 2010 19:47:31 -0500 (EST)
In-Reply-To: <ca433831002121633j5b96049bs71e539c96397aff4@mail.gmail.com>
 (Mark Lodato's message of "Fri\, 12 Feb 2010 19\:33\:56 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6038760A-1839-11DF-9786-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139766>

Mark Lodato <lodatom@gmail.com> writes:

> The basic steps are:
>
> backup .git/index
> git add -a
> git write-tree
> git commit-tree
> restore .git/index

Instead of doing that, you might want to consider

	GIT_INDEX_FILE=...some-temporary-file...
        export GIT_INDEX_FILE

and run everything as if that is the index throughout your script.  That
way, if your script ever failed in the middle, you won't have to worry
about a broken index file.
