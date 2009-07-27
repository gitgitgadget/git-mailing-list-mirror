From: Cyrill Gorcunov <gorcunov@gmail.com>
Subject: Re: [RFC] request-pull with diff body itself
Date: Tue, 28 Jul 2009 00:56:10 +0400
Message-ID: <aa79d98a0907271356l51111uac0884cf148f434f@mail.gmail.com>
References: <20090727195357.GE17942@lenovo>
	 <7vws5tg8fw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 22:56:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MVXF5-0005bE-FH
	for gcvg-git-2@gmane.org; Mon, 27 Jul 2009 22:56:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753874AbZG0U4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2009 16:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751110AbZG0U4M
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Jul 2009 16:56:12 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:52798 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750833AbZG0U4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2009 16:56:11 -0400
Received: by fg-out-1718.google.com with SMTP id e21so912719fga.17
        for <git@vger.kernel.org>; Mon, 27 Jul 2009 13:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=+1CeAHyN52KjR8wIexrTzrzu+ZX0x/YI1j9Ro+rxd+w=;
        b=lyklS5Vn96GyZ0yJx4S1erpwapvmwj7+C3iXhQTDQjhZyxXjWXJY/psNE81rSeVtSS
         TF8dxIXu33n77F1s23KekYQGzSkIQyWwR1d4691xoZBteEqaEO7E/1YoQ5T3YfLgk0YQ
         QNZ25X8mQi+k9/057KfEPqnJFBJWUTZDhlTWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dJdWD2cakCcTLf+V1tUa0S/HGhH3CgnFzh1/Czolo78qH9rCd4kyCmIj/7UPARfO/C
         3QT9LCngzdee++SfaDksur23lxxaF0V6cFtvH527LjRDZM91IYV3nm9j3bmPAML47s4i
         5ijTwkdDVf5KAK0woRc9gihlVRjEka0ppTQSY=
Received: by 10.86.65.18 with SMTP id n18mr2687851fga.7.1248728170455; Mon, 27 
	Jul 2009 13:56:10 -0700 (PDT)
In-Reply-To: <7vws5tg8fw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124192>

On 7/28/09, Junio C Hamano <gitster@pobox.com> wrote:
> Cyrill Gorcunov <gorcunov@gmail.com> writes:
>
>> Here is rfc in a sake of having ability to produce
>> diff body in small series of changes in request-pull.
>> we could use ">>" here and append diff by hands but
>> adding "-p" option seems more comfortable.
>>
>> Dunno, just a thought.
>
> I think this is a useful thing to add, as I think I've seen some
> request-pull actually made with the patch text, most likely by hand.
>
>>  git shortlog ^$baserev $headrev
>>  git diff -M --stat --summary $merge_base $headrev
>> +
>> +if [ "$usediff" = "yes" ]; then
>> +	echo "---"
>> +	git diff -M -p $merge_base $headrev
>> +fi
>
> You can just use a single "git diff" invocation here,
>
> 	git diff -M --stat --summary $usediff $merge_base $headrev
>
> and set up "$usediff" to be either empty or -p in the option parsing part.
>
yeah, indeed, thanks for the hint Junio!
Will post an updated patch in a day or so ( as only get back my laptop
back). Or maybe someone could make it faster then me ;)
