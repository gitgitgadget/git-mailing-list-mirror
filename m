From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] checkout: apply Dscho's dwim even with "--" present
Date: Sat, 30 Oct 2010 20:57:13 -0700
Message-ID: <7v8w1f3tgm.fsf@alter.siamese.dyndns.org>
References: <AANLkTinM863uZfRxy_1BW1fnfEPsPo8A2m86=Wxh7XGd@mail.gmail.com>
 <7vbp6c7ski.fsf@alter.siamese.dyndns.org> <20101029194639.GA1738@burratino>
 <7vsjzo691r.fsf@alter.siamese.dyndns.org> <20101029235358.GA21410@burratino>
 <20101030004144.GA25927@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dun Peal <dunpealer@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 04:59:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCP4b-0000tl-4I
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 04:59:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab0JaD5Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Oct 2010 23:57:24 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:34633 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753764Ab0JaD5W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Oct 2010 23:57:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5DDA1119A;
	Sat, 30 Oct 2010 23:57:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zGivf0kevTF4e7LbSsGrjkJvSSY=; b=ttnVE+
	4481gPyfRfHJ7DKR4PD8oHxUcF8BFdb/RfD2+7TJxoDLi5A3j/n6qLCEkuefPLRK
	mNHn4gYaM1cUI6w82sYoGila3pSH4lcc29GomfDhUtWRUILHtV0JKzjYCF7qf0XH
	tJuMUNyWpFqlscP/WGZ39e34iYOeecJ1tkXmU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YiJxEV5L5S2mJr6qe3wgDgP3Fx6wmVwA
	mK/wGuGivga2n/g+wfkGg5v/L6moUyuoFv/N4mvBCuiczUcSsQHymEX5nJtw+jop
	LZLX61opIj9yf6aeoGhypHQGpiACy9GHrkywx8WvP72LtKzvS7JJ/IQX/8p5up0K
	29QSi9eGRZs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 25F681198;
	Sat, 30 Oct 2010 23:57:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 602C71196; Sat, 30 Oct
 2010 23:57:15 -0400 (EDT)
In-Reply-To: <20101030004144.GA25927@burratino> (Jonathan Nieder's message of
 "Fri\, 29 Oct 2010 19\:41\:44 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F50989E6-E4A2-11DF-B66E-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160413>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jonathan Nieder wrote:
>
>> --- a/builtin/checkout.c
>> +++ b/builtin/checkout.c
>> @@ -808,23 +814,24 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
>>  			arg = "@{-1}";
>>  
>>  		if (get_sha1_mb(arg, rev)) {
>> +			trace_printf("trace: guess = %d\n", dwim_new_local_branch);
>
> Gah!  This line does not belong, sorry (though presumably it wouldn't interfere
> with testing).

Heh, two Gah's in a row?  After all mine might have been simpler ;-)
