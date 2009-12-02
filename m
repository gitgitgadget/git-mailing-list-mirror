From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 0/8] Git remote helpers to implement smart
 transports.
Date: Wed, 02 Dec 2009 10:07:55 -0800
Message-ID: <7vskbtfdvo.fsf@alter.siamese.dyndns.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fabb9a1e0912010812t4de8027dj1faf828051d1adc2@mail.gmail.com>
 <20091201165245.GF21299@spearce.org> <20091201171908.GA15436@Knoppix>
 <20091201193009.GM21299@spearce.org>
 <7vskbuwhmy.fsf@alter.siamese.dyndns.org> <20091202055632.GD31244@Knoppix>
 <7vy6llnar5.fsf@alter.siamese.dyndns.org> <20091202160446.GA32667@Knoppix>
 <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 02 19:08:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFtcl-0006sx-Ss
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 19:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755243AbZLBSIH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 13:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbZLBSIG
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 13:08:06 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755187AbZLBSIE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 13:08:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EA3B984436;
	Wed,  2 Dec 2009 13:08:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I/t68b6duZlZH/evw1Kjvsss4u4=; b=cYby6l
	EARHq1/E5YbCGK/dCVGCn1ZNaW8/5WHaNfKSw5pdTblR6huysMgYv/JsJApHUT+X
	W/1Mqw+sGJb0Wobzj+pcQB5QjV8MT+n46b+GuB3U/xMewa9bh6v1w+tf5NxyIoT1
	kxEg2wAhcS+4XOQx8bNnOQ4nk+xIwKKwdiSzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EEErJAz7gFG1bIrB9scLNBmkK+iRCMH/
	YtZRVy53uduNaW0bVtFdlmEwf9nv4GeQ56HfNmo00uKc00i3ZTF45+wvfyc4zICw
	+msKW8GqziAam27DsXmMqA8UR6US9XNw+iMUGMF+bW8tnotgd9jUbTLEiei25rvl
	Tu0MUs3Jjj8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 70CBA84433;
	Wed,  2 Dec 2009 13:08:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6110B84430; Wed,  2 Dec
 2009 13:07:57 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0912021832480.4985@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Wed\, 2 Dec 2009 18\:39\:19 +0100
 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A23E9610-DF6D-11DE-A684-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134366>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is definitely a good direction, and it would be even better if the 
> absence of the remote helper was also handled gracefully.  Just think 
> about a (as of now fictious) git-remote-http.rpm relying on git-core.rpm 
> and libcurl.rpm.  If you do not want to access http:// URLs, you can 
> install just git-core.  Once you encounter an http:// URL you need to 
> access, you install git-remote-http.  Keeping git-core.  (I like to call 
> this setup "modular".)

The "modular" setup is a good thing to do, but I do not know how it
relates to the change Ilari did.  Isn't it simply a matter of excluding
git-remote-curl from the current set of binaries to be shipped with
git-core.rpm and making a separate git-remote-http.rpm to contain it, or
does it involve a lot more than that from the packager's side?
