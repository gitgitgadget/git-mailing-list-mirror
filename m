From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 4/7] bisect: introduce support for --no-checkout
 option.
Date: Mon, 01 Aug 2011 11:13:15 -0700
Message-ID: <7vmxfthuf8.fsf@alter.siamese.dyndns.org>
References: <1312199777-10144-1-git-send-email-jon.seymour@gmail.com>
 <1312199777-10144-5-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, j6t@kdbg.org,
	jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 01 20:13:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QnwzY-0004lQ-QM
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 20:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445Ab1HASNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Aug 2011 14:13:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752426Ab1HASNV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 14:13:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FA804C04;
	Mon,  1 Aug 2011 14:13:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gMCW8WSjtBPMZCB3LPV7UL5cbDQ=; b=wF+bcX
	AfMz0JsTVzRmlJl5C3fWJICHq8j0b29N38I3KhOwDXxol0CnE6BeaDR1tr66wrv1
	SHwgaooI7ZgimF5cAzqvivKCqvy3uCn8c9q9rPIMNTvwm5CebiaU76hRpQW4CG2k
	IZErr4EjQ2sLl67IW1vRJ2RiQRGVlBFFjzdlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OFwpQL8u8yGezTZEZiRd9Y95Vo6D5s5F
	AhdDWfOwdr02WGv/k/nzvt4yW86tklnHNfgwLH/RcfCo1qtASEFUggvxGPzEWoSZ
	0ZBHif6snWNogSLmTXTB8hF5XxfMh7kfXdav6YTRb/46wrdxG6UQ3zY1URTlbdoG
	BeUBLAq/RC4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 166CD4C03;
	Mon,  1 Aug 2011 14:13:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E9C74C02; Mon,  1 Aug 2011
 14:13:16 -0400 (EDT)
In-Reply-To: <1312199777-10144-5-git-send-email-jon.seymour@gmail.com> (Jon
 Seymour's message of "Mon, 1 Aug 2011 21:56:14 +1000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDF14622-BC69-11E0-B933-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178392>

Jon Seymour <jon.seymour@gmail.com> writes:

> diff --git a/bisect.c b/bisect.c
> index dd7e8ed..534da2c 100644
> --- a/bisect.c
> +++ b/bisect.c
> ...
> -	res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
> -	if (res)
> -		exit(res);
> +	if (no_checkout) {
> +	  argv_update_ref[3] = bisect_rev_hex;
> +	  if (run_command_v_opt(argv_update_ref, RUN_GIT_CMD))
> +	    die("update-ref --no-deref HEAD failed on %s", bisect_rev_hex);
> +	} else {
> +	  res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
> +	  if (res)
> +	    exit(res);
> +	}

Please. No indentations with just a few SPs.
