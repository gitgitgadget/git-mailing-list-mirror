From: Junio C Hamano <gitster@pobox.com>
Subject: Re: .gitignore for large files?
Date: Mon, 25 Jul 2011 11:59:18 -0700
Message-ID: <7vd3gyrxtl.fsf@alter.siamese.dyndns.org>
References: <B27BF8C0758741A68E1631A7308E17C6@PhilipOakley>
 <CACsJy8C=ks1_TdQdNi4Wq8OCSAON9rhJ88zAp1kDZy3fBg2pmQ@mail.gmail.com>
 <179943CA8CCC4BEE811E31B2BCC634D1@PhilipOakley>
 <CACsJy8B8kYU7bkD8SiK354z4u=sY3hHbe4JVwNT_1pxod1cqUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philip Oakley <philipoakley@iee.org>,
	Git List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 25 20:59:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QlQNC-0004Wb-7Y
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jul 2011 20:59:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752362Ab1GYS7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jul 2011 14:59:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34518 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752088Ab1GYS7V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2011 14:59:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18D7C4BD1;
	Mon, 25 Jul 2011 14:59:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GJNdIkWl55RqokCvNhVPwC+NmlM=; b=I2Hv00
	MUtMCT9TX4aHnv1butELLJgnG1phwARj+rqnc4HLPmbqHvwdnQREKwPSQgBk2Bno
	Nnxi7dn//lA7xzRhLLF8FEHSDdI8YeB/khfV+B7KsV4H/XazVrD11laV08q+4dQb
	pbBIh6Ud+Bopt9pZX7CYF33+yBS4b9SvAEY4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jzWV5m+TQ0xi7W648NW5XwQlCup90m6M
	z+vJgTMzuPt/X/Ve9Ju1GqDStsztTxH1sRywU4PUJNREl2DiEcs1V8k5Z0rl2Ko2
	6gZnsOauNorG8yhvh/KPJyBKkwjV2Br19AGLvTB/Hx5VdCvRLYoZCUEfCOucIcG9
	KmjYBasg4TQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0F1304BD0;
	Mon, 25 Jul 2011 14:59:20 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8B8524BCE; Mon, 25 Jul 2011
 14:59:19 -0400 (EDT)
In-Reply-To: <CACsJy8B8kYU7bkD8SiK354z4u=sY3hHbe4JVwNT_1pxod1cqUw@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Mon, 25 Jul 2011 20:17:47 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33A383E4-B6F0-11E0-AF3F-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177807>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> While .gitattributes looks like a better place, it does not have
> "exclude" attribute equivalence to .gitignore. If I remember
> correctly, the way .gitignore and .gitattributes are implemented makes
> it very hard to turn .gitignore into part of .gitattributes
> implementation (gitattr checks .gitattributes of current dir first,
> then upward to parents, while .gitgnore follows the opposite
> direction).

While I do not think it is necessarily a good idea to invent yet another
way to exclude and add it to the attributes mechanism (unless we will be
dropping the support for gitignore, which is not the case), I do not know
why you think the direction of the scan matters.

A more important difference is that the attribute mechanism covers the
actual paths, not intermediate directories, unlike gitignore does.
