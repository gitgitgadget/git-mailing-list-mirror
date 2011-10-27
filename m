From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/WIP 03/11] t5403: avoid doing "git add foo/bar" where
 foo/.git exists
Date: Thu, 27 Oct 2011 10:41:19 -0700
Message-ID: <7vobx2z60w.fsf@alter.siamese.dyndns.org>
References: <1319438176-7304-1-git-send-email-pclouds@gmail.com>
 <1319438176-7304-4-git-send-email-pclouds@gmail.com>
 <7vd3dk516p.fsf@alter.siamese.dyndns.org>
 <CACsJy8CjJnO6rDVTV1tC9rWXP51LHBtUvNsgVWNfwC+HuNQ-6Q@mail.gmail.com>
 <7vr51z3bqx.fsf@alter.siamese.dyndns.org>
 <CACsJy8C2nUJkN5=E7p2u_wjHqWy7EC_BS3Sr4+_QgunWHDdtKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 27 19:41:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJTxG-00035K-Df
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 19:41:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754034Ab1J0RlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 13:41:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671Ab1J0RlV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 13:41:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 61AE14F67;
	Thu, 27 Oct 2011 13:41:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=AVCYnA2llpE6XOeMIQIpihJeQik=; b=qV1Hn/RSDtxEDS/qEKC9
	jivERYbKI9i92c0BlB9M7K+K7JFqQVdQSYUDeF8yjsbu69s5VOBVz6AGw9f8mEYI
	XyHkFp6YVCKl8S6KZl12q8r/CkaDEbZ1ZNo/aMjsrgeiYYWgKj7pOr8PHRj00FmX
	OmZS2qm6XG9mDiFWBGRDd/0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=yJfqc67CNMV10oti45v2NoMfgMIrnUopp3u5nM8iXJlcho
	93cbqXoFk5GwEEHWrJzaG8ZH9LKgjiNLyoYdRp+QFpU3dNmPuTQAyoOoEbLXBBd8
	hKjQYzylqmb/yntZBKoSoT6fmGae3ivkHEjOvexOiv2AhMJDjX/nFPi0CHDws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 59A874F66;
	Thu, 27 Oct 2011 13:41:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB26E4F63; Thu, 27 Oct 2011
 13:41:20 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E1B820B8-00C2-11E1-98DB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184305>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Thu, Oct 27, 2011 at 4:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> ...
>> Where did you get this idea that submodule is somehow involved in this test?
>
> Because "clone2" looks like a submodule (it has ".git" inside with valid HEAD)

But there is a crucial difference between "it looks like" and "it is". If
it is not a submodule, and the established behaviour is not to treat it
like a submodule, then we shouldn't suddenly change our behaviour to start
treating as one.

> ... Should we stick with one way only?

Whatever we have been doing should not change, especially in corner cases.
