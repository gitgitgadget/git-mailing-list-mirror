From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] patch-id: make it stable against hunk reordering
Date: Thu, 27 Mar 2014 09:58:41 -0700
Message-ID: <xmqqvbuzefy6.fsf@gitster.dls.corp.google.com>
References: <1395912239-29663-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jrnieder@gmail.com, peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 17:58:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTDdi-0002Ru-1z
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 17:58:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755098AbaC0Q6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 12:58:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753304AbaC0Q6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 12:58:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9B42760D5;
	Thu, 27 Mar 2014 12:58:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qOY4KxcGyZv/Vz/AeRT+2ZwOfRs=; b=Q7cMnN
	s29F009MeMA7sdWvW+YmIASEB9wT/Au2ikbnsKapNNX6Rs/c3cP1EFqPxEX9EMdW
	rtXTU89llbwSdkeHWwSUurWP0cbgLa4E2NG2aYayeB2LmgzIy+tlSMGmHR8zXXW3
	dCBRBlqkoeJlvHoPBiPsXHMbvtKIN+pCh+KcQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EBJN6ileFJvqdqj7WAgYBJyp8rgG1+Ny
	CfDuTF+TWkxaH+K11LNaCHRkFkYqsfjqHoOxH1tKGUDHADGVO3yyWA9HCNEA8Wof
	RkA9CZM+1CRqgQ4JfTBzHR7wevTy3r3gQNZ4e3dVhLiAjl6+ZqvcXmeBou42ESbb
	pQyIJPzhbc8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C653A760D2;
	Thu, 27 Mar 2014 12:58:43 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0A162760C7;
	Thu, 27 Mar 2014 12:58:42 -0400 (EDT)
In-Reply-To: <1395912239-29663-1-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Thu, 27 Mar 2014 11:25:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0D7F9940-B5D1-11E3-B3FF-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245294>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Patch id changes if you reorder hunks in a diff.

If you reorder hunks, the patch should no longer apply [*1*], so a
feature to make patch-id stable across such move would have no
practical use ;-), but I am guessing you meant something else.

Perhaps this is about using "-O <orderfile>" option, even though you
happened to have implemented the id mixing at per-hunk level?


[Footnote]

*1* It has been a long time since I looked at the code, and I do not
know offhand if "git apply" has such a bug not to diagnose a hunk
for a file for an earlier part that comes later in its input stream
after seeing another hunk for the same file as a bug. If it does
not, perhaps we should.
