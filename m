From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 07/11] Documentation/replace: tell that -f option bypasses the type check
Date: Wed, 04 Sep 2013 13:48:31 -0700
Message-ID: <xmqqppsol3ds.fsf@gitster.dls.corp.google.com>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
	<20130903071026.29838.52710.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Wed Sep 04 22:48:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHK0K-0008Mn-E9
	for gcvg-git-2@plane.gmane.org; Wed, 04 Sep 2013 22:48:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760789Ab3IDUsk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Sep 2013 16:48:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61334 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754417Ab3IDUsj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Sep 2013 16:48:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3D68F3EE65;
	Wed,  4 Sep 2013 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n8q/McwUU/ctrEvCoGbC+w53wek=; b=NsrdWc
	4Y4Gm0ku15gJoocGjEY1skRrw5dU9etv/hIS2KgQWnN4lJC9XK8+c5PeE8bDXsTy
	Hspy7RS9Q+40V2/7X3X+5MSw34q19x/o+8bQPugXeEBYcoTEfFSufQ88yVoJKntn
	NkjhUtHvZM8hJRT2NYaAwCoQI/N5Z63XM0yDY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gD4uti4PJhPGoF+MqAwwvfAaO5497C5n
	ZMCeF52Mm2MjZutTBgZkDUB5o1azyuX6VgoSdg0Z4t9V9kQ397Lgiijk+m+1I0Yu
	8VN0v224yLTqM8VfkDz4lmy/ds4IK6mqzLRPbi1RzWSgtRoSkQnRMM3sGPiCVc8v
	A5nJ1Mwk348=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DEE033EE56;
	Wed,  4 Sep 2013 20:48:35 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B87F33EE48;
	Wed,  4 Sep 2013 20:48:33 +0000 (UTC)
In-Reply-To: <20130903071026.29838.52710.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 03 Sep 2013 09:10:21 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5DABC7DC-15A3-11E3-B8A9-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233875>

Christian Couder <chriscool@tuxfamily.org> writes:

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/git-replace.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
> index 736b48c..a2bd2ee 100644
> --- a/Documentation/git-replace.txt
> +++ b/Documentation/git-replace.txt
> @@ -21,10 +21,12 @@ replaced. The content of the 'replace' reference is the SHA-1 of the
>  replacement object.
>  
>  The replaced object and the replacement object must be of the same type.
> -There is no other restriction on them.
> +This restriction can be bypassed using `-f`.
>  
>  Unless `-f` is given, the 'replace' reference must not yet exist.
>  
> +There is no other restriction on the replaced and replacement objects.
> +

This is outside the scope of this topic, but I wonder if we want to
restrict a replacement operation that causes a cycle in the object
graph (a commit reaches itself after following its parent pointer,
a tree reaches itself after looking into trees within, a tag reaches
itself after following its "object" reference), and if we do want
it, it is feasible to implement it.

>  Replacement references will be used by default by all Git commands
>  except those doing reachability traversal (prune, pack transfer and
>  fsck).
