From: Benoit SIGOURE <tsuna@lrde.epita.fr>
Subject: Re: git: avoiding merges, rebasing
Date: Mon, 8 Oct 2007 15:16:45 +0200
Message-ID: <1F840D5F-7CE7-45F5-94D2-8A366149CBFB@lrde.epita.fr>
References: <200709301421.52192.bruno@clisp.org> <46FF99E2.8050605@byu.net> <200709302141.25597.bruno@clisp.org> <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-18-941324761"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git list <git@vger.kernel.org>
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Oct 08 15:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IesUB-0000fr-45
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 15:17:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbXJHNRT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 09:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbXJHNRS
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 09:17:18 -0400
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:56198 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752916AbXJHNRS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 09:17:18 -0400
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IesU0-0001A4-7K; Mon, 08 Oct 2007 15:17:16 +0200
In-Reply-To: <C64152A3-A5A6-4320-864C-E78E3A60C8E6@lrde.epita.fr>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60320>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-18-941324761
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Sep 30, 2007, at 10:27 PM, Benoit SIGOURE wrote:

> On Sep 30, 2007, at 9:41 PM, Bruno Haible wrote:
>
>>> it should be
>>> possible to create a custom [merge "cl-merge"] in your git config  
>>> file,
>>> which points to a script designed specifically for resolving  
>>> changelog
>>> conflicts
>>
>> I would love such a script, instead of constantly having to do  
>> conflict
>> resolution at the top of ChangeLog.
>>
>
> So would I.  I've had this in my TODO list for a long time so if no  
> one else is willing to give it a try, I can try, but it won't be  
> before next week because my schedule is quite busy until then.
>

I finally found some time to hack something and here is my git-merge- 
changelog Perl script.  I tested it quickly and it seems to work  
fine.  It will mess up the ChangeLog entries when a commit actually  
modifies an existing ChangeLog entry.  It needs more testing but I'm  
just throwing this out in the wild for people that have interest in  
this to review.  I will eventually come up with a solution for the  
commits modifying existing entries and a testsuite.

I'm CC-ing the Git ML just in case it interests some more people over  
there.

In order to use it, add the following to your ~/.gitconfig:
[merge "cl-merge"]
         name = GNU-style ChangeLog merge driver
         driver = /path/to/git-merge-changelog %O %A %B
(you can also add it to a specific working copy by adding it in .git/ 
config instead)

Then, in the directory where the ChangeLog is, add a .gitattributes  
file with the following content:
ChangeLog       merge=cl-merge

For more information, see man gitattributes.

Let me know if something goes wrong.

Cheers,

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-18-941324761
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHCi29wwE67wC8PUkRAnuPAKC91rFZ71q9DoAHgQLvUmwHwypdfQCfSp4L
smiECHUuj+Bz4XIAll73vsU=
=/s89
-----END PGP SIGNATURE-----

--Apple-Mail-18-941324761--
