From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/10] revert: Introduce HEAD, TODO files to persist
 state, plan
Date: Thu, 26 May 2011 14:03:00 -0700
Message-ID: <7vhb8hw4xn.fsf@alter.siamese.dyndns.org>
References: <1306333025-29893-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-1-git-send-email-artagnon@gmail.com>
 <1306425233-504-9-git-send-email-artagnon@gmail.com>
 <20110526161102.GC24931@elie>
 <BANLkTi=FkK=k6OavQtqMRvPCZ7nc+iKtwQ@mail.gmail.com>
 <BANLkTi=ifQYFbq-ntpVF=1+sjv-wdkEJ-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 26 23:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhiC-00019B-RC
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758252Ab1EZVDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:03:16 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:41950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755056Ab1EZVDP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 17:03:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 466335512;
	Thu, 26 May 2011 17:05:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=F6b1bZrv2YdpMoaRPVQAmBBM2mg=; b=LnnYh8
	I7u5zK1fqQ0kZk3VcXnlKPDj8FaE4CmmoKSfasJpa+unAX4BHcOIdoA2P7yD4HQx
	KqHIlKPTuj59/oQhKkCc/rHfv2sJUbU3a0XmxInuATW9bfuauKb79tp48QR0fjmI
	EosofLUFj4Zjtxl1Td3yitXqCGexoPjZSr0bw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lejspt2yoblHDgaPDN3zbrI7FLvZrnnz
	jn3KKNCopRlvfzs7dLzXexwqwysMCZoxnIbNr9VwTmSk9RS/x7VClW8Z4aymDkQv
	jfF9TBLyVudVVvYHcnYjccVH5QkvhYbQtdY+YlkNeInZUXy7vgl29lEbc0d6m5Ek
	fSMHAIQR9sM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EA1DA5511;
	Thu, 26 May 2011 17:05:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id CB1DC5510; Thu, 26 May 2011
 17:05:08 -0400 (EDT)
In-Reply-To: <BANLkTi=ifQYFbq-ntpVF=1+sjv-wdkEJ-w@mail.gmail.com> (Ramkumar
 Ramachandra's message of "Thu, 26 May 2011 22:35:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DB59243E-87DB-11E0-AE1A-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174569>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> There's a good way to create a separation between patches 1-2, and the
> rest- thanks to Jonathan's suggestion on IRC.
> Junio: Would you like to merge just the first two patches? I'll
> continue working on the rest, and try to come up with something useful
> to merge in another week or two.

If you can split out a smaller series that is obviously correct and
justifiable with or without the rest of the series, that is very good
in general.

I think [1/10] almost falls into that category, modulo that we used to say
it is "fatal:" when you have unmerged files and cannot cherry-pick, but
you now say "error:", which I think is an unnecessary change that you may
want to avoid if you can.

I am not yet convinced [2/10] falls into that category.
