From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 4/7] web--browse: support opera, seamonkey and elinks
Date: Fri, 03 Dec 2010 14:01:45 -0800
Message-ID: <7vei9yms6u.fsf@alter.siamese.dyndns.org>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-5-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:02:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POdhc-00038R-AF
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:02:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752393Ab0LCWB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 17:01:59 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:37549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884Ab0LCWB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 17:01:58 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C9BEF3CBB;
	Fri,  3 Dec 2010 17:02:17 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EOM3Q/rvPIU6N8VfH7rdzw8NY48=; b=JHpU1s
	qpbP8EQCCqPnJaoDiDJrcrAIsESXEVBLU7iEbURVaF96Qt7AZ5J4hlhRbZ3FVyRX
	7/cDRlIsxGLawjpKvRY5rqBYoCjS/sruYBu3H2Xb/joQDJqB49IWGnMmeYiH6nYP
	KtHea4kmCRQ0CLANULFRkyLv6aVqjfEoa0PrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZIQySbl1uZ4acQsJ873L5Ij7hO2Ir54A
	cUFJAYylGDOJPhuBmQ13ZLIJhSXIJOaYW6sgyjfK2fqjbttMqn4AKQDGMl3rLV5V
	Zech5heQepCshVatbPCLZPR9nnNOAye0dCiDZIgeu+tU2x8iAEvcrAOtuIQmiirN
	VY9vvMJnunw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FBC63CB8;
	Fri,  3 Dec 2010 17:02:13 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id E809C3CB4; Fri,  3 Dec 2010
 17:02:06 -0500 (EST)
In-Reply-To: <1291394861-11989-5-git-send-email-giuseppe.bilotta@gmail.com>
 (Giuseppe Bilotta's message of "Fri\,  3 Dec 2010 17\:47\:38 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FBED150C-FF28-11DF-925A-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162865>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> -w3m|links|lynx|open)
> +w3m|elinks|links|lynx|open)
>  	eval "$browser_path" "$@"
>  	;;
>  start)
>  	exec "$browser_path" '"web-browse"' "$@"
>  	;;
> -dillo)
> +opera|dillo)
>  	"$browser_path" "$@" &
>  	;;

Not a complaint on your patch, but is there a reason we say "eval", "exec"
and "(nothing)" in these three case arms?

The above makes the interpretation of $browser_path and $@ inconsistent
between lynx family codepath (which would apply $IFS to find the browser)
and dillo and start family codepath (which would not), and I am wondering
if that difference is intended.
