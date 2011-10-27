From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/22] Refactor to accept NUL in commit messages
Date: Thu, 27 Oct 2011 11:47:27 -0700
Message-ID: <7v7h3qz2yo.fsf@alter.siamese.dyndns.org>
References: <7vobx863v3.fsf@alter.siamese.dyndns.org>
 <CACsJy8B=TsC4A=R6b3jyYBCvorEDBYHQ8uA864WrB0-3pgNyKA@mail.gmail.com>
 <7vipng5k80.fsf@alter.siamese.dyndns.org>
 <CACsJy8CA2cqJqt7cUN1CdnOb3=qE6B2XTd1oQKZ7osVz09kSGg@mail.gmail.com>
 <7vehy459bg.fsf@alter.siamese.dyndns.org>
 <20111023160744.GA22444@sigill.intra.peff.net>
 <7v39ej5uqb.fsf@alter.siamese.dyndns.org>
 <7vy5wb3sto.fsf@alter.siamese.dyndns.org>
 <20111024224558.GB10481@sigill.intra.peff.net>
 <7vvcrd411x.fsf@alter.siamese.dyndns.org>
 <20111027181303.GF1967@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 27 20:47:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJUzH-0000Hv-IF
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 20:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859Ab1J0Srb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 14:47:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50771 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754757Ab1J0Sra (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 14:47:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BBB6D430E;
	Thu, 27 Oct 2011 14:47:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fcf3uqyrFe6ze74BlEHwPg7dncA=; b=pmjeb9
	HiMdMb15fp8qYoJMqmwc+cBFvJpiW+rt7BTLGirt53rK/WoUMO/KjkWex+EBjvD/
	cTMD1goi8nRQXSZDVk3y0M78oTwGNYxbh5GjxLt5n91sOIyuqgvaDtBTWxxmZ1AX
	/+bKNfsCLBve2ArmL1gLowGSIWRRPohGf2Es4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hE2aEzvwbEOY8XWq9QrkLGxLu49YoL5+
	8Rnk8Jja1DloepS4xyLTivWhBX6zRyKZQsXMktQyJs49JKciJFrBcXcjRGtw339k
	V2SmGpcbbCzH7gMrnB+ad3zkjsyFfbk7szxP7QfMiEydmx0ORV7YPUKWud3K7ReY
	rAs3eIrfjg8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B159D430D;
	Thu, 27 Oct 2011 14:47:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 46662430C; Thu, 27 Oct 2011
 14:47:29 -0400 (EDT)
In-Reply-To: <20111027181303.GF1967@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 27 Oct 2011 11:13:03 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1F1A9928-00CC-11E1-A25A-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184315>

Jeff King <peff@peff.net> writes:

> I'm tempted to detect the UTF-{16,32}{LE,BE} by their BOM, reencode them
> to utf8, and then display them in utf8. Is that too gross for us to
> consider?

I tend to think so; it is entirely a different matter if the user
instructed us to clean/smudge UTF-16 payload into/outof UTF-8.
