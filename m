From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 4/8] Support remote helpers implementing smart
	transports
Date: Thu, 3 Dec 2009 11:42:42 -0800
Message-ID: <20091203194242.GD23281@spearce.org>
References: <1259675838-14692-1-git-send-email-ilari.liusvaara@elisanet.fi> <1259675838-14692-5-git-send-email-ilari.liusvaara@elisanet.fi> <20091201192233.GL21299@spearce.org> <20091202055543.GC31244@Knoppix> <20091202170457.GC31648@spearce.org> <20091202201008.GB11301@Knoppix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Dec 03 20:42:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NGHZn-0003YM-8I
	for gcvg-git-2@lo.gmane.org; Thu, 03 Dec 2009 20:42:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756179AbZLCTmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Dec 2009 14:42:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756148AbZLCTmm
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Dec 2009 14:42:42 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:62662 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756160AbZLCTml (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Dec 2009 14:42:41 -0500
Received: by yxe17 with SMTP id 17so1440699yxe.33
        for <git@vger.kernel.org>; Thu, 03 Dec 2009 11:42:48 -0800 (PST)
Received: by 10.101.88.12 with SMTP id q12mr2732025anl.76.1259869365935;
        Thu, 03 Dec 2009 11:42:45 -0800 (PST)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 34sm1194518yxf.11.2009.12.03.11.42.43
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Dec 2009 11:42:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20091202201008.GB11301@Knoppix>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134470>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> wrote:
> On Wed, Dec 02, 2009 at 09:04:57AM -0800, Shawn O. Pearce wrote:
> > Modify transport-helper.c to allow pushing TRANS_OPT_UPLOADPACK and
> > TRANS_OPT_RECEIVEPACK down into the helper via the option capability.
> 
> NAK. Modified _process_connect_or_invoke (now _process_connect) to pass
> new option that appiles to connecting all subprotocols (if needed).
...
> And from helper POV, all subprotocols should appear identical from
> layer 6 POV so it doesn't make sense to diffrentiate between path
> for upload-pack and receive-pack (or upload-archive!).

That may be true, but the remote.origin.uploadpack and
remote.origin.receivepack configuration options exist
and are passed through as these option uploadpack and
option receivepack callbacks.

If you want to pass through a single option with the remote program
name, you need to do that immediately before the connect invoke
occurs, and instead buffer the two different configuration options
in the struct transport.  I think that would make the series messier
than it is.
 
-- 
Shawn.
