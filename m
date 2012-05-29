From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Add persistent-https to contrib
Date: Tue, 29 May 2012 16:34:12 -0700
Message-ID: <7vobp61s0b.fsf@alter.siamese.dyndns.org>
References: <1337792767-18914-1-git-send-email-cranger@google.com>
 <1338328320-5653-1-git-send-email-cranger@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Colby Ranger <cranger@google.com>
X-From: git-owner@vger.kernel.org Wed May 30 01:34:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZVvk-0004JC-Eq
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 01:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756029Ab2E2XeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 May 2012 19:34:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36324 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755840Ab2E2XeO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2012 19:34:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2C25493F1;
	Tue, 29 May 2012 19:34:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dAxqHyj7G7wuOJHNpBG3lXx/oqk=; b=ZD7OuE
	HnvYxMsA9NfQiwBrWu/zhIjNj0Ysl+ZnxYZxt+d05SOu1cOf2E5PxXs/6/a/J0a/
	IWVn6lIF00F4D9M9Pfnx+dPp9aclouiLfkNikarT4UYcGnsXh+n7AITRR6jOgXHG
	gqr7ofQT2W9ukj+8a7qw2T2fFVfq1qNjWQ8ww=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tVTXIDjMrDI2k1vx4migDc8tet/SHvAB
	sPAZd6NEzBra3E+gpG9eV4to0pU41EORoaUYghGqAK3/2k5INPnNWpspcDfc+Z2H
	eCph1RWDUjzMiPMNq21DJ7VHAR1s92nGVluzio+6Vvtc/9AqRFQnO8VceqtNOIaf
	Cw2J8s6U2kU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 21ADF93F0;
	Tue, 29 May 2012 19:34:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8022193EF; Tue, 29 May 2012
 19:34:13 -0400 (EDT)
In-Reply-To: <1338328320-5653-1-git-send-email-cranger@google.com> (Colby
 Ranger's message of "Tue, 29 May 2012 14:52:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC70DC86-A9E6-11E1-B6E4-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198775>

Colby Ranger <cranger@google.com> writes:

> Git over HTTPS has a high request startup latency, since the SSL
> negotiation can take up to a second. In order to reduce this latency,
> connections should be left open to the Git server across requests
> (or invocations of the git commandline).
>
> Reduce SSL startup latency by running a daemon job that keeps
> connections open to a Git server. The daemon job
> (git-remote-persistent-https--proxy) is started on the first request
> through the client binary (git-remote-persistent-https) and remains
> running for 24 hours after the last request, or until a new daemon
> binary is placed in the PATH. The client determines the daemon's
> HTTP address by communicating over a UNIX socket with the daemon.
> From there, the rest of the Git protocol work is delegated to the
> "git-remote-http" binary, with the environment's http_proxy set to
> the daemon.
>
> Signed-off-by: Colby Ranger <cranger@google.com>
> ---

Thanks.  I'll add a few paragraphs taken from Shawn's message in
this thread before queuing, but it'll take some time until I get to
this patch (I am looking at a totally unrelated topic that brought an
unpleasant regression to cherry-pick).
