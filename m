From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH v2 3/8] Support taking over transports
Date: Sat, 5 Dec 2009 15:18:14 +0200
Message-ID: <20091205131814.GC1684@Knoppix>
References: <1259942168-24869-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259942168-24869-6-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091204182753.GD1483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 14:18:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGuWl-0003rX-B7
	for gcvg-git-2@lo.gmane.org; Sat, 05 Dec 2009 14:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZLENSM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2009 08:18:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754906AbZLENSL
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Dec 2009 08:18:11 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:38696 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754718AbZLENSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2009 08:18:11 -0500
Received: from saunalahti-vams (vs3-11.mail.saunalahti.fi [62.142.5.95])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id AE4588C107;
	Sat,  5 Dec 2009 15:18:16 +0200 (EET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-11.mail.saunalahti.fi ([62.142.5.95])
	with SMTP (gateway) id A014FAA7BCC; Sat, 05 Dec 2009 15:18:16 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 9B84C158A67;
	Sat,  5 Dec 2009 15:18:14 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091204182753.GD1483@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134599>

On Fri, Dec 04, 2009 at 10:27:53AM -0800, Shawn O. Pearce wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> > Add support for taking over transports that turn out to be smart.
> 
> Why can't you expose git_take_over_transport as a public function
> and then the transport-helper.c code can instead do:
> 
> 	... setup connect with helper ...
> 	transport_takeover(transport, child);
> 	return transport->fetch(....);
> 
> Would this make the code simpler?

The code complexity difference is not big. The magic return was for
historic reasons that no longer apply (and didn't get fixed when
corresponding upstream changes happned).

Namely, the push/push_refs impedance mismatch. Helpers used push,
smart transports used push_refs. But now that both use push_refs,
the handler can be invoked directly from push_refs of helper.

Fixed.

-Ilari
