From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 09/16] Read index-v5
Date: Wed, 08 Aug 2012 14:50:33 -0700
Message-ID: <7vsjbxqcie.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-10-git-send-email-t.gummerer@gmail.com>
 <7v4nog1twd.fsf@alter.siamese.dyndns.org>
 <20120808074138.GD867@tgummerer.surfnet.iacbox>
 <7vr4rhtjkd.fsf@alter.siamese.dyndns.org>
 <20120808204435.GC25671@tommy-fedora.surfnet.iacbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 23:51:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzE9u-0003NM-VC
	for gcvg-git-2@plane.gmane.org; Wed, 08 Aug 2012 23:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751620Ab2HHVug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Aug 2012 17:50:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34035 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750962Ab2HHVug (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2012 17:50:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ADD8B6855;
	Wed,  8 Aug 2012 17:50:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=45/n9G08Ua/zaAV2RZZYqu0bTIU=; b=TsdXAg
	kFSv49da3Hs5O9/BsfjWF9o/feE2HAG/e05pgLhh7tvPPtrl62zXmJCCNTr8vL3V
	JFCeus8/dzDWGP6Rc7ONKbHS4j532vWtfsiRScEO8s2HGhj2ckqczawNDvj4d1X9
	bJCj2YwTm8CB3rYHNIIvKINnD9o/22tYTFSQo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZY+4PayOS1yQo7kOMpFmc7STnhMcChc7
	wtJJ7L1dSb3uFow7Ahxaibzu4ke9JSWaeQM3K+Coeyb5ops7TT6vHbCh6+Q3LUD7
	5+AXsap4BxVYPgtw3X2rJaG0sb/sJeRSuFHq09zWwnQrv5/+1AOWPE0t+Gf3zqHj
	VTtjn8UC25U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9A39B6854;
	Wed,  8 Aug 2012 17:50:35 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F3D656852; Wed,  8 Aug 2012
 17:50:34 -0400 (EDT)
In-Reply-To: <20120808204435.GC25671@tommy-fedora.surfnet.iacbox> (Thomas
 Gummerer's message of "Wed, 8 Aug 2012 22:44:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 15425D92-E1A3-11E1-8645-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203136>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> On 08/08, Junio C Hamano wrote:
>> Thomas Gummerer <t.gummerer@gmail.com> writes:
>> ... 
>> After thinking about this, the ptr_add() macro might be the best
>> solution, even though I originally called it as a band-aid.  We know
>> mmap is a blob of memory, byte-offset of each component of which we
>> know about, so we can say
>> 
>>     name = ptr_add(mmap, *dir_offset);
>>     beginning = ptr_add(mmap, *dir_offset);
>> 
>> Hmmm..
>
> I start to think so too. Casting the mmap variable to "const char *"
> in the method call doesn't feel right to me, even though it would work.
> Unless there are any objections I'll use ptr_add in the next version.

Thanks for sanity checking my thinking.
