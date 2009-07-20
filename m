From: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH 2/3] push: add --current
Date: Mon, 20 Jul 2009 11:48:43 +0200
Message-ID: <4A643D7B.9090900@gmail.com>
References: <1248071820-18289-1-git-send-email-bonzini@gnu.org> <1248071820-18289-3-git-send-email-bonzini@gnu.org> <20090720071413.GA29915@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	gitster@pobox.com
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 20 11:48:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSpUM-0001Eg-Uy
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 11:48:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbZGTJsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 05:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753114AbZGTJsq
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 05:48:46 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:59321 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753113AbZGTJsq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 05:48:46 -0400
Received: by fg-out-1718.google.com with SMTP id e12so471772fga.17
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=yKpIHSdAoMan0Eybs9mZ/QmzJczsZ+lwmPI/xYtHX/I=;
        b=gw0O5v/3HFZzrI4c9Ec0VXX7016lNCWLIqlJwBoHF8ma14jpPPpyxPZ0Edl0fZnlL+
         KsOK15b1KLQuC2A3kTZ4jtz5J+piord2Y1aa0Go9WNsHa7Lw5yN7wA02Fo6RfScHYhFT
         RLdj+GcCJ8z27PIRUDdAkI3iH32XyNUZK8teM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=oEF/s/EeaHCeZsZ9GuwFWdcjQmsR7nC2RWCmYjdDgaX9IzMrFT+3SU7C2IxzQZPFGS
         4bi7e0Xmc6+4kQmVihEl3/fRAP9iUwICo9aTFuO5Fz2U68TH148ZzLT87YJ7U+QPAetN
         TDlB9WrfZ6RPsWwmOstrWz7iBrMjRXeG/2sA0=
Received: by 10.86.25.17 with SMTP id 17mr3378865fgy.73.1248083325290;
        Mon, 20 Jul 2009 02:48:45 -0700 (PDT)
Received: from yakj.usersys.redhat.com (nat-pool-brq.redhat.com [62.40.79.66])
        by mx.google.com with ESMTPS id l12sm9465466fgb.18.2009.07.20.02.48.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Jul 2009 02:48:44 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Lightning/1.0pre Thunderbird/3.0b2
In-Reply-To: <20090720071413.GA29915@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123583>

>> +--current::
>> +	Independent of the other options, restrict pushing to the current
>> +	HEAD.
>
> To me, this sounds like there are multiple HEADs and this selects the
> current one to be pushed, which would be wrong. Maybe this could be
> written as:
>
> 	Restrict pushing to the currently checked out branch head.

I wrote that referring to "the branch currently pointed to by [the 
symref] HEAD".

> Hm, this only talks about refspecs in the config, but your patch series
> is especially about push.default=tracking, which is not a refspec set in
> the config, but causes a refspec to be generated on the fly.

Not really, as push.default=tracking and push.default=current would 
anyway push only the currently checked out branch.  "git push --current" 
would have a visible effect only for push.default=matching (the effect 
would be the same as push.default=current except that a new branch will 
not be created remotely).

If you have creted all your tracking branches with autosetuppush, then 
in that case "git push --current" or pushHeadOnly will indeed achieve 
the same effect as push.default=tracking; however, that would be with 
real refspecs in the config rather than with one generated on the fly. 
And since in that case you have a push refspec in the configuration, 
push.default would not be used.

Paolo
