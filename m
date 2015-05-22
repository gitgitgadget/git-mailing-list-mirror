From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 08:12:39 -0400
Message-ID: <CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 22 14:12:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yvloq-00070p-FZ
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 14:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbbEVMMm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 08:12:42 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:36321 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbbEVMMl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 08:12:41 -0400
Received: by wizk4 with SMTP id k4so45426801wiz.1
        for <git@vger.kernel.org>; Fri, 22 May 2015 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=+elEK7uJzmywWKKpRF6//NkSUHj6CNpn/+KDwotMkH8=;
        b=CIM8iBgiIwsfsf6+rj/8JqHvOuymz6GY/2c5ZQP95vnj0vykOGEgU6H81lmXrLOdsp
         IcRr10XW1wynCW9uKs9FiqNpeJb+LjzCOTrThXfGWsn+B+WLOt+JYOA3rKN2H1Qn+GX7
         8O6dCr/w1BGGkPu1rNwtu0/haoOoyz1e6ARhLaotar7t4Vdnjs1XBl9fNTpK39pYFH/u
         VmADBTKxaahrrcOR4yoqNggLn2fUwiH2qZ2bNkHp8Uedrayfvp+Y29kTVo9i1Fmp1Jhy
         jK8TSb3xu0RZi9zSWQcHYh0eYoV5S6QEP8OqAzH0BZLr/E8ngfh+y+RUyS1WLsSzxUYS
         ijPg==
X-Received: by 10.180.90.236 with SMTP id bz12mr6928093wib.33.1432296760015;
 Fri, 22 May 2015 05:12:40 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Fri, 22 May 2015 05:12:39 -0700 (PDT)
In-Reply-To: <CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269705>

On Fri, May 22, 2015 at 12:29 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 21, 2015 at 11:40 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>> This format is more simple than the other alias file formats, so it may
>> be preferred by some users. [...]
>> Signed-off-by: Allen Hubbe <allenbh@gmail.com>
>> ---
>> diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
>> index 804554609def..38ade31e0c28 100644
>> --- a/Documentation/git-send-email.txt
>> +++ b/Documentation/git-send-email.txt
>> @@ -383,7 +383,29 @@ sendemail.aliasesFile::
>>
>>  sendemail.aliasFileType::
>>         Format of the file(s) specified in sendemail.aliasesFile. Must be
>> -       one of 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
>> +       one of 'simple', 'mutt', 'mailrc', 'pine', 'elm', or 'gnus'.
>> ++
>> +If the format is 'simple', then the alias file format is described below.
>> +Descriptions of the other file formats to the following formats can be found in
>> +the documentation of the email program of the same name.
>
> The second sentence probably needs some proof-reading.

Could you be more specific?

>
>> ++
>> +This 'simple' format is is as follows.
>> ++
>> +       <alias>: <address|alias>[, <address|alias>...]
>> ++
>> +Aliases are specified one per line.  There is no line splitting.  Anything on a
>> +line after and including a `#` symbol is considered a comment, and is ignored.
>> +Blank lines are ignored.
>
> I'm not convinced that gratuitously diverging from the
> sendmail/postfix 'aliases' format is warranted. In particular, that

This isn't 'sendmail', as of v2.

> format recognizes a comment line only when '#' is the first
> non-whitespace character[1]; and does not consider '#' a
> comment-introducer anywhere else in the line. By recognizing '#'
> anywhere as a comment-introducer, you may be painting this format into
> a corner rather than leaving it open for someone later to extend it to
> be more sendmail/postfix-like by, for instance, supporting name
> quoting and line-continuation[1].

It depends what we want to do with this parser: accept existing
sendmail aliases files in git, or enforce that git alias files are
usable for sendmail.  I really don't expect the second to ever happen.
The first, maybe, but only if the alias file is edited to remove
aliases of pipes and maildirs etc.  The second may not work if we have
comments to the right, or aliases of aliases, which sendmail does not
claim to support.

I don't know what sendmail would actually do with a '#' elsewhere.  It
only talks about having '#' at the beginning of a line, or in the
alias name in quotes (which is not supported by this parser - proper
handling of quoted strings is not easy).  It doesn't say what sendmail
does with '#' if the name is not quoted, and it doesn't define a
meaning for '#' in the definition of an alias.  If these other cases
would be errors for sendmail, so what if they are not errors here?

>
> For the same reason, I'm not convinced that "simple" is a good name.

I was worried about that back in v1 before going to v2, but I really
don't have a strong opinion about the name.  I already changed the
name, at the suggestion of Junio. I'd like to hear a consensus from
you two, or a tiebreaker from a third, before I change it again.

> "sendmail" may indeed be a more appropriate name, even if it means
> that this early implementation documents it as (currently) a subset of
> the richer sendmail/postfix 'aliases' format. By doing so, we leave
> the door open so a future person can implement additional features to
> bring it closer to that format.

Or, a future person can write a sendmail parser that is closer to that format.

>
> [1]: http://www.postfix.org/aliases.5.html
>
>> ++
>> +Example of the 'simple' format:
>> ++
>> +       alice: Alice W Land <awol@example.com>
>> +       bob: Robert Bobbyton <bob@example.com>
>> +       # this is a comment
>> +          # this is also a comment
>> +       chloe: chloe@example.com
>> +       abgroup: alice, bob # comment after an alias
>> +       bcgrp: bob, chloe, Other <o@example.com>
