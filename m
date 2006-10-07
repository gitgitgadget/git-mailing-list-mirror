From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 7 Oct 2006 11:01:15 -0700 (PDT)
Message-ID: <20061007180115.59728.qmail@web31814.mail.mud.yahoo.com>
References: <7vvemwqusl.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, ltuikov@yahoo.com
X-From: git-owner@vger.kernel.org Sat Oct 07 20:01:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWGUa-0001w0-Nk
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 20:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932521AbWJGSBS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 14:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932525AbWJGSBS
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 14:01:18 -0400
Received: from web31814.mail.mud.yahoo.com ([68.142.206.167]:29307 "HELO
	web31814.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932521AbWJGSBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 14:01:16 -0400
Received: (qmail 59730 invoked by uid 60001); 7 Oct 2006 18:01:15 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YjqV1niYuBXtDP5AomCkQ/TWAR0QIA+izwYGOFnB9vV+a8s3kcKI6HMf++c5YA7nQZgPoDyfXGQMx0tfgqcq7Z7Uby5uJ4AcbAUstVVYuH3n5y0iDxuC7ODIhiS/wbXiJ7dosdG/Jog9lZpz9BSo8lj5yG91tHeqHez8Oc+TAG0=  ;
Received: from [71.80.233.118] by web31814.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 11:01:15 PDT
To: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <7vvemwqusl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28491>

--- Junio C Hamano <junkio@cox.net> wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > Junio C Hamano wrote:
> >
> >> Luben Tuikov <ltuikov@yahoo.com> writes:
> >> 
> >>>>> +# Convert a string (e.g. a filename) into qtext as defined
> >>>>> +# in RFC 822, from RFC 2183.  To be used by Content-Disposition.
> >>>>> +sub to_qtext {
> >>>>> +  my $str = shift;
> >>>>> +  $str =~ s/\\/\\\\/g;
> >>>>> +  $str =~ s/\"/\\\"/g;
> >
> > Here probably it could be
> >         $str =~ s/"/\\"/g;
> >
> >>>>> +  $str =~ s/\r/\\r/g;
> >>>> 
> >>>> \r? Not \n?
> >>>
> >>> Yes, \r, not \n.
> >> 
> >> \r to \\r? Not to \\\r?
> >
> > We want "\r" in suggested filename, not "\
> > " I think, so it is "\\r".
> 
> Is that what you guys are attempting to achieve?

I think so.

> If we are trying to suggest a filename that is safe by avoiding
> certain characters, I suspect leaving a backslash and dq as-is
> is just as bad as leaving a CR in.  So if that is the goal here,
> I think it might be better and a lot simpler to just replace
> each run of bytes not in Portable Filename Character Set with an
> underscore '_'.

I think that if I were to download a file which had those chars
in it, I'd like to at least be able to see the _intention_ of what
chars the actual file name had.

So if I download a filename which looks like this:

     This is a \" test \" file \\.\r

Then I know that the intention had been:

     This is a " test " file \.<CR>

It becomes an intention, since it needs to be carried over
a qtext.

   Luben
