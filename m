From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC PATCH 4/8] Support remote helpers implementing smart
 transports
Date: Wed, 2 Dec 2009 22:10:08 +0200
Message-ID: <20091202201008.GB11301@Knoppix>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi>
 <20091201192233.GL21299@spearce.org>
 <20091202055543.GC31244@Knoppix>
 <20091202170457.GC31648@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 02 21:10:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFvWo-00050E-1A
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 21:10:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755389AbZLBUKK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 15:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755368AbZLBUKI
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 15:10:08 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:41005 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755285AbZLBUKG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 15:10:06 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id E1B23C83A1;
	Wed,  2 Dec 2009 22:10:10 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A02C1DDE80F; Wed, 02 Dec 2009 22:10:10 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 72742E51A3;
	Wed,  2 Dec 2009 22:10:08 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20091202170457.GC31648@spearce.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134394>

On Wed, Dec 02, 2009 at 09:04:57AM -0800, Shawn O. Pearce wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> 
> Drop invoke-r.

Dropped.

> Modify transport-helper.c to allow pushing TRANS_OPT_UPLOADPACK and
> TRANS_OPT_RECEIVEPACK down into the helper via the option capability.

NAK. Modified _process_connect_or_invoke (now _process_connect) to pass
new option that appiles to connecting all subprotocols (if needed).

It looks like following:

 > capabilities
 < option
 < connect
 <
 > option servpath <blahblah>
 < ok
 > connect git-upload-pack
 < 

And from helper POV, all subprotocols should appear identical from
layer 6 POV so it doesn't make sense to diffrentiate between path
for upload-pack and receive-pack (or upload-archive!).

> I'd rename connect-r to just connect.

Yeah, putting repository in RPC explicit signature is bit ugly (there
isn't probaby ever going to be signature that doesn't contain repo as
argument). That would make it 'connect'.

Renamed.

-Ilari
