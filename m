From: Thomas Koch <thomas@koch.ro>
Subject: [ANN] First beta: Git export with hardlinks
Date: Wed, 13 Feb 2013 14:17:21 +0100
Message-ID: <201302131417.22001.thomas@koch.ro>
References: <201302061619.07765.thomas@koch.ro> <201302101133.28746.thomas@koch.ro> <20130211171357.GF16402@sigill.intra.peff.net>
Reply-To: thomas@koch.ro
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Robert Clausecker <fuzxxl@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 13 14:17:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5cDf-0001bF-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 14:17:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758380Ab3BMNR1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 08:17:27 -0500
Received: from koch.ro ([88.198.2.104]:60875 "EHLO koch.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757155Ab3BMNR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 08:17:26 -0500
Received: from 123-16.2-85.cust.bluewin.ch ([85.2.16.123] helo=x121e.localnet)
	by koch.ro with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:256)
	(Exim 4.80)
	(envelope-from <thomas@koch.ro>)
	id 1U5cDE-0007LB-Mv; Wed, 13 Feb 2013 14:17:24 +0100
User-Agent: KMail/1.13.7 (Linux/3.7-trunk-amd64; KDE/4.8.4; x86_64; ; )
In-Reply-To: <20130211171357.GF16402@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216258>

Hi,

my git_export_hardlink command should now be in a usable state. I'd appreciate 
any feedback: https://github.com/thkoch2001/git_export_hardlinks

I still have to choose a license: BSD/GPL/?

Jeff King:

> It looks like you create the sha1->path mapping by asking the user to
> provide <tree_sha1>,<path> pairs, and then assuming that the exported
> tree at <path> exactly matches <tree_sha1>. Which it would in the
> workflow you've proposed, but it is also easy for that not to be the
> case (e.g., somebody munges a file in <path> after it has been
> exported).
> 
> So it's a bit dangerous as a general purpose tool, IMHO. It's also a
> slight pain in that you have to keep track of the tree sha1 for each
> exported path somehow.
You're right. I'd run a git reset --hard after each export to guarantee a 
pristine export.

The tree sha1 of the exported tree might be part of the folder name of the 
export or in some meta file related to the export, like

/deployments
  /2012-03-05_14-23-02_0b96bf5f72d2c282b31726b3fbff279a89220b15
    /export <- exported tree goes here
    /meta  <- git config file holding all relevant metadata: (who, when, tree,
                  commit, ref)
    /index <- git index file corresponding to the exported tree (maybe?)
  
Regards,

Thomas Koch, http://www.koch.ro
