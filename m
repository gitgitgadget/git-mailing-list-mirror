From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 0/8] Expose the submodule parallelism to the user
Date: Thu, 29 Oct 2015 13:12:14 -0700
Message-ID: <xmqqsi4tqvs1.fsf@gitster.mtv.corp.google.com>
References: <xmqqfv0wp1l1.fsf@gitster.mtv.corp.google.com>
	<1446074504-6014-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jacob.keller@gmail.com, peff@peff.net,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 21:12:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrtYc-0004on-3p
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 21:12:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751770AbbJ2UMS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 16:12:18 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751474AbbJ2UMR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 16:12:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 18DA62769B;
	Thu, 29 Oct 2015 16:12:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LsYK3n621tflDKzZvUY3hxdmDFw=; b=J+N0HN
	XpevDJzZ5sPaizln9ek8HFepDxAbNIUOXW+1WnbwABMrHT7cmWxjD1F15+weqtFN
	8ZWYbU3sWlDY+SCOfwJhXSJBeqcMbNCGjnLtUqA/v8V6bpWPcfkmb8YTZkm9e1ar
	tbq+BfRkhOJwTsMVEvp5eX36Y2Svca/ws0dW0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bN9t8S1dH6Aegz3vBbBjb5RkR+l9xY8G
	48cXEDzWR41D05BB3elJu6Kl7pbioTpBW0+0xzqGluVrnuS9KrUeVFzsKGN9XN4T
	0Yw4AD9UCY1iabg1tP5AFeT/JOIOFIWSmEG7SlqiWimmIZrInZA1oKDSQg8E7j3/
	NfEC5gbAVHQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0F3C22769A;
	Thu, 29 Oct 2015 16:12:16 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 73CBE27699;
	Thu, 29 Oct 2015 16:12:15 -0400 (EDT)
In-Reply-To: <1446074504-6014-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Wed, 28 Oct 2015 16:21:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 59180DA2-7E79-11E5-8F2F-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280458>

Stefan Beller <sbeller@google.com> writes:

> This replaces origin/sb/submodule-parallel-update
> (anchoring at 74367d8938, Merge branch 'sb/submodule-parallel-fetch'
> into sb/submodule-parallel-update)
>
> What does it do?
> ---
> This series should finish the on going efforts of parallelizing
> submodule network traffic. The patches contain tests for clone,
> fetch and submodule update to use the actual parallelism both via
> command line as well as a configured option. I decided to go with
> "submodule.jobs" for all three for now.
>
> What is new in v2?
> ---
> * The patches got reordered slightly
> * Documentation was adapted

A couple of things I noticed (other than "many issues pointed out in
v1 have been updated") are:

 - The way 7/8 and 8/8 checks for uninitialized max_jobs are
   inconsistently written.  The way 7/8 does, i.e. (max_jobs < 0),
   looks more conventional.

 - "Defaults to the `submodule.jobs` option" should say
   "configuration variable" instead.

I haven't formed an opinion on 6/8 yet.
