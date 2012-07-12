From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question: git clone --no-checkout behavior
Date: Thu, 12 Jul 2012 15:02:02 -0700
Message-ID: <7vbojkabad.fsf@alter.siamese.dyndns.org>
References: <CAGyf7-EZOSiATo3yF5x+FT6_QAkMTJ+AmrE27kwmxLkLXdaJKg@mail.gmail.com>
 <7vliioc1yn.fsf@alter.siamese.dyndns.org>
 <CAGyf7-Fkn9bjJ9EZEFNsba8U-RUzrB3TzmB-YbcvwUFRbHXG+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bryan Turner <bturner@atlassian.com>
X-From: git-owner@vger.kernel.org Fri Jul 13 00:02:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SpRSh-0003n6-VZ
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 00:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964821Ab2GLWCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jul 2012 18:02:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41084 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998Ab2GLWCG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2012 18:02:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 731878070;
	Thu, 12 Jul 2012 18:02:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sEJvS613ZD6EleX8JwZgqFU+nD8=; b=WXxdCV
	H15ST1nisBrdXsDTBbTBPjpw2GSTOc+N+sfAqZPJsB8R9mVkcg4CRl0cqk+37Hls
	DarCeVfWLQm7dMNv+Gw/jEO1vaExPgv7UsW1NvoW+72mdsC4SYD/0DJZDy0WwWjC
	vyiqtDtw87fwN9mN8P80TuSvbOW03KAI2HaqI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GUAsuE2gCYinK8Yk+5oFQCJIi6ZCOA8S
	Xr6pO1P3KAhsO9yPUeqWTZxKLTGfRsx1IN6qd0jQQcUPKu0PdFGgo8X20F0RofHa
	4XDOi1wjdBUGDFy4tKHY2Boav320/TsLzlIkCyNruJF5BOuYeGuvwHyHHo52WmpG
	kVjtW9Hf3A0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F479806F;
	Thu, 12 Jul 2012 18:02:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A16B9806E; Thu, 12 Jul 2012
 18:02:04 -0400 (EDT)
In-Reply-To: <CAGyf7-Fkn9bjJ9EZEFNsba8U-RUzrB3TzmB-YbcvwUFRbHXG+Q@mail.gmail.com> (Bryan
 Turner's message of "Fri, 13 Jul 2012 06:11:03 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 37281EBA-CC6D-11E1-862C-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201385>

Bryan Turner <bturner@atlassian.com> writes:

>> If you populated $GIT_DIR/index from the tree of HEAD, you would see
>> everything is deleted in the working tree.  You can simulate it by
>> doing this:
>>
>>         git clone -n $over_there here
>>         cd here
>>         git read-tree HEAD
>>         git status
>>
>> But it would not help people who want to check another branch out
>> immediately after cloning with -n, which is the whole point of the
>> option, so...
>
> Is the reset call in my example in essence performing that same read-tree,
> when it unstages the changes?

"git reset" (without any other parameters) reads the HEAD tree into
the index without touching the working tree, so I think it is
probably equivalent.
