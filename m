From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Refactoring hardcoded SHA-1 constants
Date: Fri, 18 Apr 2014 18:06:55 -0700
Message-ID: <xmqqy4z29lg0.fsf@gitster.dls.corp.google.com>
References: <20140418221841.GC57656@vauxhall.crustytoothpaste.net>
	<20140418224049.GA15516@google.com> <5351BE03.2070604@alum.mit.edu>
	<CACsJy8BMuj8jcsODGLPYxakh2pMV83AqsiMb7XFNkNwdGc7NLg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 19 03:07:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbJkH-0002rF-T0
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 03:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754944AbaDSBHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 21:07:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64050 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754934AbaDSBG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Apr 2014 21:06:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 06A967D931;
	Fri, 18 Apr 2014 21:06:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9tj84eC4Jn/9ASBUyT2RHi+v6sY=; b=YKI/cq
	5Zm1byXMyUmUE4SyYApX50ypXI/BIxIFqGW1yE7U+IBbjdSI0CaiJTTYS1rAAlON
	36mSrEDDqj4ptq8w2ODAQIQFu2SmPwrqs7n/iCgpuHMvr0eGq4m4zGkMMC10rMjU
	imd6xlJKQajk/PwOuhP/c8NvKwGXZqoSNOMr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TBHqcBpmoW3Rh47jpXdDG6hhjMXmGDI4
	jea0cDcB7SmVl8VssUYw1v8kS3K14ZqcSe+Vum5oty1dYbet8lNjJKVGsVMvSaj+
	6ctn9iCjyO8lE/VuAPi7r1QGlt43ODeeKU1gbxfi3RIDY/wIArkSD0cCNSXuzVOs
	qq/dx/NbDA8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E01C27D930;
	Fri, 18 Apr 2014 21:06:58 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 706B17D92F;
	Fri, 18 Apr 2014 21:06:57 -0400 (EDT)
In-Reply-To: <CACsJy8BMuj8jcsODGLPYxakh2pMV83AqsiMb7XFNkNwdGc7NLg@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 19 Apr 2014 07:48:21 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E77003DA-C75E-11E3-ABEC-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246495>

Duy Nguyen <pclouds@gmail.com> writes:

> On Sat, Apr 19, 2014 at 7:06 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Let the brainstorming (and bikeshedding) begin!
>>
>> 1. GIT_OID_RAWSZ / GIT_OID_HEXSZ
>>
>> 2. OID_RAWSZ / OID_HEXSZ
>>
>> 3. OID_BINARY_LEN / OID_ASCII_LEN
>>
>> 4. BINARY_OID_LEN / ASCII_OID_LEN
>
> 5. sizeof(oid) / ASCII_OID_LEN

Can we safely assume sizeof(struct { uchar oid[20]; }) is 20, or on
some 64-bit platforms do we have to worry about 8-byte alignment?

In any case, if the pair of names in 1. are what is already used, I
do not see a need for us to waste time bikeshedding at all.

In an ideal world, an implementation of cmd_foo() that defines a
variable to hold an object name and then calls into libgit.a
services may link in the future with a different implementation of
the services that are currently offered by libgit.a but are
reimplemented on top of libgit2, right?  Having the same name would
help us, not hurt us, with that direction in some future, no?
