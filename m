From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb and unicode special characters
Date: Sat, 13 Dec 2008 02:31:05 +0100
Message-ID: <200812130231.06929.jnareb@gmail.com>
References: <3f2beab60812121033r5d41894t77acc271b7c6955c@mail.gmail.com> <m3y6ylf3mq.fsf@localhost.localdomain> <3f2beab60812121655m6cd868bfhaaf386e6f5457533@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Santhosh Thottingal" <santhosh00@gmail.com>
To: "Praveen A" <pravi.a@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 13 02:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBJMu-0005dz-RV
	for gcvg-git-2@gmane.org; Sat, 13 Dec 2008 02:32:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753495AbYLMBbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 20:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752865AbYLMBbP
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 20:31:15 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:57317 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbYLMBbO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 20:31:14 -0500
Received: by ewy10 with SMTP id 10so2059030ewy.13
        for <git@vger.kernel.org>; Fri, 12 Dec 2008 17:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=4NrL7gNGRtgflMbgSccRTrMFnF6ZrhBzkL53YoV5KtY=;
        b=WAcI7kMaDp0cLnqXebDb4Ckc1F/EF/G9DrPAnBRkxrtPsDvjX4bBdn4ZoIiv7/OFP2
         0+3dCaxHg7e5aIlFJeblDJmkF+XRbRBs0O1WNJAr26ntWHQvd9tB3wne91ndREA4NmOq
         +Rfv0DifeNwtNrYYKRQgpYTFwbD7hehBCDTO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=vYE6kmKg0KVu11mhHJO2NqfsqeICuJY4J2fdagyY938UkLJqm4FBbzjPElLv+e2cYZ
         2AcW/2v2mwPgD7jAbRvVLOa7xEVlyUr5bVcPmLxPBzkUaw3T8TtDzhydg2qjFzRGRmqM
         kvxZLdR0ptDHlaYaSlFuksSxd5jsG3rlr6xxg=
Received: by 10.210.119.16 with SMTP id r16mr4842930ebc.161.1229131872924;
        Fri, 12 Dec 2008 17:31:12 -0800 (PST)
Received: from ?192.168.1.11? (abvt119.neoplus.adsl.tpnet.pl [83.8.217.119])
        by mx.google.com with ESMTPS id 7sm544708eyg.42.2008.12.12.17.31.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Dec 2008 17:31:12 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <3f2beab60812121655m6cd868bfhaaf386e6f5457533@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102978>

On Sat, 13 Dec 2008 01:55, Praveen A wrote:
> 2008/12/12 Jakub Narebski <jnareb@gmail.com>:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>> "Praveen A" <pravi.a@gmail.com> writes:
>>>
>>>> Git currently does not handle unicode special characters ZWJ and ZWNJ,
>>>> both are heavily used in Malayalam and common in other languages
>>>> needing complex text layout like Sinhala and Arabic.
>>>>
>>>> An example of this is shown in the commit message here
>>>> http://git.savannah.gnu.org/gitweb/?p=smc.git;a=commit;h=c3f368c60aabdc380c77608c614d91b0a628590a
>>>>
>>>> \20014 and \20015 should have been ZWNJ and ZWJ respectively. You just
>>>> need to handle them as any other unicode character - especially it is
>>>> a commit message and expectation is normal pain text display.
>>>
>>> [...] git_commit calls format_log_line_html, which
>>> in turn calls esc_html.  esc_html looks like this:
>>>
>>>   sub esc_html ($;%) {

[...]
>>>   **  $str =~ s|([[:cntrl:]])|(($1 ne "\t") ? quot_cec($1) : $1)|eg;
>>>       return $str;
>>>   }
>>>
>>> The two important lines are marked with '**'.
>> [...]
>>
>>> So it looks like Perl treats \20014 and \20015 (ZWNJ and ZWJ) as
>>> belonging to '[:cntrl:]' class. I don't know if it is correct from the
>>> point of view of Unicode character classes, therefore if it is a bug
>>> in Perl, or just in gitweb.
>>
>> I checked this, via this simple Perl script:
[...]
>>  "\N{ZWNJ}" =~ /[[:cntrl:]]/ and print "is [:cntrl:]";
>>
>> And the answer was:
>>
>>  oct=20014 dex=8204 hex=200c
>>  is [:cntrl:]
>>
>> 'ZERO WIDTH NON-JOINER' _is_ control character... We probably should
>> use [^[:print:][:space:]] instead of [[:cntrl:]] here.
> 
> That looks good. But I'm wondering why do we need to filter at all?
> Is it a security concern? It is just description.

First, from the new description [^[:print:][:space:]], or even
[^[:print:]] (whichever we choose) you can see that those characters
we are showing using C (\r, \v, \b,...) + octal (in older gitweb) or
hex (in never gitweb) escapes would be invisible otherwise, or do
the strange things like \b aka backspace character.

Sidenote: There is probably one exception we want to add, namely not
escape '\r' at the end of line, to be able to deal better with DOS
line endings (\r\n).


Second, and that is I think reason we started to escape control
characters like \014 or ^L i.e. FORM FEED (FF) character (e.g. in
COPYING file), or \033 or ^[ i.e. ESCAPE (\e) character (e.g. commit
20a3847d) is that they are not allowed in XML, which means that they
are not allowed in XHTML, which means that if they are on the page,
and MIME-type is 'application/xml+html' forcing strict XML/XHTML mode
validating browsers would not display the page because it is not valid
XHTML. Mozilla 1.17.2 did this, and it would not show page; I don't
know how it works with more modern browsers.

-- 
Jakub Narebski
Poland
