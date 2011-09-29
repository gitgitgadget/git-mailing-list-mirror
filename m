From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git bundle unbundle and "check-outable" refs
Date: Thu, 29 Sep 2011 09:49:11 -0700
Message-ID: <7vsjnfthtk.fsf@alter.siamese.dyndns.org>
References: <dec8c877-bd6e-4120-b045-87179d54abe2@i30g2000yqd.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Todd A. Jacobs" <nospam+listmail@codegnome.org>
X-From: git-owner@vger.kernel.org Thu Sep 29 18:49:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9JnV-0000bY-Al
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 18:49:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757262Ab1I2QtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 12:49:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39746 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755961Ab1I2QtN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2011 12:49:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A88A58F4;
	Thu, 29 Sep 2011 12:49:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1iWB+lBEY75Ugx70gcj3I14WJic=; b=smQUsu
	jE+gNQFVRs8tQhRia2KHyLqV4MbTpnqhlRdCTjpx/68Fetd6A5lZ7mzDLEZaYhw6
	UwxdSOclBtphNM/0tMo6Go5eXxHzHJYifWCmlmp5uYix5+mf1JYYqEBMWm2FrtqS
	YVQBzwFlGkoLyNaaWHI5NMpU/l77L74TgS3Ts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Whkl4tZOXSuJSIbkodqBGtKDKRUpBSqE
	LQRc4dEkqOmkYpJAl5Etzlh7TVl6E3mGB+2NlcLkzrenI408UQ78jj2eOxyUXSB2
	z7ay7n/acXoXglLMQUt5Iu8s1e2cg+Pcfqr41vo/VbMoolKezTOno0fIl1PHy9V7
	9aiEV7WOIk0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 218F958F3;
	Thu, 29 Sep 2011 12:49:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A9D8A58F2; Thu, 29 Sep 2011
 12:49:12 -0400 (EDT)
In-Reply-To: <dec8c877-bd6e-4120-b045-87179d54abe2@i30g2000yqd.googlegroups.com> (Todd A.
 Jacobs's message of "Thu, 29 Sep 2011 08:51:23 -0700 (PDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F5A37E38-EABA-11E0-B7C4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182413>

"Todd A. Jacobs" <nospam+listmail@codegnome.org> writes:

> directly to the local repository, but doesn't give me any of the
> branch refs that I'm expecting from such an operation. In other words,
> if I bundle branch foo on machine A, then unbundle on machine B, I
> expect to be able to "git checkout foo" and get on with life.

$ git bundle -h
usage: git bundle create <file> <git-rev-list args>
   or: git bundle verify <file>
   or: git bundle list-heads <file> [<refname>...]
   or: git bundle unbundle <file> [<refname>...]

$ git bundle list-heads /var/tmp/junk/foo.bundle
632052641517de1a965c1f045b97d2eaa541b2e9 refs/heads/maint

$ git fetch /var/tmp/junk/foo.bundle maint
From /var/tmp/junk/foo.bundle
 * branch            maint      -> FETCH_HEAD

or

$ git fetch /var/tmp/junk/foo.bundle maint:bundle_head
$ git log bundle_head
