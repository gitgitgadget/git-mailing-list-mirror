From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible bug in Git
Date: Fri, 16 Apr 2010 09:56:11 -0700
Message-ID: <7vvdbrcp5g.fsf@alter.siamese.dyndns.org>
References: <4BC6EECE.6060408@gestiweb.com>
 <k2u32541b131004151645i78733507rc50724548036ef36@mail.gmail.com>
 <7vr5mggt9a.fsf@alter.siamese.dyndns.org>
 <o2m32541b131004151706hb48a0d04yf7fa4238d423a4e3@mail.gmail.com>
 <k2n32541b131004151713s51498b01s34c5a95c0f360901@mail.gmail.com>
 <alpine.LFD.2.00.1004160845350.15116@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Avery Pennarun <apenwarr@gmail.com>,
	David =?utf-8?Q?Mart=C3=ADnez_Mart=C3=AD?= 
	<desarrollo@gestiweb.com>, git@vger.kernel.org,
	deavidsedice@gmail.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Apr 16 18:56:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2oqE-00059D-UK
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 18:56:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758626Ab0DPQ40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Apr 2010 12:56:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:52839 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758606Ab0DPQ4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 12:56:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D0744AB176;
	Fri, 16 Apr 2010 12:56:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p4gCpgUaF7SpQp/3pmbSanxpLBs=; b=v0w86I
	5TQYYMYiWt76if91dw4yfS5DJ1/7hL0UMtvnxBWOurKv3DFGCk7uEfpy1+42mKgX
	evBJp3mh9bd5oF9LRFlLbg0o4bDZQXvTOqAHEYh4lljNearFKuiEvuYTAAKH0Ito
	0mTB5gpNvwozeTL/vuJ1dc+rX+S1YxPG6nY20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AwARho8uBfmwybvKLhFmtMRGwwxHyubJ
	NRqp7PD21vw1JH3xTZHSaAvxTIkv8t+nWhdmPOMz2KfUAqhniYep8tcOKSmtSOnD
	6KdrUY7YRLBlp7qg+C5PTdohoTZsqBDQIFO+MqLtAUVgzXOHB55uAAyOovcCY1l6
	wXS/9Gr4pe0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 802B7AB175;
	Fri, 16 Apr 2010 12:56:18 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1735AB174; Fri, 16 Apr
 2010 12:56:12 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.1004160845350.15116@i5.linux-foundation.org>
 (Linus Torvalds's message of "Fri\, 16 Apr 2010 08\:53\:00 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FA13D614-4978-11DF-BC7E-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145084>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I guess the issue is that combine-diff decides that there is nothing in 
> the result that isn't in either of the sources (because there is nothing 
> at all in the result), and as such it's not "interesting" after all.

There was already a "fix" posted for the "empty vs missing" confusion.

From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] combined diff: correctly handle truncated file
Date: Thu, 15 Apr 2010 14:59:37 +0200
Message-ID:
 <884b9b68a4478aceda580299c059a9a67417cb1c.1271336073.git.trast@student.ethz.ch>

I've been busy for the past few days, but I have it in my 'to-maint'
queue.  We may actually want to do the same for "missing" case as well,
though.
