From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack: find -> /usr/bin/find, as for cygwin
Date: Sat, 19 Mar 2011 11:17:04 -0700
Message-ID: <7vsjujq8kf.fsf@alter.siamese.dyndns.org>
References: <AANLkTimHof_MNSGbU2KGX=7Q3MQpjkzXK+xyGGVjbngR@mail.gmail.com>
 <AANLkTimPbz2s=Maafhqg-7wOk_TT4fFSh7AQ-3rWY0A3@mail.gmail.com>
 <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: ryenus =?iso-2022-jp?B?GyRCIX4bKEI=?= <ryenus@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 19:17:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q10iS-0003vL-Es
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 19:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757289Ab1CSSRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Mar 2011 14:17:18 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:44559 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757269Ab1CSSRP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 14:17:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6F69E3FCC;
	Sat, 19 Mar 2011 14:18:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9reNMnGlR97pO5RhEGHrpiVlRBo=; b=iw438J
	ZfbLNKV0pZSqsihZJcSAEESRnyqxtgp/BiOCPX/K9sZnqHytnwR8bxnz6UDN8Tdk
	d1NXQfru9UG+P/c+gDzleZR2I2oPyR4nWWKm60jIL3yoPXsCZ9qVhqAYc8JSZXSY
	lQwtEnTDfy25EHXLtYnE4t3u7mjU05Pz9mzo8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LS/a2TzMVg4Aku4aEW/BAoTkA65MKR3w
	f+Th1k9Xu/nOtHoQIX8eouHQ76FWM3dp/8I7qd8sShK70nATKlh+bUvKbHZ21b0I
	r/1Zm0380C8i5AQD6GkwV/4hw2c6o85684q0FuvWqxkcaiRy7stmbq/0dkMQ0lHd
	1MxS6CBAiwA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37B703FC8;
	Sat, 19 Mar 2011 14:18:47 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0DCC43FC7; Sat, 19 Mar 2011
 14:18:42 -0400 (EDT)
In-Reply-To: <AANLkTinxyp=PbvzRkyyxXin5aOFm1NP4Be6U2Dv0aD6d@mail.gmail.com>
 ("ryenus =?iso-2022-jp?B?GyRCIX4bKEIiJ3M=?= message of "Sun, 20 Mar 2011
 00:32:47 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 54E8622C-5255-11E0-AD43-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169453>

ryenus ◇ <ryenus@gmail.com> writes:

> Thank you, Duy, you're almost right, I just checked git-sh-setup.sh,
> in the bottom, sort and find are defined as functions like what you
> pointed out, but only for MinGW, therefore a better fix is to check
> for cygwin as well:
>
> ---
>  git-sh-setup.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index aa16b83..5c52ae4 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -227,7 +227,7 @@ fi
>
>  # Fix some commands on Windows
>  case $(uname -s) in
> -*MINGW*)
> +*MINGW*|*CYGWIN*)

This looks like a more sensible alternative than forbidding the use of
"find", privided if the new pattern is an appropriate one to catch cygwin.

I don't have any Windows boxes, so I cannot verify, but the patch smells
correct.
