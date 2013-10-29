From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2] git clone: is an URL local or ssh
Date: Mon, 28 Oct 2013 21:49:45 -0400
Message-ID: <20131029014945.GC11861@sigill.intra.peff.net>
References: <201310282116.21551.tboegi@web.de>
 <xmqqmwltdsgm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org, sunshine@sunshineco.com, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 02:49:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VayRN-00066O-0j
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 02:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757931Ab3J2Btt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 21:49:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:57435 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756651Ab3J2Bts (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 21:49:48 -0400
Received: (qmail 30359 invoked by uid 102); 29 Oct 2013 01:49:48 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Oct 2013 20:49:48 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Oct 2013 21:49:45 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwltdsgm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236886>

On Mon, Oct 28, 2013 at 01:57:13PM -0700, Junio C Hamano wrote:

> > +i5601=0
> > +# $1 url
> > +# $2 none|host
> > +# $3 path
> > +test_clone_url () {
> > +	i5601=$(($i5601 + 1))
> > +	>"$TRASH_DIRECTORY/ssh-output" &&
> > +	test_might_fail git clone "$1" tmp$i5601 &&
> >  	{
> > -		case "$1" in
> > +		case "$2" in
> >  		none)
> >  			;;
> >  		*)
> > -			echo "ssh: $1 git-upload-pack '$2'"
> > +			echo "ssh: $2 git-upload-pack '$3'"
> >  		esac
> >  	} >"$TRASH_DIRECTORY/ssh-expect" &&
> 
> This looks like a strange use of {} (not an issue this patch
> introduced, though).  Shouldn't this suffice?
> 
> 	case ... in
>         ...
>         esac >"$TRASH_DIRECTORY/ssh-expect"

Yeah, I think you are right. This one is my fault from 8d3d28f; I think
in an earlier draft I had more complex logic that needed the {}, and
then never dropped them when it got simplified.

-Peff
