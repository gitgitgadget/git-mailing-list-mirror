From: Charles Bailey <charles@hashpling.org>
Subject: Re: git diff, git mergetool and CRLF conversion
Date: Wed, 21 Jan 2009 17:23:51 +0000
Message-ID: <20090121172351.GB21727@hashpling.org>
References: <83k58ofvjt.fsf@kalahari.s2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Hannu Koivisto <azure@iki.fi>
X-From: git-owner@vger.kernel.org Wed Jan 21 18:25:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPgpM-0008HZ-RV
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 18:25:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbZAURXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 12:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbZAURXy
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 12:23:54 -0500
Received: from relay.ptn-ipout02.plus.net ([212.159.7.36]:42227 "EHLO
	relay.ptn-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751544AbZAURXy (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Jan 2009 12:23:54 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAJbhdknUnw4T/2dsb2JhbADNcIVz
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.ptn-ipout02.plus.net with ESMTP; 21 Jan 2009 17:23:52 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1LPgnw-00058l-8Y; Wed, 21 Jan 2009 17:23:52 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n0LHNp98023570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 21 Jan 2009 17:23:51 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n0LHNplB023569;
	Wed, 21 Jan 2009 17:23:51 GMT
Content-Disposition: inline
In-Reply-To: <83k58ofvjt.fsf@kalahari.s2.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 151588bb6547efa2cb5422e1222668b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106631>

On Wed, Jan 21, 2009 at 06:55:34PM +0200, Hannu Koivisto wrote:
> Hi,
> 
> Suppose I have core.autocrlf set to true and and due to that a
> version controlled file in a working tree with CRLF line endings.
> If I modify such a file and then say "git diff", I get a patch with
> LF line endings.
> 
> Also, if get a merge conflict with a file to which CRLF conversion
> is applied and run e.g. "git mergetool -t emerge", the temporary
> files representing stage2 and stage3 versions seem to have LF line
> endings.
> 
> Is this intended behaviour?  I'm using 1.6.1 on Cygwin.

Speaking for mergetool, I believe that it's simply because mergetool
uses git cat-file which just outputs the raw contents of a blob and
doesn't do any line ending conversion.

IMHO, I think that it should probably perform the 'convert to working
tree format' change when preparing the temporary files. I'm not sure
how best to do that, but perhaps it should be using git checkout-index
with the --temp option instead of cat-file.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
