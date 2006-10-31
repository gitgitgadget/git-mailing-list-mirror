X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 2/n] gitweb: Use '&iquot;' instead of '?' in esc_path
Date: Tue, 31 Oct 2006 10:23:22 +0100
Message-ID: <200610311023.23409.jnareb@gmail.com>
References: <200610301953.01875.jnareb@gmail.com> <7vzmbds4pw.fsf@assigned-by-dhcp.cox.net> <7vvem1s29g.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 31 Oct 2006 09:23:43 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qeO/3dwtdEE6lU/+5mGageRD4HBeRb0LvIWro+t/J+J1KrJb2mHZH9VCYvzizfHi/Qeq3iyZ7CTBhQlkgLG7vlaAfU7pRNzZIh72rrwdx0wTW43CZhHPUnuBfSwHZE6EoqrwmuA61KmZ9G32BAb6ZYt+uE2XOUWPY4umBaQqeuU=
User-Agent: KMail/1.9.3
In-Reply-To: <7vvem1s29g.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30575>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gepq5-000628-Nv for gcvg-git@gmane.org; Tue, 31 Oct
 2006 10:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161635AbWJaJXS (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 04:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161636AbWJaJXS
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 04:23:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:34572 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1161635AbWJaJXR
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 04:23:17 -0500
Received: by ug-out-1314.google.com with SMTP id 32so1390087ugm for
 <git@vger.kernel.org>; Tue, 31 Oct 2006 01:23:15 -0800 (PST)
Received: by 10.66.249.11 with SMTP id w11mr5757940ugh; Tue, 31 Oct 2006
 01:23:15 -0800 (PST)
Received: from host-81-190-18-116.torun.mm.pl ( [81.190.18.116]) by
 mx.google.com with ESMTP id e33sm4660287ugd.2006.10.31.01.23.15; Tue, 31 Oct
 2006 01:23:15 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano wrote:
>
> Junio C Hamano <junkio@cox.net> writes:
> 
>> Jakub Narebski <jnareb@gmail.com> writes:
>>
>>> Use "&iquot;" Latin 1 entity ("&#191;" -- inverted question mark =
>>> turned question mark, U+00BF ISOnum) instead '?' as replacements for
>>> control characters and other undisplayable characters.
>>>
>>> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
>>
>> Do you have something against our Spanish and Latin American
>> friends?  ;-)
>>
>> I wonder if there is a more suitable replacement character that
>> is accepted across scripts?
> 
> I have a suspicion that instead of finding an exotic character,
> just showing the byte value in \octal, perhaps in different
> color, might be more portable and easier.  For one thing, it
> helps to show the exact byte value than just one substitution
> character if you are troubleshooting gitweb.

Will do. Well, with the exception of control characters which have
literal escape characters, for example showing LF as \n instead
of \octal. By the way, wouldn't \xhex be better?

Different color/style is good. Otherwise we would have escape escape
character, i.e. write '\\' and perhaps als mark filename as quoted.
git surrounds filename with doublequotes, "<quoted filename>", adding
'"' to the list of quoted characters: for gitweb this kind of marking
filename as quoted is PITA, as we first, don't want I think to include
'"' in link ("_filename_" vs _"filename"_), and second and more important
if we hyperlink parts of filename we would want for quote to be placed
outside whole filename ("a/_filename_" vs a/_"filename"_ and also
"_path_/_to_/_file_" vs _path_/_to_/_"file"_).

Should we mark only replaced character, or the whole filename?


On the technical side, should I send the patch as replacement for this
patch, or on top of this patch?
-- 
Jakub Narebski
