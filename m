From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Code reorgnization
Date: Thu, 17 Mar 2016 09:21:02 -0700
Message-ID: <xmqqbn6d13f5.fsf@gitster.mtv.corp.google.com>
References: <20160317111136.GA21745@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 17:21:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agafg-0002tK-7d
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 17:21:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936119AbcCQQVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 12:21:08 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:58158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933326AbcCQQVG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 12:21:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A1E324B6E0;
	Thu, 17 Mar 2016 12:21:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=grokau7lXT97GcN9fxMz1M0sVjY=; b=SXJ6QZ
	ga9cUuTY85dKDMtsKy9fbGUYrUWZkdgSo+YibjYJgFr5osPbTRXyOY4aCGBrzVZu
	DFXV6wt4uRU0/fqed/A0qZ7oSZo9z6sr7K2Lc7cNWCWCFOxNyqNJSKcWu14IC2OE
	cCaMpEpYtrSUzms1r79OXfTD6BPzdRtSrm5xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2EHGCjwpsBi7/el6D/KqPNQiDXaSHGc
	jIP00UnFrzbici/TdKpgdkNIZeWG8Iu37XiUn+aHzouINcPR2GS6x3+EI5RcqAu2
	oo+2O0OAJIfStPILS03TuxOm2FwyMIq2pyP2PVg6ak2EFS6FDvK9uLOhJ17XMvfl
	rEzVbVZ2Y9c=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 992E64B6DD;
	Thu, 17 Mar 2016 12:21:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 174A84B6D8;
	Thu, 17 Mar 2016 12:21:04 -0400 (EDT)
In-Reply-To: <20160317111136.GA21745@lanh> (Duy Nguyen's message of "Thu, 17
	Mar 2016 18:11:36 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3EE5FB1E-EC5C-11E5-A714-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289122>

Duy Nguyen <pclouds@gmail.com> writes:

> Good? Bad? Ugly?

Too fine-grained to induce confusion for things that have to work as
a bridge between two categories (e.g. odb & index).  In short, bad
and ugly.

I am OK with a looser classification e.g. (1) things that can be
used without Git at all like strbuf, string-list vs (2) things that
are Git but shared across different subcommands like read-cache,
sha1_file, vs (3) command implementations (e.g. builtin/ and also
standalone).
