From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] Add new git-cc-cmd helper to contrib
Date: Fri, 19 Apr 2013 13:08:44 -0700
Message-ID: <7vip3iz3jn.fsf@alter.siamese.dyndns.org>
References: <1366348458-7706-1-git-send-email-felipe.contreras@gmail.com>
	<1366348458-7706-2-git-send-email-felipe.contreras@gmail.com>
	<7vfvym30t8.fsf@alter.siamese.dyndns.org>
	<CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 19 22:08:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UTHc3-0007YU-O6
	for gcvg-git-2@plane.gmane.org; Fri, 19 Apr 2013 22:08:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572Ab3DSUIr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Apr 2013 16:08:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37336 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753135Ab3DSUIr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Apr 2013 16:08:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8980917F6E;
	Fri, 19 Apr 2013 20:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZXMvonTgQJ/ajkTo07B6K83aqwA=; b=fg7IOy
	AnxIfbMtSk1GlvXABXqBy1Tu91lPUV/Ob5u5GCE/pj74jGjmlM3F5L2VE0d4Wlk9
	RVo3Q/799jjL2siJigsuxBirEtZWTILI+G597uCZPwSD7VIzyGZ0xJ/Qfl/b+zcx
	1Lai6Q/LuXQ07IA8sLHYNpBowNgVn8278oRjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iTFM0Y3UbaWs+HvgGXkx/2lYIi6IZxoJ
	4DHI2YcjNN8mMPd10Mu1177Zt+lf0fj+F8ZA7SNNKHa+Erdv8oQScqwhJ0zcvBIL
	I1qvOAmpD3mR1ou7qGyyrZhqG856NPAdx5ZZdXIlmWSJSzBfbrn0vt2FB78k28h6
	eX2iBSTCUKw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 815DB17F6D;
	Fri, 19 Apr 2013 20:08:46 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07A8517F6C;
	Fri, 19 Apr 2013 20:08:45 +0000 (UTC)
In-Reply-To: <CAMP44s3YAq66MrOR5a4ydujKR5+ZNMVV4i=JzPCxLXC244b52g@mail.gmail.com>
	(Felipe Contreras's message of "Fri, 19 Apr 2013 12:35:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F0EF24D2-A92C-11E2-A6C3-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221818>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>>> +    File.open(file) do |f|
>>> +      f.each do |line|
>>> +        case line
>>> +        when /^From (\h+) (.+)$/
>>> +          from = $1
>>> +        when /^---\s+(\S+)/
>>> +          source = $1 != '/dev/null' ? $1[2..-1] : nil
>>
>> This may need to be tightened if you want to use this on a
>> real-world project (git.git itself does not count ;-); you may see
>> something like:
>>
>>     diff --git "a/a\"b" "b/a\"b"
>>
>> (I did an insane pathname 'a"b' to get the above example, but a more
>> realistic is a character outside ASCII).
>
> Suggestions on how to do that are welcome.

Check gitweb and find "unquote".
