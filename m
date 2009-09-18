From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Avoid the use of backslash-at-eol in pack-objects usage 
 string.
Date: Thu, 17 Sep 2009 17:54:40 -0700
Message-ID: <7vd45pgjhr.fsf@alter.siamese.dyndns.org>
References: <1253224300-18017-1-git-send-email-tfransosi@gmail.com>
 <7vvdjhgrjv.fsf@alter.siamese.dyndns.org>
 <a4c8a6d00909171506l6c4b6a49i22d7b337a0c6cfa2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 18 02:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MoRkU-0005oK-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 18 Sep 2009 02:54:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753789AbZIRAyo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2009 20:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753483AbZIRAyo
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Sep 2009 20:54:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58650 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056AbZIRAyo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2009 20:54:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0D8D3635D;
	Thu, 17 Sep 2009 20:54:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=ZeWMvpLkSWsHquoBATjP+oRLLTs=; b=fr8KnQaX329eKuaCsA5GK7e
	XNqNrnEPM/tBuhvBwgt7NB7Kxhbn5OYqWwoZmWh0ctDGWhYSzKgk+YpPpudHuUKp
	0ix9+uolGTDs0vBYKf4/H6GX3cZer78MV+1MJdIbMdv12ZS4fst3lK0SJ1iSX1KY
	CKTZtRdx+9+eNdoviV3w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=yYiZ4+f0L0lDRkrG6TObniM+hTf8N2qJ0nBZowScfTuOZKmNI
	6qkv4pp9dkKO0c3CnzlZlWvsQR3TRj9LgPmhGogwAA3w/sULQvtwjZ41ivShEWAX
	TwD5/+N5ydKgOt4c2HO2SUgC9hpt1CyhfyqpuBQuOLTMfQMLQfW3Se3u0k=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B3F8136359;
	Thu, 17 Sep 2009 20:54:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1262C36358; Thu, 17 Sep
 2009 20:54:41 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: DB283172-A3ED-11DE-9EAE-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128780>

Thiago Farina <tfransosi@gmail.com> writes:

> On Thu, Sep 17, 2009 at 7:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Thiago Farina <tfransosi@gmail.com> writes:
>>
>>> +static const char pack_usage[] =
>>> +  "git pack-objects [{ -q | --progress | --all-progress }] \n"
>>> +  "        [--max-pack-size=N] [--local] [--incremental] \n"
>>> +  "        [--window=N] [--window-memory=N] [--depth=N] \n"
>>> +  "        [--no-reuse-delta] [--no-reuse-object] [--delta-base-offset] \n"
>>> +  "        [--threads=N] [--non-empty] [--revs [--unpacked | --all]*] [--reflog] \n"
>>> +  "        [--stdout | base-name] [--include-tag] \n"
>>> +  "        [--keep-unreachable | --unpack-unreachable] \n"
>>> +  "        [<ref-list | <object-list]";
>>
>> Do you still want to keep the trailing whitespace on these lines?
> I did this to maintain the same output of the old string, but if you
> want I can change, what you suggest?

If you need to add or remove an option to actually _change_ the string, a
patch like this, as a preparatory step before the real improvement, would
be a very welcome clean-up.  I however would suggest doing nothing, if
this is the only patch you are going to send against this program in the
near future, to be honest.

Even though we do not have any other patch in flight that changes this
program at this moment (as expected, because we are in -rc freeze), which
means there is not much risk for this patch to cause needless conflicts
with others, we generally avoid code churn like this one, as a principle
for a maturing project.

The _very best_ thing you can do for the project on this particular issue
is to keep an eye on the list and the next time somebody wants to patch
this program in a way that affects the usage string, remind that person to
first clean-up the string without changing anything else as a preparation
patch; I however admit that I am asking a lot more work out of you.

A real improvement patch from that somebody _could_ be to remove the
trailing whitespaces from the output string, and in that case I would not
mind if two patches (one preparatory patch which is this one, and the
other being the removal of trailing whitespaces) were squashed together.
In fact, in such a trivial case, it probably be better to squash them into
one.

And that somebody _could_ be you.
