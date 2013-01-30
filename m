From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: Re: [feature request] git add completion should exclude staged content
Date: Wed, 30 Jan 2013 19:24:03 +0100
Message-ID: <51096543.9050100@gmail.com>
References: <20130126172137.GB5852@mobster.11n_AP_Router> <7vip6iteod.fsf@alter.siamese.dyndns.org> <5106444F.2040007@gmail.com> <51067487.9050505@drmicha.warpmail.net> <510684FB.80104@gmail.com> <5106A5CE.3000800@drmicha.warpmail.net> <7vd2wpxki1.fsf@alter.siamese.dyndns.org> <5106DC87.7090607@gmail.com> <E59706EF8DB1D147B15BECA3322E4BDC097A7E@eusaamb103.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	'Michael J Gruber' <git@drmicha.warpmail.net>,
	'wookietreiber' <kizkizzbangbang@googlemail.com>,
	"'git@vger.kernel.org'" <git@vger.kernel.org>
To: Marc Khouzam <marc.khouzam@ericsson.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 19:24:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cL7-0002sr-77
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:24:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302Ab3A3SYb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:24:31 -0500
Received: from mail-ee0-f54.google.com ([74.125.83.54]:37552 "EHLO
	mail-ee0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755000Ab3A3SYa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:24:30 -0500
Received: by mail-ee0-f54.google.com with SMTP id c41so997106eek.27
        for <git@vger.kernel.org>; Wed, 30 Jan 2013 10:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=K22vnIHvlYxsBH3gVNVVl5sdi0n7D2CBEoJfjLVT5Zs=;
        b=MDr2moPG0hn2/fCqusmAf2997UaY5oTVQIC4MzWhq6MFnh4wHfASq/YIeY1pr8s8vn
         1Q856w/OcKL0bKt9NwE3AJwDOIojAnhTsxShvX9e8gJKqIZvukuj/I0bleiIoxnSc+oP
         YbdHHY1UIJPvPchZsJ994+YxB5PThhSYT8cCxJa9O9T8KTFPV60LEWkX5r2Zi8rybxUH
         l2Hje31m0SC2mmUz9An3SnI7jCwAl0NHxtNnJceKzCXwBGNDqDy/Sq3oiRKBnWYVIm33
         QDlI5fBjM9QIsAAVv0dvGnbLKh2m+3n0491hGipprKzFZFDpwogSKAfwpRNm08kV0YH1
         gVZA==
X-Received: by 10.14.174.198 with SMTP id x46mr17366804eel.23.1359570269255;
        Wed, 30 Jan 2013 10:24:29 -0800 (PST)
Received: from [192.168.0.3] ([151.70.202.186])
        by mx.google.com with ESMTPS id b2sm3245454eep.9.2013.01.30.10.24.23
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 30 Jan 2013 10:24:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
In-Reply-To: <E59706EF8DB1D147B15BECA3322E4BDC097A7E@eusaamb103.ericsson.se>
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215043>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Il 30/01/2013 15:06, Marc Khouzam ha scritto:
> [...]
>> I will try to update the patch, with your latest suggestions (avoid
>> tricky POSIX shell syntax, and CDPATH issue - if I remember 
>> correctly),
>> and with an update for the t/t9902-completion.sh test (that I 
>> completely
>> missed).
> 
> Hi Manlio,
> 

Hi.

> I'm trying to update git-completion.tcsh to work properly with
> your nice new completion feature.  But I'm having trouble with 
> the missing '/' at the end of directories.
> 
> The new logic in git-completion.bash tells bash that 'filenames'
> completion is ongoing so bash will add a '/' after directories.
> Sadly, tcsh won't do that, so it would be simpler if
> git-completion.bash added the '/' itself.  I looked at the 
> git-completion.bash script changes and I noticed that for 
> bash version < 4, you have to add the '/' yourself.

The compatible version is not only required for Bash; you can use it for
other shells.

Try to redefine the __git_index_file_list_filter function to use the
version that adds a slash to directory names.


> I also noticed the following comment:
> 
>  # XXX if we append a slash to directory names when using
>  # `compopt -o filenames`, Bash will append another slash.
>  # This is pretty stupid, and this the reason why we have to
>  # define a compatible version for this function.
> 
> So I gather you would rather add a '/' all the time to deal
> with older bash version transparently.  This would be great
> for tcsh also.  I'm trying to figure out
> when bash mis-behaves when you add the '/' all the time?
> When I try it (I have bash 4.1.5(1)-release) I didn't run
> into the double slash problem you mention in the comment.
> 

I'm using the same version: 4.1.5(1), on Debian stable.

> I'm hoping we can straighten this out and have
> git-completion.bash add the '/' all the time.
> 
> Could you explain when the problem happens?
> 

Bash 4.1.5(1) always adds an additional slash for directories.
I have tested it right now: change the filter function to use the
compatible version:

__git_index_file_list_filter ()
{
	# Default to Bash >= 4.x
	__git_index_file_list_filter_compat
}


Then running `git add <TAB>` inside the git repository, I get this file
completion list:

$ git add <TAB>
contrib//


> Thanks
> 


Thanks to you

Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlEJZUMACgkQscQJ24LbaUQUGACgkMG/bZrJKBzlZ8toEQwmggQX
m9kAn2ATJbSp87kOkoCCc00eHmh71r3y
=D9iu
-----END PGP SIGNATURE-----
