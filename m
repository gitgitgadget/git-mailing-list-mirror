From: "Spencer E. Olson" <olsonse@umich.edu>
Subject: Re: [PATCH] submodule: no [--merge|--rebase] when newly cloned
Date: Thu, 17 Feb 2011 17:48:15 -0700
Message-ID: <201102171748.15516.olsonse@umich.edu>
References: <1297860417-21895-1-git-send-email-olsonse@umich.edu> <4D5CC9C9.60705@viscovery.net> <alpine.DEB.2.00.1102171929200.14950@debian>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 18 01:49:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PqEWs-0002iV-2R
	for gcvg-git-2@lo.gmane.org; Fri, 18 Feb 2011 01:49:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882Ab1BRAsv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Feb 2011 19:48:51 -0500
Received: from smtp.mail.umich.edu ([141.211.14.81]:51101 "EHLO
	hackers.mr.itd.umich.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab1BRAsv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Feb 2011 19:48:51 -0500
Received: FROM localhost (cadash.gpcc.itd.umich.edu [141.211.2.218])
	By hackers.mr.itd.umich.edu ID 4D5DC1EF.9810D.23257 ;
	Authuser olsonse;
	17 Feb 2011 19:48:48 EST
User-Agent: KMail/1.9.4
In-Reply-To: <alpine.DEB.2.00.1102171929200.14950@debian>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167144>

We are not actually using the yes utility (think y\ny\ny\ny\ny\ny\n...)

As far as I understand, in this particular use, "yes" and "no" are just 
comments.  We could also write
: I like banannas ;;
and
! : I do not like anchovies ;;

On Thursday 17 February 2011 17:34, Martin von Zweigbergk wrote:
> On Thu, 17 Feb 2011, Johannes Sixt wrote:
> > Am 2/16/2011 20:51, schrieb Junio C Hamano:
> > > Here is how to write the above more concisely, efficiently and
> > > portably.
> > >
> > > 	case "$2;" in
> > >         *";$1;"*)
> > >         	echo yes ;;
> > >         *)
> > >         	echo no ;;
> > > 	esac
> > >
> > > The trailing ';' takes care of the case where cloned_modules has only
> > > one element, in which case you have ";name" in "$2".  No need for a
> > > loop.
> >
> > And while you are here, you could make this:
> >
> > list_contains()
> > {
> > 	case "$2;" in
> > 	*";$1;"*)
> >
> > 		: yes ;;
> >
> > 	*)
> > 		! : no ;;
> > 	esac
> > }
> >
> > and test for the exit code of this function rather than its output at the
> > call site.
>
> According to Brandon Casey: "Some platforms (IRIX 6.5, Solaris 7) do
> not provide the 'yes' utility." See 8648732 (t/test-lib.sh: provide a
> shell implementation of the 'yes' utility, 2009-08-28).
>
>
> /Martin
