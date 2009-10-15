From: Johan Herland <johan@herland.net>
Subject: Re: [RFC PATCH v3 00/17] Return of smart HTTP
Date: Thu, 15 Oct 2009 17:21:08 +0200
Message-ID: <200910151721.08352.johan@herland.net>
References: <1255577814-14745-1-git-send-email-spearce@spearce.org> <20091015185253.6117@nanako3.lavabit.com> <20091015143340.GI10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 15 17:26:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MySDn-0007I9-4j
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 17:26:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761950AbZJOPXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 11:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760060AbZJOPXX
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 11:23:23 -0400
Received: from smtp.opera.com ([213.236.208.81]:42586 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759632AbZJOPXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 11:23:22 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5) with ESMTP id n9FFLEg3029487
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Oct 2009 15:21:34 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <20091015143340.GI10505@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130394>

On Thursday 15 October 2009, Shawn O. Pearce wrote:
> Nanako Shiraishi <nanako3@lavabit.com> wrote:
> > > "Shawn O. Pearce" <spearce@spearce.org> writes:
> > >> This v3 series is a respin, and includes fixes to address
> > >> reviewer comments from v2.
> >
> > Junio, you merged this series to your "pu" branch, but it breaks
> > "make test" (t9801). Shawn's "sp/smart-http" topic doesn't have
> > t9801 and passes all the tests.
>
> Actually, pu contains v2 right now, not v3.
>
> And pu doesn't always pass the tests... because of issues like this.
>
> It looks like there might be a semantic clash between John Herland's
> jh/cvs-helper branch and my sp/smart-http branch... but digging
> around at the code I haven't quite identified what that might be.

Don't have time to look into this at the moment, but a cursory gdb
shows that the "git fetch" in test #4 in t9801 segfaults with the
following stacktrace:

#0  0x00007f8dd67e8a47 in fclose () from /lib/libc.so.6
#1  0x00000000004a05b5 in disconnect_helper (transport=<value optimized out>) at transport-helper.c:81
#2  0x000000000049de1e in transport_disconnect (transport=0x1955490) at transport.c:952
#3  0x0000000000423477 in cmd_fetch (argc=26566704, argv=0x0, prefix=<value optimized out>) at builtin-fetch.c:748
#4  0x0000000000404233 in handle_internal_command (argc=2, argv=0x7fffdf293d20) at git.c:251
#5  0x0000000000404426 in main (argc=2, argv=0x7fffdf293d20) at git.c:438

Don't know if this helps...


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
