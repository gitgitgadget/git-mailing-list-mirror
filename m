From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: "fatal: cannot pread pack file", version 1.7.5.4
Date: Mon, 02 Jul 2012 14:45:02 -0700
Message-ID: <7v3959zvkx.fsf@alter.siamese.dyndns.org>
References: <5638dec6e156f83385a3baa01cf9ac4d@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Lars Winterfeld <lars.winterfeld@tu-ilmenau.de>
X-From: git-owner@vger.kernel.org Mon Jul 02 23:45:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SloQk-000199-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jul 2012 23:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933003Ab2GBVpH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jul 2012 17:45:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51046 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932074Ab2GBVpG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jul 2012 17:45:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 936F884A6;
	Mon,  2 Jul 2012 17:45:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lYx7KGRhoJoXj57TQkG0dsR7Hwg=; b=OP1jYt
	oe9rbjafQDEFJxmXimBW0zDtVcev5eZYPfEe/CUyXUyUBluC8aETAn4uFjeuwkmO
	prcZiQUo7A/ZwZTIzjJkqXUE0WRaZMRjHQpL/4qsMY40xg/9IVpfWGaXPYutaYRU
	I5y182FEu/WuBlVojLRe5O0KvLPP1tch9o/sE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kNplWzBs+9YHR+E7GdwbVoXDikSIkXMn
	aqbyO8HUkS8p1ioAz2XQPkON4qU3fMKizw6i/eABiIRozZ19fHbuz3CAGQXwhr8r
	jsNe+wMjpV0p4Xi+LOgmnW0d4zrLHukjfFZZf47VXEqjoSp7Qw2OksUm5x1lvKzR
	vRLdh3SouhA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8ABD3849E;
	Mon,  2 Jul 2012 17:45:05 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 22A83849C; Mon,  2 Jul 2012
 17:45:04 -0400 (EDT)
In-Reply-To: <5638dec6e156f83385a3baa01cf9ac4d@localhost> (Lars Winterfeld's
 message of "Mon, 02 Jul 2012 12:03:13 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2EBFFEA4-C48F-11E1-9F4C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200864>

Lars Winterfeld <lars.winterfeld@tu-ilmenau.de> writes:

> Hi,
>
> I have used git for some time and regularly pushed changes to another
> server (as some kind of backup), but today I got this error during
> git push`:
>
> Counting objects: 1293, done.
> Compressing objects: 100% (1027/1027), done.
> Writing objects: 100% (1229/1229), 70.83 MiB | 364 KiB/s, done.
> Total 1229 (delta 343), reused 0 (delta 0)
> fatal: cannot pread pack file: No such file or directory

Curious.  That is typically given for ENOENT but pread(2) would not
give that error according to

  http://pubs.opengroup.org/onlinepubs/9699919799/functions/pread.html

You didn't say what platform you are seeing the issue (the receiving
end of the "push"), but are you using Git on a pread-deficient
platform with emulation perhaps?
