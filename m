From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] svnrdump_sim: start the script with /usr/bin/env python
Date: Wed, 28 Nov 2012 08:57:50 -0800
Message-ID: <7vmwy1hdgx.fsf@alter.siamese.dyndns.org>
References: <20121128025734.21231.47468.chriscool@tuxfamily.org>
 <7vy5hmgovt.fsf@alter.siamese.dyndns.org>
 <CAMP44s17Gycr2tWOLYAxMG7-CGP3SpFf7XTWf94qGg3WfVpT-A@mail.gmail.com>
 <CAP8UFD08LhywQ9KaNoeG1nORZwtK8MNWqwjfRJPyT2vLkNgs9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 17:58:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdkxg-0006Xt-IN
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 17:58:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755577Ab2K1Q5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 11:57:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49537 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754742Ab2K1Q5x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 11:57:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 05BA59E2B;
	Wed, 28 Nov 2012 11:57:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=25eVYIYmExVe0PDIklDFGbUCX0o=; b=YWJvb5
	IMIyUpMEvgX+41674+RaYB7vKuPzvJLEXMyAj9O+o/XnQ0Ungf5gO1J8nArILbyQ
	lQwmq5NeAGIMCfMpUajPBk0WyaLXubbTzG7JUn7A5j3Jma9fb9hpg75KqeTCuNXd
	DgkCdDg/mY1tKGDdNJmT8K/dMaQf50r08fI44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JxQ64aFbYEox6uARJlZ8boxFdqfwf2cz
	NOO3hr9+sYIt/uQHfV39qa14aqxC+uqtjG4lHDh1JthjIMt6Qzcfph0rINrDt2Y4
	y/83Zd4ZG57G+HJCj8/6AVdTu2YWYdsv1NnIKsOunDFrhipH8XmU5ym7vKgFUlaO
	Cnj9/Vv3EVY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E67BE9E29;
	Wed, 28 Nov 2012 11:57:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C0449E27; Wed, 28 Nov 2012
 11:57:52 -0500 (EST)
In-Reply-To: <CAP8UFD08LhywQ9KaNoeG1nORZwtK8MNWqwjfRJPyT2vLkNgs9A@mail.gmail.com>
 (Christian Couder's message of "Wed, 28 Nov 2012 09:55:40 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BF53F968-397C-11E2-9C76-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210741>

Christian Couder <christian.couder@gmail.com> writes:

> On Wed, Nov 28, 2012 at 9:03 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, Nov 28, 2012 at 8:36 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Christian Couder <chriscool@tuxfamily.org> writes:
>>>
>>>> All the python scripts except contrib/svn-fe/svnrdump_sim.py
>>>> start with "#!/usr/bin/env python".
>>>>
>>>> This patch fix contrib/svn-fe/svnrdump_sim.py to do the same.
>>>
>>> I suspect you need a bit more than that.
>>>
>>>     $ make git-p4
>>>     $ diff -u git-p4.py git-p4
>>>
>>> shows you how we tell the scripts how to find their interpreters
>>> (that way, there is no need to rely on the existence of
>>> /usr/bin/env).
>>
>> That works if somebody managed to export PYTHON_PATH, which very very
>> often is not the case for me.
>
> Yeah, and even if PYTHON_PATH is used, in t9020-remote-svn.sh,
> svnrdump.py is used as is.

You need a fix for that; didn't I already say "you need a bit more
than that"?
