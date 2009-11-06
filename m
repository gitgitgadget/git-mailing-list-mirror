From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
 import
Date: Thu, 05 Nov 2009 22:05:27 -0800
Message-ID: <7vd43w5gt4.fsf@alter.siamese.dyndns.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>
 <1257364098-1685-10-git-send-email-srabbelier@gmail.com>
 <alpine.LNX.2.00.0911041601170.14365@iabervon.org>
 <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com>
 <alpine.LNX.2.00.0911041624401.14365@iabervon.org>
 <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com>
 <alpine.LNX.2.00.0911050016360.14365@iabervon.org>
 <alpine.LNX.2.00.0911050145010.14365@iabervon.org>
 <fabb9a1e0911051551r2e13cfb9me0e668adb962f6bd@mail.gmail.com>
 <alpine.LNX.2.00.0911051917100.14365@iabervon.org>
 <fabb9a1e0911051628v2ba15be2s9c3fb06879607cc0@mail.gmail.com>
 <alpine.LNX.2.00.0911051929340.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Nov 06 07:05:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N6HxH-0004QR-8p
	for gcvg-git-2@lo.gmane.org; Fri, 06 Nov 2009 07:05:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756054AbZKFGFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Nov 2009 01:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755922AbZKFGFj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Nov 2009 01:05:39 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:57190 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755900AbZKFGFj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Nov 2009 01:05:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1E2AC94059;
	Fri,  6 Nov 2009 01:05:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Yc/6m+tkJjryDw0h0VyzqCcqmSg=; b=me5zdb
	SAAFjTh5WUyGLi+cN9hD3n6o8MCPi9FQABovoONXu4m8ELZmUkKfBFCx2Nkqm/nf
	QGbmgxG06cNNddD8wFH/KIGHtVDKPzayjZLKqEeKgmfY7CudKfnmd4Od+3vrgwvb
	MOd2sZFAhQ5mcDihyIYD/opjbNxholfNcAQts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wx2kodBe7osWoz7hw59XnUGXR90PId1G
	zsmKURWkA23MvF+Xog5osUgiiB0azffkqgvuH3saMo/JINjGriufrO/lyWK5zgHW
	2GAzgyi6ydJe7EqVd82hb90q4JaxWcx+nUwAkJRel4umUlBooQvQKfVPvRsshKDu
	a90o8hgobdM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CF48E94055;
	Fri,  6 Nov 2009 01:05:37 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7D4AE94051; Fri,  6 Nov 2009
 01:05:29 -0500 (EST)
In-Reply-To: <alpine.LNX.2.00.0911051929340.14365@iabervon.org> (Daniel
 Barkalow's message of "Thu\, 5 Nov 2009 19\:37\:18 -0500 \(EST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 676DFCFC-CA9A-11DE-B5A3-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132275>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Fri, 6 Nov 2009, Sverre Rabbelier wrote:
>
>> > I don't know why Junio squashed your
>> > changes into my patch, particularly when I disagreed with those changes.
>> 
>> Junio didn't squash anything, it's just that pu still contains v4 of
>> the series, in which I had squashed my changes in.
>
> Oh, okay. You probably shouldn't squash un-acked changes into other 
> people's patches when taking over their series.

Thanks for having this exchange.  You are right, and I should have more
explicitly explained what I was doing when I replaced two series (yours
and Johan's cvs series) with Sverre's consolidated re-roll.
