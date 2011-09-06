From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH git] http: avoid empty error messages for some curl
 errors
Date: Tue, 06 Sep 2011 10:02:09 -0700
Message-ID: <7v62l5a9ke.fsf@alter.siamese.dyndns.org>
References: <20110905222202.GA32071@elie>
 <alpine.DEB.2.00.1109061023010.3841@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Tay Ray Chuan <rctay89@gmail.com>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Sep 06 19:02:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0z2P-0006Pn-Nn
	for gcvg-git-2@lo.gmane.org; Tue, 06 Sep 2011 19:02:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752353Ab1IFRCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 13:02:13 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46741 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752135Ab1IFRCM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2011 13:02:12 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6CC54A62;
	Tue,  6 Sep 2011 13:02:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W7rl7U9jUhePImssZqrf+Dl4Ni8=; b=LHK3Mo
	6Dvl5iUTLsEfbG/PZQXD0aknQud2nddX+3LKkEoYN6EYcvhNOAi4pK+8aKeowkDK
	OsfVgWDRLv58vyUYvLJZ6A4dVaN2+jocXlYFxewnLQyLzj6Q0Ui9fdI+GBwr04EY
	gDfB5EN7j1vkTt96DYTT/dOq05iA4TSgiQsew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cnqFsj2yCqLnQk/Xp8mk2hp/7PIQnuIV
	yJt3DOQdhFlxZX/LnTF3QrNkUZxzVdMTytEY287twngCOgIrUQTfSIK9rPSU6t2l
	CWyiOmbR9vkPE7yx6iDS/KecfQYIV0LyG31rEsxlkzPuCmxfWqRuXdxSSF6MYukU
	vs9ncnEPpvc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AEBD94A61;
	Tue,  6 Sep 2011 13:02:11 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3EB5B4A5F; Tue,  6 Sep 2011
 13:02:11 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.1109061023010.3841@tvnag.unkk.fr> (Daniel
 Stenberg's message of "Tue, 6 Sep 2011 14:20:00 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F632496A-D8A9-11E0-9303-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180816>

Daniel Stenberg <daniel@haxx.se> writes:

> On Mon, 5 Sep 2011, Jonathan Nieder wrote:
>
>> +			if (!curl_errorstr[0])
>> +				strlcpy(curl_errorstr,
>> +					curl_easy_strerror(results.curl_result),
>> +					sizeof(curl_errorstr));
>
> (as libcurl hacker)
>
> For the record, in libcurl we work on providing "extra" information in
> the error buffer when there is additional info to provide that would
> help. In some cases we deem there isn't (or we just to provide any)
> and then the generic error message is good enough and could indeed be
> used like this...

Sorry if I am a bit slow but are you saying:

 (1) we provide "extra" but your patch is not using it which is bad?
 (2) the above is Ok but there are better ways to do it?
 (3) something else?
