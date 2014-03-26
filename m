From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 14/19] tree-diff: rework diff_tree interface to be sha1 based
Date: Wed, 26 Mar 2014 14:34:24 -0700
Message-ID: <xmqq1txoiqzj.fsf@gitster.dls.corp.google.com>
References: <cover.1393257006.git.kirr@mns.spb.ru>
	<0b82e2de0edee4a590e7b4165c65938aef7090f5.1393257006.git.kirr@mns.spb.ru>
	<xmqqa9cfp9d5.fsf@gitster.dls.corp.google.com>
	<20140325092215.GB3777@mini.zxlink>
	<xmqq4n2mmarr.fsf@gitster.dls.corp.google.com>
	<20140326195201.GB16002@mini.zxlink>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kirr@mns.spb.ru, git@vger.kernel.org
To: Kirill Smelkov <kirr@navytux.spb.ru>
X-From: git-owner@vger.kernel.org Wed Mar 26 22:34:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSvSz-0001VW-7Z
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 22:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755940AbaCZVe3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 17:34:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752126AbaCZVe2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 17:34:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5768277F76;
	Wed, 26 Mar 2014 17:34:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=k5aGwGoK+Gq7yRPehNkdQgWBYKk=; b=Iz2XMi
	ZH9YH1S9AJScfG8F6zPy7oeM+6Stf6pTJAdWXqaj9sy04xEKKLUeL/TooZE5Ou5C
	Avv+ul4WJu12GsYqsNkz4es1fwLZEWnXsNyIZuZFyFvbkwyOC6s5d8SjWhv4427F
	fAMXt88f8vSJr4u0BVj0Sqs6qLkFIphnsAsQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=erevKBgHlqJ9l6sZi89raRdBiBnvSSQT
	NR6nZ2K/E9kb5yC6mDT2T389CgItgR2fdvXCfe+8NFJCZIkbrzwGId2FOy0nSyqe
	VWVkEa9WfZw7JyfBMeqbTcrSosm+0nSgygg7w5TQbvNEH/oIG7tKOHUd+TOh1QdI
	Th3Vv0JjKw8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4762C77F75;
	Wed, 26 Mar 2014 17:34:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95CB677F73;
	Wed, 26 Mar 2014 17:34:26 -0400 (EDT)
In-Reply-To: <20140326195201.GB16002@mini.zxlink> (Kirill Smelkov's message of
	"Wed, 26 Mar 2014 23:52:01 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 67D29DF0-B52E-11E3-845B-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245231>

Kirill Smelkov <kirr@navytux.spb.ru> writes:

> On Tue, Mar 25, 2014 at 10:46:32AM -0700, Junio C Hamano wrote:
>> Kirill Smelkov <kirr@navytux.spb.ru> writes:
>> 
>> > What are the downsides of "__" prefix by the way?
>> 
>> Aren't these names reserved for compiler/runtime implementations?
>
> Yes, but there are precedents when people don't obey it widely and
> in practice everything works :)

I think you are alluding to the practice in the Linux kernel, but
their requirement is vastly different---their product do not even
link with libc and they always compile with specific selected
versions of gcc, no?

> Let it be something portable anyway -
> how about diff_tree_sha1_low() ?

Sure.

As this is a file-scope static, I do not think the exact naming
matters that much.  Just FYI, we seem to use ll_ prefix (standing
for low-level) in some places.

Thanks.
