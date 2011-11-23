From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git not resuming push
Date: Tue, 22 Nov 2011 22:24:12 -0800
Message-ID: <7vmxbncq5v.fsf@alter.siamese.dyndns.org>
References: <4ECC6F80.6010907@piem.org>
 <20111123050220.GA9127@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paul Brossier <piem@piem.org>
X-From: git-owner@vger.kernel.org Wed Nov 23 07:24:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RT6G8-0007sN-Eb
	for gcvg-git-2@lo.gmane.org; Wed, 23 Nov 2011 07:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758387Ab1KWGYS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Nov 2011 01:24:18 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39777 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758502Ab1KWGYP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Nov 2011 01:24:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A352E42F6;
	Wed, 23 Nov 2011 01:24:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IJ1tvRwg7w34k9CEKE0D85HU5ss=; b=tharfV
	gI+MGnKQbdK1Ouw6BSaj1v9lwwqdFpE8kec5ZTIzROSDOY4MMcNMHVKmD0VsK6Wm
	ucQq1BFcK5MbSmxiKdTK838+HbGk+SgdMSz+k9+YcuDaxH2c8cV322kPpejFOauW
	qI7/vDqTTEh9USPgk8X1dSES4xsTeeQgU13pI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ifyLNJpqYi10ph1Un5FmW3RI64+ClRd8
	3wrUDSNc85RvSZ5HOYNxEYy6jS1U/FhgSfdMAkO/uEDmFkV2DiIFF37UaVwzxDnW
	SS7s3mVuRr3MOLuRydyrKNg1nkjgOeHOFrHBfGV4NwUXks4Ymv4sPCsDXA2tqb70
	AsJcE7p8yV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AAE042F4;
	Wed, 23 Nov 2011 01:24:14 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2EAB142F3; Wed, 23 Nov 2011
 01:24:14 -0500 (EST)
In-Reply-To: <20111123050220.GA9127@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 23 Nov 2011 00:02:20 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C3821C96-159B-11E1-8B08-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185820>

Jeff King <peff@peff.net> writes:

> On Tue, Nov 22, 2011 at 08:58:56PM -0700, Paul Brossier wrote:
>
>> If the connection fails after uploading part of the data, it seems I
>> need to start over from zero again. Is there a way to resume the upload
>> instead?
>
> No, there isn't a way to resume just using push.
>
> If you have shell access on the server, one workaround you can do is to
> create a bundle with the commits in question, upload it via some
> resumable protocol (like sftp, http, rsync, etc), possibly taking many
> attempts, and then fetch the result on the server side from the bundle
> into the repository.
>
> See "git help bundle" for some examples.

Another possibility, if it is the connection between you and the other
side that is the problem, is to chunk your push in smaller pieces. That
is, if you are trying to push out v3.0, you first push only to v1.0, then
to v2.0, and then finally to v3.0.

Peff, by the way, wouldn't this request reminds of us of a scenario we
discussed recently, which I said I would imagine would be common while you
dismissed as not likely to be common?
