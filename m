From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2 6/7] web--browse: use (x-)www-browser if available
Date: Fri, 3 Dec 2010 23:45:22 +0100
Message-ID: <AANLkTinWD53M2VjiWgeA0Qwx3OHzR2A09Y+AB2B9o1df@mail.gmail.com>
References: <1291394861-11989-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1291394861-11989-7-git-send-email-giuseppe.bilotta@gmail.com> <7vaakmmrkj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 23:45:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POeNz-0003dE-K9
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 23:45:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754068Ab0LCWpo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Dec 2010 17:45:44 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:37694 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050Ab0LCWpn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 17:45:43 -0500
Received: by iwn6 with SMTP id 6so404029iwn.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 14:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=FlltG/UDV5dxxsUHC6s5tmVKDahCr2osGsCcLxt6j98=;
        b=lCtda4Eobfm3a1TOJTkwxh2R7aFdqixU5TXvmvEggTedEV5CRoVDjTgIlBJrMWWfP9
         SfvJ9uPioGtJPli8CCTgV5GR2gtKzily4izZxPbIGMBdo5HPSYvbkGEDqChpTyJw74px
         0czQ3SfOnIdRf7r6HC5Gaer7yG2Xe2iK1g6FU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=l3uOd2cFYysL4O+jQariijObQa7Eqk7s3z/u+XycVoenE4/4ZVOucTe3f2zmGL314u
         bg9LPxLYufyftIvL1/srJHJI6orylOQhSxHe/VmCr6n4091J5eA8lYo6Z/2Evcfu8d8L
         hxQ+qdGIR2IhjZht2g8gxC7k6qBubaJDJOofk=
Received: by 10.231.34.130 with SMTP id l2mr2409059ibd.181.1291416342530; Fri,
 03 Dec 2010 14:45:42 -0800 (PST)
Received: by 10.231.39.3 with HTTP; Fri, 3 Dec 2010 14:45:22 -0800 (PST)
In-Reply-To: <7vaakmmrkj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162873>

On Fri, Dec 3, 2010 at 11:15 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:
>
>> Debian and derivatives have an alternatives-based default browser
>> configuration that uses the /usr/bin/gnome-www-browser,
>> /usr/bin/x-www-browser and /usr/bin/www-browser symlinks.
>>
>> When no browser is selected by the user and the Debian alternatives =
are
>> available, try to see if they are one of our recognized selection an=
d
>> in the affermative case use it. Otherwise, warn the user about them
>> being unsupported and move on with the previous detection logic.
>
> A "please step back a bit" question. =A0Does the packaging guideline =
of
> Debian say that non-browser applications should take these links as "=
end
> user preference" when opening HTML pages?

I'm not sure this is an actual guideline, and I cannot find much
specific information about it online. It _is_ the recommended way to
set the default browser in Debian (plus the BROWSER override), but
there are quite a few applications that don't actually follow it. (And
=46WIW, as a Debian user I find this annoying, e.g. when clicking on a
link and having konqueror or iceweasel pop up instead of my preferred
x-www-browser, that happens to be Opera.)

I do believe that Debian encourages the use of sensible-browser (that
does the BROWSER and *www-browser check itself) rather than manually
going to look at those specifications. But that means giving up the
"do anything we can to open stuff in a new tab" that is among the
specified purposes of git-web--browse.

> The behaviour of unconfigured git across platforms would become less
> consistent if we do this, while the behaviour of random programs on o=
ne
> particular platform (Debian) would become more consistent.

That's actually the reason why I wasn't so sure it would be
appropriate for inclusion.

> I am not saying that is necessarily a bad thing. =A0I just want to
> understand the motivation.

The motivation is that, lacking an explicit override, I believe git
web--browse should try and get the information about the preferred
browser from wherever it can. In a way, the *www-browser testing is
akin to the use of start in Windows or open under Mac OS X.

Of course, as I only use Debian, I am not aware of what other
distributions do (if they do anything at all) to allow a user to
specify a preferred browser.

An alternative approach would be to get rid of the *www-browser and
BROWSER patches, and just use xdg-open if it's available. Which again
raises the issue of how to enforce opening the page in a new tab.

>> +# check if a given executable is a browser we like
>> +valid_exe() {
>
> Call it valid_browser_executable or something, please.

Of course.

>> + =A0 =A0 testexe=3D"$1"
>> + =A0 =A0 basename=3D$(basename $(readlink -f "$testexe"))
>
> Are we saying "readlink" must exist on the system? =A0This dependency=
 is
> new, I think.

The only other use I found of readlink is in a specific area of
t/test-lib.sh, so this seems like a new requirement indeed. I can
either wrap that part in a type readlink check, or I can get rid of
that specific section of the test, and just leave the --version check,
bringing the code back to the previous patch version.

--=20
Giuseppe "Oblomov" Bilotta
