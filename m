From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: make sure that the last line ends in an LF
Date: Tue, 20 Oct 2009 15:00:33 -0700
Message-ID: <7vfx9dlo8u.fsf@alter.siamese.dyndns.org>
References: <1256007988-13321-1-git-send-email-srabbelier@gmail.com>
 <7vbpk2sg6m.fsf@alter.siamese.dyndns.org>
 <fabb9a1e0910200615x5d487cdk6f50e11c96f2cb6c@mail.gmail.com>
 <7vbpk2ovio.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.1.00.0910202153160.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Oct 21 00:00:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0MlA-0006GZ-4U
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 00:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752083AbZJTWAl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Oct 2009 18:00:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751864AbZJTWAl
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Oct 2009 18:00:41 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50102 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbZJTWAk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Oct 2009 18:00:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6FFB7F242;
	Tue, 20 Oct 2009 18:00:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fbS44N70lAQs2spnOW2LYSYLiPo=; b=nle/d0
	GrE9MymjwQUtaPhS+9alG+4wadcBNLMmVVScDRfuvZ2nOjLPdJdWqJDCC2D6bfSf
	n7ZwM0ni7QKi3Y9+PWzvfj0YTJTPyUKyTijr3uIcBJPzEXmnU4BwKZDsSLRW4+FU
	aBjvc7C1BHmj5GwRxQZcVJjPsulFzsaTb4U2A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xsQdnIURyYA3wgaLt2JMkyP1jxxqE1P1
	bAVM8nXvqqqyfG9X0WeTYNxDWcXCkyOfwpdn1N2pjWi0o/N7zdfARbO5lcRz0G5+
	Rp2GGTm7nuz69vaSC/AI4aS07MRd98j1Pc7XqMPCXVWEKRWw6Dm2dHRVifia5qVS
	5IXCpQrgjXY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8A6857F241;
	Tue, 20 Oct 2009 18:00:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 09D6C7F23F; Tue, 20 Oct 2009
 18:00:34 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0910202153160.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue\, 20 Oct 2009 21\:55\:36 +0200
 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0190016A-BDC4-11DE-9970-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130856>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 20 Oct 2009, Junio C Hamano wrote:
>
>> Sverre Rabbelier <srabbelier@gmail.com> writes:
>> 
>> >> Or am I worrying too much?
>> >
>> > No, I think your concerns are valid, we should go with (2) and DTRT. 
>> > Does the updated patch address your concerns? If so I can send a new 
>> > version.
>> 
>> Assuming the internal blame algorithm correctly works with such an 
>> input, I'd be happier with an approach to allow users to tell the 
>> difference. The --porcelain output was designed to be extensible, and it 
>> might make sense to show the "this line is incomplete" as a separate 
>> bit, though.
>
> Sorry, you lost me.  If, say, line 614 is the last line that does not end 
> in a new line, if I ask for it to be blamed, I want to know who is 
> responsible for the current form of line 614.
>
> Not whether the line ends in a new line or not.

Yeah, I know.

I was primarily worried about making the output format into something
Porcelains (that read from --porcelain format) cannot reconstruct the
original text from.

See Message-ID: <7viqe9n72w.fsf@alter.siamese.dyndns.org> for a revised
suggestion.
