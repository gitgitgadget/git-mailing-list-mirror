From: Junio C Hamano <junio@pobox.com>
Subject: Re: [PATCH 2/2] clone: Allow repo using gitfile as a reference
Date: Tue, 09 Apr 2013 09:47:07 -0700
Message-ID: <7v8v4rtzw4.fsf@alter.siamese.dyndns.org>
References: <20130408185957.GM27178@pug.qqx.org>
 <1365461200-13509-1-git-send-email-aaron@schrab.com>
 <1365461200-13509-3-git-send-email-aaron@schrab.com>
 <20130409002456.GW30308@google.com> <20130409163149.GA20752@pug.qqx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Aaron Schrab <aaron@schrab.com>
X-From: git-owner@vger.kernel.org Tue Apr 09 18:47:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPbha-0004Fd-TY
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 18:47:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964874Ab3DIQrS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Apr 2013 12:47:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936269Ab3DIQrR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 12:47:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E59D3156AF;
	Tue,  9 Apr 2013 16:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ViIZslKUIzqcvG+8jKZLAA6R1zA=; b=MZ+H08
	Ww3DGe88GEGg4hxcDdy1Bg77na8n66U3daJ1yoiuEZSCjvQHgHGS97XZY1hhmufI
	+qrP1ZTw6HSFAiG5t0m3bvoEJhZ/TjZ+WT96aUsWs/Cw/CO+eioKwyUUOr1LQ4oI
	odNqZo4Ivem53z7rNz9XHvcpXvDH4+chI3Miw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KB70ef3T76o4dN+9oZQqedDF8MJ1iL/h
	eOo4A92E844DTQRyhYvzJ/YBXdLG0a13DXTu03IV55nBqGxLt+6ILHrwndrG8HD/
	RAXxdiKqewrUUcXfIT03xxNMvxixE/TiAY9/sYz78hSJQ97N07eCVqcvxbySuJPc
	L9Cb5DGCAh8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB37F156AE;
	Tue,  9 Apr 2013 16:47:14 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3E3DA156A8; Tue,  9 Apr
 2013 16:47:14 +0000 (UTC)
In-Reply-To: <20130409163149.GA20752@pug.qqx.org> (Aaron Schrab's message of
 "Tue, 9 Apr 2013 12:31:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 218B25F0-A135-11E2-A7C2-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220583>

Aaron Schrab <aaron@schrab.com> writes:

> At 17:24 -0700 08 Apr 2013, Jonathan Nieder <jrnieder@gmail.com> wrote:
>>> +test_expect_success 'clone using repo with gitfile as a reference' '
>>> +	git clone --separate-git-dir=L A M &&
>>> +	git clone --reference=M A N &&
>>
>>What should happen if I pass --reference=M/.git?
>
> That isn't supported and I wouldn't expect it to work.  The
> --reference option is documented as taking the location of a
> repository as the argument and I wouldn't consider a .git file to be a
> repository.  I also can't think of a reason that it would be very
> useful since it should be simple to just refer to the directory
> containing the .git file.  But if others disagree, I could be
> convinced to add support for that.

If M/.git weren't a gitfile that points elsewhere, that request
ought to work, no?  A gitfile is the moral equilvalent of a symbolic
link, meant to help people on platforms and filesystems that lack
symbolic links, so in that sense, not supporting the case goes
against the whole reason why we have added support for gitfile in
the first place, I think.
