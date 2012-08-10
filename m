From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/4] jk/version-string and google code
Date: Fri, 10 Aug 2012 12:11:30 -0700
Message-ID: <7vhasak1el.fsf@alter.siamese.dyndns.org>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <7vboiilpvs.fsf@alter.siamese.dyndns.org>
 <CAD0k6qTnQ+b8e2wt4WZ2HhOdsKXzcMkGbUZBkbw2j6_mQdE9GA@mail.gmail.com>
 <20120810180836.GA29597@sigill.intra.peff.net>
 <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, "Shawn O. Pearce" <spearce@spearce.org>,
	git@vger.kernel.org
To: Dave Borowitz <dborowitz@google.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 21:12:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Szucc-0004gZ-U9
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 21:11:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760124Ab2HJTLj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 15:11:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45904 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752421Ab2HJTLe (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 15:11:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35BF88449;
	Fri, 10 Aug 2012 15:11:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pzBzFhBc7AmYuIPFL4fFgvCdBWQ=; b=oU4GT2
	OKj+EHprwAca4pIGf/d/3ee11hlckYIZJU2boPVPNBO74YUwKWdipNygZLfcWgrF
	ivPEMd9bn5zshgbO/m6e3PLuyMnJwnBSNSeBMsu2rbNFFdZbcTlbkFniDBb9omkz
	PITdPNf2NZUggwicuzHrQqcb0OzPuKUZo5pCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=S3z5Eb7eod0jtFRmYjVzTABF1+v/WY/h
	nAuqd205uNbvX1kqxKgA0iA2dSOA0C9qvkMABcHeb+ycoE+SQDzu/+wV2KyLRznF
	OM5KOzicWw3YNhSaFApBQN+3EwIwZNJxmtSTCmNTvAU9n0PXut3Mvoiur0eCC+B4
	oja//yc1Nf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 245458447;
	Fri, 10 Aug 2012 15:11:34 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60FA08445; Fri, 10 Aug 2012
 15:11:32 -0400 (EDT)
In-Reply-To: <CAD0k6qSZYH5mvwR5PKhs1FFAPqMfRryXooxd_qhtt+eGXU7pUA@mail.gmail.com> (Dave
 Borowitz's message of "Fri, 10 Aug 2012 11:13:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 32D3B5C2-E31F-11E1-88C6-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203248>

Dave Borowitz <dborowitz@google.com> writes:

> You may also notice in that code a set of innocuous_capabilities,
> which IIRC is the complete set of capabilities, at the time of
> writing, that the C git client may send without the server advertising
> them. Such a set (painstakingly assembled, I assure you :) may be
> useful as we move further in this direction.

In builtin/fetch-pack.c, we find this:

		if (!fetching) {
			struct strbuf c = STRBUF_INIT;
			if (multi_ack == 2)     strbuf_addstr(&c, " multi_ack_detailed");
			if (multi_ack == 1)     strbuf_addstr(&c, " multi_ack");
			if (no_done)            strbuf_addstr(&c, " no-done");
			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
			if (args.use_thin_pack) strbuf_addstr(&c, " thin-pack");
			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
			strbuf_release(&c);
		} else
			packet_buf_write(&req_buf, "want %s\n", remote_hex);

The ones we choose to throw at the other end based on "args.foo" are
not protected by "server_supports()" at all, which is where the
hardcoded list of "innocuous capabilities" comes from.  I would say
this is a client bug.  I wish Dulwich folks didn't choose to be
silent when they added that hardcoded list as a workaround.

If a client threw a request X at a server that does not support it,
and relied on a server bug that does not reject such a request to
allow it send a pack stream that does not conform to what X asked,
and handled the pack stream assuming that the server did X, it would
be a triple bug on the client's end.  Depending on the nature of X,
the end result may be broken. Dulwich is correct to raise an
exception upon seeing agent=foo.

One could argue that from correctness standpoint, being asked to
send ofs-delta and using only ref-delta does not make a corrupt
packfile (it just makes things less efficient), but we cannot
guarantee that all protocol capabilities will be "innocuous" that
way. Longer term direction should be to reduce the "innocuous" set.

Thanks.
