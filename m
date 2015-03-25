From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] t: simplify loop exit-code status variables
Date: Wed, 25 Mar 2015 13:43:19 -0400
Message-ID: <20150325174319.GA15096@peff.net>
References: <20150325052456.GA19394@peff.net>
 <20150325053017.GF31924@peff.net>
 <xmqqfv8t2dii.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 18:43:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YapL0-0003Qd-FM
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 18:43:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754860AbbCYRn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 13:43:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:38393 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754856AbbCYRnX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 13:43:23 -0400
Received: (qmail 18953 invoked by uid 102); 25 Mar 2015 17:43:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 12:43:22 -0500
Received: (qmail 16271 invoked by uid 107); 25 Mar 2015 17:43:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Mar 2015 13:43:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Mar 2015 13:43:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv8t2dii.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266287>

On Wed, Mar 25, 2015 at 10:27:49AM -0700, Junio C Hamano wrote:

> > diff --git a/t/t3060-ls-files-with-tree.sh b/t/t3060-ls-files-with-tree.sh
> > index 61c1f53..36b10f7 100755
> > --- a/t/t3060-ls-files-with-tree.sh
> > +++ b/t/t3060-ls-files-with-tree.sh
> > @@ -25,15 +25,10 @@ test_expect_success setup '
> >  		do
> >  			num=00$n$m &&
> >  			>sub/file-$num &&
> > -			echo file-$num >>expected || {
> > -				bad=t
> > -				break
> > -			}
> > -		done && test -z "$bad" || {
> > -			bad=t
> > -			break
> > -		}
> > -	done && test -z "$bad" &&
> > +			echo file-$num >>expected ||
> > +			return 1
> > +		done
> > +	done &&
> >  	git add . &&
> >  	git commit -m "add a bunch of files" &&
> 
> The empty initialization for $bad can also go for this one, right?

Yeah, it can.

-Peff
