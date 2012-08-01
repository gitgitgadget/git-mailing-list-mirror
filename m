From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Wed, 01 Aug 2012 15:10:55 -0700
Message-ID: <7vipd2e00g.fsf@alter.siamese.dyndns.org>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
 <20120731192342.GB30808@sigill.intra.peff.net>
 <7vfw87isx1.fsf@alter.siamese.dyndns.org>
 <20120801004238.GA15428@sigill.intra.peff.net>
 <7v8vdzgngo.fsf@alter.siamese.dyndns.org>
 <20120801215414.GC16233@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Aug 02 00:11:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Swh8D-0001zq-5J
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 00:11:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756078Ab2HAWK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Aug 2012 18:10:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756024Ab2HAWK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Aug 2012 18:10:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA64B986F;
	Wed,  1 Aug 2012 18:10:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0tmaMTGOOLYTEJgx4BdhWoPXLok=; b=HQdVHV
	nELYv5NGf+e6IZZBeaLB0s8s504NyiAmXsEVCa/cxIK6Uj+FhYtHDeSUrFTWj58l
	Xg7y3RfcfKVtHlQjVPXDC/MECFynsa4BVEeqlO1FhBn3I517IdnsljE8woy6sMHO
	ApihRuQXf7f6J5MSQROpusSSsQt8w6LnRixEk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6rTI9onxozmaRsoAuldEjQ+fJEV1VWC
	/e8ZIVT4ixSA532EceLspGvwmeTgyGjzmIwfmoSHnP0du3OgWOF75DafC47WrFwJ
	+E21qShquSoJmD9h9VYXn9lteC7+r3GdBzslLeGV8Po6FL8ibaT2ITRTiC21yPVF
	Sp9RXKtwcOw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8674986E;
	Wed,  1 Aug 2012 18:10:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 36FC4986D; Wed,  1 Aug 2012
 18:10:57 -0400 (EDT)
In-Reply-To: <20120801215414.GC16233@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 1 Aug 2012 17:54:14 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4D9DEE8-DC25-11E1-9F02-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202733>

Jeff King <peff@peff.net> writes:

> On Tue, Jul 31, 2012 at 11:01:27PM -0700, Junio C Hamano wrote:
> ...
>> As we still have the pathname in this codepath, I am wondering if we
>> would benefit from custom "content hash" that knows the nature of
>> payload than the built-in similarity estimator, driven by the
>> attribute mechanism (if the latter is the case, that is).
>
> Hmm. Interesting. But I don't think that attributes are a good fit here.
> They are pathname based, so how do I apply anything related to
> similarity of a particular version by pathname? IOW, how does it apply
> in one tree but not another?

When you move porn/0001.jpg in the preimage to naughty/00001.jpg in
the postimage, they both can hit "*.jpg contentid=jpeg" line in the
top-level .gitattribute file, and the contentid driver for jpeg type
may strip exif and hash the remainder bits in the image to come up
with a token you can use in a similar way as object ID is used in
the exact rename detection phase.

Just thinking aloud.
