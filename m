From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Bug#553296: gitignore broken completely
Date: Fri, 30 Oct 2009 12:51:13 -0700
Message-ID: <7vvdhwk6dq.fsf@alter.siamese.dyndns.org>
References: <20091029233458.GA32764@ikki.ethgen.de>
 <20091030162857.26604.qmail@67b7e3b41a17c8.315fe32.mid.smarden.org>
 <20091030165903.GA10671@ikki.ethgen.de>
 <20091030173838.GB18583@coredump.intra.peff.net>
 <20091030182331.GC10671@ikki.ethgen.de>
 <20091030184155.GC19901@coredump.intra.peff.net>
 <20091030190552.GA3528@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Klaus Ethgen <Klaus@Ethgen.de>, 553296@bugs.debian.org,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 30 20:51:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3xVV-0000fi-Hm
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 20:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756655AbZJ3TvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 15:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755678AbZJ3TvW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 15:51:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46071 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754700AbZJ3TvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 15:51:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2E738B1C5;
	Fri, 30 Oct 2009 15:51:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dNUyhW6FxQXFSDrFDlFSvmB/q6Y=; b=iYcql/
	E2yrazg5NLrGxrdKhd0y2Wcq7OxlKcwNskpIf6Pdj3VT69RrwZ7fEcuqAOl17V7F
	8wj2IPG+xHDe1kzJc5GTQIyA6VE5DRv9/C0mMBPhAz3Ulxz7JdSx0P0fa3rO+mVe
	0e7Acl0jZtuOfJQCm87C1Ym2HUHvy6EEmwpuM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=skoEDkaVvZlhJQA+9M7QawzA+F2Ga7pl
	MKMKpw6vhq7K/2v0wtABtUTX0IqtdEc07E+vgZkGz/nhv77C20MNlLhlBkPc6hyV
	sTI//uPT/c6CKHxVH1O9VO19wUwiqZnvvEkurJ0AxWX2r2hAb4Gs0ZZBeTdkxhIW
	6uVEuVKEhsg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 845748B1C3;
	Fri, 30 Oct 2009 15:51:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 648488B1B9; Fri, 30 Oct 2009
 15:51:15 -0400 (EDT)
In-Reply-To: <20091030190552.GA3528@coredump.intra.peff.net> (Jeff King's
 message of "Fri\, 30 Oct 2009 15\:05\:52 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 998D947A-C58D-11DE-AC7D-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131740>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 30, 2009 at 02:41:55PM -0400, Jeff King wrote:
>
>> >    6. Revert the patch and rework it so that it will only have effect if
>> >       there is no -i option on the command line. (That is similiar to a
>> >       mix of 3 and 4.)
>> 
>> Yeah, that would actually be the least invasive change, and would keep
>> "-i" just as it is. If we do anything except a simple, I think your (6)
>> makes the most sense.
>> 
>> Let me see if I can make a patch.
>
> Here it is. I think this is the right thing to do. Junio?

I am not sure; my head spins when I see "tracked but ignored" (you have
a new one in the test) which is quite a bogus concept.

Does it mean "tracked but would be ignored if it weren't---perhaps it was
added by mistake?"?
