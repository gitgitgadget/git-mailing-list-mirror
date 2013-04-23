From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git fetch refs and tags
Date: Tue, 23 Apr 2013 07:59:52 -0700
Message-ID: <7vsj2hl2c7.fsf@alter.siamese.dyndns.org>
References: <1366714421.2899.10.camel@lws-weitzel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sitaramc@gmail.com
To: J.Weitzel@phytec.de
X-From: git-owner@vger.kernel.org Tue Apr 23 17:00:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUehM-0001TP-DO
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 17:00:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639Ab3DWO7z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 10:59:55 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755020Ab3DWO7z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 10:59:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9FDB618A49;
	Tue, 23 Apr 2013 14:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7iueoYm5Z50SgItqBF0/5J5wAjM=; b=acTxSU
	gelnH2KpcdfmnSAsYCtmY/uDYDAII/cTzPPGI6/70NU4FMwiEjEQVp659+mEvR1C
	+CFU+X3kLVHc4jycR9qHgT0VmUco/H0NquhsNyr4lPGqeZvwk9N0slok2IBTkzoH
	qZ15ZgpPLRIywT46K8zZUw5yFn0dHalLbA+70=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ai7z1mBXQwx3A0ZMAgZqUDcAub1Buygx
	EKr3nxljnGtGvEgkgMPCYBPUeQlZHj9/3Sxhh9sWloaugnBZ5failjr84H2wVIId
	vJLnHwilrB50YokkCEw/H7s9JlnAl4wJ8WZorFzKxlcTESeG+M8wGNKs5rI7yauq
	s/kzUseSe0w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9586B18A48;
	Tue, 23 Apr 2013 14:59:54 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16C1818A45;
	Tue, 23 Apr 2013 14:59:54 +0000 (UTC)
In-Reply-To: <1366714421.2899.10.camel@lws-weitzel> (Jan Weitzel's message of
	"Tue, 23 Apr 2013 12:53:41 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74B0A9DE-AC26-11E2-A482-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222170>

Jan Weitzel <J.Weitzel@phytec.de> writes:

> Hello,
> I have the following problem: I have 2 bare git repositories one has
> several branches and tags.
> If I try this in the second repository:
> git fetch -f ../main.git refs/heads/master:refs/heads/master 
> I'm getting also tags from other branches, if I have an old object from
> one of the other branches.
> I would expect to have only tags pointing to master ref.

A tag that points at a commit that is reachable from 'master' will
be followed, not just pointing _at_ 'master'.  For example, when
your 'master' is a bit beyond v1.2 release, it is likely you will
also get v1.1 and v1.0 tags (if your release structure is such that
new release contains everything old releases had).
