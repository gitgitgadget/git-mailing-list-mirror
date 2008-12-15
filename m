From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [RFCv4 1/3] gitweb: add patch view
Date: Mon, 15 Dec 2008 14:48:20 +0100
Message-ID: <cb7bb73a0812150548w526a8c0eu13ec95785e0ab824@mail.gmail.com>
References: <1228575755-13432-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <1228575755-13432-2-git-send-email-giuseppe.bilotta@gmail.com>
	 <200812151417.16372.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 15 14:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCDpN-0007Cw-Px
	for gcvg-git-2@gmane.org; Mon, 15 Dec 2008 14:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751604AbYLONsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2008 08:48:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752439AbYLONsW
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Dec 2008 08:48:22 -0500
Received: from ey-out-2122.google.com ([74.125.78.25]:30775 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751011AbYLONsW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2008 08:48:22 -0500
Received: by ey-out-2122.google.com with SMTP id 6so373753eyi.37
        for <git@vger.kernel.org>; Mon, 15 Dec 2008 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xLZqrro5yY5CaB3cWmXARSurbdODKhI9GAzrElDOiEs=;
        b=iEu7ro0Qq2KU8SgNdzXIJVCzuAylWXIaClTlaJVr8knLSqCuER9UBg+P5zEx7PhzE/
         CSAOwAdxz7AcW+kGZPGxDd+LHL4QfvNPxNxX2FETp6cY7rGk40LBaW/pKzHCEekQqJhY
         oOtf4+6mjrXJFiafaxTtuLtNQhS3jBImGcp30=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wUceU5BRszUuG5v3kKCVHKw8BZ74lzOV5jUNTG6wpzuVoWhzcN+2Uu5THvz208FXpv
         wmlPsoueBtX3GiQFix3UcvNwmuxAMx+NDzIfuHJ8suHBDQzOl7fqG1cxvRFdJStcxo4K
         Ap/tgyiC9U5IEvEHzVlYf+sYrZhEJ/BsaY5vQ=
Received: by 10.210.122.5 with SMTP id u5mr7759412ebc.83.1229348900142;
        Mon, 15 Dec 2008 05:48:20 -0800 (PST)
Received: by 10.210.136.4 with HTTP; Mon, 15 Dec 2008 05:48:20 -0800 (PST)
In-Reply-To: <200812151417.16372.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103163>

On Mon, Dec 15, 2008 at 2:17 PM, Jakub Narebski <jnareb@gmail.com> wrote:
>> +     my $patch_max;
>> +     if ($format eq 'patch') {
>> +             $patch_max = gitweb_check_feature('patches');
>> +             die_error(403, "Patch view not allowed") unless $patch_max;
>> +     }
>> +
>
> Hmmm... gitweb_check_feature

You're right, it's an abuse. I'll make it gitweb_get_feature()[0]

> I am wondering if we could somehow mark (encode) either $hash_parent
> or number of patches in proposed filename... but I don't think it is
> worth it.

Including hash_parent if defined is quite possible. I'm not sure it's
really worth it considering that the typical usage would be to publish
a patchset for a particular feature (in which case the hash/branch
name would be enough).

>> +     } elsif ($format eq 'patch') {
>> +             local $/ = undef;
>> +             print <$fd>;
>> +             close $fd
>> +                     or print "Reading git-format-patch failed\n";
>
> Nice, although... I'd prefer for Perl expert to say if it is better
> to dump file as a whole in such way (it might be quite large), or
> to do it line by line, i.e. without "local $/ = undef;", or using
> "print while <$fd>;" also without "local $/ = undef;".

I'm just sticking to whatever the existing code does :-)

As soon as you finish the patchset review I'll have a new version
taking into consideration all the other suggestions and remarks I
snipped from this reply.

-- 
Giuseppe "Oblomov" Bilotta
