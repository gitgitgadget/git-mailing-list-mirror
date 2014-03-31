From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 4/4] Fix misuses of "nor" outside comments and in tests
Date: Mon, 31 Mar 2014 15:27:54 -0700
Message-ID: <xmqq7g7a2ec5.fsf@gitster.dls.corp.google.com>
References: <1396303907-23291-1-git-send-email-jlebar@google.com>
	<1396303907-23291-4-git-send-email-jlebar@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:28:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkgT-0006U5-O3
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:28:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbaCaW15 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:27:57 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45582 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750987AbaCaW15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 18:27:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 88F637907C;
	Mon, 31 Mar 2014 18:27:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vEosD8RGWVLmi+sG9H9vwBvaZrw=; b=hw/BNB
	ijKVIda3VKFUCWX2lMELaKkfMwRs14qkxxl1PgFZ1Q6ZWtYEoHuMIjt2dYGrkSQm
	OIrodIS+UhouMEwn34kkWDjFfZSXfn6aKaZI/d0AYH8+X5xPfmYC3bHwrxB+9WXI
	u4DCxe0/P283mf/B2tPX32aqSb7J+8YKxmLVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DhU4U05VqQAb4dI8+XRL2D8+Puobk0hW
	TFF8gNhGYE9XMB4X9mUU12VRqlirqnFpyptBx0ofM77pzPE2ALFrdMKOQta8cZOf
	/ppGLmbDz9u4J72zFoaTaXTRrFHYGgxd4Wn5NuhMvuxztJ2UMIhI2tdZqOCRRz9r
	odHwbeaKV3M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 748417907A;
	Mon, 31 Mar 2014 18:27:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D15C979075;
	Mon, 31 Mar 2014 18:27:55 -0400 (EDT)
In-Reply-To: <1396303907-23291-4-git-send-email-jlebar@google.com> (Justin
	Lebar's message of "Mon, 31 Mar 2014 15:11:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B4BFB9D8-B923-11E3-A790-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245560>

Justin Lebar <jlebar@google.com> writes:

> diff --git a/builtin/clean.c b/builtin/clean.c
> index 5502957..977a068 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -903,11 +903,11 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
>  
>  	if (!interactive && !dry_run && !force) {
>  		if (config_set)
> -			die(_("clean.requireForce set to true and neither -i, -n nor -f given; "
> +			die(_("clean.requireForce set to true and neither -i, -n, nor -f given; "

Encouraging Oxford/Harvard comma may or may not be desirable; it
does not seem to be a good idea to mix it in a patch to fix the
misuse of "nor", I would think.

> diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
> index 62f3293..a59564f 100644
> --- a/perl/Git/SVN.pm
> +++ b/perl/Git/SVN.pm
> @@ -480,8 +480,8 @@ sub refname {
>  	# It cannot end with a slash /, we'll throw up on this because
>  	# SVN can't have directories with a slash in their name, either:
>  	if ($refname =~ m{/$}) {
> -		die "ref: '$refname' ends with a trailing slash, this is ",
> -		    "not permitted by git nor Subversion\n";
> +		die "ref: '$refname' ends with a trailing slash; this is ",
> +		    "not permitted by git or Subversion\n";

This s/,/;/ is a good change that would not be controversial.
