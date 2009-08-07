From: Mark Rada <markrada26@gmail.com>
Subject: Re: Gitweb giving me some warnings in Apache's error_log
Date: Fri, 7 Aug 2009 13:56:03 -0400
Message-ID: <88f4c4ee0908071056g5d9da83ft77d56ec2e5e84bac@mail.gmail.com>
References: <533D6DDF-4DAC-4A86-A6F7-95B54B77E48B@gmail.com>
	 <m3my6bpv6v.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 20:04:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZTnk-0002Zn-WB
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 20:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754898AbZHGSEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Aug 2009 14:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754895AbZHGSEP
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 14:04:15 -0400
Received: from mail-bw0-f215.google.com ([209.85.218.215]:46560 "EHLO
	mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754874AbZHGSEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Aug 2009 14:04:14 -0400
X-Greylist: delayed 489 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Aug 2009 14:04:13 EDT
Received: by bwz11 with SMTP id 11so1598596bwz.39
        for <git@vger.kernel.org>; Fri, 07 Aug 2009 11:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=5nKPxMxSO3WQC9EGpv5g16Mr8JpJG98pcnyjEgVOmdA=;
        b=XLDque4lofTSqCLrD0KR617z/LVfPvg1LqVWcRhKJ9R+BoJE+OaQPtT9flkV/kF3eE
         YU2jQ4cSHoHL7jbQxvG1mCCAk/5IXcXFkZ6leOhf/IsFGhbSn4CUdxQcAmTiICtmPMc8
         l8F/0KGzHY8MZDfMBXNUp/U2o3HonJX5/Vdfg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=NpZENR0f3jox7EjA6JhAgOQa33wvhPYgFrtfGHIFf4bp4R1bRDe7lHVswO4GXrwGlN
         kRO5xy69L7k0xy5SSu9rdB5JBO7pLuvAS6tCYUku1oQBV/eohoQa0lnUryy75LZtjgIc
         ZMsm41MkihL8F+kH5RaV5lZvhied128ld1amo=
Received: by 10.204.58.136 with SMTP id g8mr69208bkh.50.1249667763974; Fri, 07 
	Aug 2009 10:56:03 -0700 (PDT)
In-Reply-To: <m3my6bpv6v.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125207>

Let me double check my understanding.

The warnings will not occur if Gitweb is run as a regular CGI script
because then it won't be nested inside a call from
ModPerl::Registry?

Will it also not complain if I provided my own $project_list in the fir=
st place?

Also, I looked at some examples from the second and third page of an ar=
ticle
on the subject, http://www.perl.com/pub/a/2002/05/07/mod_perl.html?
and it looks "fixable". Is there a particular reason why any of them ar=
e not
desirable?

Note: I haven't tried anything yet, just wondering if you know off hand

--
Mark A Rada (ferrous26)
marada@uwaterloo.ca



On Fri, Aug 7, 2009 at 10:14 AM, Jakub Narebski<jnareb@gmail.com> wrote=
:
> Mark A Rada <markrada26@gmail.com> writes:
>
>> It doesn't seem to cause any other problems, but I don't know if it =
is
>> significant or not.
>>
>> [Fri Aug =A07 08:51:13 2009] gitweb.cgi: Variable "$project_maxdepth=
"
>> may be unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi lin=
e
>> 2296.
>> [Fri Aug =A07 08:51:13 2009] gitweb.cgi: Variable "$projectroot" may=
 be
>> unavailable at /var/www/private/gitweb/cgi-bin/gitweb.cgi line 2304.
>>
>>
>> Apache 2.2.12/ mod_perl 2.04/ perl 5.8.8
>
> From perldiag(1) manpage:
>
> =A0Variable "%s" may be unavailable
>
> =A0 =A0(W closure) An inner (nested) anonymous subroutine is inside a
> =A0 =A0named subroutine, and outside that is another subroutine; and =
the
> =A0 =A0anonymous (innermost) subroutine is referencing a lexical vari=
able
> =A0 =A0defined in the outermost subroutine. =A0For example:
>
> =A0 =A0 =A0sub outermost { my $a; sub middle { sub { $a } } }
>
> =A0 =A0If the anonymous subroutine is called or referenced (directly =
or
> =A0 =A0indirectly) from the outermost subroutine, it will share the
> =A0 =A0variable as you would expect. =A0But if the anonymous subrouti=
ne is
> =A0 =A0called or referenced when the outermost subroutine is not acti=
ve,
> =A0 =A0it will see the value of the shared variable as it was before =
and
> =A0 =A0during the *first* call to the outermost subroutine, which is
> =A0 =A0probably not what you want.
>
> =A0 =A0In these circumstances, it is usually best to make the middle
> =A0 =A0subroutine anonymous, using the "sub {}" syntax. =A0Perl has
> =A0 =A0specific support for shared variables in nested anonymous
> =A0 =A0subroutines; a named subroutine in between interferes with thi=
s
> =A0 =A0feature.
>
> The warning is about 'wanted' anonymous subroutine passed to
> File::Find::find. =A0The "middle" subroutine is git_get_projects_list=
,
> and the "outermost" is mod_perl / ModPerl::Registry request loop.
>
> We can't make git_get_projects_list anonymous, but anonymous
> subroutine is not called or referenced outside git_get_projects_list,
> nor it is called or referenced outside mod_perl request/event loop.
>
> This warning is harmless... but I do not know how to silence it.
>
> --
> Jakub Narebski
> Poland
> ShadeHawk on #git
>
