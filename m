From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] diff: add a config option to control orderfile
Date: Tue, 17 Sep 2013 10:24:19 -0700
Message-ID: <xmqqfvt3z7i4.fsf@gitster.dls.corp.google.com>
References: <20130831194425.GA14706@redhat.com>
	<xmqqioyhu8wd.fsf@gitster.dls.corp.google.com>
	<20130903210815.GB24480@redhat.com>
	<20130915074900.GA30438@redhat.com>
	<20130915080830.GA30465@redhat.com>
	<xmqq8uyv1kka.fsf@gitster.dls.corp.google.com>
	<20130917164226.GB20672@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 17 19:24:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VLz0m-0002pW-8o
	for gcvg-git-2@plane.gmane.org; Tue, 17 Sep 2013 19:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447Ab3IQRYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Sep 2013 13:24:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51972 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752914Ab3IQRYX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Sep 2013 13:24:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 679524221D;
	Tue, 17 Sep 2013 17:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wfOF+I3yfst73LfzU/GAnRg8C6I=; b=nSdLVc
	1e43O7hbQxNRC5WpcG3AAKLoHk8YZIgRVl7L+T1c3Iqo3JFn0x6mulOTxT6guviI
	4aC19XbxRHw4UeGsgeNF9hZ5/BB05fXrL92yHG8nTSGIURFC6aIXW4il7bhdxWs2
	dpqmPvL3qn/GaYeitg61szxs2XNw+gjz+OQ+w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VYrUgWAldGg0484bCCjixkwknYIqAmu4
	SST2gOg/R0qidwr7/rJj06MIpJjKpi2tfowaHC6BvJKio0T9wOp5MvuKZZvZEUzn
	BUnqG0/Ui/m/gv5qnD/EglrwPHYRR2KyH0TxIWETRg2tyVDpeEwrv39iIVR4c4zw
	UWsFnqWb16Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DDB44221C;
	Tue, 17 Sep 2013 17:24:22 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF44942207;
	Tue, 17 Sep 2013 17:24:21 +0000 (UTC)
In-Reply-To: <20130917164226.GB20672@redhat.com> (Michael S. Tsirkin's message
	of "Tue, 17 Sep 2013 19:42:26 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FDC2C8A0-1FBD-11E3-AD28-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234892>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> So might it not be useful to tweak patch id to
> sort the diff, making it a bit more stable?

That is one thing that needs to be done, I think.  But it would be
unfortunate if we have to do that unconditionally, though, as we may
be "buffering" many hundred kilobytes of patch text in core.  If we
can do so without regressing the streaming performance for the most
common case of not using the orderfile on the generating side (hence
not having to sort on the receiving end), it would be ideal.  I am
not sure offhand how much code damage we are talking about, though.

> I'll be glad to help do this if you tell me what these parts are.
> anything else besides fixing besides the stand-alone patch id?

Off the top of my head I do not think of one (but that is not a
guarantee that there isn't any).
