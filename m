From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFCv2 13/16] fetch-pack: use the configured transport protocol
Date: Tue, 2 Jun 2015 14:32:38 +0300
Message-ID: <20150602113238.GA15140@LK-Perkele-VII>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
 <1433203338-27493-14-git-send-email-sbeller@google.com>
 <CACsJy8AadHof8bxeD3jfZ-MKSBLXGdw23SeJLgp7sCy+N7n_GA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 13:41:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzkZC-0000eR-QV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 13:41:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754127AbbFBLlH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 07:41:07 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:46573 "EHLO
	emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216AbbFBLlF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 07:41:05 -0400
X-Greylist: delayed 504 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jun 2015 07:41:05 EDT
Received: from LK-Perkele-VII (a91-155-194-207.elisa-laajakaista.fi [91.155.194.207])
	by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 897BF1A26F5;
	Tue,  2 Jun 2015 14:32:38 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <CACsJy8AadHof8bxeD3jfZ-MKSBLXGdw23SeJLgp7sCy+N7n_GA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270526>

On Tue, Jun 02, 2015 at 05:02:45PM +0700, Duy Nguyen wrote:
> On Tue, Jun 2, 2015 at 7:02 AM, Stefan Beller <sbeller@google.com> wrote:
> >  builtin/fetch-pack.c |  22 ++++++++++-
> >  fetch-pack.c         | 109 +++++++++++++++++++++++++++------------------------
> >  fetch-pack.h         |   1 +
> >  3 files changed, 80 insertions(+), 52 deletions(-)
> 
> And the companion changes in transport-helper.c should be in this
> patch as well to support smart http. I don't think there is any
> problem with how you store the "version" (or "transport_version", you
> should probably stick to one name) though.

Looking at transport-helper.c, process_connect() looks to need patching,
it handles smart transport establishment via remote helpers.

Looking at the routine it calls, both the name and exec look to need
patching.

I think that if process_connect() succeeds, then connect_setup() will
hit the "if (data->conn) return 0;" case and exit early.

transport-helper.c doesn't look to have anything smart-http specific.


-Ilari
