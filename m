From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Introduce a hook to run after formatting patches
Date: Thu, 20 Nov 2014 15:33:26 -0800
Message-ID: <xmqqioi91m7t.fsf@gitster.dls.corp.google.com>
References: <1416012460-4459-1-git-send-email-sbeller@google.com>
	<xmqqzjbryonp.fsf@gitster.dls.corp.google.com>
	<xmqqlhn9y7dn.fsf@gitster.dls.corp.google.com>
	<xmqqd28ly6p1.fsf@gitster.dls.corp.google.com>
	<CAP8UFD3m9aouYKXfk-vE4AGbTxdyH6=k8ey5n-kF1OLux2Ah0g@mail.gmail.com>
	<20141120232628.GA30554@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Christian Couder <christian.couder@gmail.com>,
	git <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Nov 21 00:33:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrbEE-0000vp-KI
	for gcvg-git-2@plane.gmane.org; Fri, 21 Nov 2014 00:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757431AbaKTXda (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 18:33:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757371AbaKTXda (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 18:33:30 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 603CB1F8D5;
	Thu, 20 Nov 2014 18:33:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GLgmFekBR6A7N66jCEXAL5XXTw8=; b=Q+hMDa
	XgZ9Ogg/iiCJBJuspS/6Fntf2vjPRDhKDvcw4pEhy6PTHiUzTE0J71X5uiS3xQrm
	mo6K6AwFeJQObl8KZirA9pddWjqtZOgja8EcJl5z2+21bY6Y3Bo4sL4WO10jQoFb
	soTKJVnfn050xIGJp16PPRvN0/ZxtrdXRoK/E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ERYeftbLS0SwuFclvBdBwuXeZ1e1aKdi
	nky1+gUGcDg+SRBC0IYpOpS0s3859icVlHdrbLBELAauk1KV7LZIERlt/9Ayff8n
	eT19wftowFdtSR8HRQsNlCcQ9z3ZGSGRfna4/npnWEpwgu7ExTt9dxYa5o3Z+gE7
	6dZHpnI4c8s=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 56EC31F8D4;
	Thu, 20 Nov 2014 18:33:28 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D61AC1F8D3;
	Thu, 20 Nov 2014 18:33:27 -0500 (EST)
In-Reply-To: <20141120232628.GA30554@google.com> (Stefan Beller's message of
	"Thu, 20 Nov 2014 15:26:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A11326B6-710D-11E4-9DF7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So I have read the man page on the trailers and it seems like the solution
> to my problem in removing parts from the commit message.
> However I did not find out, if it can be run automatically, whenever
> calling format-patch
>
> Maybe all that is missing here is an option
>
> 	git config format.enable_trailers 
> ?

The idea has been to first give a standalone text transmonger as a
filter for let people to try out, so that we know what kind of
changes are useful (e.g. "insert s-o-b at the very end") and make
sure the configuration language to specify the changes is easy and
expressive enough, which is more or less what we have in 'master'.

Once we gain experience (and that may result in updates to what is
in 'master'), in the second phase, we would figure out what code
paths can make use of this text transmonger (e.g. your configuration
variable "format.trailers" to affect the format-patch code path) and
integrate it more tightly to the codebase.

We are not there yet.
