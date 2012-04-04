From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH (bugfix)] gitweb: Fix unintended "--no-merges" for
 regular Atom feed
Date: Wed, 04 Apr 2012 10:47:38 -0700
Message-ID: <7v62df9yo5.fsf@alter.siamese.dyndns.org>
References: <4F79D76D.80805@pipping.org>
 <1333542344-20421-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sebastian Pipping <sebastian@pipping.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 04 19:47:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFUJ7-0001nT-Ca
	for gcvg-git-2@plane.gmane.org; Wed, 04 Apr 2012 19:47:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373Ab2DDRrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Apr 2012 13:47:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60747 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932348Ab2DDRrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2012 13:47:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 448926A09;
	Wed,  4 Apr 2012 13:47:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8Lr5SNUCd4h89DOF6xcqob0HXoo=; b=Lxg8Rk
	DiN2ikS+zpttkjbDPHJpgVgffjtNBSrLlb/w6Cal55saiXYHuUZyPvCMimmQRroZ
	p5fe4skRFdTPuj0GCBhB8OiDv4l2ZoYIiomv/62gGWHoNsquUmdJ+jHoiNMyQzYX
	BVXfNKT7BDzAIyE1VWMBJhnnAz5fXTulwke0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ye2kwpvAziZyTRMvUQABoaerEXOPWmfb
	nvHQnM2coDuSrMtiJsw5VNHcAZSY/c0/pswiLDkebHg6Tl521vEmzEg6sSvecCcr
	XfRkYsC7NJ9oLwYSRUPmu97p+TI7u+/7Yj2Tg9fIejLAoenf6HwNIiLZp+Ze+1EX
	1K0OKhMPwYg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B9046A08;
	Wed,  4 Apr 2012 13:47:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C692E6A06; Wed,  4 Apr 2012
 13:47:39 -0400 (EDT)
In-Reply-To: <1333542344-20421-1-git-send-email-jnareb@gmail.com> (Jakub
 Narebski's message of "Wed, 4 Apr 2012 14:25:44 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45B46E08-7E7E-11E1-9BD8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194713>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio, the bug is very minor, so I don't know if it is worth fixing
> for 1.7.10.

Does this exist in 1.7.9.x maintenance track?  If it is an old bug, I do
not think it should go to 1.7.10 proper (perhaps 1.7.10.1) this late, and
if it is a bug in a new feature added for 1.7.10, we may want to fix it
before the final, as the impact of the patch seems very minor.

>  gitweb/gitweb.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index a8b5fad2..ca6f038 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -3886,6 +3886,7 @@ sub print_feed_meta {
>  				'-type' => "application/$type+xml"
>  			);
>  
> +			$href_params{'extra_options'} = undef;
>  			$href_params{'action'} = $type;
>  			$link_attr{'-href'} = href(%href_params);
>  			print "<link ".
