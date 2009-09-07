From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Mon, 07 Sep 2009 12:06:08 -0700
Message-ID: <7v7hwatw0v.fsf@alter.siamese.dyndns.org>
References: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
 <0016e6470f36315b8a0472bc75a8@google.com>
 <20090904212956.f02b0c60.rctay89@gmail.com>
 <7v8wgrbb9e.fsf@alter.siamese.dyndns.org>
 <be6fef0d0909062253p1b86628et8a9f979952eebb00@mail.gmail.com>
 <7vocpn44dg.fsf@alter.siamese.dyndns.org>
 <20090907172751.6cf38640.rctay89@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com,
	Tom Preston-Werner <tom@mojombo.com>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 07 21:06:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkjXn-0005B6-Vo
	for gcvg-git-2@lo.gmane.org; Mon, 07 Sep 2009 21:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269AbZIGTGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2009 15:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754180AbZIGTGS
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Sep 2009 15:06:18 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754141AbZIGTGR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2009 15:06:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DD0AC235EF;
	Mon,  7 Sep 2009 15:06:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWqUYDlQ6jXsoAtrT9NJp7c6ba0=; b=BJCwY5
	cDom9CYuEVkZ3GCUqf9FbcGMDAmnQFuVwj5485J+HDyKnNYya6JTUTGZHUjvJDwH
	sHulTGheS+QTu5oWBCBGzZs36ZHj7ymlaOBhlO5fS9mCz8ZpcPznpsvxAVbZYBfE
	OWUFTPTtBuBpKIPEqfahN1ZBFXHayH4/llWnw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KVTR58izv1Atv7ugqZuVlZ8GqItzFB9U
	7VdXtc+KL5x55O3o/rr/R5rHDRhwfntYhPDQTrXAVzMvaKxH8F1adtp96+SYyFTL
	E0V7IG/AGjqapYyCWNBefO1CXLP9aHlLI0RmM3VwErm+aBC1f9FQTgWK7B0VGEgP
	hbFCsAuUv1I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A4E28235E9;
	Mon,  7 Sep 2009 15:06:14 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D9F5B235E3; Mon,  7 Sep
 2009 15:06:09 -0400 (EDT)
In-Reply-To: <20090907172751.6cf38640.rctay89@gmail.com> (Tay Ray Chuan's
 message of "Mon\, 7 Sep 2009 17\:27\:51 +0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 83A7BA44-9BE1-11DE-B7F9-A13518FFA523-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tay Ray Chuan <rctay89@gmail.com> writes:

> Just to clarify: the "check" of CURLE_OK in http-walker.c::fetch_index()
> in v1.6.3 is fundamentally different from the check we have in 48188c2
> (http-walker: verify remote packs, 2009-06-06).
>
> The first "check" is a full-blooded GET request, and we do get back
> actual data (in this case, the pack index file). The second check isn't
> a GET request, just an inconsequential HEAD request; we don't get back
> any real data.

Yeah, I realized after I wrote the message you are responding to and ran
some experiments with github repository myself to see for some of their
URLs HEAD gives 500 when GET gives the contents just fine.

  Tom, sorry to have given a confusing list of issues in my earlier message.
  Please disregard it.  The only funny your HTTP server folks may want to
  look into is that GET request to fetch the following URL gives the
  contents just fine, but HEAD request to it results in an Internal Server
  Error.

  http://github.com/tekkub/addontemplate.git/objects/pack/pack-382c25c935b744e909c749532578112d72a4aff9.pack

  Sorry about the confusion.

> Agreed. I didn't intend my patch to loosen up error checking, merely to
> be clearer about what we're looking for. If read in another context
> (separate from fixing cloning over github.com), my patch can be seen as
> one that clarifies the verify-remote-pack check:
>
>   Case 1: A 404 is received. The pack file is not available, so we stop.
>
>   Case 2: Our check failed, due to some reason (request failed,
>           unauthorized, etc). Nothing conclusive about availabilty of
>           file. Continue anyway.

I am torn about this.

On one hand, if we are going to treat such a half failure as nothing
conclusive, I do not see a point to keep that check to begin with.

On the other hand, if a HEAD request to a URL results in an unauthorized,
what plausible excuse the server operator could give for allowing a GET
request to the same URL?  If we are going to keep the check if *.pack that
corresponds to the *.idx will be available, shouldn't we trust whatever
check we perform?
