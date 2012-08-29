From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GC of alternate object store
Date: Wed, 29 Aug 2012 08:52:27 -0700
Message-ID: <7v3935y9tw.fsf@alter.siamese.dyndns.org>
References: <7vmx2a3pif.fsf@alter.siamese.dyndns.org>
 <loom.20120827T233125-780@post.gmane.org> <hbf.20120828vnfp@bombur.uio.no>
 <20120829074249.GA14408@ugly.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Oswald Buddenhagen <ossi@kde.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 17:52:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6kZK-0006PO-H7
	for gcvg-git-2@plane.gmane.org; Wed, 29 Aug 2012 17:52:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994Ab2H2Pwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 11:52:32 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59396 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752790Ab2H2Pwb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 11:52:31 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 433938EF3;
	Wed, 29 Aug 2012 11:52:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=mLh55vC/pbB28aGNQA1l7zhPHPU=; b=lgQ+LA
	nO4fhnVdFHXwWJe/d3wAWB0/SffReEce72HYyEACbbzcgEKqJ9aTpGoi+HyUIMEu
	HmG2mHVsH6UT9Zkj0x8oZzZrgUlT0XKRiCdBlTeFs6HD3DX1ALi+aFvheHu/ccxu
	5QRG/E+YpLSgTQOqBf/Az5nwlKZXQeSOcFwm0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qRHbJ7MGbGhmRJrB/purB4FZhdwnv+6v
	90safpbgsFibGsHAjeAP03IpZdZrwWXy3z/qwOb5f7iZIdExhU7ofIZ4gH8f6Lwj
	oPFZxRZbW8HNIhR/la4ahMUS7P3pghhgldWbxFPxlcFLtLnFfRuF/nts4OHWMvky
	f/m896GkMmc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D9738EF0;
	Wed, 29 Aug 2012 11:52:30 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B7B58EEC; Wed, 29 Aug 2012
 11:52:29 -0400 (EDT)
In-Reply-To: <20120829074249.GA14408@ugly.local> (Oswald Buddenhagen's
 message of "Wed, 29 Aug 2012 09:42:49 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89A3BFBA-F1F1-11E1-AF13-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204481>

Oswald Buddenhagen <ossi@kde.org> writes:

> On Tue, Aug 28, 2012 at 09:19:53PM +0200, Hallvard Breien Furuseth wrote:
> ...
>> Junio's proposal partially fixes that: It pushes refs/* instead of
>> refs/heads/*, to refs/remotes/<borrowing repo>/.  However...
>> 
> i did exacty that. the tags are *still* not populated - git just tries
> very hard to treat them specially.

Just this part (I won't comment on the other parts in this discussion).

Doesn't

	git push $over_there 'refs/*:refs/remotes/mine/*'

push your tag v1.0 to refs/remotes/mine/v1.0 over there?  The
version of git I ship seems to do this just fine.

> and the "stash" file is also ignored, unfortunately.

There is a work in progress to do this on 'pu'.
