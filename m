From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 00:20:26 +0200
Organization: Pardus / KDE
Message-ID: <200712040020.26773.ismail@pardus.org.tr>
References: <4753D419.80503@clearchain.com> <200712031802.55514.jnareb@gmail.com> <47547930.5070603@clearchain.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qEIVHhfBvTvQCsI"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Benjamin Close <Benjamin.Close@clearchain.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:20:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzJdw-0007GH-NQ
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:20:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbXLCWTk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbXLCWTk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:19:40 -0500
Received: from ns2.uludag.org.tr ([193.140.100.220]:54902 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751018AbXLCWTk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:19:40 -0500
Received: from ninjamobile.local (unknown [85.102.220.209])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id B280061D0363;
	Tue,  4 Dec 2007 00:50:54 +0200 (EET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <47547930.5070603@clearchain.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66966>

--Boundary-00=_qEIVHhfBvTvQCsI
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Monday 03 December 2007 Tarihinde 23:46:24 yazm=C4=B1=C5=9Ft=C4=B1:
> Jakub Narebski wrote:
> > On Mon, 3 Dec 2007, Martin Koegler wrote:
> >> On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
> >>> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> >>>> Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
> >>>>> Benjamin Close <Benjamin.Close@clearchain.com> writes:
> >>>>>> -	eval { $res =3D decode_utf8($str, Encode::FB_CROAK); };
> >>>>>> -	if (defined $res) {
> >>>>>> -		return $res;
> >>>>>> -	} else {
> >>>>>> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> >>>>>> -	}
> >>>>>> +	eval { return ($res =3D decode_utf8($str, Encode::FB_CROAK)); };
> >>>>>> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> >>>>>>  }
> >>
> >> This version is broken on Debian sarge and etch. Feeding a UTF-8 and a
> >> latin1 encoding of the same character sequence yields to different
> >> results.
>
> For the record, this was on a debian sid machine.
>
> #perl --version
> This is perl, v5.8.8 built for x86_64-linux-gnu-thread-multi
>
> and the result of not using the original patch was:
>
> <h1>Software error:</h1>
> <pre>Cannot decode string with wide characters at
> /usr/lib/perl/5.8/Encode.pm line 166. </pre>

Can you try the attached patch?


=2D-=20
Never learn by your mistakes, if you do you may never dare to try again.

--Boundary-00=_qEIVHhfBvTvQCsI
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="utf8-username.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="utf8-username.patch"

--- gitweb/gitweb.perl	2007-11-28 11:33:14.000000000 +0200
+++ gitweb/gitweb.perl	2007-11-28 11:33:42.000000000 +0200
@@ -2159,7 +2159,7 @@
 	}
 	my $owner = $gcos;
 	$owner =~ s/[,;].*$//;
-	return to_utf8($owner);
+	return $owner;
 }
 
 ## ......................................................................

--Boundary-00=_qEIVHhfBvTvQCsI--
