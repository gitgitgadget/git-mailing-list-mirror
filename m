From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] fast-import: tighten parsing of mark references
Date: Thu, 05 Apr 2012 10:20:06 -0700
Message-ID: <7vty0y5c55.fsf@alter.siamese.dyndns.org>
References: <20120401225407.GA12127@padd.com>
 <1333417910-17955-1-git-send-email-pw@padd.com>
 <20120405015121.GA10945@padd.com> <20120405022422.GB20687@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Dmitry Ivankov <divanorama@gmail.com>,
	David Barr <davidbarr@google.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johan Herland <johan@herland.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 19:20:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFqM8-0000PC-1e
	for gcvg-git-2@plane.gmane.org; Thu, 05 Apr 2012 19:20:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab2DERUM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Apr 2012 13:20:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62699 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746Ab2DERUL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2012 13:20:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E665A6598;
	Thu,  5 Apr 2012 13:20:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=06AR/eRtxqRBR6cYO5DcuucRO4w=; b=lVrWHD
	ZnCcA9nrbkc+Dc1BR43ECYluDKQ5BJdA/mXQEe1hQs47yYIAZ6HpPi5LBkVh00Ur
	DnwaszTedKIiAG5ctkVykJUvPXObI26cL7A0RVFebkQH+M1RmC9haT+TXR1ngey6
	qyVEe5OnGXn91HqSbP8jREOErAls/Fy9ay4M8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lINQTfnkOQLgaBJ7Si0uYpThLGg04SAb
	xwGGDAOEGnJ29NPMiY+Z7AbuhzI/U2++1TRMKACywEyJfW1pUavKss54r9B0U2bS
	21UXIDWS1sKUHuQfjVoRQSxt2pnJrwtZz8dk2WqHHFypn/qEwLiY7xo6uZyL0dQR
	ssAKvTellis=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DBE1C6597;
	Thu,  5 Apr 2012 13:20:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46F326596; Thu,  5 Apr 2012
 13:20:08 -0400 (EDT)
In-Reply-To: <20120405022422.GB20687@burratino> (Jonathan Nieder's message of
 "Wed, 4 Apr 2012 21:24:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 97C1E7BE-7F43-11E1-92D4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194790>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Pete Wyckoff wrote:
>
>> This addresses all of Jonathan's comments, in particular:
>
> Nice.  Thanks much.  I only have a few small worries left:
>
> [...]
>> +++ b/t/t9300-fast-import.sh
>> @@ -2635,4 +2635,280 @@ test_expect_success \
> [...]
>> +test_expect_success 'S: filemodify with garbage after sha1 must fail' '
>> +	sha1=$(grep -w :103 marks | cut -d\  -f2) &&
>
> "grep -w" isn't used elsewhere in the testsuite.  Is it portable?

It is not portable enough.

> If I understood the discussion before correctly, this error message is
> suboptimal and something like "invalid dataref" would be a little
> clearer, right?
>
> That's orthogonal to what this patch is about so I'm not suggesting
> changing it.  But shouldn't the test just check that fast-import fails
> without committing to any particular message?

That would certainly make more sense.

Thanks for being extra careful.
