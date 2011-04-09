From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] add -u: get rid of "treewideupdate" configuration
Date: Fri, 08 Apr 2011 22:20:20 -0700
Message-ID: <7vy63kyp9n.fsf@alter.siamese.dyndns.org>
References: <1302138996-10006-1-git-send-email-gitster@pobox.com>
 <1302138996-10006-3-git-send-email-gitster@pobox.com>
 <20110408175149.GA3917@sigill.intra.peff.net>
 <7vaag04k8m.fsf@alter.siamese.dyndns.org>
 <20110408202404.GA16540@sigill.intra.peff.net>
 <7vmxk01izn.fsf@alter.siamese.dyndns.org>
 <20110408223206.GA7343@sigill.intra.peff.net>
 <7vei5c1iat.fsf@alter.siamese.dyndns.org>
 <7vaag01gdl.fsf@alter.siamese.dyndns.org>
 <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 09 07:20:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8QbQ-0007YW-II
	for gcvg-git-2@lo.gmane.org; Sat, 09 Apr 2011 07:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751551Ab1DIFUk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2011 01:20:40 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460Ab1DIFUj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2011 01:20:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 818CD5E39;
	Sat,  9 Apr 2011 01:22:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAtq+YpJX8+Enupwvv2Hr5ZNVns=; b=A40Jkm
	ThQnffIqx9J9GG0q/wKWhfawZc6o4pnfikaQ25GxP51Dp+6iIwCL7hJ/GInwDnO0
	ASs0uZzLWnZLGitKH2YO/ETVHOBPp2m2kfphkP2SEPVrimP6RT8QAVFjTrzjX/J7
	p/hgKAJC8ZFTA8uFdpDL0BH1Lzn3V1Zz9z1no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wyd504XvJl+ekJG2fbd1wWgMa9SCea0L
	5LDgLMa90znaR8NbCC1hqY3MlW4MSHH3kGyx1wgQ7AoKKV9gvaCKocPHlCceZ92I
	ZO9C63Mk5Dhv7lVCYzsbYCEfTng2arWYEPWSbMYBFjNFU2dfzJ4I8Mp6mbv6GNR4
	cgWWAnV113Y=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 3EBB15E31;
	Sat,  9 Apr 2011 01:22:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1B68B5E2D; Sat,  9 Apr 2011
 01:22:18 -0400 (EDT)
In-Reply-To: <BANLkTimCbr+hnJNGWDBVbjZKEBDW1KR4=g@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Sat, 9 Apr 2011 11:58:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B271C0E-6269-11E0-84D5-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171184>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> The intention is good, but reality may need more work.

Yes, I knew about "add -u", as I was touching in its neighbourhood
recently.  The way "git grep" does this may be more appropriate as a short
term solution.

The updated init_pathspec() should at least take (prefix, argc, argv[]),
and in addition a hint as to what to do when there is no pathspec from the
command line (i.e. argc == 0), so that it can behave differently when the
user gave only ":".

By the way, the field in "struct pathspec_item" would need to be updated,
and the matcher would need to be changed, so that each item knows up to
which part of the "match" string came from the prefix (and remainder is a
user supplied pattern).  Then from a subdirectory a?a/bbb,

  - "c" should parse into prefix "a?a/bbb/" plus pattern "c"

  - ":../c" should become prefix "a?a/" plus pattern "c"

and the matcher should match the prefix part _literally_ without
fnmatch(3), while using whatever magic (e.g. use_wildcard) to match the
pattern part.  I think we currently match the whole thing with fnmatch(3),
which in practice may be OK only because not many people use glob
characters in their directory names, but what the current matcher does
logically is wrong.

Of course, both of the above are tasks after 1.7.5 ships, but I thought I
should mention them now, as you seem to be already thinking about the
future.
