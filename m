From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Wed, 26 Aug 2009 02:03:32 -0700
Message-ID: <7vr5uzeyl7.fsf@alter.siamese.dyndns.org>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0908261043140.4713@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>,
	Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 26 11:04:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgEQ9-00039L-Gs
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 11:03:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961AbZHZJDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 05:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752417AbZHZJDr
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 05:03:47 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:56681 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbZHZJDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 05:03:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 194D63737F;
	Wed, 26 Aug 2009 05:03:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=apeAz1mFNUUapI25o3X7cRQwzPI=; b=VNRUORyGNE/luJxiYUWep61
	9o6aIi4wDQ7qRivhrb40WmFcIMqlfMYXArjOo9AnLnO3DGYlks0co0tV+gAAe/Lt
	k7upnIhv3GVGPNE4Uv8x2uMU64QjEIBH12Tj3uOD2VAZytkU+b4nAARX0kGf0RLN
	S6qUESX+C2pODoi590Lc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=Rgq1pqNBsrk+zLyP+13ysh4ru9ZoOcStYwzNJZ4begh9kNVhG
	3rfgkPgwlqqBIpDPXhlTmSX6YYi6PlOkytjIXfV8riYF9p1xjDzRsb5dkVee1hdV
	CZwatjV+dlMQExkFrvxrMpXcePQqOEMMgS/3K5Lk2I+alVNjR3bJDLH1uc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CC3853737E;
	Wed, 26 Aug 2009 05:03:41 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A146F3737D; Wed, 26 Aug 2009
 05:03:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 59EAC492-921F-11DE-8BBB-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127074>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 25 Aug 2009, Junio C Hamano wrote:
>
>> If we are allowed to talk about asking for the moon,
>
> How about
>
>  	run_hook(NULL, "post-upload-pack",
>          	 create_full_pack ? "clone" : "fetch,
> 		 "the moon",
>                  NULL);
>
> then?
>
>> and if one of the primary reason for this new hook is statistics, it 
>> would be useful to see the number of bytes given, where the fetch-pack 
>> came from, and if we are using git-daemon virtual hosting which of our 
>> domain served the request.
>
> Certainly those are possible add-on patches, but would you require them to 
> be in the same commit?

I was merely responding to the "what else would be useful" question posed
by Peff.

Did you get an impression that I was saying "you must add these otherwise
I'll reject the patch"?

I didn't mean to.  I think it is entirely reasonable to queue the patch in
'pu' (after fixing the NULL termination bug), and start cooking without
any of the additional information.

Having said that, this is an external interface, and until we feel
reasonably sure that we are giving enough information to the hook and
we wouldn't need to change the interface, the series must not come near
'master'.

It might make sense to define the external interface to be "information is
given through the standard input of the hook, formatted in YAML, and here
are the initial set of items that may be fed", so that we do not have to
worry about the details too much.
