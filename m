From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git bug. gitattributes' pattern does not respect spaces in the
 filenames
Date: Mon, 10 Oct 2011 08:28:26 -0700
Message-ID: <7vipnwooh1.fsf@alter.siamese.dyndns.org>
References: <20111010110221.38e9985a@ashu.dyn.rarus.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alexey Shumkin <Alex.Crezoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 17:28:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDHmO-0006Ow-Ny
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 17:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879Ab1JJP2a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 11:28:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577Ab1JJP22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 11:28:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8EBEE5F01;
	Mon, 10 Oct 2011 11:28:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oGCemycRnbjksHujwENgB8aACAY=; b=kZrW2A
	NY/zU+g6qtz6m+g4n3q63I2gKwwH7E2NGvCcDfhJ0hfso5XGH3mPPq8L+el5z4ca
	bN1jX7iKQE0zJ2C8aUZ/O3UCStfai4J6Bnzbe2BLWmwdPPtmnVu8MbcT9N57aULW
	VATyDZ/LJLkNcxN2pZ5ucxAj16GrzsV7y9cQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CJDenflog6nZ3wKBjABWZXwtCsXKsC2l
	RP61FouX6Tq9ccUWmACRKJh/D+gFWb0oC+71BsuN7s6C+FHwrdo26sDdmLZuwNxE
	e2X+Z2EsfXyZp8r3+9vsb5nLfT5z+ilMpVxV2dl6dBsTg7eHupqfdyq5UkwApw69
	9Yn6ptqVvLA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 860305F00;
	Mon, 10 Oct 2011 11:28:28 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 119105EFE; Mon, 10 Oct 2011
 11:28:27 -0400 (EDT)
In-Reply-To: <20111010110221.38e9985a@ashu.dyn.rarus.ru> (Alexey Shumkin's
 message of "Mon, 10 Oct 2011 11:02:21 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 808FBFB0-F354-11E0-A687-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183244>

Alexey Shumkin <Alex.Crezoff@gmail.com> writes:

> As far as cp1251 and UTF-8 files are in different folders,
> it is logically enough to set pattern like
>
> <folder with a UTF-8-xmls>/*.xml diff=utf8-to-cp1251
>
> for the UTF-8 files.

... IN the directory that needs conversion and not in the other one or at
the toplevel. Problem solved, no?

Another idea may be to use "?" in the directory part of the
pattern. Unless the directory structure is sick enough to have these
directory names:

	dir-1/utf8-file.xml
        dir 1/cp1251-file.xml

dir?1/*.xml would match the matter, so...
