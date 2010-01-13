From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 16:47:47 +0200
Message-ID: <20100113144745.GA7246@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
 <20100113135753.GA7095@Knoppix>
 <20100113141218.GA17687@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 15:48:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV4Vp-0003Yr-AB
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 15:47:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab0AMOrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 09:47:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755342Ab0AMOrx
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 09:47:53 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:47307 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754889Ab0AMOrx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 09:47:53 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 5250C8BA48;
	Wed, 13 Jan 2010 16:47:51 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A05D984B0E1; Wed, 13 Jan 2010 16:47:51 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 419ED158A72;
	Wed, 13 Jan 2010 16:47:48 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100113141218.GA17687@inner.home.ulmdo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136825>

On Wed, Jan 13, 2010 at 03:12:18PM +0100, Andreas Krey wrote:
> On Wed, 13 Jan 2010 15:57:53 +0000, Ilari Liusvaara wrote:
> ...
> > And one would need custom daemon anyway even if one used stunnel. 
> > git-daemon just can't deal with authentication data.
> 
> It doesn't need to, really. stunnel sets the environment variable
> SSL_CLIENT_DN with the distinguished name of the client certificate,
> which can be used in the hook scripts ('update') on the server.

That would be useless. Data about authenticated client needs to fed to
authorization decisions already before invoking git.

And besides: Gits:// uses certificates as keypairs, which would make DN
data absolutely useless because it is untrustworthy. And adding PKI
is way too complicated.

> (I looked into that stuff once, but with the advent of smart-http(s)
> I pretty much lost any interest to try implementing gits:// via
> openssl here, as it isn't yet an actual itch.)

The authentication support for smart-http seems pretty bad (making the
old mistake of not binding authentications). Of course, the same tricks
as gits:// uses would work with https:// (its all TLS-level stuff), but
no server or client does that.

-Ilari
