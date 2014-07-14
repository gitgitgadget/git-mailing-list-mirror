From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 4/4] cache-tree: Write updated cache-tree after commit
Date: Mon, 14 Jul 2014 10:51:21 -0700
Message-ID: <xmqqvbqzygkm.fsf@gitster.dls.corp.google.com>
References: <1405140276-32162-1-git-send-email-dturner@twitter.com>
	<1405140276-32162-4-git-send-email-dturner@twitter.com>
	<CACsJy8D0CdS5B5xNSSCk+LToXV9FnHFLkPzJ5f-7NTWiw9yn5w@mail.gmail.com>
	<xmqqr41oylyo.fsf@gitster.dls.corp.google.com>
	<53C41456.2000006@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Jul 14 19:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6kPW-0006AQ-9n
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 19:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756274AbaGNRvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 13:51:31 -0400
Received: from smtp.pobox.com ([208.72.237.35]:62679 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbaGNRv3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 13:51:29 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5C5726FB2;
	Mon, 14 Jul 2014 13:51:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cBWY9YWyx9KL+kv+AFHa60Rfn5M=; b=T0070k
	Tvd6z5hnO40/KtYoFzqUoOwYHVDjyZfSra1HIL4Tmh0nND03XL/HXC82PlF1ywOV
	OSKYKSjz/jSj6ee4s/27No6b84YzN9WmvFKHDp88OeV87Cl2MU0PfLK/RMVamUln
	ko156bdLzmTLEIo3HH5o6q/CD8DUgQ1625csU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Y5a57gbt6WCi6KgFc2tfOwlPptOpid+6
	69SOMwvDMFVlpeoMzQfwOFsgVr5lgLDMvS8qFCo6eSz0tptrAF8+sAAm0yOExzZk
	4WHAaf5q//dyQKlNrR8ugnR2mhBxJWSrUmWuHf8jwYPkKr4PkGddqcO8S1rh1duw
	UXbujazQGFI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B8B0026FB1;
	Mon, 14 Jul 2014 13:51:11 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 938F526F9B;
	Mon, 14 Jul 2014 13:51:05 -0400 (EDT)
In-Reply-To: <53C41456.2000006@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Mon, 14 Jul 2014 18:33:10 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6DA41C3E-0B7F-11E4-B805-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253503>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> that the merge commit 7608c87e fails. Looking at the details of the
> merge resolution, made me think of Duy's split index work.

Yes, there is a deliberately dropped hunk from dt/cache-tree-repair
in that merge, because the topic relied on being able to say "here
is the file descriptor, write the index to it", which no longer is
available with the split-index topic.
