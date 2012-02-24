From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] do not stream large files to pack when filters are
 in use
Date: Fri, 24 Feb 2012 14:42:02 -0800
Message-ID: <7v399zhn0l.fsf@alter.siamese.dyndns.org>
References: <20120224093924.GA11680@sigill.intra.peff.net>
 <20120224094805.GB11846@sigill.intra.peff.net>
 <7vehtkyp6i.fsf@alter.siamese.dyndns.org>
 <20120224204810.GC21447@sigill.intra.peff.net>
 <20120224211913.GA30942@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 24 23:42:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S13q7-00044h-Um
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 23:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380Ab2BXWmG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 17:42:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932238Ab2BXWmF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 17:42:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C020B6047;
	Fri, 24 Feb 2012 17:42:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rUNSwsAv4QDUe+1DSnAAAG2Y37A=; b=Gd5VYm
	zb517W9L0JQgyJ/YZh3HL0Pk0QRn+hM+ZTnN5u+SZf5NYDfPHaU9TBWGACocR279
	LqJoIHK5QfA4q38wtwYhzKSdCYbn5FkVBfnOaI2bw8/cwgGBysIS53Ka/aEZbqe2
	0PkvcjUAqKC/3E6k+wy7sPkAfMEW09c0ZrCSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=VakIWdH0sJILx1X1NQA7PPFhf6v+OSrC
	bDaatNqplnE8Vj/BOf3FQslSxlGqGFOzk78QaGh/AKg2GxiGPG8TLBfyhqt1O1Rh
	4CSxslmbqW36hwdWdAzltqDEF1w+cBsCV5ckp6vQ898LaDZHPF+Vo7H9NqO7Tzxu
	hH5imHmtNtc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B83F96046;
	Fri, 24 Feb 2012 17:42:04 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3A5496045; Fri, 24 Feb 2012
 17:42:04 -0500 (EST)
In-Reply-To: <20120224211913.GA30942@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 24 Feb 2012 16:19:13 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C5FF95CA-5F38-11E1-A0E4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191497>

Jeff King <peff@peff.net> writes:

> I'll post the fixed series in a minute (with this fix, and the improved
> convert_to_git wrapper).

Thanks.

The exclusion of path==NULL case was something I didn't think much about,
but I think your solution is the right one.
