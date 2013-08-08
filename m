From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: remove another ternary expression always evaluating to true
Date: Thu, 08 Aug 2013 15:03:25 -0700
Message-ID: <7v8v0b96xe.fsf@alter.siamese.dyndns.org>
References: <1375988103-29947-1-git-send-email-stefanbeller@googlemail.com>
	<alpine.DEB.1.00.1308082257580.24252@s15462909.onlinehome-server.info>
	<52040C18.4030306@googlemail.com>
	<alpine.DEB.1.00.1308082335050.24252@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>, Jens.Lehmann@web.de,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 09 00:03:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7YIw-0007an-7h
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 00:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab3HHWDa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Aug 2013 18:03:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51434 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758176Ab3HHWD3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Aug 2013 18:03:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C86B37088;
	Thu,  8 Aug 2013 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/ygp8LlAIW58AB0Ncl3DgA+0gbA=; b=P/kZPQ
	vRA4rhDNix2txGxBG3PuMYyVpKVfnQEC4ush4KL1r/2W8521kBuyo+O+xZ2JXszD
	3LFK4NCMIkUf+rxiUlKtCEIqhqnrKz9cFHTVlPPyg1NeDEdIf0JagskRg/+QH2ha
	SH9aoJ3Cdb5Wxzl8XomxbEkzMFotUGdVUl1/M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vsCkmbyxF65Fu08YglBgXdj22Canlbly
	lV+8tYPu8Oh/Yrl36BrL07VBEpwxB+xBxvyTq0xmYcNZr1PR/VkKz+jvQyyhQnaY
	7ZFkYCSg2uAHXC/5G6DeHSmyGp2a9QsP0MqGXC0Crn/dLdwR9kDOj2fMBdr//rhW
	/ThTs96Gz6g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 703D237087;
	Thu,  8 Aug 2013 22:03:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5E5BF37085;
	Thu,  8 Aug 2013 22:03:27 +0000 (UTC)
In-Reply-To: <alpine.DEB.1.00.1308082335050.24252@s15462909.onlinehome-server.info>
	(Johannes Schindelin's message of "Thu, 8 Aug 2013 23:36:28 +0200
	(CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5A653636-0076-11E3-9205-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231943>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Stefan,
>
> On Thu, 8 Aug 2013, Stefan Beller wrote:
>
>> So you rather propose to have 
>> -		show_submodule_summary(o->file, one ? one->path : two->path,
>> +		show_submodule_summary(o->file, one->path ? one->path : two->path,
>
> I do. The reason is that one->path could be NULL (but not both one->path
> and two->path) and the summary would not be as helpful as possible if it
> wrote "(null)" instead of the path of the submodule.

Good.

Also some C libraries would choke when asked to %s format a NULL,
instead of giving "(null)" to avoid segfaulting (which I think is a
quirk in glibc).
