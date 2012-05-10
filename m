From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/8] apply: accept --threeway command line option
Date: Thu, 10 May 2012 08:31:37 -0700
Message-ID: <7vvck4njc6.fsf@alter.siamese.dyndns.org>
References: <1336629745-22436-1-git-send-email-gitster@pobox.com>
 <1336629745-22436-3-git-send-email-gitster@pobox.com>
 <CACsJy8B18gua5kRCTY6aE13J1T0YROmvSFP+88XCunOZm32mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 10 17:31:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SSVLF-0006Is-Tj
	for gcvg-git-2@plane.gmane.org; Thu, 10 May 2012 17:31:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759295Ab2EJPbl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 May 2012 11:31:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40898 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757489Ab2EJPbk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2012 11:31:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7B77631E;
	Thu, 10 May 2012 11:31:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8vnGOsxS6NE6zrf8VlK2lpEW2Kg=; b=WI4j+N
	EX9vVr1aCXbc0o3dOKiiMLzhqFsJ+hI849RL8BUtPW6iAPq3xxz40h6KwSSDwbLc
	TOaEGt2gHmtrk02cSyfCq3a2pQUEzFE9UDL9KeSkNbQ66J9CI9ohhWB/My2AVQVY
	1r4bMuX4/SAsenMbi8kx6Z8c0zNkLY33pdgSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iF7pqrI3jnRILvSBkAzZQTM/netjoqqI
	KPW9wfXV3yY5oaMdNbxZ2xqRd+WjN+wfrimmySzzxxKDsUVkJiJsYKTaqFrHoAHF
	7yx7vRpv3Bc3+3vdxT/A5Ft5wkjWgkbA0kPHFjUKyVkGTMX7tene5X++kV390ssr
	dmKKTGW2hQQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECD7631D;
	Thu, 10 May 2012 11:31:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3603A631C; Thu, 10 May 2012
 11:31:39 -0400 (EDT)
In-Reply-To: <CACsJy8B18gua5kRCTY6aE13J1T0YROmvSFP+88XCunOZm32mww@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Thu, 10 May 2012 19:40:49 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C7B809E-9AB5-11E1-8DAF-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197584>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, May 10, 2012 at 1:02 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> This is the beginning of teaching the three-way merge fallback logic "git
>> am -3" uses to the underlying "git apply". It only implements the command
>> line parsing part, and does not do anything interesting yet.
>
> Can we reuse '-3/--3way' instead of --threeway? I already have hard
> time remembering which command uses -m/--merge, which one -3.

Oh, not just "Can we reuse", but we definitely should.  Thanks for
pointing it out.

It was just that I didn't check what "am" exactly calls it, as I always
just type "am -s3c" these days ;-).
