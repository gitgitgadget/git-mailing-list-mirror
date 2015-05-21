From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH] git-send-email.perl: Add sendmail aliases support
Date: Thu, 21 May 2015 17:30:30 -0400
Message-ID: <CAJ80savEBYGKLJx8pN+4xsDodi0PJcV2YHJLukDKztg3YV__FQ@mail.gmail.com>
References: <3f1091c3de6e4e62037bc3c84c69026e33ee9707.1432229888.git.allenbh@gmail.com>
	<xmqqioblisyk.fsf@gitster.dls.corp.google.com>
	<CAJ80satMSCGydLRb5k=xpSqxXSBL=_T7nsHEz3jsuFV9MdmmtA@mail.gmail.com>
	<CAPig+cQFana40n=SCBOC0P2v4Ss7Via3eS6Ms2rU=M9_V_3Osg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 21 23:30:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvY32-0007Df-M7
	for gcvg-git-2@plane.gmane.org; Thu, 21 May 2015 23:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756471AbbEUVac (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2015 17:30:32 -0400
Received: from mail-wg0-f48.google.com ([74.125.82.48]:35282 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311AbbEUVab (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2015 17:30:31 -0400
Received: by wgfl8 with SMTP id l8so184431wgf.2
        for <git@vger.kernel.org>; Thu, 21 May 2015 14:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eLjG+9xC9ubnZSsFP/dm3C2JR7vbJQSh6i9CeeTMlrY=;
        b=RnpSxmPrO/BKCx6WzLKfjpz2trkxASik+sfIHGjKRjyOllWx9x7bhtX7Myvk5VyCVx
         HnzUwKrG3f1tC4CUnTTNZWCV4f5wTYs4tLnUfYihrudnecvS7NvfhdN5BiIL9n1VCCw7
         S0oBVyx3xq8c93qoAm8skiHlAA1jUToyDHIVx1sboR1PoC5WkrfDBMgtP3J2iO077sid
         T3IWLSHAQCT6W9Brfrq2PjeXP6tCcbMMVIetO/A8Y3di2SDSQLGqkaICrE0rrKumDRmQ
         jNVHoIBIZ5zQm1tRGhOHbSzWgtFlFg8h3M8sYef85mqEfEC5rBngoJmXhganTFq0fsWO
         mjvQ==
X-Received: by 10.180.90.236 with SMTP id bz12mr1239044wib.33.1432243830786;
 Thu, 21 May 2015 14:30:30 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Thu, 21 May 2015 14:30:30 -0700 (PDT)
In-Reply-To: <CAPig+cQFana40n=SCBOC0P2v4Ss7Via3eS6Ms2rU=M9_V_3Osg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269665>

On Thu, May 21, 2015 at 5:05 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, May 21, 2015 at 4:48 PM, Allen Hubbe <allenbh@gmail.com> wrote:
>> My motivation for this patch was not really to support the sendmail
>> aliases file directly.  The commit message may therefore be
>> misleading.  So, I could also rewrite the commit message to say
>> something like, "loosely based on" the sendmail aliases format, if the
>> exceptions to the format in the current message are not enough.
>
> That probably would be a good idea. After reading the 'aliases' man
> page you cited[1], I was wondering why your parser diverged from it in
> so many ways. In addition to lack of support for folded lines, your
> format:
>
> * only recognizes comment lines when '#' is the first character,
> whereas [1] allows whitespace before '#'
>
> * only recognizes zero-length lines as empty, whereas [1] more loosely
> interprets a whitespace-only line as empty
>
> * doesn't support quoting the 'name' part of "name: value" as [1] does
>

Those are good points.  Maybe I shouldn't even mention sendmail at
all, not in the name of the format, and not in the commit message.
What name would be a good name for this format?

All the other formats would are based on the formats of email clients.
Adding sendmail was a departure from that.  Adding a format that is
not associated with any email program would be an even further
departure.  I don't know how other people feel about this.  Hopefully,
if this new format seems like it would be useful, the fact that it is
not an email client format can be overlooked.

>> Really, I just prefer the simpler <alias>: <email|alias> syntax
>> instead of the ones for mutt, elm, etc, and that is why I wrote this
>> patch.
>
> Your patch is missing a documentation update
> (Documentation/git-send-email.txt) and new tests
> (t/t9001-send-email.sh).

Thanks for the direction.

>
> [1] http://www.postfix.org/aliases.5.html
