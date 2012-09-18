From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] Git::SVN: rename private path field
Date: Mon, 17 Sep 2012 17:00:55 -0700
Message-ID: <7vboh4qjwo.fsf@alter.siamese.dyndns.org>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin> <20120917091331.GF358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:01:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDlFT-0001L2-UB
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 02:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624Ab2IRAA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 20:00:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45148 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932621Ab2IRAA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 20:00:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8AAAE9637;
	Mon, 17 Sep 2012 20:00:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n9I+7ZgSzEEwYnZINuo+GsHZdDw=; b=LC7dEh
	z3lmhPWBaSfKOJYtvIZH/HCCj8We3skNg7Lv/tCMO04ykcNLKvWaBhRYm8RN3lpC
	OSJ2IQ38+LZSTlDUeGulXSktbW+2WwoRS3Gf7HmOAvyZgHT7tgXgdEHj/oQIdP+G
	bTnwwuPrOhpdL6yjdg6vbZu8nbYejxxglfavw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tCWiqS3L+5Ul2btG7R7yaa58U8QqDyVh
	tJK4SHYVXH30usKpAmJiigIXISrvSJ2BNen1xyeAETQiii64lBKb0X1IwcMmQmAY
	cY6Gm5HrqyZWLm8/dSoRuoGAi3OwE8bUbP8jwpMuY5ZT+tCxKzSKFDD8ZMhjBi3+
	fAN7I0q5IGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 772F39636;
	Mon, 17 Sep 2012 20:00:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D4A249634; Mon, 17 Sep 2012
 20:00:56 -0400 (EDT)
In-Reply-To: <20120917091331.GF358@elie.Belkin> (Jonathan Nieder's message of
 "Mon, 17 Sep 2012 02:13:31 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EBF6439A-0123-11E2-A195-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205770>

Jonathan Nieder <jrnieder@gmail.com> writes:

> All users of $gs->{path} should have been converted to use the
> accessor by now.  Check our work by renaming the underlying variable
> to break callers that try to use it directly.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---

I like this ;-)  If we know we have good coverage, this would be a
sensible way to catch remaining code that hasn't been converted.

>  perl/Git/SVN.pm |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 3aa20109..33f15682 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -2293,11 +2293,11 @@ sub path {
>  
>  	if (@_) {
>  		my $path = shift;
> -		$self->{path} = $path;
> +		$self->{_path} = $path;
>  		return;
>  	}
>  
> -	return $self->{path};
> +	return $self->{_path};
>  }
>  
>  # for read-only access of old .rev_db formats
