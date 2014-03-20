From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Bump core.deltaBaseCacheLimit to 128MiB
Date: Thu, 20 Mar 2014 15:35:39 -0700
Message-ID: <xmqqob10wlac.fsf@gitster.dls.corp.google.com>
References: <1395232712-6412-1-git-send-email-dak@gnu.org>
	<xmqq38id3nfs.fsf@gitster.dls.corp.google.com>
	<87ob11g9st.fsf@fencepost.gnu.org>
	<xmqqlhw5260l.fsf@gitster.dls.corp.google.com>
	<CACsJy8C3=bz1HmVgQuJRdixMhhb-JKouM7b1L7M047L_4PBViA@mail.gmail.com>
	<xmqqsiqcztu8.fsf@gitster.dls.corp.google.com>
	<87lhw4er2b.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 23:35:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQlYy-00086Y-IL
	for gcvg-git-2@plane.gmane.org; Thu, 20 Mar 2014 23:35:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933329AbaCTWfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2014 18:35:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46120 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759160AbaCTWfm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2014 18:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57EC176F86;
	Thu, 20 Mar 2014 18:35:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BqIgJn2Abo53xw5RBNe3jIy9Qs0=; b=rmAyjO
	gR8mzoqDGXJbx0bE4q6oYojw6vJGU29sXyZuF67DnpSXDsuGTEwybMMKaBlBuakH
	qeQVLRW9gEsW+Vi62B6qg0YJzNbp3lzhm/3KncsKr1xY7FKa9ZptorYLuoWpEMog
	PJSjONx3cHQ811fAKVMnpPTcn/runOqZFn7Lg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dDF767qGh4AowvLbvOEQP4yoqrB2wPm2
	62bRqlxFvfEcxQgjC9i567G4W60pyr08ie+iQuRukcaQaZYhddYyc0/TN/J+ptRt
	+eoTtbCl/b0tceI4elg5uF47zl7zOH6z+3RLuVJQa/qJJAiwo6iQtD9RIV3f/VbL
	InYoCqG3HPw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3FAEB76F83;
	Thu, 20 Mar 2014 18:35:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7756776F7F;
	Thu, 20 Mar 2014 18:35:41 -0400 (EDT)
In-Reply-To: <87lhw4er2b.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Thu, 20 Mar 2014 18:08:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F7BDC682-B07F-11E3-8399-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244595>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> The only
>>> downside I see is large blobs will be packed  undeltified, which could
>>> increase pack size if you have lots of them.
>>
>> I think that is something that can be tweaked, unless the user tells
>> us otherwise via command line override, when running the improved
>> "gc --aggressive" ;-)
>
> deltaBaseCacheLimit is used for unpacking, not for packing.

Hmm, doesn't packing need to read existing data?
