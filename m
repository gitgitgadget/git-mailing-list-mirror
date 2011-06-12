From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] zlib: zlib can only process 4GB at a time
Date: Sun, 12 Jun 2011 14:33:57 -0700
Message-ID: <7v4o3uspiy.fsf@alter.siamese.dyndns.org>
References: <1307736948-16956-1-git-send-email-gitster@pobox.com>
 <1307736948-16956-7-git-send-email-gitster@pobox.com>
 <BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun Jun 12 23:34:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVsIO-0006fg-Hs
	for gcvg-git-2@lo.gmane.org; Sun, 12 Jun 2011 23:34:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754096Ab1FLVeG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Jun 2011 17:34:06 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64530 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754438Ab1FLVeE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2011 17:34:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 271E9548F;
	Sun, 12 Jun 2011 17:36:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n4/7ZUtf48aI3Ecd8iNvSJqtyBQ=; b=E70c6h
	gV0drTAXyxUW8x/YunlbNeQI+9rAMj1Ax0WIt851KYXbJ72xS6dovCqTLIQUsQP1
	VeYnnxFKGrTtFLBXBC8+k02QQe4nF3+qn554x3I68ZiJprzP1+lp4FyZuU6WYRmt
	vc63a5TyOypNd+ix11y5mO/+KvLo8D96D0hHA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G14c6a8bZqGf39+f7isrfGcYHSVhbMhc
	WbaYZn/P2tW2eBpX8uHv8178LDiRh+ubZZgGm4fFMo7cB+sHLFc2Tb++mmJqoYBt
	riOrQ0ycvg/YH3zA5xhfg9jPjc4dAvwh9J09KjZV/KJj4B4M3lLxGPgMFd6M8nFO
	A7QeQMfA/6c=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 042A5548E;
	Sun, 12 Jun 2011 17:36:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2FC66548D; Sun, 12 Jun 2011
 17:36:08 -0400 (EDT)
In-Reply-To: <BANLkTikmLDZj2qdkmF-kBUkB33o9EjtBpg@mail.gmail.com> (Erik
 Faye-Lund's message of "Sun, 12 Jun 2011 22:43:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE111E88-953B-11E0-9759-C8CFB7AE1C3C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175668>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> On Fri, Jun 10, 2011 at 10:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> The size of objects we read from the repository and data we try to put
>> into the repository are represented in "unsigned long", so that on larger
>> architectures we can handle objects that weigh more than 4GB.
>
> shouldn't this be "size_t" instead of "unsigned long"?

No, this must be unsigned long as that is the internal type we use.

Implementation of git on 32-bit platforms has always been limited to 4GB
from day one. This topic is not about changing it.
