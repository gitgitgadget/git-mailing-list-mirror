From: Benjamin Close <Benjamin.Close@clearchain.com>
Subject: Re: Fix UTF Encoding issue
Date: Tue, 4 Dec 2007 09:34:34 +1030
Message-ID: <20071203230432.GA1337@wolf.clearchain.com>
References: <4753D419.80503@clearchain.com> <200712031802.55514.jnareb@gmail.com> <47547930.5070603@clearchain.com> <200712040020.26773.ismail@pardus.org.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Junio C Hamano <gitster@pobox.com>,
	Alexandre Julliard <julliard@winehq.org>, git@vger.kernel.org,
	Perl Unicode Mailing List <perl-unicode@perl.org>,
	Dan Kogai <dankogai@dan.co.jp>
To: Ismail D??nmez <ismail@pardus.org.tr>
X-From: git-owner@vger.kernel.org Tue Dec 04 00:31:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzKkr-00084m-M8
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 00:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbXLCXay (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 18:30:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751321AbXLCXax
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 18:30:53 -0500
Received: from wcl.ml.unisa.edu.au ([130.220.166.5]:62174 "EHLO
	wolf.clearchain.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751296AbXLCXax (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 18:30:53 -0500
X-Greylist: delayed 1063 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Dec 2007 18:30:51 EST
Received: from wolf.clearchain.com (localhost [127.0.0.1])
	by wolf.clearchain.com (8.14.2/8.14.2) with ESMTP id lB3N4eiV001381;
	Tue, 4 Dec 2007 09:34:40 +1030 (CST)
	(envelope-from Benjamin.Close@clearchain.com)
Received: (from benjsc@localhost)
	by wolf.clearchain.com (8.14.2/8.14.2/Submit) id lB3N4YbT001380;
	Tue, 4 Dec 2007 09:34:34 +1030 (CST)
	(envelope-from Benjamin.Close@clearchain.com)
X-Authentication-Warning: wolf.clearchain.com: benjsc set sender to Benjamin.Close@clearchain.com using -f
Content-Disposition: inline
In-Reply-To: <200712040020.26773.ismail@pardus.org.tr>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66978>

On Tue, Dec 04, 2007 at 12:20:26AM +0200, Ismail D??nmez wrote:
> Monday 03 December 2007 Tarihinde 23:46:24 yazm????t??:
> > Jakub Narebski wrote:
> > > On Mon, 3 Dec 2007, Martin Koegler wrote:
> > >> On Mon, Dec 03, 2007 at 04:06:48AM -0800, Jakub Narebski wrote:
> > >>> Ismail D??nmez <ismail@pardus.org.tr> writes:
> > >>>> Monday 03 December 2007 Tarihinde 12:14:43 yazm??t?:
> > >>>>> Benjamin Close <Benjamin.Close@clearchain.com> writes:
> > >>>>>> -	eval { $res = decode_utf8($str, Encode::FB_CROAK); };
> > >>>>>> -	if (defined $res) {
> > >>>>>> -		return $res;
> > >>>>>> -	} else {
> > >>>>>> -		return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> > >>>>>> -	}
> > >>>>>> +	eval { return ($res = decode_utf8($str, Encode::FB_CROAK)); };
> > >>>>>> +	return decode($fallback_encoding, $str, Encode::FB_DEFAULT);
> > >>>>>>  }
> > >>
> > >> This version is broken on Debian sarge and etch. Feeding a UTF-8 and a
> > >> latin1 encoding of the same character sequence yields to different
> > >> results.
> >
> > For the record, this was on a debian sid machine.
> >
> > #perl --version
> > This is perl, v5.8.8 built for x86_64-linux-gnu-thread-multi
> >
> > and the result of not using the original patch was:
> >
> > <h1>Software error:</h1>
> > <pre>Cannot decode string with wide characters at
> > /usr/lib/perl/5.8/Encode.pm line 166. </pre>
> 
> Can you try the attached patch?

I confirm that the patch corrects the problem.

Without it I get the Cannot decode string error. With it gitweb displays
correctly.

Cheers,
	Benjamin
