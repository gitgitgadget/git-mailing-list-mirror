From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb showing slash r at the end of line
Date: Sat, 28 Jan 2012 18:02:43 +0100
Message-ID: <201201281802.44339.jnareb@gmail.com>
References: <1327673954458-7229895.post@n2.nabble.com> <m3aa58eskw.fsf@localhost.localdomain> <7vvcnwybxj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ondra Medek <xmedeko@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 28 18:40:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrCFp-0000o9-Qk
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jan 2012 18:39:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750Ab2A1RCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jan 2012 12:02:15 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55793 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab2A1RCO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 12:02:14 -0500
Received: by eekc14 with SMTP id c14so921320eek.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 09:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=WROOVw3whYTiNkdIKhrl8yzlyVDZpzBtmtu8vZV/Ets=;
        b=mqX4p6DWWDs2g1sm5JaLrfGJXexqcW0UtmaBovtmv8FXErnGh833rJ6Umi3jmLDbGE
         hxAaULMdo9ZaWIy2EqN4SxngLIxuSTSefJ8cddMcddGsx5HCwOuRCPs9rTDA8vvhEWla
         ZfEIWEmaGzkRGiiQFNnrArf9N4gm2fwULvHWE=
Received: by 10.14.11.92 with SMTP id 68mr3520558eew.54.1327770133331;
        Sat, 28 Jan 2012 09:02:13 -0800 (PST)
Received: from [192.168.1.13] (abvp249.neoplus.adsl.tpnet.pl. [83.8.213.249])
        by mx.google.com with ESMTPS id e12sm46070303eea.5.2012.01.28.09.02.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jan 2012 09:02:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vvcnwybxj.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189259>

On Sat, 28 Jan 2012, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
>> Ondra Medek <xmedeko@gmail.com> writes:
>>
>>> we have gitweb running on Linux box. Some files have Windows line ending
>>> (CRLF) end we do not use core.autcrlf translation. gitweb show the last \r
>>> in the end of each line, which is annoying.
>>
>> Well, this "\r" allows to recognize when file with Windows line ending
>> (CRLF) made it into repository... which usually is discouraged.  But
>> if you allow this, I can understand that those "\r" at the end of
>> every line can be annoying.
> 
> I think the right thing to do is:
> 
>  * If the repository data is _supposed_ to have CRLF endings (e.g. check
>    with core.crlf or something), strip \r and do not show them.
> 
>  * Otherwise, i.e. if the repository data is supposed _not_ to have CRLF
>    endings, do show these '\r'.  Annoyance here is a *feature* to remind
>    the viewer that the contents needs _fixing_.
> 
>  * No other switches.

I agree that it would be a bast solution if gitweb could automatically
infer whether CRLF is allowed (whitelist) or disallowed (blacklist) in
files in given repository.  

But I am not sure if it is possible and what rules there should be for
a *BARE* repository; crlf and eol gitattributes and config variables
are about what should appear in working area - something gitweb is not
interested in at all.

If gitweb code was structured in different way, we could check if all
lines end in LF or all lines end in CRLF and add a note about that to
file or diff header, showing "\r" only in case of mixed line endings...
But that's a futile wish, for now at least.

-- 
Jakub Narebski
Poland
