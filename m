From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] If deriving SVN_SSH from GIT_SSH on msys, also add
 quotes
Date: Sat, 23 Jan 2010 11:33:31 -0800
Message-ID: <7vd410d3as.fsf@alter.siamese.dyndns.org>
References: <4B5ACDD5.8080007@gmail.com>
 <fabb9a1e1001230322t708756fahce326511d3f0bda5@mail.gmail.com>
 <4B5B05AC.2050200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	jugg@hotmail.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 23 20:34:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYlkA-0004gL-IE
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 20:34:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752875Ab0AWTdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 14:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833Ab0AWTdu
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 14:33:50 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47051 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797Ab0AWTdt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 14:33:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AFF34935B1;
	Sat, 23 Jan 2010 14:33:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AIqyR+MObemC+hxJg76n/7kWXxQ=; b=odQc/J
	pYwkrmS3eTNuY/pbsi3Hbnxe5cedRvUWHGHrlrFmJFZFgN5ltPgRhNghTqCxkTGr
	afMYLW13IXtbS6nD0f0izC7RBTsyAVC87Rf62TT64dIyws8dTyhZNYHPqmzlGv8W
	amYpAKpPhhNyC4fzqO9kIH23tmU6zM1E6Cx3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rz3VL4rkFnAOFNDsySZ0TiE98H/3Bw2Q
	zESr8RMCZgnnboewU7Dru+kES/nxIU6ibHKb7Y51KNHIBHsRAS0oH82SGRgcfyYn
	K2vfuSrxeFHVFLNQ0yugXHHPoA3Ch3amXqDrSJs0uQiYcpb2t1t1d4UbElu3kbBb
	CzQUBUK8duE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47BFA935A9;
	Sat, 23 Jan 2010 14:33:40 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D948935A4; Sat, 23 Jan
 2010 14:33:32 -0500 (EST)
In-Reply-To: <4B5B05AC.2050200@gmail.com> (Sebastian Schuberth's message of
 "Sat\, 23 Jan 2010 15\:20\:28 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3580C252-0856-11DF-A18B-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137853>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> In contrast to GIT_SSH, SVN_SSH requires quotes for paths that contain
> spaces. As GIT_SSH will not work if it contains quotes, it is safe to
> assume it never contains quotes. Also, adding quotes to SVN_SSH for paths
> that do not contain spaces does no harm. So we always add quotes when
> deriving SVN_SSH from GIT_SSH.
>
> This fixes msysGit issue 385, see
> http://code.google.com/p/msysgit/issues/detail?id=385
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

As the patch clearly is inside "msys-only" codepath, I don't mind
bypassing Eric and apply this directly to my tree before I tag 1.7.0-rc0,
but may I ask why this quoting magic matters only on msys?

> ---
>  git-svn.perl |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/git-svn.perl b/git-svn.perl
> index 650c9e5..ef39a9f 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -26,6 +26,7 @@ if (! exists $ENV{SVN_SSH}) {
>  		$ENV{SVN_SSH} = $ENV{GIT_SSH};
>  		if ($^O eq 'msys') {
>  			$ENV{SVN_SSH} =~ s/\\/\\\\/g;
> +			$ENV{SVN_SSH} =~ s/(.*)/"$1"/;
>  		}
>  	}
>  }
> -- 
> 1.6.6.265.ga0f40
