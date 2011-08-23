From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH/RFC 2/2] git-p4: Add complex test case for branch import
Date: Mon, 22 Aug 2011 22:27:13 -0400
Message-ID: <20110823022713.GA6005@arf.padd.com>
References: <1313712590-26876-1-git-send-email-vitor.hda@gmail.com>
 <1313712590-26876-3-git-send-email-vitor.hda@gmail.com>
 <20110820191203.GC7135@arf.padd.com>
 <20110822011319.0a013117@fenix.utopia.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Vitor Antunes <vitor.hda@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 23 04:27:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qvgi0-000068-Sg
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 04:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754855Ab1HWC1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 22:27:18 -0400
Received: from honk.padd.com ([74.3.171.149]:34990 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851Ab1HWC1Q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 22:27:16 -0400
Received: from arf.padd.com (unknown [50.52.168.230])
	by honk.padd.com (Postfix) with ESMTPSA id 8F70F5B53;
	Mon, 22 Aug 2011 19:27:15 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4B2C531448; Mon, 22 Aug 2011 22:27:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20110822011319.0a013117@fenix.utopia.dhis.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179912>

vitor.hda@gmail.com wrote on Mon, 22 Aug 2011 01:13 +0100:
> I still need some help on the code part of this RFC patch. I really do
> not like the way it is implemented. Do you see other possible ways of
> achieving the same algorithm?

I think I understand the problem now, and have a small test case
to see what's going wrong.  Your solution is definitely
sub-optimal.  :)  Is there anything that can be done with
--import-marks and --export-marks?

Could you guess at the branch point using p4?  I.e. for each file
in the new branch, grab the change that caused its most recent
revision (the #xx part).  Pick the max of those changes.  In git,
find the commit whith "change = ..." that you just discovered.
That's the parent.

Even this won't be perfect, and I'm not even sure if it's less
icky than diff-tree.

		-- Pete
