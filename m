From: Junio C Hamano <gitster@pobox.com>
Subject: Re: stripping [PATCH] without losing later tags from mailed patches
 (Re: [ 02/12] Remove COMPAT_IA32 support)
Date: Mon, 12 Mar 2012 11:04:23 -0700
Message-ID: <7vvcm9snko.fsf@alter.siamese.dyndns.org>
References: <20120312002046.041448832@1wt.eu>
 <1331514446.3022.140.camel@deadeye> <20120312024948.GB4650@kroah.com>
 <20120312063027.GB8971@1wt.eu> <20120312064855.GB16820@burratino>
 <20120312085820.GA11569@1wt.eu> <20120312152004.GB9380@kroah.com>
 <20120312152453.GB12405@1wt.eu> <87aa3l4vqq.fsf@thomas.inf.ethz.ch>
 <20120312165703.GB18791@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, Willy Tarreau <w@1wt.eu>,
	Greg KH <greg@kroah.com>, Ben Hutchings <ben@decadent.org.uk>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Mon Mar 12 19:05:21 2012
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1S79cV-0004IZ-I8
	for glk-linux-kernel-3@plane.gmane.org; Mon, 12 Mar 2012 19:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756053Ab2CLSE3 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Mon, 12 Mar 2012 14:04:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755005Ab2CLSEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Mar 2012 14:04:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1DA46699;
	Mon, 12 Mar 2012 14:04:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5sDPgmAVjzEVS9jE6QLd5ll53yA=; b=qKEDTW
	qY2wpUkTJix/Vb3ghgfKdrc+pmv50UcTkfaiUpVZdYHoGNk74iwdWMPhcbrzSp/Q
	OChwpeyUXlI//N3xZMUgM+gCJfNNBgBd1XXjgjOhuYXGc3IyLYmdTRWFAmEMTrXK
	Pi4HnPPalAAGXXHXEj5/fhC0SYuPSQCXBSdHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fM4vszAIHXf1G2s9VIVQAxLeWW0C0cJx
	tIsRjRtRCaccvE4dL8yMOzJqHlP4+8ER97Ln0yfiLLiYD7pccRaVKN1A5mQK5ugN
	/tIH60GZPCVxIH8SH/ulh8iaEFdWA42u0tAXYrT0+JOLrwz/t5rOSOM/izZP9uIc
	vsJ7TyqlO4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E90B36698;
	Mon, 12 Mar 2012 14:04:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6B5266697; Mon, 12 Mar 2012
 14:04:24 -0400 (EDT)
In-Reply-To: <20120312165703.GB18791@burratino> (Jonathan Nieder's message of
 "Mon, 12 Mar 2012 11:57:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD0783EA-6C6D-11E1-AB82-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192914>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>
>> The problem with -b is that it's a backwards-compatibility shorthand for
>> --binary, which used to pass --allow-binary-replacement (or --binary) to
>> git-apply.  However, that option was obsoleted in 2b6eef9 (Make apply
>> --binary a no-op., 2006-09-06) and has been a no-op for over 5 years.
>> It has also not been documented since cb3a160 (git-am: ignore --binary
>> option, 2008-08-09).
>>
>> So perhaps we can safely claim -b for --keep-non-patch, like so:

We can delete "git am -b" (as it was deprecated long time ago), wait
for a cycle or two, and then repurpose it.  I do not mind starting
the first step (delete, but do not say anything about repurposing)
before 1.7.10-rc1 happens.
