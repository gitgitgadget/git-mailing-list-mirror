X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG. Git config pager when --edit
Date: Mon, 07 Nov 2011 09:02:23 -0800
Message-ID: <7vpqh327ds.fsf@alter.siamese.dyndns.org>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
 <CAH6sp9Ox+6p4RkjCZ0j3tXG9F4u7SPuwbSrOWmLSXic9DxSKiQ@mail.gmail.com>
 <20111107164250.GC27055@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 7 Nov 2011 17:02:42 +0000 (UTC)
Cc: Frans Klaver <fransklaver@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tvj+CY8X6PL7MgQ3p9Sf8fCL5E8=; b=qAYqVD
	SLpP6Vm/addJjvJDaTlSSBnwIVnyKSb3ob7Duy+3OC+Jxo3KfPYS/fBJhg5VJPpS
	ufXLhkzoyehSRVS6EPNLjeCqek4gmgmnVGnPn7LPGgXgIzn1l0DlqDfNf3VYePIo
	Bce6SXBGIUUQ4ZmuC8PNlVkjUWCpZRH2ZHAJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FxcHrAdH2sXVtgeQv9034SOObq4x9Y1j
	QNSk19w5GIDvD7QfUrigP15a/U1PdELrcL+1VpIzJDSX6XEaqLtKs8od9FHvAzkQ
	MyAVwJWBW0TG7ClvmXx6c8WzfGH4mam/jeM7WYd1QJVZ16yyrfrtRZMlu70WLlvo
	PhC18FC0oGw=
In-Reply-To: <20111107164250.GC27055@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 7 Nov 2011 11:42:50 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 43C4005E-0962-11E1-AA68-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185000>
Received: from vger.kernel.org ([209.132.180.67]) by lo.gmane.org with esmtp
 (Exim 4.69) (envelope-from <git-owner@vger.kernel.org>) id 1RNSac-0004th-V2
 for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932158Ab1KGRC0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Nov 2011
 12:02:26 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60565 "EHLO
 smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id
 S1755816Ab1KGRCZ (ORCPT <rfc822;git@vger.kernel.org>); Mon, 7 Nov 2011
 12:02:25 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B4AA49DB; Mon,  7 Nov 2011
 12:02:25 -0500 (EST)
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1]) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2233049DA; Mon,  7 Nov 2011
 12:02:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9434E49D9; Mon,  7 Nov 2011
 12:02:24 -0500 (EST)
Sender: git-owner@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I should probably polish and submit the patch here:
>
>   http://thread.gmane.org/gmane.comp.version-control.git/182238/focus=182475

I was actually hoping that you won't go that route, but the route to push
further to decide/spawn pager as late as possible. Clearly no sane person
would want to run --edit subcommand under pager and "pager.config = less"
