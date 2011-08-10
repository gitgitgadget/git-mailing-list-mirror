From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git apply-diff / am cannot deal with patches generated with git
 diff/format-patch --noprefix?
Date: Wed, 10 Aug 2011 15:32:32 -0700
Message-ID: <7vfwl8sxrz.fsf@alter.siamese.dyndns.org>
References: <4E43053C.5080407@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: marcel partap <mpartap@gmx.net>
X-From: git-owner@vger.kernel.org Thu Aug 11 00:33:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QrHLL-0004OM-JW
	for gcvg-git-2@lo.gmane.org; Thu, 11 Aug 2011 00:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488Ab1HJWcg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Aug 2011 18:32:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44656 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752812Ab1HJWcg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Aug 2011 18:32:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0856B5A37;
	Wed, 10 Aug 2011 18:32:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ld4u2bWZx8i48pPyQz0ENzA8RJo=; b=XmINMb
	AuyUBilcKJxWTo4Wmb1C6D02Ty08UnvCeHD2/Q9IlHnukjSBeA13Ilff+RcjsJEz
	Q4/FkzJG7B6waNn17WpsgviXBlbrQBEbf/VNkbTjjSaMw2jWo3Xl8RxUTINn4ihB
	dgGaNfLD/C+E7LJTnUdw3q/Q6gmmArGJXp6lY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jBF+6ewVLuLXhPRuayl8szSiNU2ARoHq
	+IuoSZ2HiK+D9AhMbjR2pACVoMrUbT0uxkC/C3UgIoi7oaWD5r5iuk/JBQ45aDBd
	cmamHhf2k9Afu1OLQs4liyvkebpf4cKAUgKmWo6y9Rtfsd+TzfcbyL0C86Obcl7v
	rstZPRbOe0Q=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F30C15A36;
	Wed, 10 Aug 2011 18:32:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 839885A35; Wed, 10 Aug 2011
 18:32:34 -0400 (EDT)
In-Reply-To: <4E43053C.5080407@gmx.net> (marcel partap's message of "Thu, 11
 Aug 2011 00:25:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A4A3B8CC-C3A0-11E0-99EF-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179079>

marcel partap <mpartap@gmx.net> writes:

> ...at least it seems so. -p0 does not help:
>> fatal: git apply: bad git-diff - inconsistent old filename on line xx

Hmm, does not reproduce for me.

$ git checkout v1.7.6 ;# or whatever random commit I had at hand
$ git show --no-prefix >P.diff
$ grep "^diff --git" P.diff
diff --git Documentation/RelNotes/1.7.6.txt Documentation/RelNotes/1.7.6.txt
diff --git Documentation/git.txt Documentation/git.txt
diff --git GIT-VERSION-GEN GIT-VERSION-GEN
$ git checkout HEAD^
$ git apply -p0 <P.diff
$ git diff v1.7.6 ; echo nothing
nothing
$ git diff --stat
 Documentation/RelNotes/1.7.6.txt |    8 +-------
 Documentation/git.txt            |    5 +++++
 GIT-VERSION-GEN                  |    2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)
