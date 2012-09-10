From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 9/9] Add git-check-ignores
Date: Mon, 10 Sep 2012 12:15:01 +0100
Message-ID: <20120910111501.GB12974@atlantic.linksys.moosehall>
References: <1346544731-938-1-git-send-email-git@adamspiers.org>
 <1346544731-938-10-git-send-email-git@adamspiers.org>
 <CACsJy8A2-C9xSz2LXt9Ptjxhe++i2vcBSMY-cxJLWUiutajZUQ@mail.gmail.com>
 <7vmx15bsxj.fsf@alter.siamese.dyndns.org>
 <CACsJy8CPaJKGU0Lyjr93s9JEc_VBuLrHNH=nRa42K8Ohj3OWFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 13:15:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB1xR-0001Jc-CW
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 13:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834Ab2IJLPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 07:15:05 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:35822 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755922Ab2IJLPD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 07:15:03 -0400
Received: from localhost (f.8.b.2.1.5.e.f.f.f.4.f.0.4.2.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:240:f4ff:fe51:2b8f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 1F4B02E39E;
	Mon, 10 Sep 2012 12:15:02 +0100 (BST)
Mail-Followup-To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8CPaJKGU0Lyjr93s9JEc_VBuLrHNH=nRa42K8Ohj3OWFA@mail.gmail.com>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205118>

On Wed, Sep 05, 2012 at 05:25:25PM +0700, Nguyen Thai Ngoc Duy wrote:
> On Wed, Sep 5, 2012 at 12:26 AM, Junio C Hamano <gitster@pobox.com> wrote:
> > Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> >
> >>> +static void output_exclude(const char *path, struct exclude *exclude)
> >>> +{
> >>> +       char *type = exclude->to_exclude ? "excluded" : "included";
> >>> +       char *bang = exclude->to_exclude ? "" : "!";
> >>> +       char *dir  = (exclude->flags & EXC_FLAG_MUSTBEDIR) ? "/" : "";
> >>> +       printf(_("%s: %s %s%s%s "), path, type, bang, exclude->pattern, dir);
> >>
> >> These English words "excluded" and "included" make the translator me
> >> want to translate them. But they could be the markers for scripts, so
> >> they may not be translated. How about using non alphanumeric letters
> >> instead?
> >
> > I agree they should not be translated, but it is a disease to think
> > unintelligible mnemonic is a better input format for scripts than
> > the spelled out words.  "excluded/included" pair is just fine.
> 
> Not all mnemonic is unintelligible though. "+" and "-" may fit well in
> this case. I'm just trying to make sure we have checked the mnemonic
> pool before ending up with excluded/included.

Personally I'd be against introducing "+" and "-" when we already have
"!" and "".  Even though "+" and "-" are more intuitive, it would
create inconsistency and IMHO confusion.

I'm still unconvinced that it's worth having a separate type field in
the output when the pattern field already has a "!" prefix for
inclusions.  Does a separate field really help porcelain writers or
make the output more readable?
