From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-send-email: don't return undefined value in
 extract_valid_address()
Date: Tue, 20 Nov 2012 14:14:05 -0800
Message-ID: <7vvcczrkgi.fsf@alter.siamese.dyndns.org>
References: <1353414053-25261-1-git-send-email-krzysiek@podlesie.net>
 <7v8v9wrpdz.fsf@alter.siamese.dyndns.org>
 <20121120204736.GA7039@shrek.podlesie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Krzysztof Mazur <krzysiek@podlesie.net>
X-From: git-owner@vger.kernel.org Tue Nov 20 23:14:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Taw5J-00075e-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 20 Nov 2012 23:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206Ab2KTWOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Nov 2012 17:14:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47687 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751466Ab2KTWOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Nov 2012 17:14:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A993ABFE;
	Tue, 20 Nov 2012 17:14:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gDmtYY+joQ7GhxjdoXHlDGYb1cc=; b=a2DcSl
	N6e8Ohz3MuM7T89rvlahhCWXtaXG/Ts4m9aHWtekD0zQLVSWETHP0pj4hH4F/VxM
	Ya2y346I18Pyv/Ojc4P6sxnNJH2ajOZhDlDmiZapsrOJ0xBWNZT9L/aLZQXS258d
	ha+rUcPV0hqSdsmqEEcvYE/oiUknhgJnXRiOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mRLKPK50VJmjDiXINlqnabjb5XpZG+xQ
	4/lZ/eeTcLRbtON/kaCddBL5Mq8ZWJLV5244RCZfb0V4MHYFEXw8buwC3iWHj4US
	NeWtx0PMLOeniYPapyz+YckUY99DVeaQW4D+BD0us2OwLvLRS0BOgt83neTZAyxj
	2CLvhMPHG2A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76A3BABFC;
	Tue, 20 Nov 2012 17:14:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E8EF5ABFB; Tue, 20 Nov 2012
 17:14:07 -0500 (EST)
In-Reply-To: <20121120204736.GA7039@shrek.podlesie.net> (Krzysztof Mazur's
 message of "Tue, 20 Nov 2012 21:47:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9A62FAFA-335F-11E2-9E48-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210116>

Krzysztof Mazur <krzysiek@podlesie.net> writes:

> Yes, it's just to hide the warning, the error (warning in this case) it's
> already correctly generated:
>
> W: unable to extract a valid address from: x a.patch

But it is of no use if the message is sent out without the intended
recipient, no?  It is too late when you notice it.

> Maybe we should change it to an error?

At least, when we are not giving the "final sanity check [Y/n]?"
prompt, I think the code should error out.
