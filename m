From: Junio C Hamano <gitster@pobox.com>
Subject: Re: patch for AIX system
Date: Thu, 18 Nov 2010 09:44:11 -0800
Message-ID: <7vaal6cys4.fsf@alter.siamese.dyndns.org>
References: <4CE38472.8070206@Nemec-online.de>
 <7vr5ejg7oi.fsf@alter.siamese.dyndns.org>
 <AANLkTi=94zL-nuBeGcrAdWVBu6VTuqX3xcM9oGNNUwvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Norbert Nemec <Norbert@nemec-online.de>, git@vger.kernel.org
To: Tor Arntsen <tor@spacetec.no>
X-From: git-owner@vger.kernel.org Thu Nov 18 18:44:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJ8X6-0002ZQ-I3
	for gcvg-git-2@lo.gmane.org; Thu, 18 Nov 2010 18:44:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758567Ab0KRRoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Nov 2010 12:44:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:40749 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab0KRRoW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Nov 2010 12:44:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 468E73B44;
	Thu, 18 Nov 2010 12:44:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JO/8u0Xnjc69x/1Mzbq2jA/JAkc=; b=B4/bGt
	bJJ3dg9Fe+rvQwETJlJeUzZFdOU8rair1IzD65GHTsweCwKca2eDpBAKD3RC9/6P
	JRNhfYmtCzF6HYRrU1werHzoJKkOiCi7KObLHZpKVWT+pXsfVp+w4oxuu2B6xkZe
	Tq+eREG2jstk6MfGXAbFuXbTbjsqdk/zE+KwA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WSGgl86M85/giiL7940OhV83giT6yWDp
	C2N1jwtjoZ3NRy6gVI6YOewZ2EYn2vku5wCRmfRaZDH10q7Szp6wg9L2sieeEAb5
	oe+eB/vlaX/MFl4nnvFt+SlL9lfm3qfduOyNgUbgbT69CY8GIbs3+V687EKY3WWh
	H+QpZo0yCW4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0CC923B42;
	Thu, 18 Nov 2010 12:44:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DB7293B3F; Thu, 18 Nov 2010
 12:44:23 -0500 (EST)
In-Reply-To: <AANLkTi=94zL-nuBeGcrAdWVBu6VTuqX3xcM9oGNNUwvQ@mail.gmail.com>
 (Tor Arntsen's message of "Thu\, 18 Nov 2010 10\:13\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D96A8F6-F33B-11DF-86C7-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161692>

Tor Arntsen <tor@spacetec.no> writes:

> On Wed, Nov 17, 2010 at 18:51, Junio C Hamano <gitster@pobox.com> wrote:
>
>> I'd defer this section to AIX experts; I've always assumed that people
>> on non-gnu platforms used ginstall, but perhaps AIX doesn't have one?
>
> All my AIX systems have the coreutils RPM from the IBM Toolbox
> installed (extra CD, or, these days, from ftp.software.ibm.com), so I
> never ran into the incompatible install issue.
> However, for those without coreutils a patch to make installbsd work
> (with comments from Junio taken into account) would be reasonable I
> guess. Particularly if the patch could be made so that it's easy
> enough to switch to coreutils install if you wish to.

Hmm, would that suggest that it might be a better idea to just mention
"install coreutils RPM from the IBM Toolbox" somewhere in INSTALL instead
of the INSTALLDIR patch, i.e. not support "bsdinstall/mkdir -p" way but
require "coreutils"?  Or is it an unconditionally better way of life for
AIX folks, even for the ones who do have it installed, not to rely on the
"coreutils" package?

If the answers to the above two questions are both "no", then we would
need to make the patch more complicated (i.e. detect if "coreutils" is
there and if not use "bsdinstall/mkdir -p" way), which I'd rather avoid
if we do not have to.
